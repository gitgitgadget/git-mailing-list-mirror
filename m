Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAEAC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhLGUXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbhLGUXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E57C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u17so179941wrt.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7MRwyLqmsl9T7SYIB6ENiicnNlbMDZ1Hi2KcflJUN8=;
        b=UDtT91BMtwO5q34601w4KoTfX6Ii4WXOVla7KeBzaHROk6R2Zz4gxCDYY0KSRfkLaD
         XWOXNetY/5sjx159bx1KOuVEv96xkl2U8WX+Gz4pLmh9/q8uZos1AhCF2rESQ1zHHQLq
         bOjoqbrujLqzMnU9gyPzpd97Fo2rQJaApJLvV08e2aJLYCKDI8+RRnTlhWekUk4s2hnr
         D/Js+ie2d1+i4i/R59Vg3R1Lh+xv5H22/nDqkoOhmuaPM9KuRTgeX6B82m1ABWFeehdd
         XUi3S/1JAK+lN7k7cWEZJdwztboCRsgrLF3X+m/aSQhrO5x5uQVDkOAwjdJt2Na9Sxkf
         aPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7MRwyLqmsl9T7SYIB6ENiicnNlbMDZ1Hi2KcflJUN8=;
        b=6rR4B400KYFXlARScEEIqVi6H7pvQYXJfXTFSVI8mv7nzrudimjb3pmatR5C7S++n2
         CY2+gioEAxPDTRGjyIamhCbYFKIbpr3oG40nYGHL/7ngA12UmTHXGcm1sblwTUMNPXzq
         t9IgsF5zgSKMEI+aVUfNX4282IIcEwqWq9ReKUhezr/MnIyB3q/IIiNRArS3qYCh0ZFh
         rTYXu1lY1elpJrFSO05hRqtSUGcYZU4j/kfHJtU2CKuYjo0xLdFZwRtuTKiofclkFZb9
         6pY4/g75f5Di0joKlj6ZXoHkAeuxE9EfPNR/gbqTR63OuIs2iRvybNCoXyyMLRSW1gY4
         cfQg==
X-Gm-Message-State: AOAM530OMG0MGGLyW6Zs5RKQjApVxCrtjH/fD6F+CkCwp44fi0v0iF+U
        DfVTFvHQCgUNzXfq41Fs4nH6TN4JB90=
X-Google-Smtp-Source: ABdhPJxXgEp94RuIjIqSIp8f/ziYPQ8HWkS3H9tMHOvTfYduSuitnAFx0Bw68nsiQdzQjfm39tju3g==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr55331694wrc.193.1638908413431;
        Tue, 07 Dec 2021 12:20:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm1045332wri.89.2021.12.07.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:13 -0800 (PST)
Message-Id: <6f7de8f54127aa08b24000cc1aea39b352913fb2.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:02 +0000
Subject: [PATCH v2 02/10] sparse-checkout: break apart functions for
 sparse_checkout_(set|add)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sparse_checkout_set() was reused by sparse_checkout_add() with the only
difference being a single parameter being passed to that function.
However, we would like sparse_checkout_set() to do the same work that
sparse_checkout_init() does if sparse checkouts are not already enabled.
To facilitate this transition, give each mode their own copy of the
function.  This does not introduce any behavioral changes; that will
come in a subsequent patch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 54 +++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8612328e5dd..e252b82136e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -515,15 +515,6 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 	insert_recursive_pattern(pl, line);
 }
 
-static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout (set|add) (--stdin | <patterns>)"),
-	NULL
-};
-
-static struct sparse_checkout_set_opts {
-	int use_stdin;
-} set_opts;
-
 static void add_patterns_from_input(struct pattern_list *pl,
 				    int argc, const char **argv,
 				    int use_stdin)
@@ -663,8 +654,43 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
-			       enum modify_type m)
+static char const * const builtin_sparse_checkout_add_usage[] = {
+	N_("git sparse-checkout add (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_add_opts {
+	int use_stdin;
+} add_opts;
+
+static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_add_options[] = {
+		OPT_BOOL(0, "stdin", &add_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
+	repo_read_index(the_repository);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_add_options,
+			     builtin_sparse_checkout_add_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
+}
+
+static char const * const builtin_sparse_checkout_set_usage[] = {
+	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_set_opts {
+	int use_stdin;
+} set_opts;
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
@@ -679,7 +705,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, set_opts.use_stdin, m);
+	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
@@ -762,9 +788,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
-			return sparse_checkout_set(argc, argv, prefix, REPLACE);
+			return sparse_checkout_set(argc, argv, prefix);
 		if (!strcmp(argv[0], "add"))
-			return sparse_checkout_set(argc, argv, prefix, ADD);
+			return sparse_checkout_add(argc, argv, prefix);
 		if (!strcmp(argv[0], "reapply"))
 			return sparse_checkout_reapply(argc, argv);
 		if (!strcmp(argv[0], "disable"))
-- 
gitgitgadget

