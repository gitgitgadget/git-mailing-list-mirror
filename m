Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336EC352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92B020715
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXHg3hfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGNWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:22:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55246 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 08:21:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id g1so2547250wmh.4
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 05:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iY1dpoe4Lq4NevYW4eJJUpjLpGhk3Lk70E4o1pW3Sts=;
        b=ZXHg3hfIs4YKmM4nAQOV3RM/OEmAggSxFxVAgMCnObQ0ZEEP1MyuYwCqqvHuwh5/a9
         +gEGMVXIMlgSGv5DOq73AQrAniXRJfeRJULFD3tI2TJCvTafro8ZYSUGKW4TdXFSfXKa
         wtGfzmncAni8choTcuNyJ32nQDL8O4Z2Mj1L9o0d7+LYdP/azIwEu0M3dVeN1ws3ZtAS
         tmnPh2ayFa4+eXeeEPoW6ytGv+xdM3tzEpVdCbXqopKy5wNtZZ3K6ezqgrgHv4FtL0km
         XRDU7BcF3nGH3nzKAP8vrCyiABBn7hW4Gz4+GvGcTiwd8CH7nCiIAXrdoERGlELWahNI
         Oi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iY1dpoe4Lq4NevYW4eJJUpjLpGhk3Lk70E4o1pW3Sts=;
        b=FQS7WVaBD9PX7+IhlcHra1yigW3GKrvXkSBMq04hynM9okcMKejf6H1GQ17TutgZyL
         sMwc1VKz6kv0DyZy05bCijyUT54nTZMaYDbrIjkNPvIyDjj3KKBkaybtRTWdm0t97lj3
         lV70ukoFIis1aNcYkRkOoUCzJ+TGTzP8Wzr6vN9PJoMe3bdL/QFNhlXhOzM/IDzqsAiv
         y7XNGZMF3qM3CIBXRzoI91koCBFSOyPzu4HC7U61KZLqxXPZI2sRHOu7ZfZt9OCf4lGK
         BH0XhQnULNixG7s+9pU9ALZf9RKTiqGUqG6rY1uh+zn3+sRZNvhB41SC75PNj2hmc6x/
         vI9g==
X-Gm-Message-State: APjAAAWxJ50RW6/qFvw7pd0FOrkG5HC5fJ00/2KHugkShsK2WqA7vZNi
        yXd5MubzPfAMUeYFqtrJmn18w55s
X-Google-Smtp-Source: APXvYqwbRhWgIA/NxW8yUdJjaWw0AWewMkDVsYpev0Qp3OQn0tvSwtgzdsMyPxXQs7T4vFfMhy1BfA==
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr4307400wmg.157.1581081716361;
        Fri, 07 Feb 2020 05:21:56 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id 5sm3489343wrc.75.2020.02.07.05.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:21:54 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:21:52 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
Message-ID: <20200207132152.GC2868@szeder.dev>
References: <20200207111008.GA2868@szeder.dev>
 <20200207114954.GB2868@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207114954.GB2868@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 12:49:54PM +0100, SZEDER Gábor wrote:
> On Fri, Feb 07, 2020 at 12:10:08PM +0100, SZEDER Gábor wrote:
> > That's a good subject, isn't it? :)
> > 
> > So, to clarify: apparently it is possible to abort an ongoing 'git
> > rebase' process with ctrl-C in just the right moment that a subsequent
> > 'git rebase --abort' will refuse to clear it up.
> > 
> > I somehow messed up the upstream and branch parameters of 'git
> > rebase', and ended up trying to rebase a fairly recent (post v2.24.0)
> > branch on top of v2.22.0.  Upon seeing the unexpectedly large number
> > of patches I realized that something is wrong, hit ctrl-C right away,
> > and this is what happened:
> > 
> >   $ git rebase v2.22.0 <a-branch-on-top-of-2.24.0>
> >   First, rewinding head to replay your work on top of it...
> >   Generating patches: 100% (1108/1108), done.
> >   Applying: send-email: move the read_config() function above getopts
> >   Applying: send-email: rename the @bcclist variable for consistency
> >   Applying: send-email: do defaults -> config -> getopt in that order
> >   Using index info to reconstruct a base tree...
> >   M       git-send-email.perl
> >   M       t/t9001-send-email.sh
> >   Falling back to patching base and 3-way merge...
> >   Auto-merging t/t9001-send-email.sh
> >   Auto-merging git-send-email.perl
> >   ^C
> >   ((5f07da12ac...) *|REBASE 3/1108)$ git rebase --abort 
> >   error: could not read '/home/szeder/src/git/.git/worktrees/WT/rebase-apply/head-name': No such file or directory
> >    
> > "Fortunately" it was in a separate worktree, so I could easily get out
> > of the situation by forcibly deleting that worktree.  Unfortunately,
> > that was exactly what I did, instead of securing the failed state for
> > later analysis...  sorry.
> 
> > All this is with a git built from current 'next', with a bunch of
> > unrelated (none of them touches rebase or the sequencer) patches on
> > top.
> 
> Trying to reproduce it is a hit or miss... well, mostly miss :)
> 
> There is a rather short window when 'git rebase' applies patches
> before hitting a first merge conflict.  If the ctrl-C arrives before
> 'git rebase' starts applying patches, then it cleans everything up,
> and we are not rebasing, so there is no need for 'git rebase --abort'.
> Once 'git rebase' stops because of the merge conflict we get our shell
> back, and 'git rebase --abort' works as it should.  But after a good
> couple of tries I managed to hit ctrl-C while 'git rebase' was
> applying patches:

