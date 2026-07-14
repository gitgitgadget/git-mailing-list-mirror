Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DC30B50A
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052011; cv=none; b=WT2q3NJpOOidKq+iojqFKKGQ0GnP+QWSX/JinQQcrCC2GpbcYyzB8ubodLwVSxtk9Lo+EQMt2LUEukTSUDLRCrkBm3IjjT3d6E0iZs3RUnU+TWV+vSPRKXA9krOiGHTtRxCDdP2QM6BKRRlrlkynHPzDXE3qnP5AtxbUyqe5RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052011; c=relaxed/simple;
	bh=8vMQ0q9lIw5D8mGQMR3nxLF90sVa7GvgQZcPZLpHQuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V36PVDb4Z1PN2QjbnIx2K2aeEhxeQh/TlFZ8AO40itI42lPe/4es16dxT0H/Zak33pSuOZ/ZCpImMRtZ1FZMWr7ZKOMj/3zLKZRyvNWsYFJuLNtjR2q+9/7siU5Y/mOBYUXgY9UvswofAYPx2bSFdhl5TJJ145EtTpDdFg26z5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Nj6kj9Mo; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Nj6kj9Mo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=XSAGAXU89mMDWQMeFw6noVLhimMHDyXnRZw8h6Nouco=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nj6kj9MoIUdKNAP5MTxZdsrGCekKnajqjPTqbBkQIVDJaN8fLZckAsBP7pXB7kAg
	 9yzBfsp85g4ZSbEBhjlky7ig7Kd8xHWa/IyOwYpxIhvGxkJPvfuapTaL/COrqOZPs
	 ovVHtp76l9vrdGIODxhiIDWY98eMZhpK22r7kR/IbvO+fj8tGOBxTmABAARbsQ+f3
	 M/ykteVTKcCEYLC6r4hxgIhfGhhvBbBEDsv5mWZUubFL9DgTNBFU5sKOojDrtpNQg
	 ttZLT3eNsOHxdv927L/oOXPpKQJ6ypBiAMrtHht4wTpUyhe+s88Yh4uqI59k0Cpxo
	 UbHCbeGTeBP49W1r+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1wo30R1bAu-00EPTQ for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:07 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 5/5] use repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos
Date: Tue, 14 Jul 2026 19:59:56 +0200
Message-ID: <20260714175956.54601-6-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de>
References: <20260714175956.54601-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ylaVg/NQMV5yRX6GM7+nzJNFF4SpAW1dYNHBL2Oh6Cv9hZvHXk+
 vXn81SVu4g4mkHQdwx+m0q8wfU7SIEun4EqZDruYV1NB5oW6Qq61IokFIIXdrt6aO+rhcJU
 E5WBbY3/dsBmI1fzb7yv/fXl169Hy56ylXe5qhQZ25KGCRmh7UKe0linoZKTXlb3lf+vT4N
 IJtbvyeha3IrCa0q0Iw6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ms1pYkZ2O2g=;2T+pg72Dc/4wDYt5dt46WsO7wKP
 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
 peM6U77VqQEdHZl6l7eRZ

Apply the config setting core.sharedRepository from the repository at
hand instead of from the_repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 apply.c                   | 10 ++++++----
 builtin/difftool.c        |  2 +-
 builtin/gc.c              |  2 +-
 builtin/history.c         |  2 +-
 builtin/sparse-checkout.c |  3 ++-
 bundle.c                  |  4 ++--
 commit-graph.c            |  9 +++++----
 config.c                  |  4 ++--
 loose.c                   |  6 ++++--
 midx-write.c              |  7 ++++---
 odb/source-files.c        |  3 ++-
 refs/files-backend.c      | 10 ++++++----
 refs/packed-backend.c     |  7 +++----
 refs/packed-backend.h     |  2 +-
 repack-midx.c             |  3 ++-
 repository.c              |  2 +-
 rerere.c                  |  6 +++---
 17 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/apply.c b/apply.c
index 5e54453f79..ac1bfc7f85 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -4287,7 +4287,8 @@ static int build_fake_ancestor(struct apply_state *s=
tate, struct patch *list)
 		}
 	}
=20
-	hold_lock_file_for_update(&lock, state->fake_ancestor, LOCK_DIE_ON_ERROR=
);
+	repo_hold_lock_file_for_update(state->repo, &lock, state->fake_ancestor,
+				       LOCK_DIE_ON_ERROR);
 	res =3D write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
