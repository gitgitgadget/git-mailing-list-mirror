Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB741F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 16:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeFAQME (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 12:12:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33504 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFAQMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 12:12:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so15608080lfy.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLq1OMth/4T3yI9ogRS3cO1pLKBoT2RDEh9M0JCP/J4=;
        b=OrsCUfdCavYhM24ndaJBXopbU1SQSiC/L7ruNvDlaisfi8zcQSxuwF3TwaNhGae9Ou
         c0GxtD20JboBnjWvd6ajbo3+m8ts4ZlvNs2/U6dY7nsnkh8NyCwVTo80c+Qp8lBC6sQq
         kw2+3Is6vTGB5u29o+McHrWFSryI5wUu9AivwKgqRHpbq5GzgQkGPhJqBpAMoWKrOLGv
         NMPSwcw88GuhPSwLtrWlTwQvLspcAEe2sk6AJ6P95md8pgRifSporDExblKclosaYnMb
         vT2NrCicgcsbAmeV0wtDPEVoLtMwgRjWGWS8C1EsIttScivv9xZyQ5/anTB7DsEBjZrA
         QmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLq1OMth/4T3yI9ogRS3cO1pLKBoT2RDEh9M0JCP/J4=;
        b=XDIMqIGPUMQ6K9qwj8YpjUkbnTuMDqm5fRQR1pOuJjSP+8tr36jPLAB/7Fhg0ZZXuu
         xBw7FekFMa+NliutcOaypuKIJkMHiVXe8626V4mZmWU2CpFfrZWTgJ7kfCJ5h52SCpIl
         edJyfp/BaTxeWfyj67oN+psitwmhMaySe+RbhlCyowJijjhHXBuPgT9YsUg3y9hLIvgI
         sHUmDH/iTtxeioQrLRB9z5cx4yhCXAkZztV83zaJZBJgkrZElTTqGJsntcPZ2qI6TFKj
         wT/8e04+boib8p+QDJmQVla2Qe7f0kgzEi9hHb5hBwVrKbe89PMq2ba+pwfim+SkhuL9
         CZqg==
X-Gm-Message-State: ALKqPwdDq+IBveSBoPy+oQumW909/YVia29m+TNZTClM48FufQpe3Y06
        0SU6gEETtw4IYAN4zx1WtDYqCA==
X-Google-Smtp-Source: ADUXVKI/iRCx2RBVWI84yIQvmVk+Q3bDajq+UZIcQQp2x6oMnj+IJjsAW98RW2+YycFVnrVRRdcIpg==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr6947647lff.5.1527869521271;
        Fri, 01 Jun 2018 09:12:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p28-v6sm567566lfh.24.2018.06.01.09.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 09:11:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
Date:   Fri,  1 Jun 2018 18:11:53 +0200
Message-Id: <20180601161153.15192-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unpack-trees code works on multiple indexes specified in
unpack_trees_options. Although they normally all refer to the_index at
the call site, that is the caller's business. unpack-trees.c should
not make any assumption about that and should use the correct index
field in unpack_trees_options.

This patch is actually confusing because sometimes the function
parameter is also named "the_index" while some other times "the_index"
is the global variable because the function just does not have a
parameter of the same name! The only subtle difference is that the
function parameter is a pointer while the global one is not.

This is more of a bug report than an actual fix because I'm not sure
if "o->src_index" is always the correct answer instead of "the_index"
here. But this is very similar to 7db118303a (unpack_trees: fix
breakage when o->src_index != o->dst_index - 2018-04-23) and could
potentially break things again...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..114496cfc2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,9 @@
 #include "fsmonitor.h"
 #include "fetch-object.h"
 
+/* Do not use the_index here, you probably want o->src_index */
+#define the_index the_index_should_not_be_used here
+
 /*
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messages
@@ -1085,13 +1088,15 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	return mask;
 }
 
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval);
 
 /* Whole directory matching */
-static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
+static int clear_ce_flags_dir(struct index_state *istate,
+			      struct cache_entry **cache, int nr,
 			      struct strbuf *prefix,
 			      char *basename,
 			      int select_mask, int clear_mask,
@@ -1100,7 +1105,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el, &the_index);
+					basename, &dtype, el, istate);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1122,7 +1127,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * calling clear_ce_flags_1(). That function will call
 	 * the expensive is_excluded_from_list() on every entry.
 	 */
-	rc = clear_ce_flags_1(cache, cache_end - cache,
+	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 			      prefix,
 			      select_mask, clear_mask,
 			      el, ret);
@@ -1145,7 +1150,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
  *   cache[0]->name[0..(prefix_len-1)]
  * Top level path has prefix_len zero.
  */
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval)
@@ -1179,7 +1185,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			len = slash - name;
 			strbuf_add(prefix, name, len);
 
-			processed = clear_ce_flags_dir(cache, cache_end - cache,
+			processed = clear_ce_flags_dir(istate, cache, cache_end - cache,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
@@ -1193,7 +1199,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(cache, cache_end - cache,
+			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
 						  prefix,
 						  select_mask, clear_mask, el, defval);
 			strbuf_setlen(prefix, prefix->len - len - 1);
@@ -1203,7 +1209,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el, &the_index);
+					    name, &dtype, el, istate);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1213,15 +1219,17 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 	return nr - (cache_end - cache);
 }
 
-static int clear_ce_flags(struct cache_entry **cache, int nr,
-			    int select_mask, int clear_mask,
-			    struct exclude_list *el)
+static int clear_ce_flags(struct index_state *istate,
+			  int select_mask, int clear_mask,
+			  struct exclude_list *el)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(cache, nr,
+	return clear_ce_flags_1(istate,
+				istate->cache,
+				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				el, 0);
@@ -1231,7 +1239,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1240,8 +1248,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1256,8 +1264,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
-		       select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
@@ -1636,7 +1643,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -1678,7 +1685,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, &the_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.18.0.rc0.309.g77c7720784

