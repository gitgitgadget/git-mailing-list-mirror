Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEAA1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdFPT25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:28:57 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36131 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdFPT24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:56 -0400
Received: by mail-wr0-f175.google.com with SMTP id 36so43107423wry.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/y+4/DGn+kC58YTvpjphHXqBCcVuLB308V9imldLUaQ=;
        b=SbqeXbjmjTF/OEyH1TVZtGNPvNZx2Vs4Z4oECvP4E9PmNMM2KNST/CsFLtha6fdaVv
         HQ4Y3Bm6qOLmq3juWmb50Y3ArsU7wbNUcgG9S/AHpSc1M4p+fj5OxXHTZOjuFUqPXCPS
         ZH3gNxTXS4NOlPZ9LaW5n6jAdsEImXcqS28Y64ZcM0Z3PuvJOjtVrlzOWGRzULia4DJ5
         53ZpWAj1i2VfDLxDDnnIxVr7nCWM+c70GugM+vukZ2pTNLuGlMXQpGksfo/Kjg0Mdnut
         d9EUVdiX1k10PmvEMY32jgV5LNI9v2KsCoxd98FmaxTpo6BEwsfNSvRXofXjwqqcrKWR
         Ljew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/y+4/DGn+kC58YTvpjphHXqBCcVuLB308V9imldLUaQ=;
        b=MdSg6iy6BdE8FtizNnIcb5IrOLTdga4oJ4SO/9f5Uhz3FTL+Y87oRV48xt122+o5AK
         nAPtOwwBvFgvm7o6GuR98j9aG4YBcYBfCtwIuLFtGH7snE3gXYyoe3OKA0vj5QgG/Ktd
         LcWkXv1BXMIRhg6RNSXyCZE0UhuKnNi2DgUhZ0/H8gl/nG7zftH6yLJ8e+8jVVp6vwv/
         QGxlC63D4ag103J+ayx80K4M/ppT603VF8BEAwfZs1HHCthl9o+5HhS8dR9dWRacRzGg
         h3OMZHwtNoDR4JZw3pAXVpf5CE6atuWBDaq8oR4aH6ytYTeqyycSAD5FIwFRkvPbju+H
         Wetg==
X-Gm-Message-State: AKS2vOwBA9Qyu6Cu18Akn3NS++tHWbGaUZrfKhxJ6N8pNNoefLwlYv7w
        lGPbcqeSf0Sn6liS
X-Received: by 10.223.173.143 with SMTP id w15mr2920334wrc.113.1497641334172;
        Fri, 16 Jun 2017 12:28:54 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] remote.c: eliminate remote->fetch_refspec
Date:   Fri, 16 Jun 2017 21:28:36 +0200
Message-Id: <20170616192837.11035-5-szeder.dev@gmail.com>
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

'struct remote' stores fetch refspecs twice: once in their original
string form in remote->fetch_refspecs and once in their parsed form in
remote->fetch.

The main reason for this is that we want to read the configuration
only once, but we don't want to error out while doing so because of a
bogus refspec in a remote that we aren't accessing at all.  Therefore,
when the configuration is read all refspecs are simply stored in
string arrays for each remote, and then refspecs of a particular
remote are parsed lazily, only when that remote is actually accessed.

However, storing refspecs in both forms has some drawbacks:

  - The same information is stored twice, wasting memory.
  - remote->fetch_refspecs, i.e. the string array is conveniently
    ALLOC_GROW()-able with associated 'fetch_refspec_{nr,alloc}'
    fields, but remote->fetch is not.
  - Wherever remote->fetch are accessed, the number of parsed refspecs
    in there is specified by remote->fetch_refspec_nr.  This requires
    us to keep the two arrays in sync and makes adding additional
    refspecs cumbersome and error prone.

So eliminate remote->fetch_refspec and parse fetch refspecs right away
while they are being read from the configuration.  However, to avoid
erroring out on bogus refspecs in "uninteresting" remotes, parse them
gently: instead of die()ing, store the problematic refspec in
remote->bogus_refspec, so it will be available later when that remote
is actually accessed and we can use it in the error message.  Make
remote->fetch ALLOC_GROW()-able.  Add a new add_fetch_refspec()
function to the remote API, replacing an old function with the same
name and add_and_parse_fetch_refspec(), to encompass memory
management of remote->fetch and parsing the new refspec (gently or
otherwise).  Update all sites accessing fetch-refspec-related fields
to use the new field names.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c  |  6 +++---
 builtin/fetch.c  | 20 ++++++++++----------
 builtin/remote.c | 18 +++++++++---------
 remote.c         | 55 +++++++++++++++++++++++++++++--------------------------
 remote.h         | 23 ++++++++++++++++++-----
 5 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5b72d853f..05cc57f79 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1054,7 +1054,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
