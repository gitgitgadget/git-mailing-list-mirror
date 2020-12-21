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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8808C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92B622D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgLUSJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUSJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:09:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42EC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:09:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o17so25881645lfg.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQyNXsn+HkrFHz92ETGJmgSUu0rpCl53hUo7mEoQf+s=;
        b=m32Ex0OUuP2ElyPbKbLVsddoaNqOxWloINbXMiHPTaUSEoBYCIE9SwGrJwfpJ0OGo2
         rEXo/64+yngQ9BQciovwxpdKRkl2/FtbHVi7O3w4yyxy0eIyZbOIeb6Nuq1X8ZCsxmjh
         Vhz4wxDw5i2jpBMw0m7l5YAnIl8m0C/0hlm7fehTWpqXvsETKeq+CDM470hzPWhqpUVl
         9LhNWU2ABOk8DEEp3ZwkR0DMNLROZ7iB+pIb00gb76ElsoiEIfI+EuEuCLMYNZ2WEzUL
         bik6BFwhnvwADPMeoZnF/nUjUcz46pRgTfjiyHLOrW8eeXDm1yhiI5JC1/m+B98gHfEQ
         vuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQyNXsn+HkrFHz92ETGJmgSUu0rpCl53hUo7mEoQf+s=;
        b=ZDlCtZfP3CtTz8GEQiWeSpKJBx8IKUIezODsS/ebxy52PJW9K2bPp4r5nyxthmU9xr
         RgepgsqTtf4dLRbwDbGOrBFi7iDxx+TYLiryUCRjI2NFynUDaaz/qWpiceglR6qcJvNS
         CxnNGEC0CUy+61R4eBi1VhzEe6MEAr4pzAzxlULDha6Ak1Xq233UrAH+ycvTZeXZpz79
         lhRvI6dAGhVmyHZMqlU6LzOIABOkiXAYFDPrFOjpwVHxc2JTGpWn4MIvTgyw2lQ2RA7s
         Ad0J1wzz5ypuIxKEmNIvhgjVJmLhi4EXEV0ju7p8Bpt0rSZ50K4pbnMk2+0VAyg7PK3b
         /L2g==
X-Gm-Message-State: AOAM533qxj2ZJ4e3yjTUlkSjQKrgM53jlc/uF2eiCOnoXq3MS1BAgkXd
        IYQYHDzpfuqaFk/P+Ce+tdmjilc5NhA=
X-Google-Smtp-Source: ABdhPJyBbZmwQ2q+ToYRKbSrrSnjvGiAKc8JeJxHTVB+Xr0ogQcjy390HcdUQeBqIFg6QPlPRDg5XQ==
X-Received: by 2002:a2e:b006:: with SMTP id y6mr7426051ljk.366.1608564060714;
        Mon, 21 Dec 2020 07:21:00 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:00 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 24/32] diff-merges: do not imply -p for new options
Date:   Mon, 21 Dec 2020 18:19:52 +0300
Message-Id: <20201221152000.13134-25-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'combined_imply_patch' field and set it only for old --cc/-c
options, then imply -p if this flag is set instead of implying -p
whenever 'combined_merge' flag is set.

We don't want new --diff-merge options to imply -p, to make it
possible to enable output of diffs for merges independently from
non-merge commits. At the same time we want to preserve behavior of
old --c/-c/-m options and their interactions with --first-parent, to
stay backward-compatible.

This patch is first step in this direction: it separates old "--cc/-c
imply -p" logic from the rest of the options.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 20 ++++++++++++--------
 revision.h    |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 4d22da179577..6d48ac5ab93d 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -9,6 +9,7 @@ static void suppress(struct rev_info *revs)
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
+	revs->combined_imply_patch = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -74,19 +75,21 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	const char *optarg;
 	const char *arg = argv[0];
 
-	if (!strcmp(arg, "-m"))
+	if (!strcmp(arg, "-m")) {
 		set_m(revs);
-	else if (!strcmp(arg, "-c"))
+	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
-	else if (!strcmp(arg, "--cc"))
+		revs->combined_imply_patch = 1;
+	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
-	else if (!strcmp(arg, "--no-diff-merges"))
+		revs->combined_imply_patch = 1;
+	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
-	else if (!strcmp(arg, "--combined-all-paths"))
+	} else if (!strcmp(arg, "--combined-all-paths")) {
 		revs->combined_all_paths = 1;
-	else if ((argcount = parse_long_opt("diff-merges", argv, &optarg)))
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		set_diff_merges(revs, optarg);
-	else
+	} else
 		return 0;
 
 	revs->explicit_diff_merges = 1;
@@ -126,8 +129,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combine_merges) {
+	if (revs->combine_merges)
 		revs->diff = 1;
+	if (revs->combined_imply_patch) {
 		/* Turn --cc/-c into -p --cc/-c when -p was not given */
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/revision.h b/revision.h
index dcfa14454a55..bfbae526ad6e 100644
--- a/revision.h
+++ b/revision.h
@@ -197,6 +197,7 @@ struct rev_info {
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
+			combined_imply_patch:1,
 			dense_combined_merges:1,
 			first_parent_merges:1;
 
-- 
2.25.1

