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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFFC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4627122AAE
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLUTCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgLUTCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:02:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478BC0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:02:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r7so12178357wrc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jn5zqXUcNfSMAtnBtLBq0vbrLiabg1QIXZiDFpXraDA=;
        b=jPA//plu2V6GuIP7iU8YQ+lTwwPdzeBMZ59rENQ92ptGx8RtHFsgQ4nioI80HVL3Gk
         0wzrSjyjmiHqguds/qnVkUEfHBFt/HXaJBNnvao9/hVjTHSRkzCPgJ9MMgcmizpZL1gG
         M1kst9jlD7rVMmMDAJp2WROC4g1utMpXFU74zwc8OZdJVSd/qGPbi6x0T9Wrrq5wJJ7l
         Dwqdeh0sUdQD6sfCgSHgKQsSYPeerl5i+Vm5AR2vlommgGn2HfYMJbzqXe5mlz2RvSjP
         tWxTAHOmEMkbNKowsGx1gKAtqybaW7X3NbsEqNZRWtmm8tM5WYO5GPkecbnjgV/vw8h6
         Jqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jn5zqXUcNfSMAtnBtLBq0vbrLiabg1QIXZiDFpXraDA=;
        b=A2AHnZw00w3vEy1+9xkAasTDQFDppUAYsJ2G2HfNVOkyHkncQOVoU3XEr73wt9QqXe
         8sLAXD27weR+ovHFrTYFSAhSM4z/ZWmJdTLyox+6fUMNm61fQQP5nN19E1L5ueSWRu9U
         v8qI1bUg9EFWP2Dk6tDVRcD7fzj+MFydl+X2lr7MsiXbDt0aypc9va6KFpiIlmwMvR/s
         0S6BSeSeNEe5eC7q6+p2wkbqhUw70k7JlVBULnNtiymlNKgU+CJbgXVvnY3MQ+IIns95
         xxDmAQv0yEIWbAM4bnzEZhau+XRwsiEVad6iiFwYtjcQ9QGrzznP0ogW2TtvLoaheDQt
         FSUQ==
X-Gm-Message-State: AOAM531NdZ77zdK/34BRJdGgoSiOog0dkai2JJWrsFeM09dIPSnwF+tV
        r82gqoWWSwmaFmy9FfrHfnz1jS8YM0w=
X-Google-Smtp-Source: ABdhPJz3reP2xvRM+wqSvJ0gJhQOHCoGt+NUXaUaM8ETfmLvewYg6z9ULWKXMJNgGsvy29GFZs5IrA==
X-Received: by 2002:ac2:598a:: with SMTP id w10mr6552915lfn.547.1608564065237;
        Mon, 21 Dec 2020 07:21:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:04 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 28/32] doc/git-log: describe new --diff-merges options
Date:   Mon, 21 Dec 2020 18:19:56 +0300
Message-Id: <20201221152000.13134-29-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe all the new --diff-merges options in the git-log.txt and
adopt description of originals accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-log.txt | 83 +++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2b8ac5ff882a..ff83dff14dd6 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,45 +120,62 @@ DIFF FORMATTING
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

