Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB381F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFFHkM (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39158 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeFFHkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so7556433lff.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGR2Q0q+Ibt7+0CWKaT5/6L1oPTCIz406OWOUY2o1go=;
        b=nRmPhPnsD18gdwwO4JOVtoCBuewTc1O44f8q8WrByTORrB87VvP3u39OULxv7svDIX
         3HdWH8ffrHsa875u07PmGKkruyNpumLBKwFo2P+m2sVAFzpew4+q7rOtClrQkNFWy7im
         xeG2xZetnBzq9RBbZ63V5s8Bjny9YMuzcnj9oNxRGca9pfgmcbyjlZ6tezsvno4oBWkV
         I3f6DKu2pt0qkfezhJXsleaOmaoubiAqcvpHBb5G722GJUAou/IpA/46LIOCWiymj2R3
         ibsUvr/E4urPqqr4q4SWLUT1jVJRfhP8Vo9g04wIzncXLjbFjluJgAUrch45QK7OhyNX
         zhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGR2Q0q+Ibt7+0CWKaT5/6L1oPTCIz406OWOUY2o1go=;
        b=ks399Uu3Lie1YgKVci5a4+5dMOpzA8vBvnZoavIAjLUZqXcxHmbwYE0wrcRJ5D08Dt
         b7rulXF77KtQkV6I9Ao9HdbTZ9xUI5KuP31fkh0Zb+RMa2o0m8vmmQRhK/TBT8+Q85s1
         9w7poAnAwG8xjL6kviDp8NmRh9+XKwNY9Q/iaWjz1OwzTCPgXmpqJ8Szwc5q+jWaAwTV
         PQTz/l86KGcEGEVAacTJdSuL4coHyUJu78iTElxy1dF7iAacdTaFhU5DP3Jq0fhj7IIO
         L0CtTRFfX1ELAPYoGJ4+2tMMB7nWxwpp6RXFRCrwOtQtZKvSsLWsj1hUR/8ATDN9AjnQ
         uhfw==
X-Gm-Message-State: APt69E2Fvf5AM5yWPiM/9por7v4PWU2aeSPE5NB1Vd+togQzIWiNkGOY
        aFvUZ2ZWKxEFPJf5ZHEEo2E=
X-Google-Smtp-Source: ADUXVKJgBcS3aLYpEo8dp0Ai5s5pT4/5SspzDT8xV99n57bGwECU6rpuopWuG/HumE5CMeKIBk0SMA==
X-Received: by 2002:a19:f86:: with SMTP id 6-v6mr1078517lfp.15.1528270804021;
        Wed, 06 Jun 2018 00:40:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 17/20] cache.c: remove an implicit dependency on the_index
Date:   Wed,  6 Jun 2018 09:39:30 +0200
Message-Id: <20180606073933.14755-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make some index API take an index_state instead of assuming the_index
in read-cache.c. All external call sites are converted blindly to keep
the patch simple and retain current behavior.  Individual call sites
may receive further updates to use the right index instead of the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c            |  2 +-
 builtin/checkout.c |  2 +-
 builtin/difftool.c |  4 ++--
 builtin/reset.c    |  2 +-
 cache.h            |  5 +++--
 merge-recursive.c  |  2 +-
 read-cache.c       | 19 +++++++++++--------
 resolve-undo.c     |  2 +-
 8 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/apply.c b/apply.c
index 9720855590..811ff2ad5e 100644
--- a/apply.c
+++ b/apply.c
@@ -4090,7 +4090,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
 
-		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
+		ce = make_cache_entry(&the_index, patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
 			return error(_("make_cache_entry failed for path '%s'"),
 				     name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f8c208cea1..3c8218304e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -230,7 +230,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_cache_entry(mode, oid.hash, path, 2, 0);
+	ce = make_cache_entry(&the_index, mode, oid.hash, path, 2, 0);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc97d4aef2..e34e75a42d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,7 +321,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(mode, oid->hash, path, 0, 0);
+	ce = make_cache_entry(&the_index, mode, oid->hash, path, 0, 0);
 	ret = checkout_entry(ce, state, NULL);
 
 	free(ce);
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =
-					make_cache_entry(rmode, roid.hash,
+					make_cache_entry(&the_index, rmode, roid.hash,
 							 dst_path, 0, 0);
 
 				add_index_entry(&wtindex, ce2,
diff --git a/builtin/reset.c b/builtin/reset.c
index a862c70fab..0ea0a19d5e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -134,7 +134,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			continue;
 		}
 
-		ce = make_cache_entry(one->mode, one->oid.hash, one->path,
+		ce = make_cache_entry(&the_index, one->mode, one->oid.hash, one->path,
 				      0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
diff --git a/cache.h b/cache.h
index 89a107a7f7..5939233eb7 100644
--- a/cache.h
+++ b/cache.h
@@ -355,6 +355,7 @@ extern void free_name_hash(struct index_state *istate);
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
+#define refresh_cache_entry(ce, flags) refresh_index_entry(&the_index, ce, flags)
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
@@ -698,7 +699,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 
-extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
+extern struct cache_entry *make_cache_entry(struct index_state *istate,unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
@@ -751,7 +752,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
-extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsigned int);
+extern struct cache_entry *refresh_index_entry(struct index_state *istate, struct cache_entry *, unsigned int);
 
 /*
  * Opportunistically update the index but do not complain if we can't.
diff --git a/merge-recursive.c b/merge-recursive.c
index b404ebac7c..9280deb6a1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage, 0);
+	ce = make_cache_entry(&the_index, mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
diff --git a/read-cache.c b/read-cache.c
index 12cc22d157..c083318aa7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -745,9 +745,11 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 	return add_to_index(istate, path, &st, flags);
 }
 
-struct cache_entry *make_cache_entry(unsigned int mode,
-		const unsigned char *sha1, const char *path, int stage,
-		unsigned int refresh_options)
+struct cache_entry *make_cache_entry(struct index_state *istate,
+				     unsigned int mode,
+				     const unsigned char *sha1,
+				     const char *path, int stage,
+				     unsigned int refresh_options)
 {
 	int size, len;
 	struct cache_entry *ce, *ret;
@@ -767,7 +769,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	ret = refresh_cache_entry(ce, refresh_options);
+	ret = refresh_index_entry(istate, ce, refresh_options);
 	if (ret != ce)
 		free(ce);
 	return ret;
@@ -1415,7 +1417,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
@@ -1473,10 +1475,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
-					       unsigned int options)
+struct cache_entry *refresh_index_entry(struct index_state *istate,
+					struct cache_entry *ce,
+					unsigned int options)
 {
-	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
+	return refresh_cache_ent(istate, ce, options, NULL, NULL);
 }
 
 
diff --git a/resolve-undo.c b/resolve-undo.c
index 5e4c8c5f75..9c45fe5d1d 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -146,7 +146,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_cache_entry(ru->mode[i], ru->oid[i].hash,
+		nce = make_cache_entry(&the_index, ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
-- 
2.18.0.rc0.333.g22e6ee6cdf

