Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777FC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C38214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8bCAgP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGRxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:53:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35599 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 12:53:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so2819559oie.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tNdRp3zrqfhsmzdHhwKundNEXfruQUYmQD9kjbaGzt8=;
        b=n8bCAgP3hOAi+JhUSpdHiukebiVQAYzX/j6s5FgJ0Tje+bKl9svdTlzp/YCWEFYnYs
         8s7U7LHaiiQSjbjFAHH6mGh7n16om98R8kzJBPE0lwM8Uyl8j7QqXTEpD42zImBfkxC5
         mYi0RnivOFgr2Hvz8d/pUtRRoSvIGXYqNQ6DNb2BNk0J4xQl2x8t+norBzsMcAOEgRmD
         fEFjuf/iSSQzJ0S8HZdvJuOoNSLmJ61kUpb5uQhCXdwT6VjbGz59RJpWB4y4051nx0zR
         GoGXFRDmVPoFwbM3sszmf62uJbmEn8ahDavPqW5QLr3ILkl4UQYBR1Soq5gDfWqG1Mfr
         QE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tNdRp3zrqfhsmzdHhwKundNEXfruQUYmQD9kjbaGzt8=;
        b=kNIMFs/sa+CyV7oaY+Kbj9vFz/o/2S0MN7rSOnG7XEd9gaIWKsIkdk6+R1FHONjiwZ
         jBJlejPfebA3lA8jPj3Hk45+8Cia/ATmBISm0rlWqomH9nnxb5EvExZTDssh0D2nthaC
         tUVnB/iNRndn1OhMQAWSsBuFqJfjz8xP7nSGjKZxUQl5EArD9p2QQoK28asXZWGE8hZK
         WxyuUhunzB6GJDgJfCEXQQfZfJaM3elGA3UzdKKmRqk2Omvj71zWphc+uMVvYDl2DpH4
         wlKDf1j54w1yJI1Pdn4T7snvN1f3IeI2TZQtN+r4kp/uE7O99EOIWISH4wcQMOZZjq2p
         tkrA==
X-Gm-Message-State: APjAAAWS/9HSOGfFPOiiG9yMkVXHiiESnH+LWypYyb1kL4UlmEJnj6Sw
        m798x1FY3HUjxtWaNIvlq4iWqx9E52CdQ77b20o=
X-Google-Smtp-Source: APXvYqztthDiWsxozw8IDPPCOJ0g+XQYdrM/TfB/PYzWf3+VkO2rDtE8LsASJ1a2CQE4jwXifvQL5C/CFzJXNJ8KW5A=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr2933964oig.39.1581097983169;
 Fri, 07 Feb 2020 09:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20200207111008.GA2868@szeder.dev> <20200207114954.GB2868@szeder.dev>
 <20200207132152.GC2868@szeder.dev>
In-Reply-To: <20200207132152.GC2868@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Feb 2020 09:52:51 -0800
Message-ID: <CABPp-BHum+h4mni4zc1R+6WfsVe6BHh8QeqidAzCR37WtwgKAQ@mail.gmail.com>
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 5:21 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Fri, Feb 07, 2020 at 12:49:54PM +0100, SZEDER G=C3=A1bor wrote:
> > On Fri, Feb 07, 2020 at 12:10:08PM +0100, SZEDER G=C3=A1bor wrote:
> > > That's a good subject, isn't it? :)

Indeed.  :-)

