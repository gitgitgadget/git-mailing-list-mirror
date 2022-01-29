Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BDC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 07:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbiA2HEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348161AbiA2HEB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 02:04:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF17C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:04:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s5so23779924ejx.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yH+Wyq6/k/bLiyHFne+leNUVY1kPFNRCGjrl5F6Ncz4=;
        b=bjUhHkEq2/AFQ9yQZSgkOxsEWd2yxXFreGRMwQtqGgpV8964EDXnmrOhsFOltXoHyl
         8sy/l+2Gt7y0y1qUmIuxb2qan1kdMG/p0QQ9QX8A1FIxINNe+u0xwok2a+wwB0wq0iRo
         GhByxhb3gJ5ayN4YEXanU/lt9VoJnUg+4HOIpfGUlGQXGBCR/pMSl5Sm11MgAQDJY1sn
         WNYMpU6inps9VfwlbF2qUzr1arHtEnGGoXdQf49YoM5+O/P03q+ek2DqUfDlQBWKJx0R
         CjcWsQFsLvTSe5iMjKvcP7lnfMmnxLGOmMAZzMWitnGJ0WHpoT87Gzffz6cOcOPIo6AE
         Bp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yH+Wyq6/k/bLiyHFne+leNUVY1kPFNRCGjrl5F6Ncz4=;
        b=yzY2Ekv2qy8X3tjdKHkipjeOVEL7dLIkw1IpSPqsNaVEn8YEunFoJXXcpSlwqiEDkx
         jfbiq9AizYwX9TlbUyWqU+8oIio1FYJUqgSyOsxdPPBNueZpG71EweBDgjvrU3eWIDHE
         6V03AGjPI2um2qxpEMIuO7QRAM2HPMOApTEizFFXZata3oMUKh3dCua6pNMi6kjLJYsc
         nW3LWTxl2dwouVyYysADzN+VywUPvhBmt3GvIWlbQjOhIUcw8sF9vaUzDlldV3lwCeug
         3wC8fRYeJESV04badNpkQu6kX1H+cERRNvLLnjCTJTTxvDwJsnuhkbSQYkm5ee2JVg/m
         PSfA==
X-Gm-Message-State: AOAM5326H4azuEOetQ3tXA8BHlEtVxuX66B+MTwTVeQtK2mu1O00ygjx
        Co35G7HI+9uWFT+TNUj0847amJXy7fPG6sgDnfY=
X-Google-Smtp-Source: ABdhPJwa9JdwDUC2MG1bwEE6cCjCOB1hvgUzAdmOswlajzBM/HEFFJpjEGIHMlo+Ki2yiAyEzTw06geD77oMC7fHwEc=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr4083095ejc.100.1643439839254;
 Fri, 28 Jan 2022 23:03:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
In-Reply-To: <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 23:03:47 -0800
Message-ID: <CABPp-BH2sWWwy5bgn+R0hnnYQ6o0+1R1=VB-LYzDM+p4NMRhWg@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 12:48 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > Updates since v2 (thanks to Christian, Dscho, Ramsay, and Ren=C3=A9 for
> > suggestions and comments on v2):
> >
> >  * Significant changes to output format:
> >    * Flags no longer take a filename for additional output; they write =
to
> >      stdout instead.
> >    * More information included by default when there are conflicts (no =
need
> >      to request it with additional flags, instead flags can be used to
> >      suppress it).
> >    * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style =
of
> >      information -- when there are conflicts. Add a flag to only list
> >      conflicted files if that's preferred.
>
> The above changes seem good to me.

:-)

> >  * Much more thorough manual for git-merge-tree.txt
> >  * Renamed option from --real to --write-tree
> >  * Accept an optional --trivial-merge option to get old style merge-tre=
e
> >    behavior
> >  * Allow both --write-tree and --trivial-merge to be omitted since we c=
an
> >    deduce which from number of arguments
>
> I still think that it might be simpler and cleaner to leave 'git
> merge-tree' alone for now, and just add a new command named for
> example 'git write-merge-tree'. Later we can always add flags to 'git
> merge-tree' or add 'git trivial-merge-tree' as an alias for 'git
> merge-tree', and eventually slowly switch 'git merge-tree' to mean
> only 'git write-merge-tree' if that's where we want to go.