=20
@@ -4945,9 +4946,10 @@ static int apply_patch(struct apply_state *state,
 	state->update_index =3D (state->check_index || state->ita_only) && state=
->apply;
 	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
-			hold_lock_file_for_update(&state->lock_file,
-						  state->index_file,
-						  LOCK_DIE_ON_ERROR);
+			repo_hold_lock_file_for_update(state->repo,
+						       &state->lock_file,
+						       state->index_file,
+						       LOCK_DIE_ON_ERROR);
 		else
 			repo_hold_locked_index(state->repo, &state->lock_file,
 					       LOCK_DIE_ON_ERROR);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 26778f8515..99c01c92ef 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -636,7 +636,7 @@ static int run_dir_diff(struct repository *repo,
 			struct lock_file lock =3D LOCK_INIT;
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
-			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
+			if (repo_hold_lock_file_for_update(repo, &lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret =3D error("could not write %s", buf.buf);
 				goto finish;
diff --git a/builtin/gc.c b/builtin/gc.c
index d32af422af..7153a49aca 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1790,7 +1790,7 @@ static int maintenance_run_tasks(struct maintenance_=
run_opts *opts,
 	struct repository *r =3D the_repository;
 	char *lock_path =3D xstrfmt("%s/maintenance", r->objects->sources->path)=
;
=20
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0=
) {
 		/*
 		 * Another maintenance command is running.
 		 *
diff --git a/builtin/history.c b/builtin/history.c
index fd83de8265..7e5177bc0a 100644
=2D-- a/builtin/history.c
+++ b/builtin/history.c
@@ -764,7 +764,7 @@ static int write_ondisk_index(struct repository *repo,
=20
 	prime_cache_tree(repo, &index, tree);
=20
-	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
+	if (repo_hold_lock_file_for_update(repo, &lock, path, 0) < 0) {
 		ret =3D error_errno(_("unable to acquire index lock"));
 		goto out;
 	}
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0863d0fb46..cb4a037b77 100644
=2D-- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -341,7 +341,8 @@ static int write_patterns_and_update(struct repository=
 *repo,
 	if (safe_create_leading_directories(repo, sparse_filename))
 		die(_("failed to create directory for sparse-checkout file"));
=20
-	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
+	repo_hold_lock_file_for_update(repo, &lk, sparse_filename,
+				       LOCK_DIE_ON_ERROR);
=20
 	result =3D update_working_directory(repo, pl);
 	if (result) {
diff --git a/bundle.c b/bundle.c
index fd2db2c837..b64716f252 100644
=2D-- a/bundle.c
+++ b/bundle.c
@@ -519,8 +519,8 @@ int create_bundle(struct repository *r, const char *pa=
th,
 	if (bundle_to_stdout)
 		bundle_fd =3D 1;
 	else
-		bundle_fd =3D hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
+		bundle_fd =3D repo_hold_lock_file_for_update(r, &lock, path,
+							   LOCK_DIE_ON_ERROR);
=20
 	if (version =3D=3D -1)
 		version =3D min_version;
diff --git a/commit-graph.c b/commit-graph.c
index c6d9c5c740..1b073b367a 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -2122,8 +2122,8 @@ static int write_commit_graph_file(struct write_comm=
it_graph_context *ctx)
 	if (ctx->split) {
 		char *lock_name =3D get_commit_graph_chain_filename(ctx->odb_source);
=20
-		hold_lock_file_for_update_mode(&lk, lock_name,
-					       LOCK_DIE_ON_ERROR, 0444);
+		repo_hold_lock_file_for_update_mode(ctx->r, &lk, lock_name,
+						    LOCK_DIE_ON_ERROR, 0444);
 		free(lock_name);
=20
 		graph_layer =3D mks_tempfile_m(ctx->graph_name, 0444);
@@ -2141,8 +2141,9 @@ static int write_commit_graph_file(struct write_comm=
it_graph_context *ctx)
 		f =3D hashfd(ctx->r->hash_algo,
 			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
 	} else {
-		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
-					       LOCK_DIE_ON_ERROR, 0444);
+		repo_hold_lock_file_for_update_mode(ctx->r, &lk,
+						    ctx->graph_name,
+						    LOCK_DIE_ON_ERROR, 0444);
 		f =3D hashfd(ctx->r->hash_algo,
 			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
diff --git a/config.c b/config.c
index 6a0de86e3a..d29425ab8e 100644
=2D-- a/config.c
+++ b/config.c
@@ -3034,7 +3034,7 @@ int repo_config_set_multivar_in_file_gently(struct r=
epository *r,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd =3D hold_lock_file_for_update(&lock, config_filename, 0);
+	fd =3D repo_hold_lock_file_for_update(r, &lock, config_filename, 0);
 	if (fd < 0) {
 		error_errno(_("could not lock config file %s"), config_filename);
 		ret =3D CONFIG_NO_LOCK;
@@ -3379,7 +3379,7 @@ static int repo_config_copy_or_rename_section_in_fil=
e(
 	if (!config_filename)
 		config_filename =3D filename_buf =3D repo_git_path(r, "config");
=20
-	out_fd =3D hold_lock_file_for_update(&lock, config_filename, 0);
+	out_fd =3D repo_hold_lock_file_for_update(r, &lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret =3D error(_("could not lock config file %s"), config_filename);
 		goto out;
diff --git a/loose.c b/loose.c
index 0b626c1b85..a79cafd38a 100644
=2D-- a/loose.c
+++ b/loose.c
@@ -138,7 +138,8 @@ int repo_write_loose_object_map(struct repository *rep=
o)
 		return 0;
=20
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd =3D hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ER=
ROR, -1);
+	fd =3D repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
+						    LOCK_DIE_ON_ERROR, -1);
 	iter =3D kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) =
< 0)
 		goto errout;
@@ -180,7 +181,8 @@ static int write_one_object(struct odb_source_loose *l=
oose,
 	struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
=20
 	strbuf_addf(&path, "%s/loose-object-idx", loose->base.path);
-	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1=
);
+	repo_hold_lock_file_for_update_timeout(loose->base.odb->repo, &lock,
+					       path.buf, LOCK_DIE_ON_ERROR, -1);
=20
 	fd =3D open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
 	if (fd < 0)
diff --git a/midx-write.c b/midx-write.c
index 8c1837f6df..580724d21a 100644
=2D-- a/midx-write.c
+++ b/midx-write.c
@@ -1627,8 +1627,8 @@ static int write_midx_internal(struct write_midx_opt=
s *opts)
 			struct strbuf lock_name =3D STRBUF_INIT;
=20
 			get_midx_chain_filename(opts->source, &lock_name);
-			hold_lock_file_for_update(&lk, lock_name.buf,
-						  LOCK_DIE_ON_ERROR);
+			repo_hold_lock_file_for_update(r, &lk, lock_name.buf,
+						       LOCK_DIE_ON_ERROR);
 			strbuf_release(&lock_name);
 		}
=20
@@ -1647,7 +1647,8 @@ static int write_midx_internal(struct write_midx_opt=
s *opts)
 		f =3D hashfd(r->hash_algo, get_tempfile_fd(incr),
 			   get_tempfile_path(incr));
 	} else {
-		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
+		repo_hold_lock_file_for_update(r, &lk, midx_name.buf,
+					       LOCK_DIE_ON_ERROR);
 		f =3D hashfd(r->hash_algo, get_lock_file_fd(&lk),
 			   get_lock_file_path(&lk));
 	}
diff --git a/odb/source-files.c b/odb/source-files.c
index 6c8e935c75..db83a9745c 100644
=2D-- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -218,7 +218,8 @@ static int odb_source_files_write_alternate(struct odb=
_source *source,
 	int found =3D 0;
 	int ret;
=20
-	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR);
+	repo_hold_lock_file_for_update(source->odb->repo, &lock, path,
+				       LOCK_DIE_ON_ERROR);
 	out =3D fdopen_lock_file(&lock, "w");
 	if (!out) {
 		ret =3D error_errno(_("unable to fdopen alternates lockfile"));
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3df56c25c8..1953610c03 100644
=2D-- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -842,7 +842,7 @@ static enum ref_transaction_error lock_raw_ref(struct =
files_ref_store *refs,
 		goto error_return;
 	}
=20
-	if (hold_lock_file_for_update_timeout(
+	if (repo_hold_lock_file_for_update_timeout(refs->base.repo,
 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
 			    get_files_ref_lock_timeout_ms(transaction->ref_store->repo)) < 0) =
{
 		int myerr =3D errno;
@@ -1250,8 +1250,8 @@ struct create_reflock_cb {
 static int create_reflock(const char *path, void *cb)
 {
 	struct create_reflock_cb *data =3D cb;
-	return hold_lock_file_for_update_timeout(
-			data->lk, path, LOCK_NO_DEREF,
+	return repo_hold_lock_file_for_update_timeout(
+			data->repo, data->lk, path, LOCK_NO_DEREF,
 			get_files_ref_lock_timeout_ms(data->repo)) < 0 ? -1 : 0;
 }
=20
@@ -3581,7 +3581,9 @@ static int files_reflog_expire(struct ref_store *ref=
_store,
 		 * work we need, including cleaning up if the program
 		 * exits unexpectedly.
 		 */
-		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
+		if (repo_hold_lock_file_for_update(ref_store->repo,
+						   &reflog_lock, log_file,
+						   0) < 0) {
 			struct strbuf err =3D STRBUF_INIT;
 			unable_to_lock_message(log_file, errno, &err);
 			error("%s", err.buf);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7e65d9580e..0cfef881be 100644
=2D-- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1246,10 +1246,9 @@ int packed_refs_lock(struct ref_store *ref_store, i=
nt flags, struct strbuf *err)
 	 * don't write new content to it, but rather to a separate
 	 * tempfile.
 	 */
-	if (hold_lock_file_for_update_timeout(
-			    &refs->lock,
-			    refs->path,
-			    flags, timeout_value) < 0) {
+	if (repo_hold_lock_file_for_update_timeout(ref_store->repo, &refs->lock,
+						   refs->path, flags,
+						   timeout_value) < 0) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 1db48e801d..8a7b323825 100644
=2D-- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -21,7 +21,7 @@ struct ref_store *packed_ref_store_init(struct repositor=
y *repo,
=20
 /*
  * Lock the packed-refs file for writing. Flags is passed to
- * hold_lock_file_for_update(). Return 0 on success. On errors, write
+ * repo_hold_lock_file_for_update(). Return 0 on success. On errors, writ=
e
  * an error message to `err` and return a nonzero value.
  */
 int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbu=
f *err);
diff --git a/repack-midx.c b/repack-midx.c
index 7c7c3620e5..64c7f8d0f4 100644
=2D-- a/repack-midx.c
+++ b/repack-midx.c
@@ -954,7 +954,8 @@ static int write_midx_incremental(struct repack_write_=
midx_opts *opts)
 					    lock_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  lock_name.buf);
-	hold_lock_file_for_update(&lf, lock_name.buf, LOCK_DIE_ON_ERROR);
+	repo_hold_lock_file_for_update(opts->existing->repo, &lf, lock_name.buf,
+				       LOCK_DIE_ON_ERROR);
=20
 	if (!fdopen_lock_file(&lf, "w")) {
 		ret =3D error_errno(_("unable to open multi-pack-index chain file"));
diff --git a/repository.c b/repository.c
index 73d80bcffd..11fbc69781 100644
=2D-- a/repository.c
+++ b/repository.c
@@ -472,5 +472,5 @@ int repo_hold_locked_index(struct repository *repo,
 {
 	if (!repo->index_file)
 		BUG("the repo hasn't been setup");
-	return hold_lock_file_for_update(lf, repo->index_file, flags);
+	return repo_hold_lock_file_for_update(repo, lf, repo->index_file, flags)=
;
 }
diff --git a/rerere.c b/rerere.c
index 8232542585..2d1e99ec11 100644
=2D-- a/rerere.c
+++ b/rerere.c
@@ -911,9 +911,9 @@ int setup_rerere(struct repository *r, struct string_l=
ist *merge_rr, int flags)
 	if (flags & RERERE_READONLY)
 		fd =3D 0;
 	else
-		fd =3D hold_lock_file_for_update(&write_lock,
-					       git_path_merge_rr(r),
-					       LOCK_DIE_ON_ERROR);
+		fd =3D repo_hold_lock_file_for_update(r, &write_lock,
+						    git_path_merge_rr(r),
+						    LOCK_DIE_ON_ERROR);
 	read_rr(r, merge_rr);
 	return fd;
 }
=2D-=20
2.55.0

