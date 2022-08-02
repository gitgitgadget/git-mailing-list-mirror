Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F29C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiHBPrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiHBPrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E315FD1
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk11so8551077wrb.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=O72dRT+v+fTqGEg3j3bLCBOHUMqja/pFC/vJ3ldq9B8=;
        b=bZjMt/xQxgy4ck8YQPnYJDEuouqfFSzb60oCyBkMPn1LcBLvbplfcZ+kOs/6jmSQUu
         NMfPVnJ77fSgK2DUEozatlgYoNb1pLsme0zz3x3gfVdRm/ZC2zf8SIvrk271jI0LoFDi
         fqx0krDPU6mkEfz6kgKIU7quxncuhAKH/0igLeTtNjBSnp6cufN4qCTUXxE9P2FAXeXL
         Xc6pQOXK1tFnVuQfi0aSeZA9OTgnbZjFxs5W5i5LPtqy2uFLgjIpFfdsf3zsiZHKVH8P
         uxRVfqBZfcZ2jvKM0mUIzlLi9DtaA2PqlaswYmzEH8Fko6hzNaY/BwIvr4TLnw3yjsnJ
         YR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O72dRT+v+fTqGEg3j3bLCBOHUMqja/pFC/vJ3ldq9B8=;
        b=F6HYK2F0zUQTDnQeVFjDtZaYW0Q1LjT12dmtx9ZpPALZd5tFI61z+7r9ViBeDbICVF
         zDd3fIJacwwqoCvgYn4dr0Alg7TAFA8/bEZtODk72W3x1BpoOLYJhdsgM0FOihKqW8kQ
         kxV9T7PyI6sYCelpc1p+fhw5/ygq2taVYbAOwtJekfV7kIFXQZ55YuwClsRIFY0dkzgX
         u17RLu18JSatybOiHnlzXaXbfSgeAsAtCJxFU1wFMZrhlx3Wf2PzGxddEbebqutPQqR9
         7PJEGHGZhS5tr0YHxLOi4rV/ppCxn2NbtjJuQF2A7gmnrZqBI4DJUxe4drMkyO10st8d
         raRg==
X-Gm-Message-State: ACgBeo0pEPzLewtzF+GtdHnBKFiJhZ8angDkUDOLQxZKh82WXA3o/K56
        9FeApJgQ65hcSwxPq6ERQqy0pNUFAzpkSQ==
X-Google-Smtp-Source: AA6agR75dBe5dVZZwYSjg9Q2j095ieL9CawTDj2ZxiXbOXh5r3xmr+PJ7skQR91WomFSGjT0MBZTQQ==
X-Received: by 2002:a5d:6d85:0:b0:220:7084:35e9 with SMTP id l5-20020a5d6d85000000b00220708435e9mr2583200wrs.11.1659455198671;
        Tue, 02 Aug 2022 08:46:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/28] submodule--helper: move submodule_strategy_to_string() to only user
Date:   Tue,  2 Aug 2022 17:46:06 +0200
Message-Id: <patch-v2-22.28-98c3e562c82-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the submodule_strategy_to_string() function added in
3604242f080 (submodule: port init from shell to C, 2016-04-15) to its
only user.

This function would return NULL on SM_UPDATE_UNSPECIFIED, so it wasn't
safe to xstrdup() its return value in the general case, or to use it
in a sprintf() format as the code removed in the preceding commit did.

But its callers would never call it with either SM_UPDATE_UNSPECIFIED
or SM_UPDATE_COMMAND. Let's move it to a "static" helper, and have its
functionality reflect how it's used, and BUG() out on the rest.

By doing this we can also stop needlessly xstrdup()-ing and free()-ing
the memory for the config we're setting. We can instead always use
constant strings. We can also use the *_tmp() variant of
git_config_get_string().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 29 ++++++++++++++++++++++++-----
 submodule.c                 | 21 ---------------------
 submodule.h                 |  1 -
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b49528e1ba9..d787c0fead4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -413,12 +413,32 @@ struct init_cb {
 };
 #define INIT_CB_INIT { 0 }
 
+static const char *submodule_strategy_to_string(enum submodule_update_type type)
+{
+	switch (type) {
+	case SM_UPDATE_CHECKOUT:
+		return "checkout";
+	case SM_UPDATE_MERGE:
+		return "merge";
+	case SM_UPDATE_REBASE:
+		return "rebase";
+	case SM_UPDATE_NONE:
+		return "none";
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_COMMAND:
+		BUG("init_submodule() should handle type %d", type);
+	default:
+		BUG("unexpected update strategy type: %d", type);
+	}
+}
+
 static void init_submodule(const char *path, const char *prefix,
 			   unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
-	char *upd = NULL, *url = NULL, *displaypath;
+	const char *upd;
+	char *url = NULL, *displaypath;
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
@@ -474,14 +494,14 @@ static void init_submodule(const char *path, const char *prefix,
 
 	/* Copy "update" setting when it is not set yet */
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
-	if (git_config_get_string(sb.buf, &upd) &&
+	if (git_config_get_string_tmp(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
 		if (sub->update_strategy.type == SM_UPDATE_COMMAND) {
 			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
 				sub->name);
-			upd = xstrdup("none");
+			upd = "none";
 		} else {
-			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
+			upd = submodule_strategy_to_string(sub->update_strategy.type);
 		}
 
 		if (git_config_set_gently(sb.buf, upd))
@@ -490,7 +510,6 @@ static void init_submodule(const char *path, const char *prefix,
 	strbuf_release(&sb);
 	free(displaypath);
 	free(url);
-	free(upd);
 }
 
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
diff --git a/submodule.c b/submodule.c
index 3fa5db3ecdf..e297d94d17f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -415,27 +415,6 @@ int parse_submodule_update_strategy(const char *value,
 	return 0;
 }
 
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s)
-{
-	struct strbuf sb = STRBUF_INIT;
-	switch (s->type) {
-	case SM_UPDATE_CHECKOUT:
-		return "checkout";
-	case SM_UPDATE_MERGE:
-		return "merge";
-	case SM_UPDATE_REBASE:
-		return "rebase";
-	case SM_UPDATE_NONE:
-		return "none";
-	case SM_UPDATE_UNSPECIFIED:
-		return NULL;
-	case SM_UPDATE_COMMAND:
-		strbuf_addf(&sb, "!%s", s->command);
-		return strbuf_detach(&sb, NULL);
-	}
-	return NULL;
-}
-
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index bfaa9da1868..949f67b8031 100644
--- a/submodule.h
+++ b/submodule.h
@@ -72,7 +72,6 @@ void die_path_inside_submodule(struct index_state *istate,
 enum submodule_update_type parse_submodule_update_type(const char *value);
 int parse_submodule_update_strategy(const char *value,
 				    struct submodule_update_strategy *dst);
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *, const char *);
 void show_submodule_diff_summary(struct diff_options *o, const char *path,
 			    struct object_id *one, struct object_id *two,
-- 
2.37.1.1233.ge8b09efaedc

