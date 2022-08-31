Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698CECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiHaXTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiHaXSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EBD4C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s7so5225854wro.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jLGnDA05jM1kKA+Us9LI/1yvfDX1KqtqYdb/PpOyae0=;
        b=Qe9gnegHX2QfQQkiJHrD7x/ZjZPXS7lgfeK3qCpkDDRFtGhlHbPthOWcyuM7vT3ol5
         d7bqxGtiPoIdurEIg1VAPNTLba0wrz5GD+9YKnHLK1v4QgE0TQdQvPJzyi+8GzRHmLvw
         xbVCBo7A1ZzQjMsTukFBrgq/mQllQG7XGmX1Nwbt2FIPNMDNfiSxVhDkPo61KpDOIQH3
         GrZ/U/ISxipbzEuj1QoHdiwQRDJkPCCYhNglGJ6zsfjgz1ZqUFpdSSlARTWvArhM/e2D
         9Agf8D5+JhcS4I8KMJ//yricoEsGNCH/yNO8Vy30qrtuh3+xzbhuZGtWOuQC2ZzgHown
         voVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jLGnDA05jM1kKA+Us9LI/1yvfDX1KqtqYdb/PpOyae0=;
        b=obGXg/MUpw15dPPP/Ks9kuw2/WdOht44fpOA2YE9eP+BbvOyM6sVAnE41TvUkTAcZC
         4b6IyFIuN0H1KT431ZhmUzTLiNDppVpf+z9Wvv0hiLhDTmEkgMhHdjIDLoGBBL6kCeFm
         gQc1/cZZMSoIX3S/kDvHxleJ30PjUkIPE2VVILk2+ksQvbd7kfJ5TA8r4G+9ZXBIcROW
         pz1ws58bgZAX4ERvjDW768RmHv8MqYVw1fhCwHPX7b5zmcSJMHYH1okva9msR3BXXApv
         iDVNFWKpNPamPsCTNGRBcgNDJcKcUKQStyAnc8l40pELAukmVrz61V4PR40iJ4rgm2On
         hMHA==
X-Gm-Message-State: ACgBeo3My8//JydZcjRuKg2I1YP1SojCjlQ0mOCplt6HehXxkS85RvjW
        dkIsxwT14kN66faOOOusUnThwSsW9RffCA==
X-Google-Smtp-Source: AA6agR5fPt7/KsekhLdJlOlt2OCm4R4UlZnniyuTusZQ+V5wzCbj7hQ+2o7W/+t+eAy1iEWtd/PFxg==
X-Received: by 2002:a5d:6f0c:0:b0:226:eda7:ee93 with SMTP id ay12-20020a5d6f0c000000b00226eda7ee93mr2607781wrb.657.1661987918664;
        Wed, 31 Aug 2022 16:18:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 23/33] submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
Date:   Thu,  1 Sep 2022 01:18:05 +0200
Message-Id: <patch-v4-23.33-d101aa6c8c5-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the submodule_strategy_to_string() function added in
3604242f080 (submodule: port init from shell to C, 2016-04-15) to
really return a "const char *". In the "SM_UPDATE_COMMAND" case it
would return a strbuf_detach().

Furthermore, this function would return NULL on SM_UPDATE_UNSPECIFIED,
so it wasn't safe to xstrdup() its return value in the general case,
or to use it in a sprintf() format as the code removed in the
preceding commit did.

But its callers would never call it with either SM_UPDATE_UNSPECIFIED
or SM_UPDATE_COMMAND. Let's have its behavior reflect how its only
user expects it to behave, and BUG() out on the rest.

By doing this we can also stop needlessly xstrdup()-ing and free()-ing
the memory for the config we're setting. We can instead always use
constant strings. We can also use the *_tmp() variant of
git_config_get_string().

Let's also rename this submodule_strategy_to_string() function to
submodule_update_type_to_string(). Now that it's only tasked with
returning a string version of the "enum submodule_update_type type".
Before it would look at the "command" field in "struct
submodule_update_strategy".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 10 +++++-----
 submodule.c                 | 12 +++++-------
 submodule.h                 |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 965196a005d..35989c81603 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -418,7 +418,8 @@ static void init_submodule(const char *path, const char *prefix,
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
-	char *upd = NULL, *url = NULL, *displaypath;
+	const char *upd;
+	char *url = NULL, *displaypath;
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
@@ -474,14 +475,14 @@ static void init_submodule(const char *path, const char *prefix,
 
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
+			upd = submodule_update_type_to_string(sub->update_strategy.type);
 		}
 
 		if (git_config_set_gently(sb.buf, upd))
@@ -490,7 +491,6 @@ static void init_submodule(const char *path, const char *prefix,
 	strbuf_release(&sb);
 	free(displaypath);
 	free(url);
-	free(upd);
 }
 
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
diff --git a/submodule.c b/submodule.c
index 3fa5db3ecdf..1ebda30c506 100644
--- a/submodule.c
+++ b/submodule.c
@@ -415,10 +415,9 @@ int parse_submodule_update_strategy(const char *value,
 	return 0;
 }
 
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s)
+const char *submodule_update_type_to_string(enum submodule_update_type type)
 {
-	struct strbuf sb = STRBUF_INIT;
-	switch (s->type) {
+	switch (type) {
 	case SM_UPDATE_CHECKOUT:
 		return "checkout";
 	case SM_UPDATE_MERGE:
@@ -428,12 +427,11 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 	case SM_UPDATE_NONE:
 		return "none";
 	case SM_UPDATE_UNSPECIFIED:
-		return NULL;
 	case SM_UPDATE_COMMAND:
-		strbuf_addf(&sb, "!%s", s->command);
-		return strbuf_detach(&sb, NULL);
+		BUG("init_submodule() should handle type %d", type);
+	default:
+		BUG("unexpected update strategy type: %d", type);
 	}
-	return NULL;
 }
 
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
diff --git a/submodule.h b/submodule.h
index bfaa9da1868..6a9fec6de11 100644
--- a/submodule.h
+++ b/submodule.h
@@ -72,7 +72,7 @@ void die_path_inside_submodule(struct index_state *istate,
 enum submodule_update_type parse_submodule_update_type(const char *value);
 int parse_submodule_update_strategy(const char *value,
 				    struct submodule_update_strategy *dst);
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
+const char *submodule_update_type_to_string(enum submodule_update_type type);
 void handle_ignore_submodules_arg(struct diff_options *, const char *);
 void show_submodule_diff_summary(struct diff_options *o, const char *path,
 			    struct object_id *one, struct object_id *two,
-- 
2.37.3.1420.g76f8a3d556c

