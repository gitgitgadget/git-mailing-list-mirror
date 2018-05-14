Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639C11F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeENV5P (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:15 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:32809 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeENV5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:12 -0400
Received: by mail-yw0-f202.google.com with SMTP id z195-v6so5831335ywa.0
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Gflpdrhc4t5qTdXZX0CB4LASuBJpEWKNoIGYBs7+Mh8=;
        b=vZkJ/ozJicOOwkxwvwBu4uPo1yEajQIjYQBClVFgBoLPWKCCQldI0p6zH18DvxYZKl
         m1pvk+WeOCt27/UqvhnfifKE/AoH9U1puf+9VqoDr/jVD3TMD1l5J8Whn5wriFhdOsmo
         vZqqIOWqq3HR7ihaObv/vtecxdtupeLAt3uw/0m/+wfIRUdsWPsywyrDetKjt8viMpPq
         5AaRcBAiXh+ve2jVRjZ6Ef5m3MjzT5Qi7ghaMfcR3bZXgDwMJ/78sn3As3Sp2mxRMEvp
         xSWijhsZZo9TBpVAm3JAC5wHbHh2H9ihSC91TnG9f4EDeO7EokHJ+vMog8y1ZLlvz5I7
         ycOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Gflpdrhc4t5qTdXZX0CB4LASuBJpEWKNoIGYBs7+Mh8=;
        b=pOaXkuzb79hb4LYrADBlFbLzLVorzJSCQLNbFbBpZS7rthAOM2FXIxS7bOejJ4QvQP
         vxJqDjz3Op35EVPyrv6NbKun30wk2q4UA3d0bUWbV7VBjop0IJoXBSVN7QEh9aKPGb11
         X+MuNv5RsqGkLds9BBm8yyaG0YzNl1BebiBW6yfeGhj09nDoJiN1JwWBaVc8bcyY+gfd
         1hEdGp/0cG0OYmtQ2zcKJdk8hc4JsOpkfv4XVyr4Lk2zDxZVdSZOJkNeyKWLMTVCMZCl
         LQzaSHgHHFElNYeoZuCOsHC9OXZzIni3rc2nlmwxxNkNEBiOCTP0125YOxFm+9gJZjRG
         lEzw==
X-Gm-Message-State: ALKqPwfAdRmRifimzolOTdP1sNEamb9OYsDL3AkMbUpA37bKUhXtAEBO
        rpW0wiAD39a8BAgRk4qhQEzNknmcSkXpjSoRvrWO3IDHJzK2v7+0ZNE8zQstc49VA0taQXAB9Yl
        uAFXuMVn3EF+ujfsZYK0Rn16oOZhU0Wp+P99tqhnJmtVc7ygH0jUJyUCM9A==
X-Google-Smtp-Source: AB8JxZqQd5oduZAq/Ra1vtecNv5AU9vg/wXvZmpsnGYVS31pWOIts140zcec1P/T688ggxYfdMSGhIBojYo=
MIME-Version: 1.0
X-Received: by 2002:a25:8b81:: with SMTP id j1-v6mr4734631ybl.14.1526335032177;
 Mon, 14 May 2018 14:57:12 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:05 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-15-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 14/35] remote: convert fetch refspecs to struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the set of fetch refspecs stored in 'struct remote' to use
'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c  | 20 ++++++++++----------
 builtin/remote.c | 18 +++++++++---------
 remote.c         | 24 ++++++------------------
 remote.h         |  5 +----
 4 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 745020a10..30083d4bc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -407,8 +407,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
 			fetch_refspec_nr = refmap_nr;
 		} else {
-			fetch_refspec = transport->remote->fetch;
-			fetch_refspec_nr = transport->remote->fetch_refspec_nr;
+			fetch_refspec = transport->remote->fetch.items;
+			fetch_refspec_nr = transport->remote->fetch.nr;
 		}
 
 		for (i = 0; i < fetch_refspec_nr; i++)
