Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98607C63699
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B74206F4
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjY5knGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgKHVlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgKHVlo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:44 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E6C0613D3
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:44 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so9542748lfd.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9W0hLrOfmJHLxxseRkRkGLHrJsJGZBjpD6R06Vh/aWU=;
        b=FjY5knGpA7jdDcXPFm94nVC8Yvk7thPjKsVdTWe8uDLzuSYVTtjq0bBMA0uoESNMRx
         kLZmXGkfr85K+YqqKJJF4u4jgsdzO0Wuqb2QfNZ67YPgSETglgd0xyprSQ4PXfcFbAQS
         JFYeIqltS1S37a9/94twKx6JLUXnzsIjV3wX/t5teXZwO0bvApBXl1OBoEXrUY+V+Tx7
         AZEKNSEJRmVr4HzH4o7XDDm/nK5/6X4i3Cg6DZFyFRqxrjzh6/koMgVHeN5F9L2OyjS0
         XkGUwiLHwj1oP6kLLUNj07z8JNbh3luN0qAh+8Ehy/qjxxth1ZvjGwaqu2VOMcj3YVbx
         MdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9W0hLrOfmJHLxxseRkRkGLHrJsJGZBjpD6R06Vh/aWU=;
        b=R8I1jEPFDZU5BZnFoqTka7ef50VQumCq+2VI2ojAPi0v8euXOClNbWGjeapom2naG+
         orh4NREOQaGTd9LMpS+e0E0SfPsHniR+y10H/X6Ws3v5LbEkXXV1OUg0lFza7CfbuHBG
         tXxAB5Fxc21nOWXhiHK1tBlaY9onMrm1dVwhdYp88Y3K3NWVY27wDfsT3aghGGL18LnJ
         yqnicZ9gQVC/bZ7MhXG/P+C6GFNECWLCqmoDNtFP8o6siOyCwcrT8+9NOseCZN/F8HXG
         1TK27ZXV/WW5846EUX2r/2cyyb5guO/28aSlxAUaTf8z3eELml8CmLCZuJmYV5DkGF5s
         D8Gg==
X-Gm-Message-State: AOAM530OcIY4fi3NadRHSuqpiHsuZyG8TiBZz/tLXWQ1d4Ah3cPqMICe
        di5iQsWNPfVa8nf66x5UgVA=
X-Google-Smtp-Source: ABdhPJwgMebb/OheMPKnEirsFJBPU8n7Hwycpl+l/3LN7YEhySARuY5fFJqW5fHGvfn91l8zSuJNJQ==
X-Received: by 2002:a19:ac44:: with SMTP id r4mr4241474lfc.168.1604871702505;
        Sun, 08 Nov 2020 13:41:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:41 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
Date:   Mon,  9 Nov 2020 00:38:35 +0300
Message-Id: <20201108213838.4880-25-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe all the new --diff-merges options in the git-log.txt

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-log.txt | 79 +++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2b8ac5ff882a..de498a189646 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,45 +120,58 @@ DIFF FORMATTING
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
+is when `--first-parent` is in use, in which case
+`--diff-merges=first-parent` is implied.
 
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
+--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
+--no-diff-merges::
+	Specify diff format to be used for merge commits. This has no
+	effect unless diff output is enabled in the first place (e.g.,
+	with `--patch` option.)
++
+--diff-merges=(off|none):::
+--no-diff-merges:::
+	(default) Disable output of diffs for merge commits. Useful to
+	override implied value.
++
+--diff-merges=first-parent:::
+	This option makes merge commits show the full diff with
+	respect to the first parent only, exactly like	regular
+	commits.
++
+--diff-merges=separate:::
+-m:::
+	This makes merge commits show the full diff with respect to
+	each of the parents. Separate log entry and diff is generated
+	for each parent.
++
+--diff-merges=combined:::
+-c:::
+	With this option, diff output for a merge commit shows the
+	differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a
+	parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
++
+--diff-merges=dense-combined:::
+--cc:::
+	With this option the output produced by
+	`--diff-merges=combined` is further compressed by omitting
+	uninteresting hunks whose contents in the parents have only
+	two variants and the merge result picks one of them without
+	modification.
 
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

