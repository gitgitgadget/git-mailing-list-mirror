Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4487B1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdFPT3F (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:29:05 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35093 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdFPT3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:29:01 -0400
Received: by mail-wr0-f173.google.com with SMTP id y25so4094783wrd.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSTElRQDVReoMlr1v/Aqa1t7wQrXH3AdgIFIB9eYY6Y=;
        b=cQKx+Kq1vYlhnlnChB+D1hWvUO9olqx2Dek7Opg8qld9gUjolBQb3qRJGUtRp5yhlz
         CANMctvztK7aCCayoC0z3KrTbU24uCbNv/Noe8Fb/NqdvckcNLHMriKiOYM/opv0CoCl
         ez+LlMahlA4pTtJHeXDMFwK2t9xU6evhtRcYefBwECNbYDr10Ekmk4rU1XWPGhOD4XXH
         3VRzgkgtpHPbxOc3RmHS8fTm83rY595hQcCDkxjEAecUxG08rrTqTKkq+6YYfeZV9Jug
         XuWt4FIuujWb08PDWhs288ZWADxlqLoANze5wl4Vg5CW/1wohBm75WFR/OAICbYXf/gd
         lsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSTElRQDVReoMlr1v/Aqa1t7wQrXH3AdgIFIB9eYY6Y=;
        b=UI09vIRFy8WaoJwCXqq0lWgtwiz9JBrQohVjiay8PmNN7XBO2n0msikfBFWTOUzzZl
         wAWYUiBA3DWY9vaeSekomtfwxh38QkkWcKZ1fFmJIre4CugC4SXlKaY/LeJORS7X3qIl
         Q5U7FGhrON/iFB7I4ZOMZgpLZolFwWnnv2gpL+8CpgC64h0Em6cD+zio8bPteOe9Ux93
         pg0lcSOK1ME9UsLLUDFe73t5OS6h3RhcGyHjo8H1+Eb3sOJEzbb2ri+qrEDlbBIywg5I
         3NMV++BLNgU41SCkTkQk2mCOVSPm2VG68UQmCOp0IBoxYRrJAB+M/OHKLpWZqRdCrb+2
         UaLA==
X-Gm-Message-State: AKS2vOwSyQKNebvqwwIQMCdRjXrnYvwu9yGJQquMEdE4l8J+rYEruJTp
        7P2qpGrAAJaonmgY
X-Received: by 10.223.136.131 with SMTP id f3mr9457640wrf.151.1497641335014;
        Fri, 16 Jun 2017 12:28:55 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] remote.c: eliminate remote->push_refspec
