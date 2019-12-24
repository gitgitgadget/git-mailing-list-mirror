Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C93C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FEA206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAFKgbOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLXTzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40828 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXTzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id b8so18677719edx.7
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jS4fsimonN6RELyiEedcdE5V085NEX9nPuuerJLKRO8=;
        b=JAFKgbObJ5VZYwJCnQ2htUwQ1AIUJBI3k51Nbrbw+L6U7TolCTaWOdUOM4+O7NGpx6
         aO+fX20gfg3HQxhnjHMZCeCjfVrBfygpF8wTxUqOjWuyGbHC5gLsvWKulgxTdCbnfV0h
         uYp1b7gMB9orQVt0pHzdJgCWSZ8mSFn9eGhTSExvANSPLgXNxrD+Kw0/8L2SFsdn6b/7
         V8exu8Qsxnt8bhHR1k0kLHUkVOicvB1rJbh8JYQZpNl2EzziSDV4Zgnl/tS2yGIAg4qD
         JkPmSpqoGGkCMCR+bVqpQoyWDHzpHZqNg6g8yQkAyuNXEFpoPXiXxAqoojvv6Sp6bIyn
         FwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jS4fsimonN6RELyiEedcdE5V085NEX9nPuuerJLKRO8=;
        b=AZlnkvcMJmzl9icmBluxYSVXVjKeuIXXl6qv6Icm2OhQnPGMajzLb0vXmvbAUjGbdm
         EzWTajq7iJ0eN5elnkqyWPdCdmRLOjhkYWndR7bzCV5/i5ThXxiiiJ2VTLGhOJLU+EqI
         vNOUqlpKetJ5Omy1zARfQoWXqwav/Xmp3GJge2AotLOPmacIMoCGoaQbbMVh0qungrG9
         ICwFLEzk9lmy3kL9B/Gt8gkt2hiUVqTALRM03X4z497pGGIUUsGv2TXDc91gDt5c98Tm
         ZyXMwM0gxXwN9AdT4M7WyHUpZxhPdiKZXXY6jecFFLk5Crc6L2biWh5+zcWx9iZqE2Ma
         fSfQ==
X-Gm-Message-State: APjAAAXN2uumvpWkSPe3vad0fLHTu9kAxDKvtjGpjAMTYqun7dULN3KK
        HgAFyjzQdXe091eA+dyAK96ne/SX
X-Google-Smtp-Source: APXvYqy5yX8Vh5A+S5XR3l4pCe1Mg8MxZ/J6OfE7h8pTSp4OsE9YjBx3y38hJ0IfxJbnJmEl/HtacA==
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr39395948eja.21.1577217301112;
        Tue, 24 Dec 2019 11:55:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm2780617edx.12.2019.12.24.11.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:00 -0800 (PST)
Message-Id: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:44 +0000
Subject: [PATCH v3 00/15] rebase: make the default backend configurable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series does a lot of work around making the default rebase backend
configurable, and switching the default from the am backend to the
merge/interactive one.

See the cover letter for v1[*] for a more detailed motivation for the
series, the type of changes being made, and areas I'd like to reviewers to
focus on.

Changes since v2:

 * Tweaked patch 11 (commit message, and condensing if-else block that was
   same on both sides), as suggested by Denton

[*] 
https://lore.kernel.org/git/pull.679.git.git.1576861788.gitgitgadget@gmail.com/

