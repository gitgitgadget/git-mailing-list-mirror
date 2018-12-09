Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABE020A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLIBt7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:49:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65067 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLIBt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:49:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3947D11306B;
        Sat,  8 Dec 2018 20:49:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qkdICEXfvWD8GB/oTE+tmbqdOd4=; b=tPM1nV
        jlbIP6K9nNGYxlULYBAOaGaUtys1cjQYzCDBLA6FGZuP9NvSTnR767C215P+hwWw
        i2+K6hCKb0/9WcDn2XADSMPPDobqoHgEQe++2cKA1fQOruO/hAWBSahLTvi2RMi0
        d3fvN5p8NC/wBJQrn7Xol1lJB000mwQEqYbl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ClzePqfJIFz389sNhLtdVkphDT96o2/f
        O3F2sOld1A+HmcaFoHTSg2Ns3/Ogep9w1UaBdrpm5QYRBt3xiL6x6X6pNabm+iCh
        3fWpMRA6uq9kaKvFCiliTf42b3dmWzZViymM2M2CW3IEn4Gm7fro58sedDxkBF9s
        GAtpa0WR00U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31B4011306A;
        Sat,  8 Dec 2018 20:49:54 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78101113069;
        Sat,  8 Dec 2018 20:49:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH on master v2] revision: use commit graph in get_reference()
References: <20181204224238.50966-1-jonathantanmy@google.com>
        <20181207215034.213211-1-jonathantanmy@google.com>
        <xmqqwooj5xpr.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 09 Dec 2018 10:49:52 +0900
In-Reply-To: <xmqqwooj5xpr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 09 Dec 2018 09:51:28 +0900")
Message-ID: <xmqqbm5v5v0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B90A3068-FB54-11E8-A5A0-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> When fetching into a repository, a connectivity check is first made by
>> check_exist_and_connected() in builtin/fetch.c that runs:
>> ...
>> Another way to accomplish this effect would be to modify parse_object()
>> to use the commit graph if possible; however, I did not want to change
>> parse_object()'s current behavior of always checking the object
>> signature of the returned object.
>
> Sounds good.
>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>> This patch is now on master.
>
> OK.  
>
> Obviously that won't apply to the base for v1 without conflicts, and
> it of course applies cleanly on 'master', but the result of doing so
> will cause the same conflicts when sb/more-repo-in-api is merged on
> top, which means that the same conflicts need to be resolved if this
> wants to be merged to 'next' (or 'pu', FWIW).

So,... as I had to do the reverse rebase anyway, here is the
difference since the previous round, which I came up with by
comparing these two:

 (A) merge 'sb/more-repo-in-api' to 'master' and then merge v1 of
     this topic to the result.

 (B) apply your patch to 'master', and then merge
     'sb/more-repo-in-api' to the result.

diff --git a/commit-graph.c b/commit-graph.c
index f78a8e96b5..74a17789f8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -286,7 +286,8 @@ void close_commit_graph(struct repository *r)
 	r->objects->commit_graph = NULL;
 }
 
