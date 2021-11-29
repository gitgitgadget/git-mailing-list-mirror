Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683FC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhK2WWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhK2WU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9FC091D00
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so18455050wrw.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGgyxkh9MZVhQuR8k2Ek7IE6tYXY8J0bHnKZLBKRvFg=;
        b=nJg5u5q9TK7VUEHf+PFbIFEqGh9GcEqjJyRXZk5mQ9/Q3+i9oa+Y7NDy6jf3R7P9Ht
         KG8FhwsvJGZ/F1igZaGIl0xTAxM/O49JfWJNYxgwIa9b4YWsgACrH2cESd4tW5IxhsHH
         vU/oT/WqKWHXFdwX9LDtRKRHBzXLcVS/cqq6qWeXpzhnEsePj3ru/TAaaop0JjD+Hm1J
         KacDkaao2kI6ldkPpQ2Pxdq2NUAEBucG3DgLh1tKrthBoeWb41f9fyfWlPOeT/V6TUjg
         h7IBEq7lavqO8LRxMnJHRA8bH1rRSfNxzH90aZdtrIUj6v5g8KmT97QKccqjoG5G+lr/
         6GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGgyxkh9MZVhQuR8k2Ek7IE6tYXY8J0bHnKZLBKRvFg=;
        b=Nw2j9Sfw53HmJ3mBVQ7felO2QXjBIItXkTo5tynBrBO1ND956Vil1knkYQxMrNnfr5
         fz/Nbnd+sX77iviQVA9vDTTY6Y7ZCslbunQQUUPE5PfAZW6/wrRj90sA/q7guQaygtiF
         UZMr/7cfBfCW2KcCnXXb4EuUrTMg0TkGNG18mgWdQuc3/j3L07+zTzMGFbRk7jixSUdp
         mZkAiFON2N+yfgDFY/vGV3TeLTKhKzKk7fSyS935PaFrMXVGFw2Q0pBztJS2h2v5SlTF
         DAisPnIxNGrLZmUUOmuRL+2854AaXPCLgOeiibjr+VtnjNidRO4CiSajb+ApMcYzUozV
         TPUw==
X-Gm-Message-State: AOAM530+uxBj2dCkeh+mPaP8vCjBI1l94zVEEp3zpZmHYvMOZKtMQnGE
        5DAvp9qCvB9z4YJyOjqpCoEqlgjq/YKIjQ==
X-Google-Smtp-Source: ABdhPJxQNvf+Q1oBHg/ZgzlidLZ8/ZCODXzRGp/5y0Z59KfmoVqwn8/+zdQNF59hCuu7QMYgImFTug==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr35025936wrd.369.1638215958424;
        Mon, 29 Nov 2021 11:59:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] cat-file: move "usage" variable to cmd_cat_file()
Date:   Mon, 29 Nov 2021 20:57:45 +0100
Message-Id: <patch-v3-05.10-a9ea4c52222-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no benefit to defining this at a distance, and it makes the
code harder to read as you've got to scroll up to see the usage that
corresponds to the options.

In subsequent commits I'll make use of usage_msg_opt(), which will be
quite noisy if I have to use the long "cat_file_usage" variable,
there's no other command being defined in this file, so let's rename
it to just "usage".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1df7f797cb6..6d0f645301b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -618,18 +618,6 @@ static int batch_objects(struct batch_options *opt)
 	return retval;
 }
 
-static const char * const cat_file_usage[] = {
-	N_("git cat-file <type> <object>"),
-	N_("git cat-file (-e | -p) <object>"),
-	N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
-	N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
-	   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-	   "             [--textconv | --filters]"),
-	N_("git cat-file (--textconv | --filters )\n"
-	   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
-	NULL
-};
-
 static int git_cat_file_config(const char *var, const char *value, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
@@ -664,6 +652,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	struct batch_options batch = {0};
 	int unknown_type = 0;
 
+	const char * const usage[] = {
+		N_("git cat-file <type> <object>"),
+		N_("git cat-file (-e | -p) <object>"),
+		N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
+		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
+		   "             [--textconv | --filters]"),
+		N_("git cat-file (--textconv | --filters )\n"
+		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
+		NULL
+	};
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
 		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
@@ -700,7 +699,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
-	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
@@ -708,35 +707,35 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 	}
 	if (batch.enabled) {
 		if (batch.cmdmode != opt || argc)
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(usage, options);
 		if (batch.cmdmode && batch.all_objects)
 			die("--batch-all-objects cannot be combined with "
 			    "--textconv nor with --filters");
 	}
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && opt != 'c' && opt != 'w') {
 		error("--path=<path> needs --textconv or --filters");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (force_path && batch.enabled) {
 		error("--path=<path> incompatible with --batch");
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(usage, options);
 	}
 
 	if (batch.buffer_output < 0)
-- 
2.34.1.841.gf15fb7e6f34