@@ -421,16 +421,16 @@ static struct ref *get_ref_map(struct transport *transport,
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
-		    (remote->fetch_refspec_nr ||
+		    (remote->fetch.nr ||
 		     /* Note: has_merge implies non-NULL branch->remote_name */
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
-			for (i = 0; i < remote->fetch_refspec_nr; i++) {
-				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
-				if (remote->fetch[i].dst &&
-				    remote->fetch[i].dst[0])
+			for (i = 0; i < remote->fetch.nr; i++) {
+				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
+				if (remote->fetch.items[i].dst &&
+				    remote->fetch.items[i].dst[0])
 					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
-				    !remote->fetch[0].pattern)
+				    !remote->fetch.items[0].pattern)
 					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			}
 			/*
@@ -1166,8 +1166,8 @@ static int do_fetch(struct transport *transport,
 		if (ref_count) {
 			prune_refs(refs, ref_count, ref_map, transport->url);
 		} else {
-			prune_refs(transport->remote->fetch,
-				   transport->remote->fetch_refspec_nr,
+			prune_refs(transport->remote->fetch.items,
+				   transport->remote->fetch.nr,
 				   ref_map,
 				   transport->url);
 		}
diff --git a/builtin/remote.c b/builtin/remote.c
index fb84729d6..94dfcb78b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -333,10 +333,10 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	struct ref *ref, *stale_refs;
 	int i;
 
-	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
-		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
+	for (i = 0; i < states->remote->fetch.nr; i++)
+		if (get_fetch_map(remote_refs, &states->remote->fetch.items[i], &tail, 1))
 			die(_("Could not get fetch map for refspec %s"),
-				states->remote->fetch_refspec[i]);
+				states->remote->fetch.raw[i]);
 
 	states->new_refs.strdup_strings = 1;
 	states->tracked.strdup_strings = 1;
@@ -347,8 +347,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs = get_stale_heads(states->remote->fetch,
-				     states->remote->fetch_refspec_nr, fetch_map);
+	stale_refs = get_stale_heads(states->remote->fetch.items,
+				     states->remote->fetch.nr, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
@@ -590,8 +590,8 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->push.raw[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
+	for (i = 0; i < remote->fetch.raw_nr; i++)
+		git_config_set_multivar(buf.buf, remote->fetch.raw[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
@@ -646,11 +646,11 @@ static int mv(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
-	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
+	for (i = 0; i < oldremote->fetch.raw_nr; i++) {
 		char *ptr;
 
 		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
+		strbuf_addstr(&buf2, oldremote->fetch.raw[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr) {
 			refspec_updated = 1;
diff --git a/remote.c b/remote.c
index 090110c37..db1e4edb7 100644
--- a/remote.c
+++ b/remote.c
@@ -84,21 +84,12 @@ static void add_push_refspec(struct remote *remote, const char *ref)
 
 static void add_fetch_refspec(struct remote *remote, const char *ref)
 {
-	ALLOC_GROW(remote->fetch_refspec,
-		   remote->fetch_refspec_nr + 1,
-		   remote->fetch_refspec_alloc);
-	remote->fetch_refspec[remote->fetch_refspec_nr++] = ref;
+	refspec_append(&remote->fetch, ref);
 }
 
 void add_prune_tags_to_fetch_refspec(struct remote *remote)
 {
-	int nr = remote->fetch_refspec_nr;
-	int bufsize = nr  + 1;
-	int size = sizeof(struct refspec_item);
-
-	remote->fetch = xrealloc(remote->fetch, size  * bufsize);
-	memcpy(&remote->fetch[nr], tag_refspec, size);
-	add_fetch_refspec(remote, xstrdup(TAG_REFSPEC));
+	refspec_append(&remote->fetch, TAG_REFSPEC);
 }
 
 static void add_url(struct remote *remote, const char *url)
@@ -174,6 +165,7 @@ static struct remote *make_remote(const char *name, int len)
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
+	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
@@ -580,7 +572,6 @@ static struct remote *remote_get_1(const char *name,
 		add_url_alias(ret, name);
 	if (!valid_remote(ret))
 		return NULL;
-	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	return ret;
 }
 
@@ -611,9 +602,6 @@ int for_each_remote(each_remote_fn fn, void *priv)
 		struct remote *r = remotes[i];
 		if (!r)
 			continue;
-		if (!r->fetch)
-			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
-						       r->fetch_refspec);
 		result = fn(r, priv);
 	}
 	return result;
@@ -792,7 +780,7 @@ char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
+	return query_refspecs(remote->fetch.items, remote->fetch.nr, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
@@ -1590,7 +1578,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 {
 	char *ret;
 
-	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	ret = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
@@ -2224,7 +2212,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
-	dst = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	dst = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
 	if (read_ref(dst, oid))
diff --git a/remote.h b/remote.h
index 637fc5d0c..e7d00fe2a 100644
--- a/remote.h
+++ b/remote.h
@@ -30,10 +30,7 @@ struct remote {
 
 	struct refspec push;
 
-	const char **fetch_refspec;
-	struct refspec_item *fetch;
-	int fetch_refspec_nr;
-	int fetch_refspec_alloc;
+	struct refspec fetch;
 
 	/*
 	 * -1 to never fetch tags
-- 
2.17.0.441.gb46fe60e1d-goog