-	add_and_parse_fetch_refspec(remote, default_refspec.buf);
+	add_fetch_refspec(remote, default_refspec.buf, 0);
 
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
@@ -1106,8 +1106,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, remote->fetch,
-					       remote->fetch_refspec_nr);
+		mapped_refs = wanted_peer_refs(refs, remote->fetch.rs,
+					       remote->fetch.nr);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 100248c5a..0f791a12f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -360,8 +360,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
 			fetch_refspec_nr = refmap_nr;
 		} else {
-			fetch_refspec = transport->remote->fetch;
-			fetch_refspec_nr = transport->remote->fetch_refspec_nr;
+			fetch_refspec = transport->remote->fetch.rs;
+			fetch_refspec_nr = transport->remote->fetch.nr;
 		}
 
 		for (i = 0; i < fetch_refspec_nr; i++)
@@ -374,16 +374,16 @@ static struct ref *get_ref_map(struct transport *transport,
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
+				get_fetch_map(remote_refs, &remote->fetch.rs[i], &tail, 0);
+				if (remote->fetch.rs[i].dst &&
+				    remote->fetch.rs[i].dst[0])
 					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
-				    !remote->fetch[0].pattern)
+				    !remote->fetch.rs[0].pattern)
 					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			}
 			/*
@@ -1117,8 +1117,8 @@ static int do_fetch(struct transport *transport,
 		if (ref_count) {
 			prune_refs(refs, ref_count, ref_map, transport->url);
 		} else {
-			prune_refs(transport->remote->fetch,
-				   transport->remote->fetch_refspec_nr,
+			prune_refs(transport->remote->fetch.rs,
+				   transport->remote->fetch.nr,
 				   ref_map,
 				   transport->url);
 		}
diff --git a/builtin/remote.c b/builtin/remote.c
index 7f0072fe5..d61daa5e8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -331,10 +331,10 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	struct ref *ref, *stale_refs;
 	int i;
 
-	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
-		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
+	for (i = 0; i < states->remote->fetch.nr; i++)
+		if (get_fetch_map(remote_refs, states->remote->fetch.rs + i, &tail, 1))
 			die(_("Could not get fetch map for refspec %s"),
-			      refspec_to_string(&states->remote->fetch[i]));
+			      refspec_to_string(&states->remote->fetch.rs[i]));
 
 	states->new.strdup_strings = 1;
 	states->tracked.strdup_strings = 1;
@@ -345,8 +345,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs = get_stale_heads(states->remote->fetch,
-				     states->remote->fetch_refspec_nr, fetch_map);
+	stale_refs = get_stale_heads(states->remote->fetch.rs,
+				     states->remote->fetch.nr, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
@@ -591,8 +591,8 @@ static int migrate_file(struct remote *remote)
 	}
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch_refspec_nr; i++) {
-		strbuf_add_refspec(&refspec, &remote->fetch[i]);
+	for (i = 0; i < remote->fetch.nr; i++) {
+		strbuf_add_refspec(&refspec, &remote->fetch.rs[i]);
 		git_config_set_multivar(buf.buf, refspec.buf, "^$", 0);
 		strbuf_reset(&refspec);
 	}
@@ -651,11 +651,11 @@ static int mv(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
-	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
+	for (i = 0; i < oldremote->fetch.nr; i++) {
 		char *ptr;
 
 		strbuf_reset(&buf2);
-		strbuf_add_refspec(&buf2, &oldremote->fetch[i]);
+		strbuf_add_refspec(&buf2, &oldremote->fetch.rs[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr) {
 			refspec_updated = 1;
diff --git a/remote.c b/remote.c
index fc1d3cf7a..952000b61 100644
--- a/remote.c
+++ b/remote.c
@@ -94,14 +94,6 @@ static void add_push_refspec(struct remote *remote, const char *ref)
 	remote->push_refspec[remote->push_refspec_nr++] = strdup(ref);
 }
 
-static void add_fetch_refspec(struct remote *remote, const char *ref)
-{
-	ALLOC_GROW(remote->fetch_refspec,
-		   remote->fetch_refspec_nr + 1,
-		   remote->fetch_refspec_alloc);
-	remote->fetch_refspec[remote->fetch_refspec_nr++] = strdup(ref);
-}
-
 static void add_url(struct remote *remote, const char *url)
 {
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
@@ -267,7 +259,7 @@ static void read_remotes_file(struct remote *remote)
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			add_push_refspec(remote, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
-			add_fetch_refspec(remote, skip_spaces(v));
+			add_fetch_refspec(remote, skip_spaces(v), 1);
 	}
 	strbuf_release(&buf);
 	fclose(f);
@@ -308,7 +300,7 @@ static void read_branches_file(struct remote *remote)
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
 
 	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s", frag, remote->name);
-	add_fetch_refspec(remote, buf.buf);
+	add_fetch_refspec(remote, buf.buf, 1);
 	strbuf_reset(&buf);
 
 	/*
@@ -408,7 +400,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
-		add_fetch_refspec(remote, v);
+		add_fetch_refspec(remote, v, 1);
 		free((char*)v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		const char *v;
@@ -630,17 +622,28 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
-void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
+static int add_refspec(struct remote *remote, const char *refspec,
+		       int fetch, int gently)
 {
-	struct refspec *rs;
+	struct refspec_array *rsa = fetch ? &remote->fetch : NULL;
 
-	add_fetch_refspec(remote, refspec);
-	rs = parse_fetch_refspec(1, &refspec);
-	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
-	remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
+	ALLOC_GROW(rsa->rs, rsa->nr + 1, rsa->alloc);
 
-	/* Not free_refspecs(), as we copied its pointers above */
-	free(rs);
+	if (parse_one_refspec(&rsa->rs[rsa->nr], refspec, fetch, gently) < 0) {
+		if (gently) {
+			if (!remote->bogus_refspec)
+				remote->bogus_refspec = strdup(refspec);
+			return -1;
+		} else
+			die("Invalid refspec: '%s'", refspec);
+	}
+	rsa->nr++;
+	return 0;
+}
+
+int add_fetch_refspec(struct remote *remote, const char *refspec, int gently)
+{
+	return add_refspec(remote, refspec, 1, gently);
 }
 
 struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