-static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
+static int bsearch_graph(struct commit_graph *g, const struct object_id *oid,
+			 uint32_t *pos)
 {
 	return bsearch_hash(oid->hash, g->chunk_oid_fanout,
 			    g->chunk_oid_lookup, g->hash_len, pos);
@@ -377,26 +378,41 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-static int parse_commit_in_graph_one(struct repository *r,
-				     struct commit_graph *g,
-				     struct commit *item)
+static struct commit *parse_commit_in_graph_one(struct repository *r,
+						struct commit_graph *g,
+						struct commit *shell,
+						const struct object_id *oid)
 {
 	uint32_t pos;
 
-	if (item->object.parsed)
-		return 1;
+	if (shell && shell->object.parsed)
+		return shell;
 
-	if (find_commit_in_graph(item, g, &pos))
-		return fill_commit_in_graph(r, item, g, pos);
+	if (shell && shell->graph_pos != COMMIT_NOT_FROM_GRAPH) {
+		pos = shell->graph_pos;
+	} else if (bsearch_graph(g, shell ? &shell->object.oid : oid, &pos)) {
+		/* bsearch_graph sets pos */
+	} else {
+		return NULL;
+	}
 
-	return 0;
+	if (!shell) {
+		shell = lookup_commit(r, oid);
+		if (!shell)
+			return NULL;
+	}
+
+	fill_commit_in_graph(r, shell, g, pos);
+	return shell;
 }
 
-int parse_commit_in_graph(struct repository *r, struct commit *item)
+struct commit *parse_commit_in_graph(struct repository *r, struct commit *shell,
+				     const struct object_id *oid)
 {
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r, r->objects->commit_graph, shell,
+					 oid);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -1033,7 +1049,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(r, g, graph_commit))
+		if (!parse_commit_in_graph_one(r, g, graph_commit, NULL))
 			graph_report("failed to parse %s from commit-graph",
 				     oid_to_hex(&cur_oid));
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..8b7b5985dc 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -13,16 +13,20 @@ struct commit;
 char *get_commit_graph_filename(const char *obj_dir);
 
 /*
- * Given a commit struct, try to fill the commit struct info, including:
+ * If the given commit (identified by shell->object.oid or oid) is in the
+ * commit graph, returns a commit struct (reusing shell if it is not NULL)
+ * including the following info:
  *  1. tree object
  *  2. date
  *  3. parents.
  *
- * Returns 1 if and only if the commit was found in the packed graph.
+ * If not, returns NULL. See parse_commit_buffer() for the fallback after this
+ * call.
  *
- * See parse_commit_buffer() for the fallback after this call.
+ * Either shell or oid must be non-NULL. If both are non-NULL, oid is ignored.
  */
-int parse_commit_in_graph(struct repository *r, struct commit *item);
+struct commit *parse_commit_in_graph(struct repository *r, struct commit *shell,
+				     const struct object_id *oid);
 
 /*
  * It is possible that we loaded commit contents from the commit buffer,
diff --git a/commit.c b/commit.c
index a5333c7ac6..da7a1d3262 100644
--- a/commit.c
+++ b/commit.c
@@ -462,7 +462,7 @@ int repo_parse_commit_internal(struct repository *r,
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(r, item))
+	if (use_commit_graph && parse_commit_in_graph(r, item, NULL))
 		return 0;
 	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
 	if (!buffer)
diff --git a/revision.c b/revision.c
index 22aa109c14..05fddb5880 100644
--- a/revision.c
+++ b/revision.c
@@ -213,19 +213,9 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	/*
-	 * If the repository has commit graphs, repo_parse_commit() avoids
-	 * reading the object buffer, so use it whenever possible.
-	 */
-	if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
-		struct commit *c = lookup_commit(revs->repo, oid);
-		if (!repo_parse_commit(revs->repo, c))
-			object = (struct object *) c;
-		else
-			object = NULL;
-	} else {
+	object = (struct object *) parse_commit_in_graph(revs->repo, NULL, oid);
+	if (!object)
 		object = parse_object(revs->repo, oid);
-	}
 
 	if (!object) {
 		if (revs->ignore_missing)
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index f7f8618445..689a0b652e 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -27,7 +27,7 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	c = lookup_commit(&r, commit_oid);
 
-	if (!parse_commit_in_graph(&r, c))
+	if (!parse_commit_in_graph(&r, c, NULL))
 		die("Couldn't parse commit");
 
 	printf("%"PRItime, c->date);
@@ -62,7 +62,7 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	 * get_commit_tree_in_graph does not automatically parse the commit, so
 	 * parse it first.
 	 */
-	if (!parse_commit_in_graph(&r, c))
+	if (!parse_commit_in_graph(&r, c, NULL))
 		die("Couldn't parse commit");
 	tree = get_commit_tree_in_graph(&r, c);
 	if (!tree)

