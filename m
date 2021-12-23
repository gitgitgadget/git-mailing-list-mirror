Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041DC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbhLWS0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhLWS0h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:26:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E268C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:26:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so24558828edc.11
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bH1dOuBV+pk3Y1gs/swk7uYN7HYKxFT0DUN2atEL6fw=;
        b=aPCEoKSH99nuzyUw8TU3cYfLMRgwVG+MJyhhKiNVcGpq38lG8tlBY4uuMFHnTe+uKD
         DzDQcaZ82X9lCCG95ez0+PuJOg/FoYei8tfhrv3TCaBwiXS4+/UWqrspCeQJO9Kyguzk
         5hRbmKlO8lTwqwjAxmm/xA/82ujnZZYnrPU6H3M2f2pCMkypNQ3zocmNFHIEDhNIiU/6
         LWnCt2DlTPeogtNI2073vAyP3IRiaTh29e3xPCPPQSNnB1xVhScXIX9+3kJwNnWoQdz7
         ccSy/keKZK5BihcnukC0AhbxtWphcmIVygCrz46yKDiqESw8he9uQC2MYhN4d2FkFqsY
         w/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH1dOuBV+pk3Y1gs/swk7uYN7HYKxFT0DUN2atEL6fw=;
        b=yo2wVCetTt/RIxC/qw6Po0lxczWlTkUE/4B0jG8JESFyiigOvp+F8eaETdu7BUFnmG
         uK14zZ+YtHsIkEYxXa78OTB8qK8fSzpSewYEnSouUZI0bKLB26pesMn62oYgFk8i050f
         TstMNbQzhG7pBTGo/ik2j/yIrARHQVlGIcMoH+5WOP17OlTkEk7pcJP4uG3hadaZLW11
         qpYstvwAw7arM0SG+/iOrWT9gNYz96rEsHPrHKE4lx+3HXhqa/eWWnr77wTdsyq7CzEi
         s9HsY9w+7ThPvLfngIxSvMOV/kgCInnrtyXW6GhX4Ev/0lhKixUHmC8acFwefx0Fz82U
         hd3g==
X-Gm-Message-State: AOAM533qTWVPv6HcT8OYAZNjVOBWSF50BN/NmYX3tYYPLHlZt9XC7y99
        L0HPc2mtO3FcD1N6kK8/e7AVboCZ9+TM5avdP3T+VLVByRY=
X-Google-Smtp-Source: ABdhPJwJdUAVb+Lcg7OP1DD1gvjQEH31rsZIy1bf/2+wb6XuvO2qrar9Xny5awrP3sQfaOTiIac4Dx+7kGcFQbqiIsw=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr2778939ejc.269.1640283995011;
 Thu, 23 Dec 2021 10:26:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
 <xmqqa6gto74z.fsf@gitster.g>