@@ -725,7 +728,8 @@ static struct remote *remote_get_1(const char *name,
 		add_url_alias(ret, name);
 	if (!valid_remote(ret))
 		return NULL;
-	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
+	if (ret->bogus_refspec)
+		die("Invalid refspec '%s'", ret->bogus_refspec);
 	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
@@ -757,9 +761,8 @@ int for_each_remote(each_remote_fn fn, void *priv)
 		struct remote *r = remotes[i];
 		if (!r)
 			continue;
-		if (!r->fetch)
-			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
-						       r->fetch_refspec);
+		if (r->bogus_refspec)
+			die("Invalid refspec '%s'", r->bogus_refspec);
 		if (!r->push)
 			r->push = parse_push_refspec(r->push_refspec_nr,
 						     r->push_refspec);
@@ -961,7 +964,7 @@ char *refspec_to_string(const struct refspec *refspec)
 
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
-	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
+	return query_refspecs(remote->fetch.rs, remote->fetch.nr, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
@@ -1756,7 +1759,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 {
 	char *ret;
 
-	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	ret = apply_refspecs(remote->fetch.rs, remote->fetch.nr, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
@@ -2373,7 +2376,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
-	dst = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	dst = apply_refspecs(remote->fetch.rs, remote->fetch.nr, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
 	if (read_ref(dst, oid->hash))
diff --git a/remote.h b/remote.h
index ee6c432d0..416a08501 100644
--- a/remote.h
+++ b/remote.h
@@ -11,6 +11,11 @@ enum {
 	REMOTE_BRANCHES
 };
 
+struct refspec_array {
+	struct refspec *rs;
+	int nr, alloc;
+};
+
 struct remote {
 	struct hashmap_entry ent;  /* must be first */
 
@@ -32,10 +37,10 @@ struct remote {
 	int push_refspec_nr;
 	int push_refspec_alloc;
 
-	const char **fetch_refspec;
-	struct refspec *fetch;
-	int fetch_refspec_nr;
-	int fetch_refspec_alloc;
+	struct refspec_array fetch;
+
+	/* Copy of the first bogus fetch refspec we couldn't parse */
+	const char *bogus_refspec;
 
 	/*
 	 * -1 to never fetch tags
@@ -169,7 +174,15 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
-void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec);
+/*
+ * Add a fetch refspec to a remote.
+ * If the refspec cannot be parsed successfully and
+ *  - gently=0: die().
+ *  - gently=1: store the refspec in remote->bogus_refspec and return with -1.
+ *              If there are more than one bogus refspecs in the same remote,
+ *              then only the first one will be stored.
+ */
+int add_fetch_refspec(struct remote *remote, const char *refspec, int gently);
 extern struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
-- 
2.13.1.505.g7cc9fcafb

