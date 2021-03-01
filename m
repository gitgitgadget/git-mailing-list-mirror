Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F700C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DBA64DF5
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhCAIuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhCAIsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:48:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D311C061221
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:47:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 201so11019705pfw.5
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=fu9Li6f2BXPvbJPvP3/+R8Hby4Jd/CBBLZZ/FboEsTg=;
        b=fCROvi4It/Z4qkJQhzw6i8Ot0FofmosxhIHYTZa1vfNMdJ9fVm0yBFpHqBfMqQx6Z+
         N9Hjbgithzk7r5j8HnaiuuaHg32UUKgG/+hmAYjCLZazveq4cPTd2P9YLH5FjvgvBXyL
         G0eh86p3iNCDSrcoq3Mfu5V3nfqqJdeUe/jEmGLsapwmTJn/Qt4mOOsu20nHjdmLe4Xt
         SYUvrBJp7ZS7dxySkgO+yT/P4Hg9HuPdpv/6mlrveDDd8+cAnP6Ee6+CCzjzthtfIwMU
         RP53MuMb0QC+lpTAdL6e+ujoYgQN2qXD2O/0EivbBiXmKtx5CuroR8z+qNVSiCwcQb0Y
         JBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=fu9Li6f2BXPvbJPvP3/+R8Hby4Jd/CBBLZZ/FboEsTg=;
        b=PKIz/xbPwwdz+65bTFdOjums0H8aEP8GZzmyyyX3L9Iu9XYpwp8K4ZHD5MmPlNaRnh
         TYAl+++ce68Kxhjxrac3kozYdjaYRw6uA30c8Qq16f+HWFyfwGdJVp/WdFJoikHOW5eV
         BSO0ubaCd6t45rFA5MSnGYOuurHm4KRvcIcYa7QxcDru/JAsp8Z82oWDTiGjT3LRBjAU
         SPbw3XkQ4lqid5qGcDHaZoPPkJLOi4fWIDUFw/7pySPMpdB7a3sWgYa3qd1/bRrOuxXJ
         OBrdaaCEBW01bPcCCjnHezMyxPw5oDipIdweuleWCXM+lRkbR60wX55gHBa4UYnhXp0o
         CDwQ==
X-Gm-Message-State: AOAM533dqXHYERuQwY9c1xuKT0rKii8Glwv4oeDnJBQJJX9tWnE54DM/
        G/tTZ9NoW7KBbkYtq1nOjjFDj7m1LpU4cw==
X-Google-Smtp-Source: ABdhPJxjah1iTr1rRKWsMPlvTRGhNGasnmKPt0CiUGZhdXMadmj6lxBNmZme/dzNpOku4BkDwBM/NA==
X-Received: by 2002:a65:44c5:: with SMTP id g5mr13111358pgs.295.1614588420994;
        Mon, 01 Mar 2021 00:47:00 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:47:00 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 6/6] doc/git-commit: add documentation for fixup=[amend|reword] options
Date:   Mon,  1 Mar 2021 14:15:14 +0530
Message-Id: <20210301084512.27170-7-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-commit.txt | 40 ++++++++++++++++++++++++++++++------
 Documentation/git-rebase.txt | 21 ++++++++++---------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7ea..722f8f0a6d 100644
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
@@ -86,11 +86,39 @@ OPTIONS
 	Like '-C', but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
---fixup=<commit>::
-	Construct a commit message for use with `rebase --autosquash`.
-	The commit message will be the subject line from the specified
-	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
-	for details.
+--fixup=[(amend|reword):]<commit>::
+	Without `amend:` or `reword:`, create a `fixup!` commit where
+	the commit message will be the subject line from the specified
+	commit with a prefix of "fixup!'". The resulting "fixup!" commit
+	is further used with `git rebase --autosquash` to fixup the
+	content of the specified commit.
++
+The `--fixup=amend:<commit>` form creates an "amend!" commit to
+fixup both the content and the commit log message of the specified
+commit. The resulting "amend!" commit's commit message subject
+will be the subject line from the specified commit with a prefix of
+"amend!'" and the message body will be commit log message of the
+specified commit. It also invokes an editor seeded with the log
+message of the "amend!" commit to allow to edit further. And it
+refuses to create "amend!" commit if it's commit message body is
+empty unless used with the `--allow-empty-message` option. "amend!"
+commit when rebased with `--autosquash` will fixup the contents and
+replace the commit message of the specified commit with the "amend!"
+commit's message body.
++
+The `--fixup=reword:<commit>` form creates an "amend!" commit similar
+to `--fixup=amend:<commit>` creates, but it records the same tree as
+`HEAD`, i.e. it does not take any staged changes and only allows to
+fixup the commit message of the specified commit. It will reword the
+specified commit when it is rebased with `--autosquash`.
++
+The `--fixup=amend:` and `--fixup=reword:` forms cannot be used with
+other options to add to the commit log message i.e it is incompatible
+with `-m`/`-F`/`-c`/`-C` options.
++
+Also, after fixing the commit using `--fixup`, with or without option
+and rebased with `--autosquash`, the authorship of the original commit
+remains unchanged. See linkgit:git-rebase[1] for details.
 
 --squash=<commit>::
 	Construct a commit message for use with `rebase --autosquash`.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8bfa5a9272..ffea76e53b 100644
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
+	When the commit log message begins with "squash! ..." (or "fixup! ..."
+	or "amend! ..."), and there is already a commit in the todo list that
+	matches the same `...`, automatically modify the todo list of
+	`rebase -i`, so that the commit marked for squashing comes right after
+	the commit to be modified, and change the action of the moved commit
+	from `pick` to `squash` (or `fixup` or `fixup -C`) respectively. A commit
+	matches the `...` if the commit subject matches, or if the `...` refers
+	to the commit's hash. As a fall-back, partial matches of the commit
+	subject work, too. The recommended way to create fixup/squash/amend
+	commits is by using the `--fixup=[amend|reword]`/`--squash` options of
+	linkgit:git-commit[1].
 +
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
-- 
2.29.0.rc1

