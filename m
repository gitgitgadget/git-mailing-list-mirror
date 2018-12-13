Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F330020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 18:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLMSyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 13:54:55 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47271 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMSyz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 13:54:55 -0500
Received: by mail-qk1-f202.google.com with SMTP id z68so2490948qkb.14
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 10:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1p+vk0bW7XMkxHmpbUPODNyV53JDCJZnvxxIaCHOKWs=;
        b=lBSfRU52yB9LsF7QRE1gAmviICD+O/c5j6iY/G0cPrzCy+ZIy/a2fx6epooTKpoHYo
         SWJQBzcBsOEHVjo7RL/TueRKb3z2Ki8Khhncr0XtWF+Tld6NB1HuedxpdNwODKgjMeJK
         d7CzhOakGAlOotmbz4ZjWXsFThCb7TxuoG9YuzRLvxQfFh+w+oZyyShad4+OHCtnSv0W
         j7gwVs4bUQMUBo+m8UvChPwKomQOUWYLoPYmnB3hQX7dvm3jEJvWo92EaiAyGmoBn4V8
         Z6JLz9EyHGk5wxeLDe72I2Hu0OigZ4bOtKJSYFNVTIjXewqri56EKtfFniTva5oJX9s0
         VFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1p+vk0bW7XMkxHmpbUPODNyV53JDCJZnvxxIaCHOKWs=;
        b=UaOwZtanwyqxA3fuRDW5O7TQUksnZgTblYhL7uXG5bS6X32obqdmNOVr3SE6X1KPIV
         qEfGn7AJDQXUCgv23Wrr73o9XpRDa01viZXRCH4An5kVxEzRg/YHhMrCBp9geWAKzyfs
         h/ZVtVafDr4LxP/NC7m7f2M+q/kqhWcU5slsan93ITZRhpnvnBRmeHhxhD9M+GC0dnUE
         NqEG/w8hLa2kAf2bGG4coabvKYmBlz9Pt48XaEfF18d1s1b7vdNNxmD5AEaMk2ZZjKsx
         fIrTUxWq/eaeEk7w1vKhEOA+eEnvQZvgLWub03N1ZEgK+quY2MUj2Ty29ZiF+6aUd1b8
         kIlA==
X-Gm-Message-State: AA+aEWaMTRK1E4iQs2JAQCAk7orNC2awaC6mpKD8MVMwRqs82Jh/IxLJ
        g0gd1cn75TsUYG4IO7diqqnISsrtx/8t+tN/EbAxn7XLDjF+fFMNmg2UXL3DxBkQINlO+Fn4K+C
        hugFVkU/kHpFpEGBkT3eS37Jap3OVEJ5S2mLI9stsVe1Imbp5cfHC1L2yd6h/javmI37vGw951A
        OI
X-Google-Smtp-Source: AFSGD/Vy5//x7tIq6Ky6D63hpnoLXTAadneE//kwjmHmyNOER8XYkA9T4glRzXCLFaYgnvDTFUZjmnzYdUlCc+UYmqRG
X-Received: by 2002:a0c:9199:: with SMTP id n25mr19677021qvn.49.1544727294066;
 Thu, 13 Dec 2018 10:54:54 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:54:50 -0800
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com>
Message-Id: <20181213185450.230953-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181204224238.50966-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v3] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        stolee@gmail.com, gitster@pobox.com
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
This patch is still on master. Junio, let me know if you would rather
have me base it on sb/more-repo-in-api instead.

I mentioned [1] that I would unify parse_commit_in_graph_one() and
parse_commit_in_graph() so that one documentation comment could cover
all the functionality, but with the simpler API, I decided not to do
that to minimize the diff.

Change in v3: Now uses a simpler API with the algorithm suggested by
Peff in [2], except that I also retain the existing optimization that
checks if graph_pos is already set.