Date:   Fri, 16 Jun 2017 21:28:37 +0200
Message-Id: <20170616192837.11035-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.501.g45ae33cbf
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do the same as in the previous patch, but for push refspecs, i.e. with
remote->push_refspec, remote->push and add_push_refspec().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/push.c   | 12 +++++++-----
 builtin/remote.c | 19 ++++++++++++-------
 remote.c         | 29 +++++++++++------------------
 remote.h         | 10 ++++------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 258648d5f..9a721fe8a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -47,11 +47,11 @@ static const char *map_refspec(const char *ref,
 	if (count_refspec_match(ref, local_refs, &matched) != 1)
 		return ref;
 
-	if (remote->push) {
+	if (remote->push.rs) {
 		struct refspec query;
 		memset(&query, 0, sizeof(struct refspec));
 		query.src = matched->name;
-		if (!query_refspecs(remote->push, remote->push_refspec_nr, &query) &&
+		if (!query_refspecs(remote->push.rs, remote->push.nr, &query) &&
 		    query.dst) {
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addf(&buf, "%s%s:%s",
@@ -401,9 +401,11 @@ static int do_push(const char *repo, int flags,
 	}
 
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push_refspec_nr) {
-			refspec = remote->push_refspec;
-			refspec_nr = remote->push_refspec_nr;
+		if (remote->push.nr) {
+			ALLOC_ARRAY(refspec, remote->push.nr);
+			for (i = 0; i < remote->push.nr; i++)
+				refspec[i] = refspec_to_string(&remote->push.rs[i]);
+			refspec_nr = remote->push.nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
 			setup_default_push_refspecs(remote);
 	}
diff --git a/builtin/remote.c b/builtin/remote.c
index d61daa5e8..c04dec0e1 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -380,14 +380,19 @@ static int get_push_ref_states(const struct ref *remote_refs,
 {
 	struct remote *remote = states->remote;
 	struct ref *ref, *local_refs, *push_map;
+	const char **refspec;
+	int i;
 	if (remote->mirror)
 		return 0;
 
 	local_refs = get_local_heads();
 	push_map = copy_ref_list(remote_refs);
 
-	match_push_refs(local_refs, &push_map, remote->push_refspec_nr,
-			remote->push_refspec, MATCH_REFS_NONE);
+	ALLOC_ARRAY(refspec, remote->push.nr);
+	for (i = 0; i < remote->push.nr; i++)
+		refspec[i] = refspec_to_string(&remote->push.rs[i]);
+	match_push_refs(local_refs, &push_map, remote->push.nr,
+			refspec, MATCH_REFS_NONE);
 
 	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
@@ -433,14 +438,14 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 		return 0;
 
 	states->push.strdup_strings = 1;
-	if (!remote->push_refspec_nr) {
+	if (!remote->push.nr) {
 		item = string_list_append(&states->push, _("(matching)"));
 		info = item->util = xcalloc(1, sizeof(struct push_info));
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
 	}
-	for (i = 0; i < remote->push_refspec_nr; i++) {
-		struct refspec *spec = remote->push + i;
+	for (i = 0; i < remote->push.nr; i++) {
+		struct refspec *spec = remote->push.rs + i;
 		if (spec->matching)
 			item = string_list_append(&states->push, _("(matching)"));
 		else if (strlen(spec->src))
@@ -584,8 +589,8 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push_refspec_nr; i++) {
-		strbuf_add_refspec(&refspec, &remote->push[i]);
+	for (i = 0; i < remote->push.nr; i++) {
+		strbuf_add_refspec(&refspec, &remote->push.rs[i]);
 		git_config_set_multivar(buf.buf, refspec.buf, "^$", 0);
 		strbuf_reset(&refspec);
 	}
diff --git a/remote.c b/remote.c
index 952000b61..9dfe3e9a6 100644
--- a/remote.c
+++ b/remote.c
@@ -86,14 +86,6 @@ static const char *alias_url(const char *url, struct rewrites *r)
 	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
 
-static void add_push_refspec(struct remote *remote, const char *ref)
-{
-	ALLOC_GROW(remote->push_refspec,
-		   remote->push_refspec_nr + 1,
-		   remote->push_refspec_alloc);
-	remote->push_refspec[remote->push_refspec_nr++] = strdup(ref);
-}
-
 static void add_url(struct remote *remote, const char *url)
 {
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
@@ -257,7 +249,7 @@ static void read_remotes_file(struct remote *remote)
 		if (skip_prefix(buf.buf, "URL:", &v))
 			add_url_alias(remote, xstrdup(skip_spaces(v)));
 		else if (skip_prefix(buf.buf, "Push:", &v))
-			add_push_refspec(remote, skip_spaces(v));
+			add_push_refspec(remote, skip_spaces(v), 1);
 		else if (skip_prefix(buf.buf, "Pull:", &v))
 			add_fetch_refspec(remote, skip_spaces(v), 1);
 	}
@@ -308,7 +300,7 @@ static void read_branches_file(struct remote *remote)
 	 * (master if missing)
 	 */
 	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
-	add_push_refspec(remote, buf.buf);
+	add_push_refspec(remote, buf.buf, 1);
 	remote->fetch_tags = 1; /* always auto-follow */
 
 	strbuf_release(&buf);
@@ -394,7 +386,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
-		add_push_refspec(remote, v);
+		add_push_refspec(remote, v, 1);
 		free((char*)v);
 	} else if (!strcmp(subkey, "fetch")) {
 		const char *v;
@@ -625,7 +617,7 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 static int add_refspec(struct remote *remote, const char *refspec,
 		       int fetch, int gently)
 {
-	struct refspec_array *rsa = fetch ? &remote->fetch : NULL;
+	struct refspec_array *rsa = fetch ? &remote->fetch : &remote->push;
 
 	ALLOC_GROW(rsa->rs, rsa->nr + 1, rsa->alloc);
 
@@ -651,6 +643,11 @@ struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
+int add_push_refspec(struct remote *remote, const char *refspec, int gently)
+{
+	return add_refspec(remote, refspec, 0, gently);
+}
+
 void free_refspec(int nr_refspec, struct refspec *refspec)
 {
 	int i;
@@ -730,7 +727,6 @@ static struct remote *remote_get_1(const char *name,
 		return NULL;
 	if (ret->bogus_refspec)
 		die("Invalid refspec '%s'", ret->bogus_refspec);
-	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
 
@@ -763,9 +759,6 @@ int for_each_remote(each_remote_fn fn, void *priv)
 			continue;
 		if (r->bogus_refspec)
 			die("Invalid refspec '%s'", r->bogus_refspec);
-		if (!r->push)
-			r->push = parse_push_refspec(r->push_refspec_nr,
-						     r->push_refspec);
 		result = fn(r, priv);
 	}
 	return result;
@@ -1777,11 +1770,11 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 				 _("branch '%s' has no remote for pushing"),
 				 branch->name);
 
-	if (remote->push_refspec_nr) {
+	if (remote->push.nr) {
 		char *dst;
 		const char *ret;
 
-		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
+		dst = apply_refspecs(remote->push.rs, remote->push.nr,
 				     branch->refname);
 		if (!dst)
 			return error_buf(err,
diff --git a/remote.h b/remote.h
index 416a08501..eba06bacb 100644
--- a/remote.h
+++ b/remote.h
@@ -32,14 +32,10 @@ struct remote {
 	int pushurl_nr;
 	int pushurl_alloc;
 
-	const char **push_refspec;
-	struct refspec *push;
-	int push_refspec_nr;
-	int push_refspec_alloc;
-
+	struct refspec_array push;
 	struct refspec_array fetch;
 
-	/* Copy of the first bogus fetch refspec we couldn't parse */
+	/* Copy of the first bogus refspec we couldn't parse */
 	const char *bogus_refspec;
 
 	/*
@@ -184,6 +180,8 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
  */
 int add_fetch_refspec(struct remote *remote, const char *refspec, int gently);
 extern struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
+/* The same as add_fetch_refspec() above, but for push refspecs. */
+int add_push_refspec(struct remote *remote, const char *refspec, int gently);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
-- 
2.13.1.505.g7cc9fcafb

