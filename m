Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F75C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiG1QSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiG1QSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DA70E7C
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i8so2828159wro.11
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=W05pZ2PE0IggFfmmgw6juUOtJcF/MGyeWze3BCybyD8=;
        b=gqnX9Fi9hzRFm9umAia4+Rpuwewl9qE1bwKtJDbjrByE4t0UdaFmCqXAYZlsv2h+eR
         dCsCWK58jtliKvcwk5HuqrkWhfNyhZv9phS6QCDUsyHJHocQg3AqHAJofpOvHjBWxjfo
         PJzh0W+jnzwBsYXVX/6JSWHqjegSJbi7tMvhe4KQHKKMD5Zc/eRKGNzVTPahKhJT6qEP
         45LkjVKfhypQ0aznBAYH+wXNIbJDbDxDpxYirejX4ELDSrdgDA0hemW8nOVnDICafsuN
         XM3h8IOWEguYLi3Ifazl3pHEZpOqHqwKvTahXTE8Y8IPt6o14iC1/aycDDYIoRdcrZeQ
         GyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W05pZ2PE0IggFfmmgw6juUOtJcF/MGyeWze3BCybyD8=;
        b=lP/di5r2BF0UO8pmy4Vv/jWXnbQtjn4+jSi9bxlKlqBX0HqJd9VLBlKI5gwmZQvf/l
         sxJLZqoWdjNTXyMQaJlEp70pGXFC8J6RVEukFCqQ4bapJBCwOpv+7M1H7cFC2u/QJpEm
         6tqCZOfyvcZTSEOpjiqHTiJ+rBP7W8xR6gWOIYfhkBYZ5hFhdb1I7gc6pQBQ1rD6f7zG
         W7t6jVnnJW/arS9aBbrIxT6J/105ekzOGn8wEwEWaEtRWb+eRET5+q1bHVLy7Qk0ZE17
         0ZmjkRz7pN/8DZGJoIQJ2S47orAQQvoRdMbw6sc0yiDIIHXYhcTJqluYLoAYNj7K631x
         K5Wg==
X-Gm-Message-State: AJIora90pXdTk9d52Gx/+YFyYVqTn3uA0iO22rljWyD5Fomq2xBUp3Xu
        GGHgG9G4RtMCd9LjdbONB8qRftvcNaCzsA==
X-Google-Smtp-Source: AGRyM1sLJCI24v8cp5Yh8vJpH17jKdSVbua7m76hiuQxlSOB92aSlZJcBHa8XP7jutEQR+vRZiZdoA==
X-Received: by 2002:a5d:5a82:0:b0:21e:2899:60bd with SMTP id bp2-20020a5d5a82000000b0021e289960bdmr17508072wrb.80.1659025076852;
        Thu, 28 Jul 2022 09:17:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/20] submodule--helper: stop conflating "sb" in clone_submodule()
Date:   Thu, 28 Jul 2022 18:16:58 +0200
Message-Id: <patch-13.20-afe34d8b73b-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the two uses of a "struct strbuf sb" such that each of them
exists in its own scope. This makes the control flow clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f74957444e1..6cedcc5b239 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1557,16 +1557,24 @@ static void prepare_possible_alternates(const char *sm_name,
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
 
 	if (!is_absolute_path(clone_data->path))
 		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
@@ -1624,6 +1632,8 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    clone_data->url, clone_data->path);
 	} else {
+		struct strbuf sb = STRBUF_INIT;
+
 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
 		    !is_empty_dir(clone_data->path))
 			die(_("directory not empty: '%s'"), clone_data->path);
@@ -1631,7 +1641,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("could not create directory '%s'"), clone_data->path);
 		strbuf_addf(&sb, "%s/index", sm_gitdir);
 		unlink_or_warn(sb.buf);
-		strbuf_reset(&sb);
+		strbuf_release(&sb);
 	}
 
 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
@@ -1653,7 +1663,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	free(sm_alternate);
 	free(error_strategy);
 
-	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(p);
 	return 0;
-- 
2.37.1.1167.g38fda70d8c4

