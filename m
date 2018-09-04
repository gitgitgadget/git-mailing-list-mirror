Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFDE91F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeIEAyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:54:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIEAyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:54:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so5271674wre.10
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1/lS8ympO++ubxtR+O0e6Jrphj4xo0oi6Z0VgEzCvQ=;
        b=p9SZF7YpqQFIuLtsfpVoHFO3GSsjCrvbXde/bsPJ6lxQi/qEMkds4C28jRZYbsH2yc
         ofmAYf2aI0ZltAkhGUKt776yMMKWAkiJ5RLD5bf1mvTRk+FPNG+/1TFjYl2F+freryIP
         EQrIiQCvfnyGgHQaDXxBy7r+LwIbUgbFNFGcNTQGoGhyro58Nz/tOerc4pevBYqtN1nU
         wIIdbnsizc5b0OAPdxEQBFaE+Vy4zbbPpIx/11aqQlTpbYtDGqe6rc0EGNuZgfGHsot6
         6bxRaNJ3Ok4EmOTNsj4Gs0E/yDTqaoXh3XdB9FkDpnsdHbHQZzYupfN3WCXrNVOiQko4
         eOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1/lS8ympO++ubxtR+O0e6Jrphj4xo0oi6Z0VgEzCvQ=;
        b=sxtLVslyvQuSijN3NL14JG3AtegCg4+cbRu9zYwWaQ93jkAOfuY0daiWmYwbtTnohT
         NBBbFGeDCCCEf+EyM69jX7xa4c5ZJzRttTV3tpMaA4kA7d7N1r6K8Mg+fWeMAVIrJgKr
         KsgD48ZX1NavFgd4ydEy0AFOpnda20LyBBgAd8rb+b6ZRQOZIipjxY3Dy3K4ki99vc2A
         S68rUspn683o7Fj01FGfXJz3hLYA1fwmewW/DAvWgpfP0+uE44nnOqmPmAZ5ncjcfXij
         1Y1UJMbnMEVvw8IAROvkoollO0AsIpixn3wk4KdD+D+EqomD+pNbw74w1JfAF2p0SXxx
         dhhw==
X-Gm-Message-State: APzg51DCoqJpoDLeC95/8XQ3VjaRsMihUrGnf9h00PjMw0cA5V4g7MlB
        yOaYLosZmx2Jrw5BoZ9g+NVgMUnjmSQ=
X-Google-Smtp-Source: ANB0VdZHpfJlkn2tO72DR6sNrQD7aQMw4oETTFNw+6DoLdCWBeaTGGILbESUU/vLBK+efl5IbpdLrw==
X-Received: by 2002:adf:ee86:: with SMTP id b6-v6mr23113822wro.242.1536092866116;
        Tue, 04 Sep 2018 13:27:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l130-v6sm257109wmd.16.2018.09.04.13.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 13:27:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] commit-graph write: add progress output
Date:   Tue,  4 Sep 2018 20:27:28 +0000
Message-Id: <20180904202729.13900-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180904202729.13900-1-avarab@gmail.com>
References: <20180904202729.13900-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change the "commit-graph write" command didn't report any
progress. On my machine this command takes more than 10 seconds to
write the graph for linux.git, and around 1m30s on the
2015-04-03-1M-git.git[1] test repository, which is a test case for
larger monorepos.

Furthermore, since the gc.writeCommitGraph setting was added in
d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27),
there was no indication at all from a "git gc" run that anything was
different. This why one of the progress bars being added here uses
start_progress() instead of start_delayed_progress(), so that it's
guaranteed to be seen. E.g. on my tiny 867 commit dotfiles.git
repository:

    $ git -c gc.writeCommitGraph=true gc
    Enumerating objects: 2821, done.
    [...]
    Total 2821 (delta 1670), reused 2821 (delta 1670)
    Computing commit graph generation numbers: 100% (867/867), done.

On larger repositories, such as linux.git the delayed progress bar(s)
will kick in, and we'll show what's going on instead of, as was
previously happening, printing nothing while we write the graph:

    $ git -c gc.writeCommitGraph=true gc
    Annotating commits in commit graph: 1565573, done.
    Computing commit graph generation numbers: 100% (782484/782484), done.

Note that here we don't show "Finding commits for commit graph", this
is because under "git gc" we seed the search with the commit
references in the repository, and that set is too small to show any
progress, but would e.g. on a smaller repo such as git.git with
--stdin-commits:

    $ git rev-list --all | git -c gc.writeCommitGraph=true write --stdin-commits
    Finding commits for commit graph: 100% (162576/162576), done.
    Computing commit graph generation numbers: 100% (162576/162576), done.

