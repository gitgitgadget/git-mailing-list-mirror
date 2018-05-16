Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E681F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEPW7P (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:15 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:38165 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeEPW7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:12 -0400
Received: by mail-yb0-f202.google.com with SMTP id t12-v6so1254586ybg.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2j2PtlmB9pR1qfjLnQ555X0I6wBMEopjRwYKUsZ/6ZY=;
        b=MHo5bNH9POrU55vVp75nS4uLQA2QeCan7UK8CK+AlkXRHqJFW1NaMcR5dLYZTKSQSX
         HQtCBnEgNySq8Zi5d78YqbAfmz9OQPizi6JD6e3L6BJ5ehfKcAJUeM87fLXCQrbi5n+A
         xcpoEl7BVVdJvYxNP+ACWAI59O2OCY6X5UUCCbgWiHFb0qkFxgR+6ChyJyHOJOrzkn/F
         5/q5hI2X9BRQsgtJG9X0H+lv6hG55Pb7pp0YP0mjrfHfVd3AzomyCuO6izyQoWZlkQIt
         FYLgaYeH/115LypD9Zb9YVAha7yLq/0INYuvV4KpCx5VCnqUlI6ma+cPuJzFc0T1BhFm
         FOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2j2PtlmB9pR1qfjLnQ555X0I6wBMEopjRwYKUsZ/6ZY=;
        b=l2q8paO+cb6Btg8REXuMkzs545nFVZkHwjhwYrGeGbXeLuWgkzvMyNIp8ctEkrw82A
         UPcGzGIizPCY7XKSDNBqT+/ilxVif+nSUYDEWvWEwk1CK870IKeifcsEE9NqZhr6s1/e
         akh7Dyf99MlFBptzjdsl7fbf2X/WNgpLG0sjA3MaYF/KXf/vxkUfiVGM6hV8GSnl2umN
         fLDtSuQG006nAwgniB5xSZJx/f9HgS6NXHg5k9Pu7rGJBNBGIUkv0sGfEjHXuPLhKZAo
         4rAOtkmTi+CpijZ2nxGEnQVMl58gj5RxLLMb1z8mt8OEB9QJ0gKrOzF2rW0vjPLZnVWY
         ufmQ==
X-Gm-Message-State: ALKqPweZNMl19LcsUZkbPzk3A4QuXwisSya6kk4gmz/lxyXHhExjt16s
        Q7hkxGyp9nZKG75B1cEsJ9Iti2GrlZNTsdxUD+kW5O8TBm0Tq6phxlFu9PpFcHml1Rxh5S2NhO4
        z6B0hk63ZEakiLBC9HzmP0XyhfT6AQbSyp8+igkyUO6zw2AkT175RGdkBCw==
X-Google-Smtp-Source: AB8JxZohbNxu/OKJc+M6xzayw5s+Ws6EzlYvnbbTup/AdLjc9zN1unJSNo012xdAnfMN6ix9rzIOsPrjhL8=
MIME-Version: 1.0
X-Received: by 2002:a81:48c1:: with SMTP id v184-v6mr993558ywa.221.1526511551982;
 Wed, 16 May 2018 15:59:11 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:01 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-15-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 14/36] remote: convert fetch refspecs to struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
 remote.c         | 38 ++++++++++++--------------------------
 remote.h         |  5 +----
 4 files changed, 32 insertions(+), 49 deletions(-)

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
index 1b7258f77..26842ce37 100644
--- a/remote.c
+++ b/remote.c
@@ -77,23 +77,9 @@ static const char *alias_url(const char *url, struct rewrites *r)
 	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
 
-static void add_fetch_refspec(struct remote *remote, const char *ref)
-{
-	ALLOC_GROW(remote->fetch_refspec,
-		   remote->fetch_refspec_nr + 1,
-		   remote->fetch_refspec_alloc);
-	remote->fetch_refspec[remote->fetch_refspec_nr++] = ref;
-}
-
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
@@ -169,6 +155,7 @@ static struct remote *make_remote(const char *name, int len)
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
+	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
@@ -271,7 +258,7 @@ static void read_remotes_file(struct remote *remote)
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
-			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
+			refspec_append(&remote->fetch, skip_spaces(v));
 	}
 	strbuf_release(&buf);
 	fclose(f);
@@ -310,13 +297,15 @@ static void read_branches_file(struct remote *remote)
 		frag = "master";
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
-	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
-					  frag, remote->name));
+	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
+		    frag, remote->name);
+	refspec_append(&remote->fetch, buf.buf);
 
 	/*
 	 * Cogito compatible push: push current HEAD to remote #branch
 	 * (master if missing)
 	 */
+	strbuf_reset(&buf);
 	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
 	refspec_append(&remote->push, buf.buf);
 	remote->fetch_tags = 1; /* always auto-follow */
@@ -411,7 +400,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
-		add_fetch_refspec(remote, v);
+		refspec_append(&remote->fetch, v);
+		free((char *)v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
@@ -578,7 +568,6 @@ static struct remote *remote_get_1(const char *name,
 		add_url_alias(ret, name);
 	if (!valid_remote(ret))
 		return NULL;
-	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
 	return ret;
 }
 
@@ -609,9 +598,6 @@ int for_each_remote(each_remote_fn fn, void *priv)
 		struct remote *r = remotes[i];
 		if (!r)
 			continue;
-		if (!r->fetch)
-			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
-						       r->fetch_refspec);
 		result = fn(r, priv);
 	}
 	return result;
@@ -790,7 +776,7 @@ char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
+	return query_refspecs(remote->fetch.items, remote->fetch.nr, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
@@ -1588,7 +1574,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 {
 	char *ret;
 
-	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	ret = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
@@ -2222,7 +2208,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
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

