Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC22C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjAJGSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjAJGRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FE1C13E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v30so15959536edb.9
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I630ZkCPAdQ4L15RWoitoZtakXFJm54p6dncO9flkwo=;
        b=OC2Q4Y3zEjEdzKH85mJyaqQdOmP6zzKXlSGNotibftZ+mB+CT+PfKas9kJ3hiFYaVx
         CErd9tb8O4517Pyf5TAn5Xvwh3BZUvFxiVBd+ete0Bp1p2Ex7GdLQ7UEh9ZIGd/c7Urk
         sLx17o9TmNFR4wZg0C0S0hyenXM2MjBFG1woXPXa7VPsX3QpDaBo9XrK5Sb5ZIvU9+/t
         CnH/Osk8HYKu98kSot9s7+Qy9ipr280g4dtm51HZSziRSGyXnXjjOJ76ph8i11EatxfJ
         Y23/FFESDXwFBDkYjnqUu5o/Ezqz0+4dDUkH699wiEw7ujh9bZczRc7fFgzf5fuCAxfG
         I64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I630ZkCPAdQ4L15RWoitoZtakXFJm54p6dncO9flkwo=;
        b=2TWWhSyiQSDJ3kQTlksSaYyDkFIxQbOWBQhI1pJeEiq5X42Ee4jtvFQjVfNGGcf8Bp
         VhZmXjyoFs/C4L/PLEPIs5A4kEOXiUJb7sfN7VL+hHx6aQZw08rIsxh9etCoZ4X08lfF
         iEwTkVts7A6IwXwvA/sFKuJUHcto+a6J77iCfT/doyqyAbhIjv3Sa6PLIPe58GaPQPr1
         S8PHFvvOH1E3IBl1+qfI4YoaZy1VZRr2vNitsODwAUMK8zzvPDNSb5Devup/5YppGG4G
         JEJOH5Br1u0UzVBoNbrEraa8114RmWN11a185df55W6ciGyrC2JZ47/iKZY6qg0CpAKe
         1ISg==
X-Gm-Message-State: AFqh2kp1qsjU0ehxahufJXhV4QCP8JjTyPJhtMwicPFeyYSjpDMgNcFa
        eutrwLQtICiFTuGE2oHImN7E9QAK2hx33Q==
X-Google-Smtp-Source: AMrXdXttQdq7h3zziDbzZJUQCasB6gdOWV+YbJLANggDIFXANr/JoOolZTOIylKlEY12/+hU+jWHng==
X-Received: by 2002:a05:6402:520b:b0:48b:58be:472c with SMTP id s11-20020a056402520b00b0048b58be472cmr49029126edd.18.1673331460622;
        Mon, 09 Jan 2023 22:17:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] sparse-index API: fix TODO, BUG() out on NULL ensure_full_index()
Date:   Tue, 10 Jan 2023 07:17:31 +0100
Message-Id: <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the ensure_full_index() function stricter, and have it only
accept a non-NULL "struct index_state". This function (and this
behavior) was added in [1].

The only reason it needed to be this lax was due to interaction with
repo_index_has_changes(). See the addition of that code in . This
fixes one of the TODO comments added in 0c18c059a15, the other one was
already removed in [3].

The other reason for why this was needed dates back to interaction
with code added in [4]. In [5] we started calling ensure_full_index()
in unpack_trees(), but the caller added in 34110cd4e39 wants to pass
us a NULL "dst_index". Let's instead do the NULL check in
unpack_trees() itself.

1. 4300f8442a2 (sparse-index: implement ensure_full_index(), 2021-03-30)
2. 0c18c059a15 (read-cache: ensure full index, 2021-04-01)
3. d76723ee531 (status: use sparse-index throughout, 2021-07-14).
4. 34110cd4e39 (Make 'unpack_trees()' have a separate source and
   destination index, 2008-03-06)
5. 6863df35503 (unpack-trees: ensure full index, 2021-03-30)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c   | 5 +++--
 sparse-index.c | 4 +++-
 unpack-trees.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index cf87ad70970..9fbff4bc6aa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2646,8 +2646,7 @@ int repo_index_has_changes(struct repository *repo,
 		}
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
-	} else {
-		/* TODO: audit for interaction with sparse-index. */
+	} else if (istate) {
 		ensure_full_index(istate);
 		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
@@ -2655,6 +2654,8 @@ int repo_index_has_changes(struct repository *repo,
 			strbuf_addstr(sb, istate->cache[i]->name);
 		}
 		return !!istate->cache_nr;
+	} else {
+		return 0;
 	}
 }
 
diff --git a/sparse-index.c b/sparse-index.c
index 65a08d33c73..86e3b99870b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -299,7 +299,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	 * If the index is already full, then keep it full. We will convert
 	 * it to a sparse index on write, if possible.
 	 */
-	if (!istate || istate->sparse_index == INDEX_EXPANDED)
+	if (istate->sparse_index == INDEX_EXPANDED)
 		return;
 
 	/*
@@ -424,6 +424,8 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 
 void ensure_full_index(struct index_state *istate)
 {
+	if (!istate)
+		BUG("ensure_full_index() must get an index!");
 	expand_index(istate, NULL);
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index ea09023b015..2381cd7cac4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1880,7 +1880,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	prepare_repo_settings(repo);
 	if (repo->settings.command_requires_full_index) {
 		ensure_full_index(o->src_index);
-		ensure_full_index(o->dst_index);
+		if (o->dst_index)
+			ensure_full_index(o->dst_index);
 	}
 
 	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED &&
-- 
2.39.0.1195.gabc92c078c4

