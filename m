Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6B91F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeENV73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:29 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:50311 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeENV5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:10 -0400
Received: by mail-qk0-f202.google.com with SMTP id p190-v6so16666988qkc.17
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6GWzaTaOZ5kNvacwXquPLBjPr9DrI38CehrTMDI9vzg=;
        b=KIVVnVayfeqF2/YiNgefv10483YgD3xvycCiI20jpGyAWriYppy/6alZaY/vXTf1LP
         Bk8pq64y0/61nCBssRqA7/f+fySMkHNWQnWQSKVqlMCSAp5Q39d3VNUol1uWu5/yjJmF
         FWW4/0z3HsWzzmSck7YygdP3AK/EvIlOeCg83Bv6QdmEyO1zvvrKW7hYt5yutbyVtm+r
         C4ZztvNYHSJgflKbspEOFJbIS7iuLooPUud00+l4VpTSTekuzFwYewIEFhdWgMZRWvT2
         l34XMXo07+rdBVZ6547mlolJXOSoK2vun4iFXjubTGuVkWp3sMfoIzA+d5ov+QnRaPj0
         zApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6GWzaTaOZ5kNvacwXquPLBjPr9DrI38CehrTMDI9vzg=;
        b=oAWUnBYFwbebNVfV96IhoWrpcIj2TxhQu+pBqJfWq1U0sHH+HKlLlK60UzuTWhwyIe
         X5/ZlPJkvB6XMUFzOVQX65DANhGGDq9z5lWGfocRlqCPGVMstBthPD4PJ8070ozKBFpb
         qEhxqWCIhQvYBdn0hPKvKUJyzt4a+oihz3IuHFzGBvTVDgFRZKirnnf/OR90ieo1NgeR
         OvZixvjRG03qEg6CaB920H+CoxwhIIoEeM+o+PTtP7qbmzY8MFwLhP/Nntq/jNozcj96
         Con4tL2zOPlwK6LZD5642KpugAgJ7S48GqB5T/S1KRyYQsGxsmQiVCCkqmAx3chvIMOK
         br9w==
X-Gm-Message-State: ALKqPwflZxeSP4ON5IVK4NOdjVfbteFpHtgUKoSEMOqdxPRKjhu7aPJh
        4Ms75nM67lbxvaWueO+snE0exrFQYdaN2FSGFe0axi370beUJgatK+t9xn1nhpGYFQzrPh7OVcY
        NKRAAWbiZJWFG78jdbCIx6kOvweIxX4oOudojDplLV+eZntscLa+h0N30vg==
X-Google-Smtp-Source: AB8JxZrXAQNzHM/5af2sQfGMR09WWQ5uW9xZMcq3CW38nDdwTeOvPCI/MMcv5SOFlvw89j7xdeuvi2pkwX8=
MIME-Version: 1.0
X-Received: by 2002:a0c:d2ee:: with SMTP id x43-v6mr17855098qvh.45.1526335029681;
 Mon, 14 May 2018 14:57:09 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:04 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-14-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 13/35] remote: convert push refspecs to struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the set of push refspecs stored in 'struct remote' to use
