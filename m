Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798E71F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeC1Wfo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46123 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeC1Wfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so1811177pfe.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nNQzZ+x3m0lhkw+0k394WnhVlW9e9KUO3S6m60nM8ac=;
        b=B6NIaWq1yvAjS0d7w65fQTNuXoYekAG1wh8jdjbNWivntwVUS6Lt0SldEM7jPQOGrr
         +IDm0bpVl0sFbTmc/pVLg4NJDRnpZmojiR4uWew/Bz38OEMMuH8UF9xD5XlMCkRC/eD2
         U0yuTosqd6S4GisDLtVXRHk7u+EMXyya0lkfQLXsB7rm0/rvpSlLaUOlALBxrO1XUYXW
         JeHihGUETSMxnTXB4jaPCtou9gYZ67sKG2eym6awSb3kk1pv+9RUxWtQdxEFPdNFArsR
         ueDDp9x2K7HypWMpF9+iF+671I9Z13WHDxlH+lAGeO99j3mTmERIl48Cg4JaluHJAn7d
         veXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nNQzZ+x3m0lhkw+0k394WnhVlW9e9KUO3S6m60nM8ac=;
        b=ky6xt5jKNpvU6tDkSxbqpriUTvNaiisr2GYkQsNbl4SZHmPBgdE9Tf6aY/0tJClJPY
         es8FuKbDaK3uNK5iY5YwFuQXsTBCRK1kiCsw0GWZ9n7p1+w7X+/oVxVvof2Zfsdvc48z
         WvDN4awjT9mG5XSqgcILBTLNrbKa71W1sgw898L/TANRtgn+F24gvvKxigrdFIJ7+O4Z
         6tEyK7DCylaA/Rlv2nxWb45ehyic5WND7wmAFBibOkzRYGzLoYLo0OV790Y+NzRGYA4P
         cl6PlSkjbmLejllYmPV3Fe4U0dACo7VbRPWMj1Hqq/CXSGy7q1bnu9SdVBirzdZyrnSS
         zt9A==
X-Gm-Message-State: AElRT7Hp+JNUOrn6DwCtVqo84I9tCMvYyGgy/lZnWMvnW1OFOWklH8+z
        1qfL5pDxekll5buUVX9RMMhAeREsVBU=
X-Google-Smtp-Source: AIpwx49UlCLyNrIqWAuW43jFzXs8rQtwrUqZ14d0WsGCKeVbaWQ+Pgw1s/ue7RLSs3mybKSzwA5SDQ==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr5692810plv.332.1522276538974;
        Wed, 28 Mar 2018 15:35:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t16sm8271835pgu.63.2018.03.28.15.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 3/6] submodule-config: allow submodule_free to handle arbitrary repositories
Date:   Wed, 28 Mar 2018 15:35:28 -0700
Message-Id: <20180328223531.241920-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
 <20180328223531.241920-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At some point we may want to rename the function so that it describes what
it actually does as 'submodule_free' doesn't quite describe that this
clears a repository's submodule cache.  But that's beyond the scope of
this series.

While at it remove the extern key word from its declaration.

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
index 3dce003fda..44a85bbb8b 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -38,7 +38,7 @@ Data Structures
 Functions
 ---------
 
-`void submodule_free()`::
+`void submodule_free(struct repository *r)`::
 
 	Use these to free the internally cached values.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 754eb6da3b..c1f22fb9fb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -643,7 +643,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free();
+			submodule_free(the_repository);
 			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
diff --git a/submodule-config.c b/submodule-config.c
index 2aa8a1747f..5b4f0baae8 100644
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
index a5503a5d17..6b71a8cd30 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -46,6 +46,6 @@ extern const struct submodule *submodule_from_path(
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
 						    const char *key);
-extern void submodule_free(void);
+void submodule_free(struct repository *r);
 
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
index e6a15bbe44..3a6a28e794 100644
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