In-Reply-To: <xmqqa6gto74z.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Dec 2021 10:26:23 -0800
Message-ID: <CABPp-BFN+54-poG3JAqeF7SfMdcc+8Q+23ri58FbNe=eYjNF6w@mail.gmail.com>
Subject: Re: [PATCH 2/9] ll-merge: make callers responsible for showing warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 3:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since some callers may want to send warning messages to somewhere other
> > than stdout/stderr, stop printing "warning: Cannot merge binary files"
> > from ll-merge and instead modify the return status of ll_merge() to
> > indicate when a merge of binary files has occurred.
> >
> > Note that my methodology included first modifying ll_merge() to return
> > a struct, so that the compiler would catch all the callers for me and
> > ensure I had modified all of them.  After modifying all of them, I then
> > changed the struct to an enum.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  apply.c            |  5 ++++-
> >  builtin/checkout.c | 12 ++++++++----
> >  ll-merge.c         | 40 ++++++++++++++++++++++------------------
> >  ll-merge.h         |  9 ++++++++-
> >  merge-blobs.c      |  5 ++++-
> >  merge-ort.c        |  5 ++++-
> >  merge-recursive.c  |  5 ++++-
> >  notes-merge.c      |  5 ++++-
> >  rerere.c           | 10 +++++++---
> >  9 files changed, 65 insertions(+), 31 deletions(-)
> >
> > diff --git a/apply.c b/apply.c
> > index 43a0aebf4ee..12ea9c72a6b 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -3492,7 +3492,7 @@ static int three_way_merge(struct apply_state *state,
> >  {
> >       mmfile_t base_file, our_file, their_file;
> >       mmbuffer_t result = { NULL };
> > -     int status;
> > +     enum ll_merge_result status;
> >
> >       /* resolve trivial cases first */
> >       if (oideq(base, ours))
> > @@ -3509,6 +3509,9 @@ static int three_way_merge(struct apply_state *state,
> >                         &their_file, "theirs",
> >                         state->repo->index,
> >                         NULL);
> > +     if (status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     "base", "ours", "theirs");
>
> This used to come from ll_merge()
>
> > -                     warning("Cannot merge binary files: %s (%s vs. %s)",
> > -                             path, name1, name2);
> > -                     /* fallthru */
>
> And our call to ll_merge() above (half of it invisible in the
> pre-context of the hunk) gave "ours" and "theirs" to our_label and
> their_label, which in turn are called name1 and name2, respectively,
> in ll_merge_binary() driver.
>
> I am not sure about the "base" string, though.  I suspect that your
> "base" should be a reference to the parameter 'path' of three_way_merge()
> function.

Ah, indeed; thanks for reading carefully.

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index cbf73b8c9f6..3a559d69303 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -237,6 +237,7 @@ static int checkout_merged(int pos, const struct checkout *state,
> >       struct cache_entry *ce = active_cache[pos];
> >       const char *path = ce->name;
> >       mmfile_t ancestor, ours, theirs;
> > +     enum ll_merge_result merge_status;
> >       int status;
> >       struct object_id oid;
> >       mmbuffer_t result_buf;
> > @@ -267,13 +268,16 @@ static int checkout_merged(int pos, const struct checkout *state,
> >       memset(&ll_opts, 0, sizeof(ll_opts));
> >       git_config_get_bool("merge.renormalize", &renormalize);
> >       ll_opts.renormalize = renormalize;
> > -     status = ll_merge(&result_buf, path, &ancestor, "base",
> > -                       &ours, "ours", &theirs, "theirs",
> > -                       state->istate, &ll_opts);
> > +     merge_status = ll_merge(&result_buf, path, &ancestor, "base",
> > +                             &ours, "ours", &theirs, "theirs",
> > +                             state->istate, &ll_opts);
> >       free(ancestor.ptr);
> >       free(ours.ptr);
> >       free(theirs.ptr);
> > -     if (status < 0 || !result_buf.ptr) {
> > +     if (merge_status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     path, "ours", "theirs");
>
> This one looks correct.
>
> > +     if (merge_status < 0 || !result_buf.ptr) {
> >               free(result_buf.ptr);
> >               return error(_("path '%s': cannot merge"), path);
> >       }
>
> > diff --git a/merge-blobs.c b/merge-blobs.c
> > index ee0a0e90c94..8138090f81c 100644
> > --- a/merge-blobs.c
> > +++ b/merge-blobs.c
> > @@ -36,7 +36,7 @@ static void *three_way_filemerge(struct index_state *istate,
> >                                mmfile_t *their,
> >                                unsigned long *size)
> >  {
> > -     int merge_status;
> > +     enum ll_merge_result merge_status;
> >       mmbuffer_t res;
> >
> >       /*
> > @@ -50,6 +50,9 @@ static void *three_way_filemerge(struct index_state *istate,
> >                               istate, NULL);
> >       if (merge_status < 0)
> >               return NULL;
> > +     if (merge_status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     path, ".our", ".their");
>
> OK.
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 0342f104836..c24da2ba3cb 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -1743,7 +1743,7 @@ static int merge_3way(struct merge_options *opt,
> >       mmfile_t orig, src1, src2;
> >       struct ll_merge_options ll_opts = {0};
> >       char *base, *name1, *name2;
> > -     int merge_status;
> > +     enum ll_merge_result merge_status;
> >
> >       if (!opt->priv->attr_index.initialized)
> >               initialize_attr_index(opt);
> > @@ -1787,6 +1787,9 @@ static int merge_3way(struct merge_options *opt,
> >       merge_status = ll_merge(result_buf, path, &orig, base,
> >                               &src1, name1, &src2, name2,
> >                               &opt->priv->attr_index, &ll_opts);
> > +     if (merge_status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     path, name1, name2);
>
> OK; this is your code and I do not have to read it too carefully,
> but all we need is conveniently in the pre-context of the hunk ;-).
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index d9457797dbb..bc73c52dd84 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1044,7 +1044,7 @@ static int merge_3way(struct merge_options *opt,
> >       mmfile_t orig, src1, src2;
> >       struct ll_merge_options ll_opts = {0};
> >       char *base, *name1, *name2;
> > -     int merge_status;
> > +     enum ll_merge_result merge_status;
> >
> >       ll_opts.renormalize = opt->renormalize;
> >       ll_opts.extra_marker_size = extra_marker_size;
> > @@ -1090,6 +1090,9 @@ static int merge_3way(struct merge_options *opt,
> >       merge_status = ll_merge(result_buf, a->path, &orig, base,
> >                               &src1, name1, &src2, name2,
> >                               opt->repo->index, &ll_opts);
> > +     if (merge_status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     a->path, name1, name2);
>
> OK.
>
> > diff --git a/notes-merge.c b/notes-merge.c
> > index b4a3a903e86..01d596920ea 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -344,7 +344,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
> >  {
> >       mmbuffer_t result_buf;
> >       mmfile_t base, local, remote;
> > -     int status;
> > +     enum ll_merge_result status;
> >
> >       read_mmblob(&base, &p->base);
> >       read_mmblob(&local, &p->local);
> > @@ -358,6 +358,9 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
> >       free(local.ptr);
> >       free(remote.ptr);
> >
> > +     if (status == LL_MERGE_BINARY_CONFLICT)
> > +             warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                     oid_to_hex(&p->obj), o->local_ref, o->remote_ref);
>
> This uses another slot in the rotating buffer used by oid_to_hex(),
> but I do not think anybody grabbed a pointer to one of them and held
> onto it before we got here, so it would be OK.
>
> > diff --git a/rerere.c b/rerere.c
> > index d83d58df4fb..46fd01819b8 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -609,19 +609,23 @@ static int try_merge(struct index_state *istate,
> >                    const struct rerere_id *id, const char *path,
> >                    mmfile_t *cur, mmbuffer_t *result)
> >  {
> > -     int ret;
> > +     enum ll_merge_result ret;
> >       mmfile_t base = {NULL, 0}, other = {NULL, 0};
> >
> >       if (read_mmfile(&base, rerere_path(id, "preimage")) ||
> >           read_mmfile(&other, rerere_path(id, "postimage")))
> > -             ret = 1;
> > -     else
> > +             ret = LL_MERGE_CONFLICT;
> > +     else {
>
> Let's have {} around the if clause now the corresponding else clause
> needs it.

Will fix.

> >               /*
> >                * A three-way merge. Note that this honors user-customizable
> >                * low-level merge driver settings.
> >                */
> >               ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
> >                              istate, NULL);
> > +             if (ret == LL_MERGE_BINARY_CONFLICT)
> > +                     warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                             path, "", "");
> > +     }
>
> This is a faithful conversion of what should not happen in practice,
> as the rerere logic would not be able to reach here.  In a binary
> file, we won't be able to identify <<< === >>> blocks, hash the text
> in the conflicted block to come up with the conflict ID to find the
> preimage and postimage files.  These files are the input to the low
> level merge driver call we are making here.
>
> Looking almost good except for a warning message bug I spotted
> earlier.
>
> Thanks.
