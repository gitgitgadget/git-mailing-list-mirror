Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB34C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49096206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvviaWSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgFOMul (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbgFOMu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B1C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so14699359wmi.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rAzvm0XOxsf7t0W8bPxhM8ar8h3+3XWAPQwSN/S9xWo=;
        b=XvviaWSqyfBQuKmAiNZvThyN41iAsBruwDY8iqdbBlGgL/twlX73t5E+ZTEE4TY9Dq
         NXrxIQbMq+a3Srq3/maQ9j27wLzYUpMvfEsofWvzn9ly9kHHVWR/owfhGP0/F7+pKtwK
         WapyMSjdc7fH7omrBlggTelwCHUgJHy7Ku0Bz5NkeKC2g7ioWVBoOBTKHmkCmrAuOIJG
         NXXdO7u+pkE0YkLRqUE9fKplpbQOc4780Vc1anH94x/qv3xuSKIHDi9nis6cxwMig0Z1
         5inqyKJ1XAyIEe2zklnWXb3mL6becdEQHuY83lVSH5QRnltF+hTnlLMcDVUAV7ck4aP0
         yWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rAzvm0XOxsf7t0W8bPxhM8ar8h3+3XWAPQwSN/S9xWo=;
        b=GAcUP99Am9q5/5BJQ981LBmNIguoHzUfGilbGl7BOYaGzAH1DjOYZ3Bl8VkV1Mnvdu
         +i9MTRBXjQcBecUz1fLcOKjtV8fzjKcsoervcPXI/JGyh+xO4+GfqAzD5xquY38LoSeN
         0hKRdNGiYtmITFa2RTDwj9+PXgRl9wTF+iGnVth1oDS6EwX9uJUKQOp1NDQHiWrBSyI6
         bwxsPLz3U5ydhXY2Ayhg1tifWcHASTZiUE4O2gZLALA8yD0+rD8Yhv2UNDpdTXRDRzEb
         jRC0VL0zt/hwKRHXMZh58Ht6Nsi9jvTsPRxo2PJQnuDml0DAGZ7ZzrpH6iNNo8V7LvcO
         mjmg==
X-Gm-Message-State: AOAM532/04drNonZ+TxLghbbyNIUOMoK/H5F/ACJetQ2fLiN7I6hM4mF
        JdgyoAcefexaNalkFDQvsmPrLNbq
X-Google-Smtp-Source: ABdhPJxIjg56pg+B5Fp7d6Ufukakc7QwtW/9NkKlFcoXlnnpDZ5+8fkNJmeE56XZw+fTZ9qQURBkCA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr13032414wmd.138.1592225426064;
        Mon, 15 Jun 2020 05:50:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm23214639wmd.42.2020.06.15.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:25 -0700 (PDT)
Message-Id: <c711eba7e760b4f80ab8ef69ed1d69d9710d85c7.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:12 +0000
Subject: [PATCH v2 08/12] init: allow overriding the default main branch name
 via the config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Don Goodman-Wilson <don@goodman-wilson.com>

We just introduced the command-line option `--main-branch=<branch-name>`
to allow initializing a new repository with a different initial branch
than the hard-coded one.

To allow users to override the default main branch name more permanently
(i.e. without having to specify the name manually for each and every
`git init` invocation), let's introduce the `init.defaultBranch` config
setting.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
---
 Documentation/config/init.txt |  4 ++++
 builtin/init-db.c             |  6 ++++--
 refs.c                        |  7 +++++--
 refs.h                        |  4 ++++
 t/t0001-init.sh               | 16 ++++++++++++++++
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index 46fa8c6a082..6ae4a38416e 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -1,3 +1,7 @@
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+
+init.defaultBranch::
+	Allows overriding the default branch name when initializing
+	a new repository.
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 287cdafaab1..d09c9dc7845 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -266,10 +266,11 @@ static int create_default_files(const char *template_path,
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
-		char *ref;
+		char *ref, *fall_back = NULL;
 
 		if (!main_branch)
-			main_branch = "master";
+			main_branch = fall_back =
+				git_main_branch_name(MAIN_BRANCH_FOR_INIT);
 
 		ref = xstrfmt("refs/heads/%s", main_branch);
 		if (check_refname_format(ref, 0) < 0)
@@ -280,6 +281,7 @@ static int create_default_files(const char *template_path,
 		free(ref);
 
 		git_config_set("core.mainbranch", main_branch);
+		free(fall_back);
 	} else if (main_branch)
 		warning(_("re-init: ignoring --main-branch=%s"), main_branch);
 
diff --git a/refs.c b/refs.c
index 7da3ac178c4..4b0e5b14062 100644
--- a/refs.c
+++ b/refs.c
@@ -563,8 +563,11 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
 char *repo_main_branch_name(struct repository *r, int flags)
 {
 	int full_name = flags & MAIN_BRANCH_FULL_NAME;
-	const char *config_key = "core.mainbranch";
-	const char *config_display_key = "core.mainBranch";
+	int for_init = flags & MAIN_BRANCH_FOR_INIT;
+	const char *config_key = for_init ?
+		 "init.defaultbranch" : "core.mainbranch";
+	const char *config_display_key = for_init ?
+		 "init.defaultBranch" : "core.mainBranch";
 	const char *fall_back = "master";
 	char *name = NULL, *ret;
 
diff --git a/refs.h b/refs.h
index 96472f9a9f5..c801d08490c 100644
--- a/refs.h
+++ b/refs.h
@@ -158,10 +158,14 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
  * Retrieves the name of the main (or: primary) branch of the given
  * repository.
  *
+ * To obtain the default for newly-initialized repositories, pass the flag
+ * `MAIN_BRANCH_FOR_INIT`.
+ *
  * The result is an allocated string. Unless the flags ask for a short name, it
  * will be prefixed with "refs/heads/".
  */
 #define MAIN_BRANCH_FULL_NAME (1<<0)
+#define MAIN_BRANCH_FOR_INIT   (1<<1)
 char *git_main_branch_name(int flags);
 char *repo_main_branch_name(struct repository *r, int flags);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5d8e321a703..fbf02066940 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -479,4 +479,20 @@ test_expect_success '--main-branch' '
 	grep hello actual
 '
 
+test_expect_success 'overridden default main branch name (config)' '
+	test_config_global init.defaultBranch nmb &&
+	git init main-branch-config &&
+	git -C main-branch-config symbolic-ref HEAD >actual &&
+	grep nmb actual &&
+	git -C main-branch-config config core.mainBranch >actual &&
+	echo nmb >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'invalid default branch name' '
+	test_config_global init.defaultBranch "with space" &&
+	test_must_fail git init main-branch-invalid 2>err &&
+	test_i18ngrep "invalid branch name" err
+'
+
 test_done
-- 
gitgitgadget

