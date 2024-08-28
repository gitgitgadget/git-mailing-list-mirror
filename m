Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111769D2B
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817470; cv=none; b=Z251aZRtYSqbLdjO1TT2+oPnUd/dELZdUoA5aJiKTzgBNRs8enj3jfzx7lEVx05i9lZvafCIw1WAl6PWNt//CletRbFgYFWVMkWgPznCqtC8/6/rq3uuVV1ucdNOYc9Tt9QndplwHIIUrPPZOfZUpemDT3EelAtBrUqjvrca2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817470; c=relaxed/simple;
	bh=R9VDqZDA+h+QAHnlF7JLyo3yprNoAtoQPlr0DQRDv58=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/QgM7t4xecbJ6QYB1rkHxOG5eIoovN0SM9971Ud06G2L86opswWKx6I7TNIDmEa3DBF3gnLgzkgUMq5M8F+I9ylYOCoQ9Xp5liMFDnsYig1oEkYXEZX5ApbRC4sWgyFRy+bO393afWeIbYwJJURo8V/qxwfMa9pm5TCfOGsNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20535 invoked by uid 109); 28 Aug 2024 03:57:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 03:57:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23048 invoked by uid 111); 28 Aug 2024 03:57:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2024 23:57:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Aug 2024 23:57:46 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/6] gc: mark unused config parameter in virtual functions
Message-ID: <20240828035746.GA3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

Commit d1ae15d68b (builtin/gc: refactor to read config into structure,
2024-08-16) added a new parameter to the maintenance_task virtual
functions, but most of them don't need to look at it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 427faf1cfe..0e361253e3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -967,7 +967,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 	return result;
 }
 
-static int should_write_commit_graph(struct gc_config *cfg)
+static int should_write_commit_graph(struct gc_config *cfg UNUSED)
 {
 	int result;
 	struct cg_auto_data data;
@@ -1005,7 +1005,7 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 }
 
 static int maintenance_task_commit_graph(struct maintenance_run_opts *opts,
-					 struct gc_config *cfg)
+					 struct gc_config *cfg UNUSED)
 {
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_commit_graph)
@@ -1040,7 +1040,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 }
 
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
-				     struct gc_config *cfg)
+				     struct gc_config *cfg UNUSED)
 {
 	if (for_each_remote(fetch_remote, opts)) {
 		error(_("failed to prefetch remotes"));
@@ -1051,7 +1051,7 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
 }
 
 static int maintenance_task_gc(struct maintenance_run_opts *opts,
-			       struct gc_config *cfg)
+			       struct gc_config *cfg UNUSED)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -1100,7 +1100,7 @@ static int loose_object_count(const struct object_id *oid UNUSED,
 	return 0;
 }
 
-static int loose_object_auto_condition(struct gc_config *cfg)
+static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 {
 	int count = 0;
 
@@ -1192,12 +1192,12 @@ static int pack_loose(struct maintenance_run_opts *opts)
 }
 
 static int maintenance_task_loose_objects(struct maintenance_run_opts *opts,
-					  struct gc_config *cfg)
+					  struct gc_config *cfg UNUSED)
 {
 	return prune_packed(opts) || pack_loose(opts);
 }
 
-static int incremental_repack_auto_condition(struct gc_config *cfg)
+static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 {
 	struct packed_git *p;
 	int incremental_repack_auto_limit = 10;
@@ -1317,7 +1317,7 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 }
 
 static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts,
-					       struct gc_config *cfg)
+					       struct gc_config *cfg UNUSED)
 {
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_multi_pack_index) {
-- 
2.46.0.754.g24c813f009

