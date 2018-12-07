Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2683D20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 21:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLGVuk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 16:50:40 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36734 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 16:50:40 -0500
Received: by mail-vs1-f73.google.com with SMTP id r133so2342664vsc.3
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 13:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C0us9fhRqtJ1ZgBa/1QREJ+YsF/kR57aFgb32UHfBMk=;
        b=MpTCdmfVkLvXC/qZMDhqYIgcopXChK56K9gv6XECDxBmAWLUDEPaG0H6WGv4G6kiMX
         ErBlUqxE0lrnT4pVZYp4iwXsjEUgsrDbOGOE77mrFM3Fk13tz/41g73Qc6k9+ny8Oepf
         32X8O97mgzTeMDySWeQ6j0FPiqdfzzfirTGdLfwQzzqdMDvVin4ZYViFTe4fwgLQ648d
         1ztaolh0J6efNCVllNCmmrPI61aDE3LvrniYwWQArsnLtqsar8nwm+I5Ab2HCLVJhLId
         cchBZDRvby/IoVxu7pbSTpdQhgjnxlNgShA07DcDWZsDlaekEQ7DScBOK0IP6bAsra+o
         FeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C0us9fhRqtJ1ZgBa/1QREJ+YsF/kR57aFgb32UHfBMk=;
        b=J4ZNbu907SsApL0cKxPOIRCTEOYNBFJUzwxK02LIj2qqTK9hKP+K+ihlwl51vaXd9R
         mFiS8/8b8FSl54FxRGrzdFVyq3wAIY2r3/fREgi+Lzt/2BJ35wntkAecdEU1ix/fUV+S
         taG+npwBDLkuolc68cYEykIFadtx/0DZtSgOHv+vHXq+KgKVFmT7JlFcU9aAbzw8LuY+
         W6uur48QkYhyMMa0EfdPdUJUbRaeI8IZCdsNN5QS8cAhSPdjS0Q0eFFbG235Mv1I6Bbd
         58oCFKgH+K15e8DJ1yENXD9INJQcJH7DGY/52TKT2JXqY6Pa1RcJefB0b5D+w8cSZGcw
         whhQ==
X-Gm-Message-State: AA+aEWZ6t8NscfVGaGApct1FsXJP+1oyvBS7dB51mqpuBHYPqCNQdiim
        3Blz9K/ANz65ADHt+2pKIgqAUg987wW8MnfYwQEcXBGm0ekKoxCGrI88kaxbkrlRodQz9vzyLyx
        srRGzICK4yOKdhPPq2pGlgcqQF1/2eW8gQTFsSGeb211k9csejPePr+cEbUKIkZNaGq1JuCD5VX
        fe
X-Google-Smtp-Source: AFSGD/VJjn6maUnvYz7bbPGu0xOm1hnqRz876XskP4TvWfP5Awq+N4GxMjO8sxQN/mBxInJLXHpene4rObDWM0VWXR7T
X-Received: by 2002:a1f:1696:: with SMTP id 144mr3110503vkw.26.1544219438312;
 Fri, 07 Dec 2018 13:50:38 -0800 (PST)
Date:   Fri,  7 Dec 2018 13:50:34 -0800
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com>
Message-Id: <20181207215034.213211-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181204224238.50966-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH on master v2] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching into a repository, a connectivity check is first made by
check_exist_and_connected() in builtin/fetch.c that runs:

  git rev-list --objects --stdin --not --all --quiet <(list of objects)

If the client repository has many refs, this command can be slow,
regardless of the nature of the server repository or what is being
fetched. A profiler reveals that most of the time is spent in
setup_revisions() (approx. 60/63), and of the time spent in
setup_revisions(), most of it is spent in parse_object() (approx.
49/60). This is because setup_revisions() parses the target of every ref
(from "--all"), and parse_object() reads the buffer of the object.

Reading the buffer is unnecessary if the repository has a commit graph
and if the ref points to a commit (which is typically the case). This
patch uses the commit graph wherever possible; on my computer, when I
run the above command with a list of 1 object on a many-ref repository,
I get a speedup from 1.8s to 1.0s.

Another way to accomplish this effect would be to modify parse_object()
to use the commit graph if possible; however, I did not want to change
parse_object()'s current behavior of always checking the object
signature of the returned object.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This patch is now on master.

v2 makes use of the optimization Stolee describes in [1], except that I
have arranged the functions slightly differently. In particular, I
didn't want to add even more ways to obtain objects, so I let
parse_commit_in_graph() be able to take in either a commit shell or an
OID, and did not create the parse_probably_commit() function he
suggested. But I'm not really attached to this design choice, and can
change it if requested.

[1] https://public-inbox.org/git/aa0cd481-c135-47aa-2a69-e3dc71661caa@gmail.com/
---
 commit-graph.c             | 38 ++++++++++++++++++++++++++++----------
 commit-graph.h             | 12 ++++++++----
 commit.c                   |  2 +-
 revision.c                 |  5 ++++-
 t/helper/test-repository.c |  4 ++--
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..a571b523b7 100644
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
@@ -374,24 +375,41 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
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
-		return fill_commit_in_graph(item, g, pos);
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
+	fill_commit_in_graph(shell, g, pos);
+	return shell;
 }
 
-int parse_commit_in_graph(struct repository *r, struct commit *item)
+struct commit *parse_commit_in_graph(struct repository *r, struct commit *shell,
+				     const struct object_id *oid)
 {
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r, r->objects->commit_graph, shell,
+					 oid);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -1025,7 +1043,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(g, graph_commit))
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
index d13a7bc374..88eb580c5a 100644
--- a/commit.c
+++ b/commit.c
@@ -456,7 +456,7 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
+	if (use_commit_graph && parse_commit_in_graph(the_repository, item, NULL))
 		return 0;
 	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
diff --git a/revision.c b/revision.c
index 13e0519c02..05fddb5880 100644
--- a/revision.c
+++ b/revision.c
@@ -213,7 +213,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(revs->repo, oid);
+	object = (struct object *) parse_commit_in_graph(revs->repo, NULL, oid);
+	if (!object)
+		object = parse_object(revs->repo, oid);
+
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 6a84a53efb..63b928a883 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -22,7 +22,7 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	c = lookup_commit(&r, commit_oid);
 
-	if (!parse_commit_in_graph(&r, c))
+	if (!parse_commit_in_graph(&r, c, NULL))
 		die("Couldn't parse commit");
 
 	printf("%"PRItime, c->date);
@@ -52,7 +52,7 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	 * get_commit_tree_in_graph does not automatically parse the commit, so
 	 * parse it first.
 	 */
-	if (!parse_commit_in_graph(&r, c))
+	if (!parse_commit_in_graph(&r, c, NULL))
 		die("Couldn't parse commit");
 	tree = get_commit_tree_in_graph(&r, c);
 	if (!tree)
-- 
2.19.0.271.gfe8321ec05.dirty