Elijah Newren (15):
  rebase: extend the options for handling of empty commits
  t3406: simplify an already simple test
  rebase, sequencer: remove the broken GIT_QUIET handling
  rebase: make sure to pass along the quiet flag to the sequencer
  rebase: fix handling of restrict_revision
  t3432: make these tests work with either am or merge backends
  rebase: allow more types of rebases to fast-forward
  git-rebase.txt: add more details about behavioral differences of
    backends
  rebase: move incompatibility checks between backend options a bit
    earlier
  rebase: add an --am option
  git-prompt: change the prompt for interactive-based rebases
  rebase tests: mark tests specific to the am-backend with --am
  rebase tests: repeat some tests using the merge backend instead of am
  rebase: make the backend configurable via config setting
  rebase: change the default backend from "am" to "merge"

 Documentation/config/rebase.txt         |   8 ++
 Documentation/git-rebase.txt            | 150 ++++++++++++++++----
 builtin/rebase.c                        | 177 +++++++++++++++++++-----
 contrib/completion/git-prompt.sh        |   6 +-
 rebase-interactive.c                    |   4 +-
 rebase-interactive.h                    |   2 +-
 sequencer.c                             |  80 ++++++++---
 sequencer.h                             |   6 +-
 t/t3400-rebase.sh                       |  36 ++++-
 t/t3401-rebase-and-am-rename.sh         |   4 +-
 t/t3404-rebase-interactive.sh           |   2 +-
 t/t3406-rebase-message.sh               |  19 ++-
 t/t3407-rebase-abort.sh                 |   6 +-
 t/t3420-rebase-autostash.sh             |   2 +-
 t/t3421-rebase-topology-linear.sh       |   4 +-
 t/t3424-rebase-empty.sh                 |  89 ++++++++++++
 t/t3425-rebase-topology-merges.sh       |   8 +-
 t/t3427-rebase-subtree.sh               |  16 ++-
 t/t3432-rebase-fast-forward.sh          |  54 ++++----
 t/t3433-rebase-options-compatibility.sh |  13 +-
 t/t5407-post-rewrite-hook.sh            |  12 +-
 t/t5520-pull.sh                         |  27 +++-
 t/t6047-diff3-conflict-markers.sh       |  13 +-
 t/t7512-status-help.sh                  |  12 +-
 t/t9106-git-svn-commit-diff-clobber.sh  |   3 +-
 t/t9903-bash-prompt.sh                  |   8 +-
 26 files changed, 576 insertions(+), 185 deletions(-)
 create mode 100755 t/t3424-rebase-empty.sh


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v3
Pull-Request: https://github.com/git/git/pull/679

Range-diff vs v2:

  1:  1c2b77e94d =  1:  1c2b77e94d rebase: extend the options for handling of empty commits
  2:  bd3c5ec155 =  2:  bd3c5ec155 t3406: simplify an already simple test
  3:  49388b79fd =  3:  49388b79fd rebase, sequencer: remove the broken GIT_QUIET handling
  4:  478479358f =  4:  478479358f rebase: make sure to pass along the quiet flag to the sequencer
  5:  ee26f5a161 =  5:  ee26f5a161 rebase: fix handling of restrict_revision
  6:  34a69def33 =  6:  34a69def33 t3432: make these tests work with either am or merge backends
  7:  f2c92853b4 =  7:  f2c92853b4 rebase: allow more types of rebases to fast-forward
  8:  b307340f7c =  8:  b307340f7c git-rebase.txt: add more details about behavioral differences of backends
  9:  7c3f2e07f3 =  9:  7c3f2e07f3 rebase: move incompatibility checks between backend options a bit earlier
 10:  1df11f0b51 = 10:  1df11f0b51 rebase: add an --am option
 11:  94b5a3051d ! 11:  ff43593211 contrib: change the prompt for interactive-based rebases
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    contrib: change the prompt for interactive-based rebases
     +    git-prompt: change the prompt for interactive-based rebases
      
          In the past, we had different prompts for different types of rebases:
             REBASE: for am-based rebases
     @@ -40,17 +40,18 @@
       --- a/contrib/completion/git-prompt.sh
       +++ b/contrib/completion/git-prompt.sh
      @@
     + 		__git_eread "$g/rebase-merge/head-name" b
       		__git_eread "$g/rebase-merge/msgnum" step
       		__git_eread "$g/rebase-merge/end" total
     - 		if [ -f "$g/rebase-merge/interactive" ]; then
     +-		if [ -f "$g/rebase-merge/interactive" ]; then
      -			r="|REBASE-i"
     -+			r="|REBASE"
     - 		else
     +-		else
      -			r="|REBASE-m"
     -+			r="|REBASE"
     - 		fi
     +-		fi
     ++		r="|REBASE"
       	else
       		if [ -d "$g/rebase-apply" ]; then
     + 			__git_eread "$g/rebase-apply/next" step
      
       diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
       --- a/t/t9903-bash-prompt.sh
 12:  c905d288bf = 12:  99388f24e5 rebase tests: mark tests specific to the am-backend with --am
 13:  0287881361 = 13:  c2ba6317bf rebase tests: repeat some tests using the merge backend instead of am
 14:  ec782e711c = 14:  8bec6df51a rebase: make the backend configurable via config setting
 15:  7adcbc0bc5 = 15:  044853fd61 rebase: change the default backend from "am" to "merge"

-- 
gitgitgadget
