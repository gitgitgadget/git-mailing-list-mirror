Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76271C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiA2GIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiA2GIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:08:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5BC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:08:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so23338882ejp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEf3ouC0IEfS30PZN4wN5+YqkA/eFCX2VD5yXYD4g9g=;
        b=kydpL6JCKen7/DwnLvtOA+CN4qNSakXITcS0Jh4ySlNK5tKZWugP2Cx0HCFZjFHSKJ
         4Sa3rUZ8SBFU8mZoJQHZ6MTftC19fGVmteSUoCkLwWJY+VE3BXFXoAreGeW9FYDJqi4B
         tyRavHTVz02UpykB2a+oU+bVZzO7YCXxwKNE143Yhzduc289DRyaf25iUhjWMerX9x0D
         op/UxEYHO9vtOwp7I8BKsjyyAs8vwXGVkma5q9SCe9VptUSyjmNKVp5ROqkE5hHuZCsP
         jvxvGF/0p+b02Hx96U4VgtT0cahdvmV7y/FQ2dDWsutm51Fboy0kapjaWsZjTyoqsGT6
         y+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEf3ouC0IEfS30PZN4wN5+YqkA/eFCX2VD5yXYD4g9g=;
        b=VgKmdnNpX10QuBuNFhit42FKXHEUtN8eqHUQdJfFKEwjrG9ApPC+51rQmnQnHXe5YF
         KmLE4UIx549of4YOa2k9uMWYAg8vg2IPpTT4C0tk/5mRWosjzIDf9wYZxrEh9bFkcaAm
         vp8/CJOA3tBaXHnLHVCSOfsCvUzJE4opv16Tnn7eEWYfrPimav7Wq9tulnkvcKE2USWm
         p1PqRCih6MoZtkwnkhf1qDtTgGYxi4rmvz31Hi4FcW923XHgb/5SkZddONHygt7a4iwj
         J4d1uoSFB8Dc2jaATo2eCpZSyqjYgk/HRMVs5UI5gz2IQ+AohenEfmaZhG9akCzbXHmi
         oyrQ==
X-Gm-Message-State: AOAM5331H1HZH1qntK5zGz6pNgv+zmmTDzsVBAwU2g50wCznx9Q47N2T
        4zrDD3vMgbvzPEGqLK8HRlKMQHv3XuCJmuI2U0A=
X-Google-Smtp-Source: ABdhPJxn1vtgRH4HzfkXEiM6TFtND5pj6p+oeCewS0PlCgVK3/BtGT2D/oFEf1ISBRtFWWFJe2jp2Lbu+q5nR3N4Eyg=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr3972096ejc.100.1643436497140;
 Fri, 28 Jan 2022 22:08:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 22:08:05 -0800
Message-ID: <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > After a merge, this function allows the user to extract the same
> > information that would be printed by `ls-files -u` -- conflicted
> > files with their mode, oid, and stage.
>
> Hmm. Okay.
>
> I am not really a fan of that output where we use a variable
> number of lines per file. As in: in the regular case, where a file was
> modified in divergent ways, we get three lines. But if it was deleted in
> one branch, or if it was created in both branches, we have only two lines.
>
> Frankly, I'd much rather have 3 lines for each and every conflict.

Out of curiosity, does this also mean you feel like `git ls-files -u`
is mis-designed (even if we're stuck with it for backward
compatibility reasons)?

Anyway, if we make this change guaranteeing there are 3 lines for each
and every conflict, that probably implies we can remove the stage
field (just letting it be implicit), right?  And it also implies that
the "path" field of the lines is now duplicate information.  Should
the path be printed on each line regardless of the duplication?
Should the path be printed separately on its own line, followed by the
three lines of (mode, oid) pairs?  Or should the format be something
else entirely?

> Granted, we currently only have three stages...

I thought that was true too, but Junio informed me otherwise[1].
Granted, ort does not currently make use of that, but it could.  Not
sure I want to rule it out.

[1] https://lore.kernel.org/git/xmqqr1t89gi8.fsf@gitster.c.googlers.com/

> ...and we can pretty much
> guarantee that at least two of these stages are non-empty (otherwise where
> would be the conflict?).

No, that's not true.  See the paragraph about "conflict types" from
the final patch in this series, where I mentioned three different
types of conflicts that can result in a path having a single higher
order stage.

> Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
> missing from the second conflict, in the output we would see stages 1, 2,
> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
> different conflicts.

I don't understand why you're fixating on the stage here.  Why would
you want to group all the stage 2s together, count them up, and then
determine there are N conflicting files because there are N stage 2's?
 In such a design, you'd have to do the extra post-processing to
recognize the all-zero modes and hashes and toss them.

To me, that seems like more work than just handling the `ls-files -u`
style of output, and doesn't have the advantage of showing things in a
format users may already be familiar with (see above about dropping
stages and maybe also pathname).  Since the `ls-files -u` output is
simply several lines of:
   <mode> <hash> <stage> <filename>
