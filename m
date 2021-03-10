Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B5C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162CB64FB5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhCJTpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhCJTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:45:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB2C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:45:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ba1so9017758plb.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhMsXp3Eh3UCCTi/QpSoFUymJgUGv4xUYWp+rDX+PWg=;
        b=OThAdaem3qbyEi9fy4a1IXSV1wK6lxgsieue/Sx+93s0zONFDnmykJgXk4+KxZAXdU
         wFGoP1gNGxtowQFFhSfFIXA9T1bLlWtZEz2tBgQ3dfYetgpnG6gaBWLhoqHwfYSgotai
         KjxMclkrrDRq8cnoasAnSxC7JDyA9LxIdShUkk+yPQNh8Fjq0bd8624VM2Fs/sQeZLVI
         kfFEXwa4jsaINI3E9tDV27wdZ0/HOoGGikMrWVigqLLNfptEdrcluY/WeyPtPF2jqbNx
         kpLgFycVOSFIv5wvjMGoSEp6XKyFcD0uvjW2MwnFBT0DyatrJQGnsws04DLK9ZeakF2O
         GNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhMsXp3Eh3UCCTi/QpSoFUymJgUGv4xUYWp+rDX+PWg=;
        b=pSuuW1iIlAFXiuF/cD7A9+47fvx1/PCL9HxHTEP2hFhSir8khItcAuSrYkH0lAvG/6
         q8OlSwFwaYMYB9KJ8XAg9mrt+c2WGjGUSfgFSXyP5I9aefHh5RbJ4WCgFS1nZKf4r5dB
         XWU6NhXGv/DGs5YoeeJ6xvXMISDFbMC6/gcJVlE8lw5UNNjRR24f0pCWclDJAJPy+hYI
         VACmcyCFDs4aoKNXT4PRkbTsn0/EdDSc+0EKzuSWdRlSR17h1Qk/sucg/E8gUZcqaZOm
         MxlYXAdSljj7ytfHx10JCSFmrbYz8/l9MmB4pf+zbMqlUNAq6msPNAfgjWsit4+p2u5I
         UVlA==
X-Gm-Message-State: AOAM530Btol17tHNSyP90+jKyZrKkaQ6g4LjvATw4olK9ybjiI8EMTdT
        WoqrjTn6Tz7382UuMCiwRgRwfOShp1g4jg==
X-Google-Smtp-Source: ABdhPJyVYA+KPOq6slmEM+qfFT9WqQsHfWm5N333kmC3yo8+TRRgSvqQbyFuanOvgvdFsFm6bYxc6w==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr5051128pjh.29.1615405502390;
        Wed, 10 Mar 2021 11:45:02 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:45:01 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 6/6] doc/git-commit: add documentation for fixup=[amend|reword] options
Date:   Thu, 11 Mar 2021 01:13:10 +0530
Message-Id: <20210310194306.32565-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-commit.txt | 41 ++++++++++++++++++++++++++++++------
 Documentation/git-rebase.txt | 21 +++++++++---------
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7ea..2de8255bdb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
+	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
@@ -86,11 +86,40 @@ OPTIONS
 	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
---fixup=<commit>::
-	Construct a commit message for use with `rebase --autosquash`.
-	The commit message will be the subject line from the specified
-	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
-	for details.
+--fixup=[(amend|reword):]<commit>::
+	Construct a new commit for use with `rebase --autosquash`,
+	which fixes the specified commit. The plain form
+	`--fixup=<commit>` creates a "fixup!" commit, that allows
+	to fixup only the content of the specified commit and leave
+	it's commit log message untouched. When used with `amend:`
+	or `reword:`, it creates "amend!" commit that is like "fixup!"
+	commit but it allows to fixup both the content and the commit
+	log message of the specified commit. The commit log message of
+	the specified commit is fixed implicitly by replacing it with
+	the "amend!" commit's message body upon `rebase --autosquash`.
++
+The resulting "fixup!" commit message will be the subject line
+from the specified commit with a prefix of "fixup!". Can be used
+with additional commit message option `-m`.
++
+The `--fixup=amend:<commit>` form creates an "amend!" commit where
+its commit message subject will be the subject line from the
+specified commit with a prefix of "amend!" and the message body
+will be commit log message of the specified commit. It also invokes
+an editor seeded with the log message of the "amend!" commit to
+allow to edit further. It refuses to create "amend!" commit if it's
+commit message body is empty unless used with the
+`--allow-empty-message` option.
++
+The `--fixup=reword:<commit>` aliases `--fixup=amend:<commit> --only`
+and it also creates an "amend!" commit, but here it records the same
+tree as `HEAD`, i.e. it does not take any staged changes and only allows
+to fixup the commit message of the specified commit. It will reword the
+specified commit when it is rebased with `--autosquash`.
++
+Also, after fixing the commit using `--fixup`, with or without option
+and rebased with `--autosquash`, the authorship of the original commit
+remains unchanged. See linkgit:git-rebase[1] for details.
 
 --squash=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8bfa5a9272..f08ae27e2a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -593,16 +593,17 @@ See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is already a commit in the todo list that
-	matches the same `...`, automatically modify the todo list of rebase
-	-i so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved commit
-	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
-	the commit subject matches, or if the `...` refers to the commit's
-	hash. As a fall-back, partial matches of the commit subject work,
-	too.  The recommended way to create fixup/squash commits is by using
-	the `--fixup`/`--squash` options of linkgit:git-commit[1].
+	When the commit log message begins with "squash! ..." or "fixup! ..."
+	or "amend! ...", and there is already a commit in the todo list that
+	matches the same `...`, automatically modify the todo list of
+	`rebase -i`, so that the commit marked for squashing comes right after
+	the commit to be modified, and change the action of the moved commit
+	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
+	matches the `...` if the commit subject matches, or if the `...` refers
+	to the commit's hash. As a fall-back, partial matches of the commit
+	subject work, too. The recommended way to create fixup/amend/squash
+	commits is by using the `--fixup`, `--fixup=amend:` or `--fixup=reword:`
+	and `--squash` options respectively of linkgit:git-commit[1].
 +
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
-- 
2.29.0.rc1

