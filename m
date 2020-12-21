Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE14C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E1022D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLUSQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgLUSQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:16:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BCC061248
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so25840343lfc.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBicHsZcsIwzg1GxE2sO1OE5cAj9Ysf8W24YnUbwq5s=;
        b=JjuUabO8QkUkulXDe6GYkJJSiQDGRrLZxNuWiE9tI9EFu4DaZVyLyTkFnQms1pBVXb
         176g8+nU3Bnnb/F2MyWw1qCz+13pnhVCQI8oj3snyIW+flvgBMStWGfr+z117ikz8X+I
         fuHfBpjO9DlHfvF7ibshCRO4yEo8RKwkfD9tgGF2UhbQ7of5WLJTy7iK1ORi9B9vJg0R
         ehbjzQ9cJZDmqqSNvYuZX2asF7SGlIhCPBFD610/Qa+LgMtBLUdToUQdRtC/BylQPY6+
         vvTTmjibocf5BTtZCd6GmLpaZg9IjMPcGt2PWEF6IxywL5VdfEu0dPUJrx3/cp6s0U7h
         CRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBicHsZcsIwzg1GxE2sO1OE5cAj9Ysf8W24YnUbwq5s=;
        b=H/LB0SLPdq0Zk+y+IWa1MByXT5ZyDRjxLVlnYsYEFpoM52La6z3ESQancBfjczfBYd
         HHEZpWsFfEEfmA+4Jni/eg7Ci8gLRpfDAhEpV6GNupQrBGY2QUPZZCrMhpKoynHncbQk
         O58QIPhpGJc8Kc0egM+SpH7MjBEPrPlNX6lnLJhk257XDobOJBKzanX20e+398knbEqH
         IQvl1LEgxmPTDwVfrbJblwT+RszX+SqC2sCFiXWXViLzlsdZinV/4sTFw96Ipd/VtHNg
         55ayFQZceNnMLnXD6+iKwrgBhkWHYq+8IaIUA3LWUZ3tE3vPB9BqMX77NN7m+WJ3i1L3
         Nb1Q==
X-Gm-Message-State: AOAM532NTkzsSijZIvrYkklVcQs/3mfQR0s69EI1ZvYo59Yd40QCcMqU
        LXlZDC4nAsMjvR9j8NhWrZg4JFwlo/w=
X-Google-Smtp-Source: ABdhPJzfE0ylbfRQvDfjF5aChGb2OKJiNxIUSUEH06hUiqW3g3VVN9z6+WylF6tyrQ5UxE21gbcgBw==
X-Received: by 2002:a2e:8045:: with SMTP id p5mr7868906ljg.289.1608564068260;
        Mon, 21 Dec 2020 07:21:08 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:07 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 31/32] doc/git-show: include --diff-merges description
Date:   Mon, 21 Dec 2020 18:19:59 +0300
Message-Id: <20201221152000.13134-32-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move description of --diff-merges option from git-log.txt to
diff-options.txt so that it is included in the git-show help.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 51 ++++++++++++++++++++++++++++++++++
 Documentation/git-log.txt      | 51 +---------------------------------
 Documentation/git-show.txt     |  7 +++--
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71e2..c995e82584f3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -33,6 +33,57 @@ endif::git-diff[]
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
+	for each parent. `-m` doesn't produce any output without `-p`.
++
+--diff-merges=combined:::
+--diff-merges=c:::
+-c:::
+	With this option, diff output for a merge commit shows the
+	differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a
+	parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents. `-c` implies
+	`-p`.
++
+--diff-merges=dense-combined:::
+--diff-merges=cc:::
+--cc:::
+	With this option the output produced by
+	`--diff-merges=combined` is further compressed by omitting
+	uninteresting hunks whose contents in the parents have only
+	two variants and the merge result picks one of them without
+	modification.  `--cc` implies `-p`.
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
index ff83dff14dd6..727d20e1a2ab 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -127,57 +127,8 @@ selected, nor will they match search options like `-S`. The exception
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
-	for each parent. `-m` doesn't produce any output without `-p`.
-+
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. `-c` implies
-	`-p`.
-+
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  `--cc` implies `-p`.
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