'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c   | 10 +++++-----
 builtin/remote.c | 14 +++++++-------
 remote.c         | 23 +++++++++--------------
 remote.h         |  6 ++----
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 00d81fb1d..509dc6677 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -79,11 +79,11 @@ static const char *map_refspec(const char *ref,
 	if (count_refspec_match(ref, local_refs, &matched) != 1)
 		return ref;
 
-	if (remote->push) {
+	if (remote->push.nr) {
 		struct refspec_item query;
 		memset(&query, 0, sizeof(struct refspec_item));
 		query.src = matched->name;
-		if (!query_refspecs(remote->push, remote->push_refspec_nr, &query) &&
+		if (!query_refspecs(remote->push.items, remote->push.nr, &query) &&
 		    query.dst) {
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addf(&buf, "%s%s:%s",
@@ -436,9 +436,9 @@ static int do_push(const char *repo, int flags,
 	}
 
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push_refspec_nr) {
-			refspec = remote->push_refspec;
-			refspec_nr = remote->push_refspec_nr;
+		if (remote->push.raw_nr) {
+			refspec = remote->push.raw;
+			refspec_nr = remote->push.raw_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
 			setup_default_push_refspecs(remote);
 	}
diff --git a/builtin/remote.c b/builtin/remote.c
index d9da82dc8..fb84729d6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -388,8 +388,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	local_refs = get_local_heads();
 	push_map = copy_ref_list(remote_refs);
 
-	match_push_refs(local_refs, &push_map, remote->push_refspec_nr,
-			remote->push_refspec, MATCH_REFS_NONE);
+	match_push_refs(local_refs, &push_map, remote->push.raw_nr,
+			remote->push.raw, MATCH_REFS_NONE);
 
 	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
@@ -435,14 +435,14 @@ static int get_push_ref_states_noquery(struct ref_states *states)
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
-		struct refspec_item *spec = remote->push + i;
+	for (i = 0; i < remote->push.nr; i++) {
+		const struct refspec_item *spec = &remote->push.items[i];
 		if (spec->matching)
 			item = string_list_append(&states->push, _("(matching)"));
 		else if (strlen(spec->src))
@@ -586,8 +586,8 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
+	for (i = 0; i < remote->push.raw_nr; i++)
+		git_config_set_multivar(buf.buf, remote->push.raw[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
diff --git a/remote.c b/remote.c
index bce6e7ce4..090110c37 100644
--- a/remote.c
+++ b/remote.c
@@ -79,10 +79,7 @@ static const char *alias_url(const char *url, struct rewrites *r)
 
 static void add_push_refspec(struct remote *remote, const char *ref)
 {
-	ALLOC_GROW(remote->push_refspec,
-		   remote->push_refspec_nr + 1,
-		   remote->push_refspec_alloc);
-	remote->push_refspec[remote->push_refspec_nr++] = ref;
+	refspec_append(&remote->push, ref);
 }
 
 static void add_fetch_refspec(struct remote *remote, const char *ref)
@@ -175,9 +172,11 @@ static struct remote *make_remote(const char *name, int len)
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->name = xstrndup(name, len);
+	refspec_init(&ret->push, REFSPEC_PUSH);
+
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
-	ret->name = xstrndup(name, len);
 
 	hashmap_entry_init(ret, lookup_entry.hash);
 	replaced = hashmap_put(&remotes_hash, ret);
@@ -542,9 +541,9 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 				pushremote_for_branch(branch, NULL);
 			struct remote *remote = remote_get(remote_name);
 
-			if (remote && remote->push_refspec_nr &&
-			    (dst = apply_refspecs(remote->push,
-						  remote->push_refspec_nr,
+			if (remote && remote->push.nr &&
+			    (dst = apply_refspecs(remote->push.items,
+						  remote->push.nr,
 						  branch->refname))) {
 				if (explicit)
 					*explicit = 1;
@@ -582,7 +581,6 @@ static struct remote *remote_get_1(const char *name,
 	if (!valid_remote(ret))
 		return NULL;
 	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
-	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
 
@@ -616,9 +614,6 @@ int for_each_remote(each_remote_fn fn, void *priv)
 		if (!r->fetch)
 			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
 						       r->fetch_refspec);
-		if (!r->push)
-			r->push = parse_push_refspec(r->push_refspec_nr,
-						     r->push_refspec);
 		result = fn(r, priv);
 	}
 	return result;
@@ -1613,11 +1608,11 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 				 _("branch '%s' has no remote for pushing"),
 				 branch->name);
 
-	if (remote->push_refspec_nr) {
+	if (remote->push.nr) {
 		char *dst;
 		const char *ret;
 
-		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
+		dst = apply_refspecs(remote->push.items, remote->push.nr,
 				     branch->refname);
 		if (!dst)
 			return error_buf(err,
diff --git a/remote.h b/remote.h
index 3657bd43d..637fc5d0c 100644
--- a/remote.h
+++ b/remote.h
@@ -3,6 +3,7 @@
 
 #include "parse-options.h"
 #include "hashmap.h"
+#include "refspec.h"
 
 enum {
 	REMOTE_UNCONFIGURED = 0,
@@ -27,10 +28,7 @@ struct remote {
 	int pushurl_nr;
 	int pushurl_alloc;
 
-	const char **push_refspec;
-	struct refspec_item *push;
-	int push_refspec_nr;
-	int push_refspec_alloc;
+	struct refspec push;
 
 	const char **fetch_refspec;
 	struct refspec_item *fetch;
-- 
2.17.0.441.gb46fe60e1d-goog