[1] https://public-inbox.org/git/20181212195812.232726-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20181213012707.GC26210@sigill.intra.peff.net/
---
 commit-graph.c             | 44 ++++++++++++++++++++++++++------------
 commit-graph.h             | 11 +++++-----
 commit.c                   |  4 +++-
 revision.c                 |  5 ++++-
 t/helper/test-repository.c |  8 ++-----
 5 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..0aca7ec0fe 100644
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
@@ -374,24 +375,42 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
+static struct commit *parse_commit_in_graph_one(struct repository *r,
+						struct commit_graph *g,
+						const struct object_id *oid)
 {
+	struct object *obj;
+	struct commit *commit;
 	uint32_t pos;
 
-	if (item->object.parsed)
-		return 1;
+	obj = lookup_object(r, oid->hash);
+	commit = obj && obj->type == OBJ_COMMIT ? (struct commit *) obj : NULL;
+	if (commit && obj->parsed)
+		return commit;
 
-	if (find_commit_in_graph(item, g, &pos))
-		return fill_commit_in_graph(item, g, pos);
+	if (commit && commit->graph_pos != COMMIT_NOT_FROM_GRAPH)
+		pos = commit->graph_pos;
+	else if (bsearch_graph(g, oid, &pos))
+		; /* bsearch_graph sets pos */
+	else
+		return NULL;
 
-	return 0;
+	if (!commit) {
+		commit = lookup_commit(r, oid);
+		if (!commit)
+			return NULL;
+	}
+
+	fill_commit_in_graph(commit, g, pos);
+	return commit;
 }
 
-int parse_commit_in_graph(struct repository *r, struct commit *item)
+struct commit *parse_commit_in_graph(struct repository *r,
+				     const struct object_id *oid)
 {
 	if (!prepare_commit_graph(r))
-		return 0;
-	return parse_commit_in_graph_one(r->objects->commit_graph, item);
+		return NULL;
+	return parse_commit_in_graph_one(r, r->objects->commit_graph, oid);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -1004,8 +1023,6 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	}
 
 	for (i = 0; i < g->num_commits; i++) {
-		struct commit *graph_commit;
-
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
@@ -1024,8 +1041,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			cur_fanout_pos++;
 		}
 
-		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(g, graph_commit))
+		if (!parse_commit_in_graph_one(r, g, &cur_oid))
 			graph_report("failed to parse %s from commit-graph",
 				     oid_to_hex(&cur_oid));
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..b67aac1125 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -13,16 +13,17 @@ struct commit;
 char *get_commit_graph_filename(const char *obj_dir);
 
 /*
- * Given a commit struct, try to fill the commit struct info, including:
+ * If the given commit is in the commit graph, returns a commit struct
+ * including the following info:
  *  1. tree object
  *  2. date
  *  3. parents.
  *
- * Returns 1 if and only if the commit was found in the packed graph.
- *
- * See parse_commit_buffer() for the fallback after this call.
+ * If not, returns NULL. See parse_commit_buffer() for the fallback after this
+ * call.
  */
-int parse_commit_in_graph(struct repository *r, struct commit *item);
+struct commit *parse_commit_in_graph(struct repository *r,
+				     const struct object_id *oid);
 
 /*
  * It is possible that we loaded commit contents from the commit buffer,
diff --git a/commit.c b/commit.c
index d13a7bc374..19ce5e34a2 100644
--- a/commit.c
+++ b/commit.c
@@ -456,7 +456,9 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
+	if (use_commit_graph &&
+	    parse_commit_in_graph(the_repository, &item->object.oid) &&
+	    item->object.parsed)
 		return 0;
 	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
diff --git a/revision.c b/revision.c
index 13e0519c02..7f54f3b4c7 100644
--- a/revision.c
+++ b/revision.c
@@ -213,7 +213,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(revs->repo, oid);
+	object = (struct object *) parse_commit_in_graph(revs->repo, oid);
+	if (!object)
+		object = parse_object(revs->repo, oid);
+
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 6a84a53efb..35bfd1233d 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -20,9 +20,7 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
-	c = lookup_commit(&r, commit_oid);
-
-	if (!parse_commit_in_graph(&r, c))
+	if (!(c = parse_commit_in_graph(&r, commit_oid)))
 		die("Couldn't parse commit");
 
 	printf("%"PRItime, c->date);
@@ -46,13 +44,11 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
-	c = lookup_commit(&r, commit_oid);
-
 	/*
 	 * get_commit_tree_in_graph does not automatically parse the commit, so
 	 * parse it first.
 	 */
-	if (!parse_commit_in_graph(&r, c))
+	if (!(c = parse_commit_in_graph(&r, commit_oid)))
 		die("Couldn't parse commit");
 	tree = get_commit_tree_in_graph(&r, c);
 	if (!tree)
-- 
2.19.0.271.gfe8321ec05.dirty

