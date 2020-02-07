Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8DC352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6956C20720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlrGjq2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGLKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:10:18 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36137 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 06:10:18 -0500
Received: by mail-wm1-f46.google.com with SMTP id p17so2296963wma.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7QCvWQu7LFPonKqTqJix1dBRZUtlSQGEUmgobWyx0b0=;
        b=rlrGjq2ue80chDtMNe78yV7F3eBaSzGbI/hrymSPXLWotlHiWtGSHuDMiwgMv3Om7K
         IUyJW2+hHRiA5vN2bGO4L0Y/qhNLIXlw+e7okIJKi8YL3f98aPuhJvTJZ8/XlbZDdo83
         FXfm1QxHuX/GwWD7rxEf05n0a/poMa6peuwZ0oA4BJpImGGM5x1t6S76pkAwd7rGcMAn
         M8nu89GykWYfh58YFST30Sqi6yMR0KRlPvC92MNboo8/blcmdt5QsdqQJt5LWrcJDOkN
         XPELl7fa+86QvyNIOXtzfGW7Agp/X5devCgSVif0DkiZ8KRB2DFhRrSXnscMn6B+9fHD
         cL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7QCvWQu7LFPonKqTqJix1dBRZUtlSQGEUmgobWyx0b0=;
        b=qIJbxEcmXeCQ+2FALPB6nOZHAM411A8mxkf5rJjtLudlwFOSDbdDZX5c7kjer8vxyk
         rM+jIev3hk7hGFOCTt/Pg4+2JnxU7kLhEt3tCvf6nKRYEWnGHU4kEDTDBMLtRzUaq9Ou
         ejAie0aqnesFx4sHh8z8kVPREd7EcJrEOPo29W/ooOloaNKTiPC7hCXBwBxnWpJgoJ6w
         HJu94ec/QFccihwZklvDaZTYxz73Pc8ep9f9K7gLJ90UeVp3ZZzUgL1RNz7764OKQDfc
         FjnLXP2wUrlX7F7EXJq5aO9Suh2LLVObj+Jd3DDOfvrJgOVN58anqcCfBUMSFWHvPFHk
         KHUg==
X-Gm-Message-State: APjAAAUd1+5j5c22V4eNps+hDJRmCnh7sMsknzrgwgJslM0gKof+sHJT
        4/InUUT8PGqHfMaAAS52t49AM8Ti
X-Google-Smtp-Source: APXvYqxnRHROH5FcIVpbZUBiOATz4eLBKJKxwDMeQN26QT9/53bnKhQ3aAN1+zPRAS5U1gTmCIZG2g==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3784653wmf.75.1581073814959;
        Fri, 07 Feb 2020 03:10:14 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id i204sm3067471wma.44.2020.02.07.03.10.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 03:10:13 -0800 (PST)
Date:   Fri, 7 Feb 2020 12:10:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
Message-ID: <20200207111008.GA2868@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's a good subject, isn't it? :)

So, to clarify: apparently it is possible to abort an ongoing 'git
rebase' process with ctrl-C in just the right moment that a subsequent
'git rebase --abort' will refuse to clear it up.

I somehow messed up the upstream and branch parameters of 'git
rebase', and ended up trying to rebase a fairly recent (post v2.24.0)
branch on top of v2.22.0.  Upon seeing the unexpectedly large number
of patches I realized that something is wrong, hit ctrl-C right away,
and this is what happened:

  $ git rebase v2.22.0 <a-branch-on-top-of-2.24.0>
  First, rewinding head to replay your work on top of it...
  Generating patches: 100% (1108/1108), done.
  Applying: send-email: move the read_config() function above getopts
  Applying: send-email: rename the @bcclist variable for consistency
  Applying: send-email: do defaults -> config -> getopt in that order
  Using index info to reconstruct a base tree...
  M       git-send-email.perl
  M       t/t9001-send-email.sh
  Falling back to patching base and 3-way merge...
  Auto-merging t/t9001-send-email.sh
  Auto-merging git-send-email.perl
  ^C
  ((5f07da12ac...) *|REBASE 3/1108)$ git rebase --abort 
  error: could not read '/home/szeder/src/git/.git/worktrees/WT/rebase-apply/head-name': No such file or directory
   
"Fortunately" it was in a separate worktree, so I could easily get out
of the situation by forcibly deleting that worktree.  Unfortunately,
that was exactly what I did, instead of securing the failed state for
later analysis...  sorry.
The only thing I still have is the list of files in the rebase directory,
rescued from the terminal's scrollback buffer:

  $ ls ~/src/git/.git/worktrees/WT/rebase-apply/
  < ... omitting the 1k+ patch files ... >
  abort-safety
  apply-opt
  author-script
  final-commit
  keep
  last
  messageid
  next
  original-commit
  patch
  patch-merge-index
  quiet
  rebasing
  rewritten
  scissors
  sign
  threeway
  utf8

All this is with a git built from current 'next', with a bunch of
unrelated (none of them touches rebase or the sequencer) patches on
top.