Understood.  Since we can't immediately kill the old merge-tree, I
don't think there's a perfectly clean solution here, and it's totally
understandable that different folks would have different opinions on
which interim choice would be cleanest.  What you suggest is
reasonable, I just personally prefer the path in this series.

> >  * Document exit code when the merge cannot be run (so we can distingui=
sh
> >    other error cases from conflicts)
> >  * testcase cleanups: test_tick, early skip of test when using recursiv=
e
> >    backend, variable renames, etc.
> >  * various minor code cleanups
> >  * Add a new --allow-unrelated-histories option (with same meaning as t=
he
> >    one used in git merge)
>
> The above changes seem good to me too.

Thanks for reading over things carefully and for providing many
detailed, helpful comments!

> > Stuff intentionally NOT included, but which others seemed to feel stron=
gly
> > about; they'd need to convince me more on these:
> >
> >  * Any form of diff output[1]
>
> It's not a big issue for me to not include them right now as long as
> it's possible to add cli options later that add them.

My main concern is just that `merge-tree` remain a low-level tool and
have machine-parseable output.  I was a little worried that both you
and Dscho wanted everything on stdout rather than in separate files,
as the <Informational messages> part of the output is rather
free-form.  But since it's at the end, and has a machine-parseable
beginning, it can just be slurped in and we're all good.  The diff
output raises my eyebrow because I'm worried we're losing this
property.  If there are clear usecases for adding more output, and we
can do so without losing this machine-parseable property, I don't have
a problem with adding an option for it.

One analogy we might use here is that `git merge` provides a diffstat
at the end.  What you're asking is more than a diffstat, but might be
considered similar-ish in nature.

> The reason is
> that I think in many cases when there are conflicts, the conflicts
> will be small and the user will want to see them.

I'm a little worried about the assumption here that conflict size is
measurable and visible via diffs.  That might be true in some cases,
but a UI written with that assumption is going to be very confusing
when hitting cases where that assumption does not hold.  For example:

  * What if there is a binary file conflict, or a modify/delete or
rename/delete conflict, or failed-to-merge submodule conflict, or a
file location conflict? (For these, there is no diff relative to the
first parent and hence this conflict would have no diff output for
it)?
  * What if there was a simple file/directory conflict?  A diff would
show a rename (even when neither side did any renames), but not any
conflict markers.
  * What if there was a rename/rename conflict (both sides renamed
same file differently) or a distinct types conflict?  The former
results in three different conflicting files, none of them with
conflict markers, while the latter results in two different
conflicting files both without conflict markers?  Showing individual
per-file diffs totally loses all context here -- it'll show no-diff
for one of the files, and totally new additions for the ones.

Such a problem statement just seems fraught with edge cases to me, and
suggests that the problem statement might be in need of revisiting.

Don't read this as me closing the door on the possibility of diffs;
I'm not trying to do that.  I'm listing my misgivings about how I
think they might be used (i.e. be careful if you're headed down this
path as you might be digging yourself a never-ending support hole).
You can also think of my comments as feedback to consider and address
when you propose a future feature addition for adding diffs.  If/when
you propose such a feature, we'd probably be able to dive more into
specifics and usecases at that time, which may or may not circumvent
my concerns.

> So it would be
> simpler to just have an option to show any conflict right away, rather
> than have the user launch another command (a diff-tree against which
> tree and with which options?).

Um, this part I'm not sure I get.  I thought the reason for the diffs
was performance -- you knew you wanted the diffs, and you wanted it
done as part of the same process.  But why would this be simpler?
Your patch series included three different diffs, and the emails you
pointed me at suggested all kinds of configurability.  That suggests
the merge-tree command would have to take the exact same options the
user would supply to diff, and thus would have to be told all the same
options, right?  I don't see how this removes any complexity at all
for the user.

Unless...is the request in some way similar to merge's diffstat where
there is always a very specific type of diff that is wanted and you
aren't envisioning much flexibility in what kind of diff or what to
diff against -- is that where the simplification comes from?
