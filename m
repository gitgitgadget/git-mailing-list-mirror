Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309BEC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DD12084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RE7uEGoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgAPClE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:04 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39908 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPClD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:03 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so8413098qvk.6
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TA7lRlyRWEd5mU0k/fFdKmgevZllR9GjhHtwI3rbbuE=;
        b=RE7uEGoUYF85BJEoij2bYjKiTPAyj0E0PjNOI9d+CJfwpZ/ZQHJH+5l6ulSfuzdMuA
         IHJoaX6a6w1DpTSGivDPMR+/4RKWbMenmGzkGY7FPbZsGPQdeJO8cg0HQssDDKUAsiBx
         2XTYB2Gbg7M72SXk2V4BXhCjfCiqHWiI9KvNLKKq0WDRl3DjdLD/V98P7N3c2zo8xlnZ
         Fa7ooZW9u/DqBR+Nr0dNkO8qNzXc865LwTAscJzJ/kT3RfT7TV15l1HzS3kifXzlKWrm
         tRj1ozfWVjMyhwBMXQkkr9bTJSfIs6vkkn2SB+l3wkJhNc+OpdI0fQ0MTm+9oJnPiqtU
         LmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TA7lRlyRWEd5mU0k/fFdKmgevZllR9GjhHtwI3rbbuE=;
        b=eiOyOW7V180+yTjYb7d+HBfL37EEo+M8gHhFLPJlTX5WaOHilKljkL+pZjJ0KtbGDI
         uHtilqRVwJqz3hypAGp3V+H/T+Bti39pjMNid9EHPcQR0n4e5Kor4ISyG6ilETIOEvFS
         qfw/iz7o0/djxGZVpRm9cZmbA8hqCS99w+yrtN0N0AQIq39RS8BgWGFihQU2RAjNodKw
         bZA/kD7TbSWZ3l8JlG0S794iJkd4PrfzfbgLwTC8l2pdicgiiq5ZvlndBzEMvzeRSPym
         vbiQ5bW18pm4f4wOOr+57tIe9L0m8xI182Vm53wmt6NGBq3dO9nIttOqLuECooqinW7b
         MYdw==
X-Gm-Message-State: APjAAAV9eRfVXS4Noq0GZuD7WQLIcF3nwoEl2QEWvp45v1tu7tzz4P26
        f0fC+2Kqim7NmFOmj1NHuAGa1tmWQAE=
X-Google-Smtp-Source: APXvYqwD2mZdulpw+xw0giCRKvYPibqvDuvGps+z+9j7nnRTgKsKv5K7Ws9JW2G/J3BrvQwtvsAfAg==
X-Received: by 2002:a0c:ed22:: with SMTP id u2mr480777qvq.13.1579142462118;
        Wed, 15 Jan 2020 18:41:02 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:01 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 07/12] submodule-config: add skip_if_read option to repo_read_gitmodules()
Date:   Wed, 15 Jan 2020 23:39:55 -0300
Message-Id: <d39d2ce9c4c4975969a7b99cbe1ee6c8abb586c1.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, submodule-config.c doesn't have an externally accessible
function to read gitmodules only if it wasn't already read. But this
exact behavior is internally implemented by gitmodules_read_check(), to
perform a lazy load. Let's merge this function with
repo_read_gitmodules() adding a 'skip_if_read' which allows both
internal and external callers to access this functionality. This
simplifies a little the code. The added option will also be used in
the following patch.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c     |  2 +-
 submodule-config.c | 18 ++++++------------
 submodule-config.h |  2 +-
 unpack-trees.c     |  4 ++--
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4a436d6c99..d3ed05c1da 100644
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
index 85064810b2..bd5e14ab20 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -674,10 +674,13 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
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
 
@@ -703,20 +706,11 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
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
 
@@ -724,7 +718,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *treeish_name,
 		const char *path)
 {
-	gitmodules_read_check(r);
+	repo_read_gitmodules(r, 1);
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
diff --git a/submodule-config.h b/submodule-config.h
index 42918b55e8..c11e22cf50 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -61,7 +61,7 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 					  const char *arg, int unset);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-void repo_read_gitmodules(struct repository *repo);
+void repo_read_gitmodules(struct repository *repo, int skip_if_read);
 void gitmodules_config_oid(const struct object_id *commit_oid);
 
 /**
diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818b..f5a8051803 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -291,11 +291,11 @@ static void load_gitmodules_file(struct index_state *index,
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
2.24.1

