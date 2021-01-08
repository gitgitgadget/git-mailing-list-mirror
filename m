Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52651C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F7F23AAC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbhAHUEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbhAHUEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CCC0612A9
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so10071316wrc.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AKrjmO1/ZFbpcKjWQvaQLMrhMhS47QmP9byd4n49/9E=;
        b=YNmNOyIw98AJ7tqr9QHXc47mNYU6hjsuAMX+aATkvvxoF3RkSL73DCplM7nzWZumTV
         MdHMK1G4zxmW8BM5TLIt+By30R1S7ergSgP8lqgLHoZ+useippeOHTrwukuo3bICDPhy
         YhAdmyl391ufwEDBHZlRMD0C7CP8FRXwC95DKrMAasDjkIaHIDR5Z5a8pLwZutnvt39z
         YQcyqv7ZMg1aCdjqvPR/+6/XIM1QOfmVG7oM84pxfwJ8On9WwraCd9CD7rY0eOl/XiVm
         kfvVc24SR9mXGvn4CR/CVgvzxGkiECtdy3fKQdNOFGL64Kx4ablI5/OYbVQgOLA1lvM3
         BauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AKrjmO1/ZFbpcKjWQvaQLMrhMhS47QmP9byd4n49/9E=;
        b=hZu9wFC+uw1uDNq0DCjsu1AaEffPgTv7ldu9YVdYQzQTgBhlIM9A0nu00HHVLp2ou6
         R7lI4waqe063odtQ8CthgX4IytWSsrSlTCt3YeBknykVEk34AX13GwTqamGPcy5tn+ST
         CnhYQKDu/6Lb70YqCyqUnz+vpT2dKMqfCaXcLk++7tk59iyIZ8jChUfv/BB6WzZRh2Vz
         87xIcXdoVujx6dWuTvY6jpv4IqbbUYPpsHUwNc/ibzvjVQnVrRdgxz++lkHHMc8cATaN
         1Y1jpZcRufMk/38zk85Ir+BGmUg+uWQ9BjSLtnkhszskrDHoaYroGq+fPDQvU5W7YpNI
         nQFg==
X-Gm-Message-State: AOAM530LthkSC79cJHyycnkk3yWwXMstjS7Y3mt6JGaICDYikeZud/hk
        3zi5ObxYbOLuSiHekjmjP+IkzqGkgdE=
X-Google-Smtp-Source: ABdhPJw4kdHJZKFyMF7Wokr311EWrJOrmCFIqcP1MEbrsYXSk/CHnIVZU/SdRebmP7OV2vWyjK3MCw==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr5129482wre.128.1610136191430;
        Fri, 08 Jan 2021 12:03:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm14942505wrb.92.2021.01.08.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:10 -0800 (PST)
Message-Id: <a9185af4740d7b7fe2325604045ca8b6df0a52c0.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:56 +0000
Subject: [PATCH v3 13/14] update-index: reduce static globals, part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In order to remove index compatibility macros cleanly, we relied upon
static globals 'repo' and 'istate' to be pointers to the_repository and
the_index, respectively. We can continue reducing the need for these
static globals by modifying method prototypes to use them when
necessary.

Move the remaining 'struct repository *repo' further down the file and
use method parameters to pass it around instead.

The only remaining change is to remove the static global entirely, but
that requires updating the parse-opt callbacks, which need a different
solution.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 9a83603c0db..3e01d62865f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -593,9 +593,9 @@ static const char * const update_index_usage[] = {
 
 static struct object_id head_oid;
 static struct object_id merge_head_oid;
-static struct repository *repo;
 
-static struct cache_entry *read_one_ent(const char *which,
+static struct cache_entry *read_one_ent(struct repository *repo,
+					const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
@@ -623,7 +623,8 @@ static struct cache_entry *read_one_ent(const char *which,
 	return ce;
 }
 
-static int unresolve_one(const char *path)
+static int unresolve_one(struct repository *repo,
+			 const char *path)
 {
 	int namelen = strlen(path);
 	int pos;
@@ -665,8 +666,8 @@ static int unresolve_one(const char *path)
 	 * stuff HEAD version in stage #2,
 	 * stuff MERGE_HEAD version in stage #3.
 	 */
-	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
-	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
+	ce_2 = read_one_ent(repo, "our", &head_oid, path, namelen, 2);
+	ce_3 = read_one_ent(repo, "their", &merge_head_oid, path, namelen, 3);
 
 	if (!ce_2 || !ce_3) {
 		ret = -1;
@@ -705,7 +706,8 @@ static void read_head_pointers(void)
 	}
 }
 
-static int do_unresolve(int ac, const char **av,
+static int do_unresolve(struct repository *repo,
+			int ac, const char **av,
 			const char *prefix, int prefix_length)
 {
 	int i;
@@ -719,13 +721,14 @@ static int do_unresolve(int ac, const char **av,
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
 		char *p = prefix_path(prefix, prefix_length, arg);
-		err |= unresolve_one(p);
+		err |= unresolve_one(repo, p);
 		free(p);
 	}
 	return err;
 }
 
-static int do_reupdate(int ac, const char **av,
+static int do_reupdate(struct repository *repo,
+		       int ac, const char **av,
 		       const char *prefix)
 {
 	/* Read HEAD and run update-index on paths that are
@@ -754,7 +757,7 @@ static int do_reupdate(int ac, const char **av,
 		if (ce_stage(ce) || !ce_path_match(repo->index, ce, &pathspec, NULL))
 			continue;
 		if (has_head)
-			old = read_one_ent(NULL, &head_oid,
+			old = read_one_ent(repo, NULL, &head_oid,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
 		    oideq(&ce->oid, &old->oid)) {
@@ -782,6 +785,8 @@ struct refresh_params {
 	int *has_errors;
 };
 
+static struct repository *repo;
+
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
@@ -921,8 +926,8 @@ static enum parse_opt_result unresolve_callback(
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
-	*has_errors = do_unresolve(ctx->argc, ctx->argv,
-				prefix, prefix ? strlen(prefix) : 0);
+	*has_errors = do_unresolve(repo, ctx->argc, ctx->argv,
+				   prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
 		repo->index->cache_changed = 0;
 
@@ -943,7 +948,7 @@ static enum parse_opt_result reupdate_callback(
 
 	/* consume remaining arguments. */
 	setup_work_tree();
-	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
+	*has_errors = do_reupdate(repo, ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
 		repo->index->cache_changed = 0;
 
-- 
gitgitgadget

