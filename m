Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735F220248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCHJ6d (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:33 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38661 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:33 -0500
Received: by mail-pf1-f174.google.com with SMTP id n125so13784337pfn.5
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dW0PlIg5SOEnwZdWMv4V+8eSlWkhoFlZWDstSiHtUVk=;
        b=PIWWQdjBhGylaEI9mc4GUfTg+WLOU5HbuQhQn6T7o/GmThyAeW1dXDFccVm9eIJXDm
         TKxcVpfR7qrCp4CXGSK1PzTsVLEyxb8y4n8hFjDjzNRe0sLq6orTZN7cyy8lXr3iLke8
         DLCHu9FE7B6Rea2xXdbEaAUQLnqsN7md+KMs4Mwls74oTlKGYomDCLFCzy8IaSihLY3Q
         ai48j2ZKSCXhydVPL0jsZj7cpU4J5vaxXJcLyDOFJwO4sVI4hGcl7dn94IIQjbK4cfsl
         cTigCBz+3mbojGJ/t1UtJZsFGliYDWEd5GmLW008jqx3I+cf5R6xV7TD7kNoNbzqQl5D
         8m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dW0PlIg5SOEnwZdWMv4V+8eSlWkhoFlZWDstSiHtUVk=;
        b=dHeVxbq4GFMihGav/3+swoxdo3H2M82VxCODwoJ3cOvjTClqN6pSj/0bFRXjAqh10C
         XWrmPJOS1jLarCQ67fTbPjm9ovPa4etyiYy4oho6JR69Yo0GJeNok6Smxc3XGXNnph6O
         O58Z/6AiPcr0pmLtvkBlHU5q9xrHIOMwT6HZFZhHK1ZWqZ94hpyEsiSW0jZBjp+2fN33
         55hCGvo5LmSBFm1x+Mmu4MsAYdR8fm7jvxnuaYVIsg9SUUDNULB1JUl/w6A0mUwFjJv0
         2kJHIQIlWXTP+t36KqqixZ86mu4OCe8yUk1OszJpTllK2V/DqfZxFqQFMCXwjSiRwAZ/
         Ellg==
X-Gm-Message-State: APjAAAWaD+dMobtNpyNkyvte0DzFYSlKwtFlhr9Xp+IlXclAkETscupa
        BDY2m3QtZSeekdzzgEgAgPY=
X-Google-Smtp-Source: APXvYqyBgW0fAmcOIHi+k7R9qYlEwdf8B9L0aPzhD+Ge/a6OVfX2yYakNNZzZ898PGonhUSGULittg==
X-Received: by 2002:a17:902:ea06:: with SMTP id cu6mr2718220plb.187.1552039112375;
        Fri, 08 Mar 2019 01:58:32 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n23sm8260306pgv.86.2019.03.08.01.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 06/21] checkout: factor out some code in parse_branchname_arg()
Date:   Fri,  8 Mar 2019 16:57:37 +0700
Message-Id: <20190308095752.8574-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in preparation for the new command restore, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.
---
 builtin/checkout.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6037b296..cbdcb1417f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1081,6 +1081,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
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
@@ -1088,10 +1116,8 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1213,26 +1239,11 @@ static int parse_branchname_arg(int argc, const char **argv,
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
2.21.0.rc1.337.gdf7f8d0522

