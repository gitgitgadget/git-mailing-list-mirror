Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685361F731
	for <e@80x24.org>; Mon,  5 Aug 2019 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEIC5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 04:02:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32981 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfHEIC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 04:02:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so83503557wru.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cybeV+wWQq1wmuDRiQPJusqEeu/cR0dlOT0ya2Ji4e0=;
        b=C9m/G+nOa+FjkiTW/1056TO5eEKMhdCUjTq/0hboaw3lgVwoUc/FkX7B714/DFoo2d
         OKjv/jcya75LMQ7HLWl1wzbIrTpmXzKC1oJwOHtcH0nUPtqMKQUjckkhyaS21ZLycUVc
         /QooXZNaXaJVjSgT1XqOtaOB2P07d6ZRkzEV3kH2K8RihLWywpUu36YUnC9VOMZxjQR8
         3GFLWT/v8hv+L8n6CVTWVx/fa9VsXgonveXaksB5cF0GoCw1XTbyhJ5w/Pz+93RSAAN7
         /JzK6DS8WbMPCP1yCA9Cv0jy82QOjZEXVQTrR2JNby70pcOvG9Y2bQY2LLKrj3/35LmP
         CrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cybeV+wWQq1wmuDRiQPJusqEeu/cR0dlOT0ya2Ji4e0=;
        b=Oh1QevMPLA42GgQa20bYZp1pP8jMND6MgzNbmFyGF4X0QGehpPmkFY8kdPtxx7e4/c
         5RQ0H/l7WZg/rKY/3BZWHQXsSHsGNXm5ftd6vJrUZ3pHy54x+N2BA//424KrsKUyTihj
         WoURw3ndOLivUwD65JpCb8BbSQNz+4V54QrQKizxT2VFPlr0BUykAiqzuFj7laUDXs0J
         5y1C84T2FNlCLZAjJVU4wALtnMlsSMGERx00lnVXFkv06iPMowEB5X5f5eHFC0pVBzGJ
         oSWV+2jeX5FEOnRVV/eUS98jMVmokCJHl0sAHKOAMYr7nysOha5H9nHFfAGykkyamCND
         BNMA==
X-Gm-Message-State: APjAAAUEGWSp/1mZ1Q03SS6gdhVlAXXe6wXwQEPA4aCO66ypMoeF75zF
        GKIlhf5MUUN+fZ8ICiCUiZQ=
X-Google-Smtp-Source: APXvYqxDeq3IKH7ZW1h5X7HxC7wq1davL5v1WmeGF+/EqekUJDYIAPKrpfXy3z521AcSzJfk5MQjng==
X-Received: by 2002:adf:f544:: with SMTP id j4mr56640863wrp.150.1564992174111;
        Mon, 05 Aug 2019 01:02:54 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id v124sm89514573wmf.23.2019.08.05.01.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 01:02:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] commit-graph: error out on invalid commit oids in 'write --stdin-commits'
Date:   Mon,  5 Aug 2019 10:02:40 +0200
Message-Id: <20190805080240.30892-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190805080240.30892-1-szeder.dev@gmail.com>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While 'git commit-graph write --stdin-commits' expects commit object
ids as input, it accepts and silently skips over any invalid commit
object ids, and still exits with success:

  # nonsense
  $ echo not-a-commit-oid | git commit-graph write --stdin-commits
  $ echo $?
  0
  # sometimes I forgot that refs are not good...
  $ echo HEAD | git commit-graph write --stdin-commits
  $ echo $?
  0
  # valid tree OID, but not a commit OID
  $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
  $ echo $?
  0
  $ ls -l .git/objects/info/commit-graph
  ls: cannot access '.git/objects/info/commit-graph': No such file or directory

Check that all input records are indeed valid commit object ids and
return with error otherwise, the same way '--stdin-packs' handles
invalid input; see e103f7276f (commit-graph: return with errors during
write, 2019-06-12).

Note that it should only return with error when encountering an
invalid commit object id coming from standard input.  However,
'--reachable' uses the same code path to process object ids pointed to
by all refs, and that includes tag object ids as well, which should
still be skipped over.  Therefore add a new flag to 'enum
commit_graph_write_flags' and a corresponding field to 'struct
write_commit_graph_context', so we can differentiate between those two
cases.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c  |  4 +++-
 commit-graph.c          | 29 +++++++++++++++++------------
 commit-graph.h          |  4 +++-
 t/t5318-commit-graph.sh | 11 ++++++++++-
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 64eccde314..57863619b7 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -213,8 +213,10 @@ static int graph_write(int argc, const char **argv)
 
 		if (opts.stdin_packs)
 			pack_indexes = &lines;
-		if (opts.stdin_commits)
+		if (opts.stdin_commits) {
 			commit_hex = &lines;
+			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+		}
 
 		UNLEAK(buf);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 04324a4648..821900675b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -782,7 +782,8 @@ struct write_commit_graph_context {
 
 	unsigned append:1,
 		 report_progress:1,
-		 split:1;
+		 split:1,
+		 check_oids:1;
 
 	const struct split_commit_graph_opts *split_opts;
 };
@@ -1193,8 +1194,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	return 0;
 }
 
-static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
-				      struct string_list *commit_hex)
+static int fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
+				     struct string_list *commit_hex)
 {
 	uint32_t i;
 	struct strbuf progress_title = STRBUF_INIT;
@@ -1215,20 +1216,21 @@ static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
 		struct commit *result;
 
 		display_progress(ctx->progress, i + 1);
-		if (commit_hex->items[i].string &&
-		    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
-			continue;
-
-		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
-
-		if (result) {
+		if (!parse_oid_hex(commit_hex->items[i].string, &oid, &end) &&
+		    (result = lookup_commit_reference_gently(ctx->r, &oid, 1))) {
 			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
 			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
 			ctx->oids.nr++;
+		} else if (ctx->check_oids) {
+			error(_("invalid commit object id: %s"),
+			    commit_hex->items[i].string);
+			return -1;
 		}
 	}
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
+
+	return 0;
 }
 
 static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
@@ -1775,6 +1777,7 @@ int write_commit_graph(const char *obj_dir,
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
+	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
 
 	if (ctx->split) {
@@ -1829,8 +1832,10 @@ int write_commit_graph(const char *obj_dir,
 			goto cleanup;
 	}
 
-	if (commit_hex)
-		fill_oids_from_commit_hex(ctx, commit_hex);
+	if (commit_hex) {
+		if ((res = fill_oids_from_commit_hex(ctx, commit_hex)))
+			goto cleanup;
+	}
 
 	if (!pack_indexes && !commit_hex)
 		fill_oids_from_all_packs(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index ae4db87fb5..486e64e591 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -74,7 +74,9 @@ int generation_numbers_enabled(struct repository *r);
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
-	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2)
+	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
+	/* Make sure that each OID in the input is a valid commit OID. */
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
 };
 
 struct split_commit_graph_opts {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4391007f4c..ab3eccf0fa 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -23,7 +23,7 @@ test_expect_success 'write graph with no packs' '
 	test_path_is_missing info/commit-graph
 '
 
-test_expect_success 'close with correct error on bad input' '
+test_expect_success 'exit with correct error on bad input to --stdin-packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	echo doesnotexist >in &&
 	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
@@ -40,6 +40,15 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
+test_expect_success 'exit with correct error on bad input to --stdin-commits' '
+	cd "$TRASH_DIRECTORY/full" &&
+	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "invalid commit object id" stderr &&
+	# valid tree OID, but not a commit OID
+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "invalid commit object id" stderr
+'
+
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
-- 
2.23.0.rc1.309.g896d8c5f5f

