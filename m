Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCB5C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGUTNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUTNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1988740
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b6so1569663wmq.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOqjhYU91jK04HUzdyOxH4z9EhSirbod/RbA74jUA3s=;
        b=BDfTsSqytQU5WvVF3oCxo6gGBqtUEQ47MrpofVOLc6qf9nnKFoXvydEXRWdM4+Zvrr
         +gGDVZA+SAUXWG8ArGV3P7jXm2JqxmDKpyLRm8OJer+Gw2FWYU9UlvCYA+/guLgx+G64
         +vSDDtl+681Fe5UoiWVVjA1wQZVHXcWC0RvkE/46ls7ZWWLixZMP3UQSixHweVxrjgOV
         R96zWZsx+03RU93/sxI8ZQyavvIa8w25HlQ7e73TZ0T4PaPWSr9c+LYsHQwNoU4pZK79
         EfxXZXwFmurUvWMw16WgCoENCjSIUPlrRtxCp+zDPf0TjUBr/X6u6mBQ9uumHKgZsW0T
         U7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOqjhYU91jK04HUzdyOxH4z9EhSirbod/RbA74jUA3s=;
        b=xIcYxIuspW4gwe0ZKs7ihRNZPfVqkq6LRsgjxIC89PW5hxJ9GSg8uuHp0XeuOozxZK
         4FuJ3+wTaAW2zonp9rwkHuT1KKVGgc233VW8aa5Psbl7QqLRMUTyXZcAThEmJ3C7xuzl
         vTuSxZdOM4Mcw0N6eTTS3jyf+PDa0O6xXZsB1waUD4kT4xgP1Wys/mpYeoQgscy4+vjp
         /2dMIhFUlEqZR220ZAWEhhnIi7PAyZ96a3fz7nlXv7EwN4mHBDuZon7LBuLiH++Yj04q
         pWwx1k3zjGIOTSpZiplQKxvGdtPMO6VYf4NRcWfbiY/oHr81asYcAhlKgDbTXZ4oSrVr
         wa1A==
X-Gm-Message-State: AJIora+bC04WFFp+NN9NgtOEVaSs0ByLJ3AvRgJ8Fctjkxye86RolFde
        vyI780fv+/vucBa2ulIFaw1tgaZKT2S3Hg==
X-Google-Smtp-Source: AGRyM1se/2V/sz+aFeVnnZncotgXsv+L42lh7i3FThtVSKiZBJhDmPa7t+GWABQyhRiYwFsv5QI7jw==
X-Received: by 2002:a7b:c316:0:b0:3a3:c83:9001 with SMTP id k22-20020a7bc316000000b003a30c839001mr9737152wmj.105.1658430815639;
        Thu, 21 Jul 2022 12:13:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in clone_submodule()
Date:   Thu, 21 Jul 2022 21:12:58 +0200
Message-Id: <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the three uses of a "struct strbuf sb" such that each of them
exists in its own scope. This makes the control flow clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 73717be957c..29641690c8c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1638,18 +1638,28 @@ static void prepare_possible_alternates(const char *sm_name,
 	free(error_strategy);
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static char *clone_submodule_sm_gitdir(const char *name)
 {
-	char *p, *sm_gitdir;
-	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	char *sm_gitdir;
 
-	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
-	strbuf_reset(&sb);
+	strbuf_release(&sb);
+
+	return sm_gitdir;
+}
+
+static int clone_submodule(struct module_clone_data *clone_data)
+{
+	char *p;
+	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	if (!is_absolute_path(clone_data->path)) {
+		struct strbuf sb = STRBUF_INIT;
+
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
 		clone_data->path = strbuf_detach(&sb, NULL);
 	} else {
@@ -1705,6 +1715,8 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    clone_data->url, clone_data->path);
 	} else {
+		struct strbuf sb = STRBUF_INIT;
+
 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
 		    !is_empty_dir(clone_data->path))
 			die(_("directory not empty: '%s'"), clone_data->path);
@@ -1712,7 +1724,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("could not create directory '%s'"), clone_data->path);
 		strbuf_addf(&sb, "%s/index", sm_gitdir);
 		unlink_or_warn(sb.buf);
-		strbuf_reset(&sb);
+		strbuf_release(&sb);
 	}
 
 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
@@ -1734,7 +1746,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	free(sm_alternate);
 	free(error_strategy);
 
-	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(p);
 	return 0;
-- 
2.37.1.1095.g0bd6f54ba8a