This patch below increases the size of the window where a ctrl-C gets
us into that problematic situation:

diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..5d62766000 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1737,6 +1737,14 @@ static void am_run(struct am_state *state, int resume)
 			exit(1);
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
+		{
+			int i;
+			for (i = 0; i < 60; i++) {
+				fprintf(stderr, "sleeping... %d\r", i);
+				sleep(1);
+			}
+			fprintf(stderr, "\n");
+		}
 
 		apply_status = run_apply(state, NULL);
 
And then we can reliably reproduce the issue even when rebasing only a
single commit:

  $ ./bin-wrappers/git rebase v2.25.0 9c8a294
  First, rewinding head to replay your work on top of it...
  Applying: sha1-file: remove OBJECT_INFO_SKIP_CACHED
  ^Ceeping... 3
  ((v2.25.0)|REBASE 1/1)$ ./bin-wrappers/git rebase --abort 
  error: could not read '.git/rebase-apply/head-name': No such file or directory

Note that the sleep() calls were added to 'builtin/am.c', i.e. this
issue is present in the 'am' rebase backend.  I tried to break 'git
rebase -m ...' by adding sleep()s to various places in pick_commits()
in 'sequencer.c', but, FWIW, the subsequent 'git rebase --abort'
always worked as expected.

So we may have yet another reason to switch the default rebase backend
from 'am' to 'merge'.


> Finally, note the 'v2.24.0^{commit}' parameter, in particular the
> '^{commit}' part.  That's important, because without it we stumble
> upon _another_ bug:
> 
>   $ git rebase v2.22.0 v2.24.0
>   error: Object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 not a commit
>   First, rewinding head to replay your work on top of it...
>   Generating patches: 100% (1049/1049), done.
>   Applying: send-email: move the read_config() function above getopts
>   < ... applying further patches and hitting a merge conflict ... >
>   Resolve all conflicts manually, mark them as resolved with
>   "git add/rm <conflicted_files>", then run "git rebase --continue".
>   You can instead skip this commit: run "git rebase --skip".
>   To abort and get back to the state before "git rebase", run "git rebase --abort".
>   (detached HEAD *+|REBASE 7/1049)$ git rebase --abort 
>   error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 to branch 'HEAD'
> 
> So 'git rebase' shows an error right at the beginning when rebasing a
> tag, but then continues anyway.  However, 'git rebase --abort' can't
> restore the original state.

Now let's rebase a tag with the 'merge' backend, and then try to abort
it:

  $ ./BUILDS/v2.25.0/bin/git rebase -m v2.22.0 v2.24.0
  error: Object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 not a commit
  Auto-merging t/t9001-send-email.sh
  Auto-merging git-send-email.perl
  CONFLICT (content): Merge conflict in git-send-email.perl
  Auto-merging Documentation/git-send-email.txt
  error: could not apply 3ff15040e2... send-email: fix regression in sendemail.identity parsing
  Resolve all conflicts manually, mark them as resolved with
  "git add/rm <conflicted_files>", then run "git rebase --continue".
  You can instead skip this commit: run "git rebase --skip".
  To abort and get back to the state before "git rebase", run "git rebase --abort".
  Recorded preimage for 'git-send-email.perl'
  Could not apply 3ff15040e2... send-email: fix regression in sendemail.identity parsing
  (detached HEAD *+|REBASE 7/1049)$ ./BUILDS/v2.25.0/bin/git rebase --abort
  ((v2.24.0))$

So it prints the same error as the 'am' backend (or perhaps that error
comes from the common, backend-independent parts of rebase?  I didn't
look), and it continues all the same, but in the end '--abort' is
capable to abort the operation.  So we do have yet another reason to
switch the default backend.

