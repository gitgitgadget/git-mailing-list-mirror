Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE82B1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC0Vjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:39:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41904 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC0Vjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:39:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11so142317pff.8
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xABzrOClhgAv8m+Dym+uZH3146G3JdByr3qMJsrrsBs=;
        b=QC4BaLXsMGOT35unV7V0cdNqiXKCarGSG3DITs+yxpWIxBuNN+udvf7lrGmJgnva7t
         RIoQqW4VOvQZGb6BnKxQX3FielVroUBV/mfvGPiZS3T22YphAjB3YZPq/MT5fiABPuJ4
         w9XGHaXT2/4v3wcNekEB7xMjHDPbPk6VxHgBCNSZAzp4WcOzq6tiTGc0+gRrijxCeaZ7
         q+BBW3pIcx2rgM3xBiYU0L1VftceaouUUqsrYL0bLD/tTzxtn3zFfTDY76vuNfy/oev8
         jiMZdE8tCeAi97XIMMO10M/NgHs3aqYq6S7bjDCB6isKUfaDMQPshzGmtq8be6dwlXsc
         HkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xABzrOClhgAv8m+Dym+uZH3146G3JdByr3qMJsrrsBs=;
        b=YWlxHfK7+zRPgqzS21fIiP8dSaX2Xn5gSLfO74DKgf1LNLU2DZAb/9eeYGcdIOj2Vg
         LChICUYRj3ih+OtneXpYtSbkXhKGjciAAtRwKIg3whP7MQ4x72/Jj818pdpyQeWVNw+q
         ghi8YrH1mUvW0A1KSSFXVXrWBotX29eT2ab/N9SyWHrAPOZvilsdNyKoVP636ZpFYjOE
         VjVoynYI6NTXMpUOw3GyMq9cw9NcBssqwGkxoW11Gtke/qaAnZWTBI+MIy6sLmbeBY5V
         5rdGr68ajTv8Wk4edteUmqC/QsIPSU1z5DpQRJBGS+cGT76UtLxb+3pUSxC3g4cGrKYZ
         poHg==
X-Gm-Message-State: AElRT7EYJX0iLJVuORmvZHHPa+n+ZBzt8jQoEVqzJ2VzQkODSus5rmNi
        rSIGGI+5ClnTvlmcRJg2lsyXI1k/eKQ=
X-Google-Smtp-Source: AIpwx4+Ybw0QRPu5s/0O29RHx8r+GA+5bJMaqEzQ6jJ9PI9g7ruGb+VPyVpIRaV/kQm1RhqVvJb22g==
X-Received: by 10.98.244.6 with SMTP id r6mr742534pff.242.1522186774523;
        Tue, 27 Mar 2018 14:39:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t17sm4066668pgv.36.2018.03.27.14.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 14:39:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     seanwbehan@riseup.net, bmwill@google.com, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] submodule-config: allow submodule_free to handle arbitrary repositories
Date:   Tue, 27 Mar 2018 14:39:15 -0700
Message-Id: <20180327213918.77851-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180327213918.77851-1-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt | 2 +-
 builtin/grep.c                                   | 2 +-
 submodule-config.c                               | 6 +++---
 submodule-config.h                               | 2 +-
 t/helper/test-submodule-config.c                 | 2 +-
 unpack-trees.c                                   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index ee907c4a82..fb06089393 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -38,7 +38,7 @@ Data Structures
 Functions
 ---------
 
-`void submodule_free()`::
+`void submodule_free(struct repository *r)`::
 
 	Use these to free the internally cached values.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 789a89133a..8f04cde18e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -651,7 +651,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free();
+			submodule_free(repo);
 			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
diff --git a/submodule-config.c b/submodule-config.c
index 602ba8ca8b..a3efff1a34 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -642,8 +642,8 @@ const struct submodule *submodule_from_cache(struct repository *repo,
 			   key, lookup_path);
 }
 
-void submodule_free(void)
+void submodule_free(struct repository *r)
 {
-	if (the_repository->submodule_cache)
-		submodule_cache_clear(the_repository->submodule_cache);
+	if (r->submodule_cache)
+		submodule_cache_clear(r->submodule_cache);
 }
diff --git a/submodule-config.h b/submodule-config.h
index a5503a5d17..df6bd6e6db 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -46,6 +46,6 @@ extern const struct submodule *submodule_from_path(
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
 						    const char *key);
-extern void submodule_free(void);
+extern void submodule_free(struct repository *r);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index f23db3b19a..9971c5e9dd 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -64,7 +64,7 @@ int cmd_main(int argc, const char **argv)
 		arg += 2;
 	}
 
-	submodule_free();
+	submodule_free(the_repository);
 
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index d5685891a5..05e5fa77eb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -290,7 +290,7 @@ static void load_gitmodules_file(struct index_state *index,
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
 			repo_read_gitmodules(the_repository);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
-			submodule_free();
+			submodule_free(the_repository);
 			checkout_entry(ce, state, NULL);
 			repo_read_gitmodules(the_repository);
 		}
-- 
2.17.0.rc1.321.gba9d0f2565-goog