> > > So, to clarify: apparently it is possible to abort an ongoing 'git
> > > rebase' process with ctrl-C in just the right moment that a subsequen=
t
> > > 'git rebase --abort' will refuse to clear it up.
> > >
> > > I somehow messed up the upstream and branch parameters of 'git
> > > rebase', and ended up trying to rebase a fairly recent (post v2.24.0)
> > > branch on top of v2.22.0.  Upon seeing the unexpectedly large number
> > > of patches I realized that something is wrong, hit ctrl-C right away,
> > > and this is what happened:
> > >
> > >   $ git rebase v2.22.0 <a-branch-on-top-of-2.24.0>
> > >   First, rewinding head to replay your work on top of it...
> > >   Generating patches: 100% (1108/1108), done.
> > >   Applying: send-email: move the read_config() function above getopts
> > >   Applying: send-email: rename the @bcclist variable for consistency
> > >   Applying: send-email: do defaults -> config -> getopt in that order
> > >   Using index info to reconstruct a base tree...
> > >   M       git-send-email.perl
> > >   M       t/t9001-send-email.sh
> > >   Falling back to patching base and 3-way merge...
> > >   Auto-merging t/t9001-send-email.sh
> > >   Auto-merging git-send-email.perl
> > >   ^C
> > >   ((5f07da12ac...) *|REBASE 3/1108)$ git rebase --abort
> > >   error: could not read '/home/szeder/src/git/.git/worktrees/WT/rebas=
e-apply/head-name': No such file or directory
> > >
> > > "Fortunately" it was in a separate worktree, so I could easily get ou=
t
> > > of the situation by forcibly deleting that worktree.  Unfortunately,
> > > that was exactly what I did, instead of securing the failed state for
> > > later analysis...  sorry.
> >
> > > All this is with a git built from current 'next', with a bunch of
> > > unrelated (none of them touches rebase or the sequencer) patches on
> > > top.
> >
> > Trying to reproduce it is a hit or miss... well, mostly miss :)
> >
> > There is a rather short window when 'git rebase' applies patches
> > before hitting a first merge conflict.  If the ctrl-C arrives before
> > 'git rebase' starts applying patches, then it cleans everything up,
> > and we are not rebasing, so there is no need for 'git rebase --abort'.
> > Once 'git rebase' stops because of the merge conflict we get our shell
> > back, and 'git rebase --abort' works as it should.  But after a good
> > couple of tries I managed to hit ctrl-C while 'git rebase' was
> > applying patches:
>
> This patch below increases the size of the window where a ctrl-C gets
> us into that problematic situation:
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 8181c2aef3..5d62766000 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1737,6 +1737,14 @@ static void am_run(struct am_state *state, int res=
ume)
>                         exit(1);
>
>                 say(state, stdout, _("Applying: %.*s"), linelen(state->ms=
g), state->msg);
> +               {
> +                       int i;
> +                       for (i =3D 0; i < 60; i++) {
> +                               fprintf(stderr, "sleeping... %d\r", i);
> +                               sleep(1);
> +                       }
> +                       fprintf(stderr, "\n");
> +               }
>
>                 apply_status =3D run_apply(state, NULL);
>
> And then we can reliably reproduce the issue even when rebasing only a
> single commit:
>
>   $ ./bin-wrappers/git rebase v2.25.0 9c8a294
>   First, rewinding head to replay your work on top of it...
>   Applying: sha1-file: remove OBJECT_INFO_SKIP_CACHED
>   ^Ceeping... 3
>   ((v2.25.0)|REBASE 1/1)$ ./bin-wrappers/git rebase --abort
>   error: could not read '.git/rebase-apply/head-name': No such file or di=
rectory
>
> Note that the sleep() calls were added to 'builtin/am.c', i.e. this
> issue is present in the 'am' rebase backend.  I tried to break 'git
> rebase -m ...' by adding sleep()s to various places in pick_commits()
> in 'sequencer.c', but, FWIW, the subsequent 'git rebase --abort'
> always worked as expected.
>
> So we may have yet another reason to switch the default rebase backend
> from 'am' to 'merge'.
>
>
> > Finally, note the 'v2.24.0^{commit}' parameter, in particular the
> > '^{commit}' part.  That's important, because without it we stumble
> > upon _another_ bug:
> >
> >   $ git rebase v2.22.0 v2.24.0
> >   error: Object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 not a commit
> >   First, rewinding head to replay your work on top of it...
> >   Generating patches: 100% (1049/1049), done.
> >   Applying: send-email: move the read_config() function above getopts
> >   < ... applying further patches and hitting a merge conflict ... >
> >   Resolve all conflicts manually, mark them as resolved with
> >   "git add/rm <conflicted_files>", then run "git rebase --continue".
> >   You can instead skip this commit: run "git rebase --skip".
> >   To abort and get back to the state before "git rebase", run "git reba=
se --abort".
> >   (detached HEAD *+|REBASE 7/1049)$ git rebase --abort
> >   error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': tr=
ying to write non-commit object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 to=
 branch 'HEAD'
> >
> > So 'git rebase' shows an error right at the beginning when rebasing a
> > tag, but then continues anyway.  However, 'git rebase --abort' can't
> > restore the original state.
>
> Now let's rebase a tag with the 'merge' backend, and then try to abort
> it:
>
>   $ ./BUILDS/v2.25.0/bin/git rebase -m v2.22.0 v2.24.0
>   error: Object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 not a commit
>   Auto-merging t/t9001-send-email.sh
>   Auto-merging git-send-email.perl
>   CONFLICT (content): Merge conflict in git-send-email.perl
>   Auto-merging Documentation/git-send-email.txt
>   error: could not apply 3ff15040e2... send-email: fix regression in send=
email.identity parsing
>   Resolve all conflicts manually, mark them as resolved with
>   "git add/rm <conflicted_files>", then run "git rebase --continue".
>   You can instead skip this commit: run "git rebase --skip".
>   To abort and get back to the state before "git rebase", run "git rebase=
 --abort".
>   Recorded preimage for 'git-send-email.perl'
>   Could not apply 3ff15040e2... send-email: fix regression in sendemail.i=
dentity parsing
>   (detached HEAD *+|REBASE 7/1049)$ ./BUILDS/v2.25.0/bin/git rebase --abo=
rt
>   ((v2.24.0))$
>
> So it prints the same error as the 'am' backend (or perhaps that error
> comes from the common, backend-independent parts of rebase?  I didn't
> look), and it continues all the same, but in the end '--abort' is
> capable to abort the operation.  So we do have yet another reason to
> switch the default backend.

Ooh, interesting; thanks for investigating and providing a heads up.
I should probably add a note about this to the "differences between
backends"; I'll roll it into whatever changes I might need to make
with Phillip's review of the series.
