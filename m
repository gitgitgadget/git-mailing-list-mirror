Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E950C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9FC23407
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgLPSwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgLPSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2BC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x20so31452547lfe.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3srUsdd9p3VydjEtA3btL6rUTsfe3/4rnng1b9QE7k=;
        b=Kk7xsiVf99h+4B1DwtevuF31soPg9pvoSoA42rZfU0LAOEgpSHw2ib9lHyUYO7g+3s
         T5+O37IGkdZ5iJkBvovUg1qFXC+W6qehfk87Mcqz6v+FHdCobLU1/9OQiF67RYvXNJsD
         CsAQzn9BxrFDv03jzcs2tMkT0lUp8JH52JTW0SW66RwNUzzsRCpSfKXpAZhKVkxBHlhw
         XnwbccZljd0PwKluPBRzeMxa40yabuv+kVQLDUL2RxiwlhQtW4LJHhyISN+vkEfFG+0h
         3Rz8xGf+9ow1BykyzZVgTK690bzuxm7yvTkcBZ/dK86pkrPyxPNCXcNs5Fzz1tEON/sc
         xbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3srUsdd9p3VydjEtA3btL6rUTsfe3/4rnng1b9QE7k=;
        b=jB7vCpTpFccFSDntkrDfPGRQX07FejtEndKPTG+ECQLNTHslUW8uXywp9WBWldwETZ
         R3jc0J6m8sFcTDZKtcb5+8HKZK464k04HxMX7kox1YFa75yTvMTSfdkW+S7HdA0a9I4e
         qwxOp7DxS5DMy3LTGW0pnFM/x9DVgiaRuOhjLkVyuXthUGf30j5lcVDbXkPLZ+0/8IJ/
         RS/WlagD0GAI+SoIVtsMcQ431K6xMt9o2TaUqKHDDqsZOySgwFaHnY7ArQgStafnivic
         HmxAjQTDTFvsJ5+9lJe8CwQfmHgcsYDLFsFrNX1BKL6Dc+KfDqQ284lvwZt4mB7bYa5j
         EIFA==
X-Gm-Message-State: AOAM530z0hwPQG3+XJp/uLloWErM7IrOZnndeuL+s8QdcEb0S2McsRIG
        rBLCFyh+uAODMXYvYxtW1wg=
X-Google-Smtp-Source: ABdhPJy1wu0rStodmJYii95+uvBBa5rMz8UmtVphDHbqzncxqlfgJLQ7Nd53A9NAzdYBHXUUl6psnA==
X-Received: by 2002:a19:c70b:: with SMTP id x11mr13390161lff.258.1608144663017;
        Wed, 16 Dec 2020 10:51:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:51:01 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 32/33] doc/git-show: include --diff-merges description
Date:   Wed, 16 Dec 2020 21:49:28 +0300
Message-Id: <20201216184929.3924-33-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move description of --diff-merges option from git-log.txt to
diff-options.txt so that it is included in the git-show help.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 53 ++++++++++++++++++++++++++++++++++
 Documentation/git-log.txt      | 53 +---------------------------------
 Documentation/git-show.txt     |  7 +++--
 3 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71e2..98db2be423dc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -33,6 +33,59 @@ endif::git-diff[]
 	show the patch by default, or to cancel the effect of `--patch`.
 endif::git-format-patch[]
 
+ifdef::git-log[]
+--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--no-diff-merges::
+	Specify diff format to be used for merge commits. Default is
+	{diff-merges-default} unless `--first-parent` is in use, in which case
+	`first-parent` is the default.
++
+--diff-merges=(off|none):::
+--no-diff-merges:::
+	Disable output of diffs for merge commits. Useful to override
+	implied value.
++
+--diff-merges=first-parent:::
+--diff-merges=1:::
+	This option makes merge commits show the full diff with
+	respect to the first parent only.
++
+--diff-merges=separate:::
+--diff-merges=m:::
+-m:::
+	This makes merge commits show the full diff with respect to
+	each of the parents. Separate log entry and diff is generated
+	for each parent. `-m` is different in that it doesn't produce
+	any output without `-p`.
++
+--diff-merges=combined:::
+--diff-merges=c:::
+-c:::
+	With this option, diff output for a merge commit shows the
+	differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a
+	parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents. Historically,
+	`-c` enables diff output for non-merge commits as well.
++
+--diff-merges=dense-combined:::
+--diff-merges=cc:::
+--cc:::
+	With this option the output produced by
+	`--diff-merges=combined` is further compressed by omitting
+	uninteresting hunks whose contents in the parents have only
+	two variants and the merge result picks one of them without
+	modification.  Historically, `--c` enables diff output for
+	non-merge commits as well.
+
+--combined-all-paths::
+	This flag causes combined diffs (used for merge commits) to
+	list the name of the file from all parents.  It thus only has
+	effect when `--diff-merges=[dense-]combined` is in use, and
+	is likely only useful if filename changes are detected (i.e.
+	when either rename or copy detection have been requested).
+endif::git-log[]
+
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 27bc619490c6..727d20e1a2ab 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -127,59 +127,8 @@ selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
 the default format.
 
---diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
---no-diff-merges::
-	Specify diff format to be used for merge commits. Default is
-	`off` unless `--first-parent` is in use, in which case
-	`first-parent` is the default.
-+
---diff-merges=(off|none):::
---no-diff-merges:::
-	Disable output of diffs for merge commits. Useful to override
-	implied value.
-+
---diff-merges=first-parent:::
---diff-merges=1:::
-	This option makes merge commits show the full diff with
-	respect to the first parent only.
-+
---diff-merges=separate:::
---diff-merges=m:::
--m:::
-	This makes merge commits show the full diff with respect to
-	each of the parents. Separate log entry and diff is generated
-	for each parent. `-m` is different in that it doesn't produce
-	any output without `-p`.
-+
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. Historically,
-	`-c` enables diff output for non-merge commits as well.
-+
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  Historically, `--c` enables diff output for
-	non-merge commits as well.
-
---combined-all-paths::
-	This flag causes combined diffs (used for merge commits) to
-	list the name of the file from all parents.  It thus only has
-	effect when `--diff-merges=[dense-]combined` is in use, and
-	is likely only useful if filename changes are detected (i.e.
-	when either rename or copy detection have been requested).
-
-
 :git-log: 1
+:diff-merges-default: `off`
 include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index fcf528c1b30d..2b1bc7288d5f 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -45,10 +45,13 @@ include::pretty-options.txt[]
 include::pretty-formats.txt[]
 
 
-COMMON DIFF OPTIONS
--------------------
+DIFF FORMATTING
+---------------
+The options below can be used to change the way `git show` generates
+diff output.
 
 :git-log: 1
+:diff-merges-default: `dense-combined`
 include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
-- 
2.25.1

