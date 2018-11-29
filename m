Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E7D211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeK3JGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46496 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK3JGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so3127153ljh.13
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw3wHKeJn3AyRQLTslCCQDWRCYKFVWw9mmN9u83fg5c=;
        b=szWWm8SMAil/LhSD9IlEkU1GFpcrJ58SuG9lAHrZV/UQ/Czmn0lRekUBAAsuQVC+2i
         2OICBtMFfJhkk6K+dUJ5ASc0+qxPEdIOan/i2vIXlfOWS8vX+gXCyogeUItKZQgqQhx/
         mDbYGyJ2kZ9YHUk2+Q+jW/BFLFbphJIh9m1Y39EXScBdZozj0bsf4j6cwMVidlLM9R7a
         24V9RbdU3coCATlvEFKh7yBnzu6jNzAfI0wF5Wo0FZYJfo6S07dElYkksaXqOcci6MpO
         lNlf6nV7iEVSv1mmtntDa5x/gwx3vdKJN1+a+gA7ItRBsHsVEUKHyi775dzxyKEV7G8V
         GDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw3wHKeJn3AyRQLTslCCQDWRCYKFVWw9mmN9u83fg5c=;
        b=oyj2AqsafFyx7Uc9zTaFrYQgTZRBfXVLmTQGPmLFTw9Y1zEMn371/YRpcg1uTYaISo
         ftMHla4htcijJvvdXVuDtwfQ6Syjb7grkjZHwWubh8gOyZzjUICzcmBU48mgPxTpl9D2
         zxxx6rzxRoZrbFHn7zbrrybAtKOKe1d4tIrEcV9h8sV1D0iHjX69Tm5QznyitmodI/9F
         r9jSGdKAxlNCgVojGryAt+d3xR2BldS11qUAKJahUDeoWpt5Yp0nxJ3tvet6sQy62/yJ
         MnEigkW/jrI/AcYyFFhSYKPzy3HslNIVP6DCavTd823XTi8H7ENWfZlV3T6Jsk8ty1iZ
         /o3w==
X-Gm-Message-State: AA+aEWZxs7E4DPbHR3INQmAs74FtdusfAcXSEQG+sGWSc3KhOImMhxPg
        Rln+1Q/I65eYP/Z7bsLvwIOJPNR9
X-Google-Smtp-Source: AFSGD/UgXzjedRYG3dcQ84zUyfUT7SaB+Ix6j4JNgdMgdUW1Zx2/ToVKI8XjyBdQt2htVRW2U561EA==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr2360191ljd.21.1543528755662;
        Thu, 29 Nov 2018 13:59:15 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:15 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 03/14] checkout: factor out some code in parse_branchname_arg()
Date:   Thu, 29 Nov 2018 22:58:38 +0100
Message-Id: <20181129215850.7278-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in preparation for the new command restore-files, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..1887c996c6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -990,6 +990,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
 
+static void setup_new_branch_info_and_source_tree(
+	struct branch_info *new_branch_info,
+	struct checkout_opts *opts,
+	struct object_id *rev,
+	const char *arg)
+{
+	struct tree **source_tree = &opts->source_tree;
+	struct object_id branch_rev;
+
+	new_branch_info->name = arg;
+	setup_branch_path(new_branch_info);
+
+	if (!check_refname_format(new_branch_info->path, 0) &&
+	    !read_ref(new_branch_info->path, &branch_rev))
+		oidcpy(rev, &branch_rev);
+	else
+		new_branch_info->path = NULL; /* not an existing branch */
+
+	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
+	if (!new_branch_info->commit) {
+		/* not a commit */
+		*source_tree = parse_tree_indirect(rev);
+	} else {
+		parse_commit_or_die(new_branch_info->commit);
+		*source_tree = get_commit_tree(new_branch_info->commit);
+	}
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -997,10 +1025,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev,
 				int *dwim_remotes_matched)
 {
-	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	struct object_id branch_rev;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1114,26 +1140,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new_branch_info->name = arg;
-	setup_branch_path(new_branch_info);
-
-	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
-		oidcpy(rev, &branch_rev);
-	else
-		new_branch_info->path = NULL; /* not an existing branch */
+	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
-	if (!new_branch_info->commit) {
-		/* not a commit */
-		*source_tree = parse_tree_indirect(rev);
-	} else {
-		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = get_commit_tree(new_branch_info->commit);
-	}
-
-	if (!*source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
+
 	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
-- 
2.20.0.rc1.380.g3eb999425c.dirty