You can get the number of conflicted files by counting the number of
*unique* filenames.  If you want to see which lines are about the same
file, get all the lines with the same filename -- they are sorted by
(<filename>, <stage>) for convenience, much like `ls-files -u` is.


On a different angle, I'm also slightly worried there's an embedded
assumption here, one that I tried to address in the "Mistake to avoid"
section I added in my last patch of this series.  What if you have a
conflicting merge and 0 lines of output in the conflicting info
section?  Is there something about the reason you're asking for three
lines of output per conflicted file which is going to make you
overlook that particular possibility and not handle it?

> But still. It makes me uneasy to have that much variability in
> machine-consumable output.
>
> And who knows, maybe if we're ever implementing more sophisticated merge
> strategies for octopus merges, we might end up with more stages...

Um, if we need to handle more stages, wouldn't that undercut your
request for exactly 3 stages?  Wouldn't it suggest that we would
indeed want to have a flexible number of lines?

> In other words...
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 31 +++++++++++++++++++++++++++++++
> >  merge-ort.h | 21 +++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index b78dde55ad9..5e7cea6cc8f 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -4275,6 +4275,37 @@ void merge_display_update_messages(struct merge_options *opt,
> >       trace2_region_leave("merge", "display messages", opt->repo);
> >  }
> >
> > +void merge_get_conflicted_files(struct merge_result *result,
> > +                             struct string_list *conflicted_files)
> > +{
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *e;
> > +     struct merge_options_internal *opti = result->priv;
> > +
> > +     strmap_for_each_entry(&opti->conflicted, &iter, e) {
> > +             const char *path = e->key;
> > +             struct conflict_info *ci = e->value;
> > +             int i;
> > +
> > +             VERIFY_CI(ci);
> > +
> > +             for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
> > +                     struct stage_info *si;
> > +
> > +                     if (!(ci->filemask & (1ul << i)))
> > +                             continue;
> > +
> > +                     si = xmalloc(sizeof(*si));
> > +                     si->stage = i+1;
> > +                     si->mode = ci->stages[i].mode;
> > +                     oidcpy(&si->oid, &ci->stages[i].oid);
> > +                     string_list_append(conflicted_files, path)->util = si;
> > +             }
> > +     }
> > +     /* string_list_sort() uses a stable sort, so we're good */
> > +     string_list_sort(conflicted_files);
> > +}
> > +
> >  void merge_switch_to_result(struct merge_options *opt,
> >                           struct tree *head,
> >                           struct merge_result *result,
> > diff --git a/merge-ort.h b/merge-ort.h
> > index d643b47cb7c..e635a294ea8 100644
> > --- a/merge-ort.h
> > +++ b/merge-ort.h
> > @@ -2,6 +2,7 @@
> >  #define MERGE_ORT_H
> >
> >  #include "merge-recursive.h"
> > +#include "hash.h"
> >
> >  struct commit;
> >  struct tree;
> > @@ -89,6 +90,26 @@ void merge_display_update_messages(struct merge_options *opt,
> >                                  struct merge_result *result,
> >                                  FILE *stream);
> >
> > +struct stage_info {
> > +     struct object_id oid;
> > +     int mode;
> > +     int stage;
> > +};
>
> ... I'd rather not tack this onto a `string_list` but instead have
> something like:
>
>         struct conflict_info {

Nit: "conflict_info" is already taken for another structure; we'd need
a different name.  But it does illustrate the idea just fine.

>                 struct {
>                         struct object_id oid;
>                         int mode;
>                         const char *path;
>                 } stages[3]
>         };
>
> where `path` can be `NULL` to indicate that this stage is missing.

I'll get back to the data structure in a second, but the note about
path being `NULL` is interesting.  I'm presuming that oid and mode are
all-zeros as well, yes?  Now, your original request was that you
wanted a line printed for all three stages.  If we're printing oid,
mode, and path for each stage, what do we print for the path one these
lines?  Is it (1) "(null)", (2) "", or (3) the real pathname (via
carefully comparing to surrounding stages to find out what it is)?  If
we're changing the format to only print the name of the path once,
does the code need to loop over the list of conflicts in order to find
out the name (since the first or second stage might have a NULL path
field)?

In regards to the overall data structure and your comment about
string_list: I'm slightly confused.  You say you want to avoid a
string_list, but you've only accounted for there being one conflict in
this data structure.  I don't see how this suggestion avoids the need
for an array or a string_list or some kind of container to hold
multiple of these.

The inclusion of path within the stages array is also interesting --
should there be (up to) three copies of the pathname allocated per
conflict?  Seems a bit wasteful.  Wouldn't it make more sense to have
something like

    struct conflicts {
        struct {
            struct object_id oid;
            unsigned short mode;
        } stages[3]
    };

and then have a string_list storing the pathname -> conflicts mappings
to avoid the pathname duplication?  Or is there something you really
find problematic about the string_list and you really want an array or
other data structure?
