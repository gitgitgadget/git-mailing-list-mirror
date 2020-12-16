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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D36C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E5023432
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgLPSwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbgLPSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02893C0619DC
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o17so48052184lfg.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sj7YslDoRkybHL0j9cZBWvCacUMa3n1/n24L88ClS0o=;
        b=ObI1/nlAg4Sf9CtKar3hDUH0dwoI1oUeDEjgMr4CVk3BjI97ZB6hqRbGaJIwqXhGua
         objdffJ9U+Gu9wQnBlwX6DouIlcE+hLMYqo7e82LAdvHSUDIYAz7nY8aRXzgXjH6/U8T
         h2PV18gcxJdLeQMtZyKmwbhQdfco6e6uQPJur0wjm09ozUT8PJU874OTdTe5+1tee6Tl
         YAiEiHilwZpggUA9eTioj//Jr3vh8Esi69h5jcHW1dKhhT2Y5/QWLXvTS0LsY7qMIc5E
         CGKh3Kn6cem+IvAdC4SxCs1WWjmr4QpzD/vx6n7dQuGEiEweEM2UNYt/GEgE+O9E2Wdm
         XxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sj7YslDoRkybHL0j9cZBWvCacUMa3n1/n24L88ClS0o=;
        b=catYBGrpHNNrqyDvkMEPKkOnRh9YXvpIw+ceIlofmWpOCpEtRUDd/EYGx4nTPMSMb0
         sTrLOMa8AIoRTeQcd1ksBt1hqq9ZjKe7gbT9BIhpUlhK9LAk1AKlaPT3h5fbHOiFTUVP
         Hu5+8XXEBeHVkm1fBzQmPJCUvb6E9f53TNNh19QCzdrHa2cN2mN6tVcwZFiUteh38Zov
         wFybC6vXetBaVKIV0ebImdP7n9BRK+QY4bq+w2xFn8H6imIlQRbqAbtLsrpxbh3wEeus
         yauTL5n5UXQMskYG8Pl7rfEsgsFqBqqHtGc5uoQvgg8QtagVbdX6/HK7GDj/WX6o5TxE
         RD7g==
X-Gm-Message-State: AOAM532o74QbnBolhu1+LFx3ePRDIM76LP841xgLczymDKfhI3OFpELr
        z277zFMdknTn6c3fKpopsDM=
X-Google-Smtp-Source: ABdhPJw65m3caCvxs+3XPh5AMjN5wO3iTEu2GsXs+HPrN40IVfVH7+Aqn8o0RAy+LPBhTr0P9ZqLGw==
X-Received: by 2002:a2e:2405:: with SMTP id k5mr14794596ljk.185.1608144658654;
        Wed, 16 Dec 2020 10:50:58 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:57 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
Date:   Wed, 16 Dec 2020 21:49:25 +0300
Message-Id: <20201216184929.3924-30-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe all the new --diff-merges options in the git-log.txt and
adopt description of originals accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2b8ac5ff882a..27bc619490c6 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,45 +120,64 @@ DIFF FORMATTING
 By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
-Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
-will never show a diff, even if a diff format like `--patch` is
-selected, nor will they match search options like `-S`. The exception is
-when `--first-parent` is in use, in which merges are treated like normal
-single-parent commits (this can be overridden by providing a
-combined-diff option or with `--no-diff-merges`).
+Note that unless one of `--diff-merges` variants (including short
+`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+will not show a diff, even if a diff format like `--patch` is
+selected, nor will they match search options like `-S`. The exception
+is when `--first-parent` is in use, in which case `first-parent` is
+the default format.
 
--c::
-	With this option, diff output for a merge commit
-	shows the differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a parent
-	and the result one at a time. Furthermore, it lists only files
-	which were modified from all parents.
-
---cc::
-	This flag implies the `-c` option and further compresses the
-	patch output by omitting uninteresting hunks whose contents in
-	the parents have only two variants and the merge result picks
-	one of them without modification.
+--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--no-diff-merges::
+	Specify diff format to be used for merge commits. Default is
+	`off` unless `--first-parent` is in use, in which case
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
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
 	list the name of the file from all parents.  It thus only has
-	effect when -c or --cc are specified, and is likely only
-	useful if filename changes are detected (i.e. when either
-	rename or copy detection have been requested).
+	effect when `--diff-merges=[dense-]combined` is in use, and
+	is likely only useful if filename changes are detected (i.e.
+	when either rename or copy detection have been requested).
 
--m::
-	This flag makes the merge commits show the full diff like
-	regular commits; for each merge parent, a separate log entry
-	and diff is generated. An exception is that only diff against
-	the first parent is shown when `--first-parent` option is given;
-	in that case, the output represents the changes the merge
-	brought _into_ the then-current branch.
-
---diff-merges=off::
---no-diff-merges::
-	Disable output of diffs for merge commits (default). Useful to
-	override `-m`, `-c`, or `--cc`.
 
 :git-log: 1
 include::diff-options.txt[]
-- 
2.25.1

