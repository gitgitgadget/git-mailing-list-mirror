Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233541F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfI3Bvi (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42553 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfI3Bvh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so6408983qkl.9
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxfiWCZo0YKl0QO8A60X9gdAN0bHMQeS4a3WgubKrxI=;
        b=rKb04N8RoZxum1e1BBA5fkndiGdam/Len6OBLeaxJkOKDE6LHd0KEiMcrF+6egeCVF
         lWnqeGMS6pdES/El82K8aczti0nDCBzzVlM3fwVhsmTtuD+Snao+4OdHlkDFL6P1AMXn
         ZeoVr/M8DAAY3xQVbS78eRk47UdMCHmRy+jVMcL44XSLqWNZ+QFcD+cCiB9W//Wl26MZ
         j/5FsqDleaWZYkjxOrq9NM32JUFJyumKL3bpxaL96iD/4cY562fD26aEo5eeVKnoh3jm
         EyuVv2cEBC8HxfISbkpTzumRNX/oyXVwK3lamPK5vIHF5oUAi1NIfbsLJ1buF/zg3qMD
         vzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxfiWCZo0YKl0QO8A60X9gdAN0bHMQeS4a3WgubKrxI=;
        b=a1DLnD2n85kf+Vj03/8mL6ndiP9R5dSZ7DfoYFYfDqyHbPoziVnmZcT2ZlmOzg6Aw9
         Pvu1GyZz0xlIRUxLcRScFlINW1InksjYJ+Pb4xdzQ7lgOb7GFCD19xVt+a3twZDilJGT
         NY4PQZjb1HiSkbTN69c1EWA00Wd85sjNoze1gIstX2WAXhcQu+RA7qWPmcwF5UKycmrX
         blOuk/KJGUMKNUMx1zK5Gp2/YfMMvRj3KCFqOt7J+yOv/xNQkKbX1gUrfBCbi9XnkB2A
         1iy3+SCRmQ0zTy92jT8T6qJIyxklSRdtjuTKW6c2jmf58uiUrgyrAoeVk7NjcKnfGXpL
         2dPg==
X-Gm-Message-State: APjAAAWVfYhheM48OrhGQy6xKoMHUWmacoy7qDPqj2PWmAeeW6AXoV5u
        1diV07P8yY0m2vPI9fEDJTIk9cQul8Y=
X-Google-Smtp-Source: APXvYqw4VfcOg4qptuoRkpRfqGiPGi+o8FlbzCXRTEYQP85putAEIjqMBVSYT+FaN/d67qE+ed/JWg==
X-Received: by 2002:a37:6005:: with SMTP id u5mr15242355qkb.79.1569808296340;
        Sun, 29 Sep 2019 18:51:36 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:35 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 07/11] submodule-config: add skip_if_read option to repo_read_gitmodules()
Date:   Sun, 29 Sep 2019 22:50:53 -0300
Message-Id: <38940b38af5337646b0ddd4b06d3efb1b97aec81.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, submodule-config.c doesn't have an externally acessible
function to read gitmodules only if it wasn't already read. But this
exactly behavior is internally implemented by gitmodules_read_check(),
to perform a lazy load. Let's merge this function with
repo_read_gitmodules() adding an 'skip_if_read' which allow both
internal and external callers to access this functionality. This
simplifies a little the code. The added option will also be used in the
following patch.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c     |  2 +-
 submodule-config.c | 18 ++++++------------
 submodule-config.h |  2 +-
 unpack-trees.c     |  4 ++--
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a404ee1db..1c4ff4a75f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -420,7 +420,7 @@ static int grep_submodule(struct grep_opt *opt,
 		return 0;
 	}
 
-	repo_read_gitmodules(&subrepo);
+	repo_read_gitmodules(&subrepo, 0);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
diff --git a/submodule-config.c b/submodule-config.c
index 4264ee216f..8c4333120a 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -660,10 +660,13 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 	return parse_config(var, value, &parameter);
 }
 
-void repo_read_gitmodules(struct repository *repo)
+void repo_read_gitmodules(struct repository *repo, int skip_if_read)
 {
 	submodule_cache_check_init(repo);
 
+	if (repo->submodule_cache->gitmodules_read && skip_if_read)
+		return;
+
 	if (repo_read_index(repo) < 0)
 		return;
 
@@ -689,20 +692,11 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 	the_repository->submodule_cache->gitmodules_read = 1;
 }
 
-static void gitmodules_read_check(struct repository *repo)
-{
-	submodule_cache_check_init(repo);
-
-	/* read the repo's .gitmodules file if it hasn't been already */
-	if (!repo->submodule_cache->gitmodules_read)
-		repo_read_gitmodules(repo);
-}
-
 const struct submodule *submodule_from_name(struct repository *r,
 					    const struct object_id *treeish_name,
 		const char *name)
 {
-	gitmodules_read_check(r);
+	repo_read_gitmodules(r, 1);
 	return config_from(r->submodule_cache, treeish_name, name, lookup_name);
 }
 
@@ -710,7 +704,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *treeish_name,
 		const char *path)
 {
-	gitmodules_read_check(r);
+	repo_read_gitmodules(r, 1);
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
diff --git a/submodule-config.h b/submodule-config.h
index 1b4e2da658..7a76ef8cd8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -39,7 +39,7 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 					  const char *arg, int unset);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-void repo_read_gitmodules(struct repository *repo);
+void repo_read_gitmodules(struct repository *repo, int skip_if_read);
 void gitmodules_config_oid(const struct object_id *commit_oid);
 const struct submodule *submodule_from_name(struct repository *r,
 					    const struct object_id *commit_or_tree,
diff --git a/unpack-trees.c b/unpack-trees.c
index 9c25126aec..689575944c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -292,11 +292,11 @@ static void load_gitmodules_file(struct index_state *index,
 	if (pos >= 0) {
 		struct cache_entry *ce = index->cache[pos];
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
-			repo_read_gitmodules(the_repository);
+			repo_read_gitmodules(the_repository, 0);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
 			submodule_free(the_repository);
 			checkout_entry(ce, state, NULL, NULL);
-			repo_read_gitmodules(the_repository);
+			repo_read_gitmodules(the_repository, 0);
 		}
 	}
 }
-- 
2.23.0