With --stdin-packs we don't show any estimation of how much is left to
do. This is because we might be processing more than one pack. We
could be less lazy here and show progress, either detect by detecting
that we're only processing one pack, or by first looping over the
packs to discover how many commits they have. I don't see the point in
doing that work. So instead we get (on 2015-04-03-1M-git.git):

    $ echo pack-<HASH>.idx | git -c gc.writeCommitGraph=true --exec-path=$PWD commit-graph write --stdin-packs
    Finding commits for commit graph: 13064614, done.
    Annotating commits in commit graph: 3001341, done.
    Computing commit graph generation numbers: 100% (1000447/1000447), done.

1. https://github.com/avar/2015-04-03-1M-git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8a1bec7b8a..74889dc90a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,6 +13,7 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "alloc.h"
+#include "progress.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -548,6 +549,8 @@ struct packed_oid_list {
 	struct object_id *list;
 	int nr;
 	int alloc;
+	struct progress *progress;
+	int progress_done;
 };
 
 static int add_packed_commits(const struct object_id *oid,
@@ -560,6 +563,9 @@ static int add_packed_commits(const struct object_id *oid,
 	off_t offset = nth_packed_object_offset(pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
+	if (list->progress)
+		display_progress(list->progress, ++list->progress_done);
+
 	oi.typep = &type;
 	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
@@ -591,8 +597,13 @@ static void close_reachable(struct packed_oid_list *oids)
 {
 	int i;
 	struct commit *commit;
+	struct progress *progress = NULL;
+	int j = 0;
 
+	progress = start_delayed_progress(
+		_("Annotating commits in commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
@@ -604,6 +615,7 @@ static void close_reachable(struct packed_oid_list *oids)
 	 * closure.
 	 */
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
@@ -611,19 +623,25 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 
 	for (i = 0; i < oids->nr; i++) {
+		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit)
 			commit->object.flags &= ~UNINTERESTING;
 	}
+	stop_progress(&progress);
 }
 
 static void compute_generation_numbers(struct packed_commit_list* commits)
 {
 	int i;
 	struct commit_list *list = NULL;
+	struct progress *progress = NULL;
 
+	progress = start_progress(
+		_("Computing commit graph generation numbers"), commits->nr);
 	for (i = 0; i < commits->nr; i++) {
+		display_progress(progress, i);
 		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
 		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
 			continue;
@@ -655,6 +673,8 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
 			}
 		}
 	}
+	display_progress(progress, i);
+	stop_progress(&progress);
 }
 
 static int add_ref_to_list(const char *refname,
@@ -692,9 +712,12 @@ void write_commit_graph(const char *obj_dir,
 	int num_chunks;
 	int num_extra_edges;
 	struct commit_list *parent;
+	struct progress *progress = NULL;
 
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
+	oids.progress = NULL;
+	oids.progress_done = 0;
 
 	if (append) {
 		prepare_commit_graph_one(the_repository, obj_dir);
@@ -721,6 +744,9 @@ void write_commit_graph(const char *obj_dir,
 		int dirlen;
 		strbuf_addf(&packname, "%s/pack/", obj_dir);
 		dirlen = packname.len;
+		oids.progress = start_delayed_progress(
+			_("Finding commits for commit graph"), 0);
+		oids.progress_done = 0;
 		for (i = 0; i < pack_indexes->nr; i++) {
 			struct packed_git *p;
 			strbuf_setlen(&packname, dirlen);
@@ -733,15 +759,19 @@ void write_commit_graph(const char *obj_dir,
 			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
 			close_pack(p);
 		}
+		stop_progress(&oids.progress);
 		strbuf_release(&packname);
 	}
 
 	if (commit_hex) {
+		progress = start_delayed_progress(
+			_("Finding commits for commit graph"), commit_hex->nr);
 		for (i = 0; i < commit_hex->nr; i++) {
 			const char *end;
 			struct object_id oid;
 			struct commit *result;
 
+			display_progress(progress, i);
 			if (commit_hex->items[i].string &&
 			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
 				continue;
@@ -754,10 +784,16 @@ void write_commit_graph(const char *obj_dir,
 				oids.nr++;
 			}
 		}
+		display_progress(progress, i);
+		stop_progress(&progress);
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		oids.progress = start_delayed_progress(
+			_("Finding commits for commit graph"), 0);
 		for_each_packed_object(add_packed_commits, &oids, 0);
+		stop_progress(&oids.progress);
+	}
 
 	close_reachable(&oids);
 
-- 
2.19.0.rc1.350.ge57e33dbd1

