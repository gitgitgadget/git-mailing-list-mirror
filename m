Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A3A1F62D
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeFFRDm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40370 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeFFRDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so10219896lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVm4mIx3HZDZA2SCbJWyiVuWBq49LGkgivi6yAmkZTg=;
        b=f5J4qpa/hiWwqirye/sGeez5hEFcIv3OHQ2QazCu9gZ6FVkDBzbbAKK/qfUtIRS83H
         PWWdHMBNqhlnAAJEUsX/lXAC6XcbRdPnFAsaIGT4HEtqQDNutNyGjL45Fq4L/Andc5Yi
         ZfrSzHD51q9IshJjgx215uck94/+zYcs6419JHEpaCuPDg9BX3SaSd7vC5n+uBgEN9nm
         YTmMkE+sL0+BTLAgZnkH4x3IvsfG99oCg7ZHhFc6x3wc54WzEXFvJDaWAyVHtMN/lT3h
         3lnbLk+ps8MVEUNJBadev9Q2904kBigI8NJfnS+Oew8eM4K5pVq32v/UmKtYzUFlGcB7
         qEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVm4mIx3HZDZA2SCbJWyiVuWBq49LGkgivi6yAmkZTg=;
        b=TE8C2kDlF0qvrMTjVf7+eGCUK44JDGoc/OrliaK+/T19sH1l/PmXSgAmkgaqbiJBjh
         S0tcN70r9tl/yOr+8RfnnPNkH/WrZ8hGrNPmasP6FvDb4sHbkMHXd2apm7ponBB06NPb
         INEM2qPtqXq3uCLaekPOAwVvFF0VncN+jv7VsrCgUL6Dflm4LiCfUG48MrurD/NQ05IZ
         KKQGs7U0uSnvxODmudwBr+8i+9+KQ0znVyeovkCwrNKvzLfJuOkQom+XAPL+3qYqih2Y
         5jOrxGB4t9QpDaAI6ySLoG3QOG9n9Khg5H54+fhGs2qUasJtILkt8E4JOhfYMxCzygHm
         XZwQ==
X-Gm-Message-State: APt69E0YpOqyPSvD4x5zdBhVTlM3ZQw0WJyPBxE2dF+QqEtqZOm83W5e
        gwcniMlJB1d21FjlFH8ZkHY=
X-Google-Smtp-Source: ADUXVKK/+CMlndTY40IybtolVCONC/Fp17x7iQmlIKpotJx/W8ekWZd7dT/YF62JRZEuVmEGa1L1Mg==
X-Received: by 2002:a19:a413:: with SMTP id q19-v6mr2299247lfc.143.1528304591277;
        Wed, 06 Jun 2018 10:03:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 17/23] read-cache.c: remove an implicit dependency on the_index
Date:   Wed,  6 Jun 2018 19:02:37 +0200
Message-Id: <20180606170243.4169-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
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
 apply.c            |  4 ++--
 builtin/checkout.c |  4 ++--
 builtin/difftool.c |  4 ++--
 builtin/reset.c    |  4 ++--
 cache.h            |  5 +++--
 merge-recursive.c  |  2 +-
 read-cache.c       | 19 +++++++++++--------
 resolve-undo.c     |  2 +-
 8 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/apply.c b/apply.c
index 9720855590..fc42a0eadf 100644
--- a/apply.c
+++ b/apply.c
@@ -4090,9 +4090,9 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
 
-		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
+		ce = make_index_entry(&the_index, patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
-			return error(_("make_cache_entry failed for path '%s'"),
+			return error(_("make_index_entry failed for path '%s'"),
 				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
 			free(ce);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f8c208cea1..d2257e0d82 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -230,9 +230,9 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_cache_entry(mode, oid.hash, path, 2, 0);
+	ce = make_index_entry(&the_index, mode, oid.hash, path, 2, 0);
 	if (!ce)
-		die(_("make_cache_entry failed for path '%s'"), path);
+		die(_("make_index_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
 	free(ce);
 	return status;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc97d4aef2..fb2ccfe6f0 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,7 +321,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(mode, oid->hash, path, 0, 0);
+	ce = make_index_entry(&the_index, mode, oid->hash, path, 0, 0);
 	ret = checkout_entry(ce, state, NULL);
 
 	free(ce);
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =
-					make_cache_entry(rmode, roid.hash,
+					make_index_entry(&the_index, rmode, roid.hash,
 							 dst_path, 0, 0);
 
 				add_index_entry(&wtindex, ce2,
diff --git a/builtin/reset.c b/builtin/reset.c
index a862c70fab..067f535031 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -134,10 +134,10 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			continue;
 		}
 
-		ce = make_cache_entry(one->mode, one->oid.hash, one->path,
+		ce = make_index_entry(&the_index, one->mode, one->oid.hash, one->path,
 				      0, 0);
 		if (!ce)
-			die(_("make_cache_entry failed for path '%s'"),
+			die(_("make_index_entry failed for path '%s'"),
 			    one->path);
 		if (is_missing) {
 			ce->ce_flags |= CE_INTENT_TO_ADD;
diff --git a/cache.h b/cache.h
index 89a107a7f7..64abd3e55c 100644
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
+extern struct cache_entry *make_index_entry(struct index_state *istate, unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
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
index b404ebac7c..4f054d6dbb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage, 0);
+	ce = make_index_entry(&the_index, mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
diff --git a/read-cache.c b/read-cache.c
index 12cc22d157..4352aac521 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -745,9 +745,11 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 	return add_to_index(istate, path, &st, flags);
 }
 
-struct cache_entry *make_cache_entry(unsigned int mode,
-		const unsigned char *sha1, const char *path, int stage,
-		unsigned int refresh_options)
+struct cache_entry *make_index_entry(struct index_state *istate,
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
index 5e4c8c5f75..383231b011 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -146,7 +146,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
-		nce = make_cache_entry(ru->mode[i], ru->oid[i].hash,
+		nce = make_index_entry(&the_index, ru->mode[i], ru->oid[i].hash,
 				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
-- 
2.18.0.rc0.333.g22e6ee6cdf

