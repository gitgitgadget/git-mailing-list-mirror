From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/15] Add tracing to measure where most of the time is spent
Date: Wed, 20 Apr 2016 16:59:54 +0700
Message-ID: <1461146394-5135-1-git-send-email-pclouds@gmail.com>
References: <1461108489-29376-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 12:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asovU-0004es-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 12:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626AbcDTJ77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 05:59:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36296 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077AbcDTJ74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 05:59:56 -0400
Received: by mail-pa0-f48.google.com with SMTP id er2so16415437pad.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vf6RjTBh/uVAY1IclMVuNqNgvjn7/l9fCqYVkSo8Zf4=;
        b=iZ6Lnp+lxgBn8v/30jHtR/YfANx2rZ3TrRC/D+NR/PqGDvVP4uljo7RPl7y2gazCpQ
         9QaAFDDAE2sJ9rUQ/WFnGUDGfvgnhrcKupu+qRHz3FTBwA2zRqCpy4leZ5Tn96kKA+gH
         QSqLiJeP4IDcLKaqpK+lbEnaTQQVVmttAl4T2yUHq31c7Rl5NBWlufNLAf/79fTeU1M3
         3bnudML2SoXPayXwepT/HEbuWu67bLYf03yMAlLPq6PIll0e1ChH4NXkT+SHxfCa6fgv
         A/+pcy+0ZT6SsHxns3hOW0K2f9i1JK/SE6u9iLWW+MrIbstwR0OusQVObSDYnpMTeosR
         yk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vf6RjTBh/uVAY1IclMVuNqNgvjn7/l9fCqYVkSo8Zf4=;
        b=ORcb9JhYnUE0WVBZGKYWY2iVWoXXLvby3wOURSSYE2ar8Ily42lHWHy3XKVig69QNM
         nouK3YECAkP071oX3cCa+P6FA10IgMgEryaV0FT3HJ3i3a3V+X0ZavgLhoRlH3/7e6Kp
         S6OMxO6JrkXS5mgzIuHTyiOWR7ktwYOrYJI4nZFETHNJMb4/q5evhSVdeQQsnPIf/lDs
         E9u4ImYfFAAo9fKPVoJPil0KyO8SuwIH5OYdYAdX3A/5qF14eIkGxk7kolrVeCnL7OOa
         6hXCBY2OlEPnGww8KKSHk1BrEief5cLrhOe2Szl1d5Qkrhuo6+WTbm3qEb6ZEHz5UdiR
         YTuA==
X-Gm-Message-State: AOPr4FVvMMMKdK3wU7qKKZq1JwtKVIhTMq13BfFV9d3CT9cE8YH2gGjjwl84agpPeXsU9g==
X-Received: by 10.67.4.69 with SMTP id cc5mr10984392pad.11.1461146395693;
        Wed, 20 Apr 2016 02:59:55 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id d2sm57030340pfd.80.2016.04.20.02.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 02:59:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 17:00:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461108489-29376-16-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292001>

All the known heavy code blocks are measured (except object database
access). This should help identify if an optimization is effective or
not. An unoptimized git-status would give something like below (92% of
time is accounted). To sum up the effort of making git scale better:

 - read cache line is being addressed by index-helper
 - preload/refresh index by watchman
 - read packed refs by lmdb backend
 - diff-index by rebuilding cache-tree
 - read directory by untracked cache and watchman
 - write index by split index
 - name hash potientially by index-helper

read-cache.c:2075         performance: 0.004058570 s: read cache .../in=
dex
preload-index.c:104       performance: 0.004419864 s: preload index
read-cache.c:1265         performance: 0.000185224 s: refresh index
refs/files-backend.c:1100 performance: 0.001935788 s: read packed refs
diff-lib.c:240            performance: 0.000144132 s: diff-files
diff-lib.c:506            performance: 0.013592000 s: diff-index
name-hash.c:128           performance: 0.000614177 s: initialize name h=
ash
dir.c:2030                performance: 0.015814103 s: read directory
read-cache.c:2565         performance: 0.004052343 s: write index, chan=
ged mask =3D 2
trace.c:420               performance: 0.048365509 s: git command: './g=
it' 'status'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is worth merging, I think.

 diff-lib.c           |  4 ++++
 dir.c                |  2 ++
 name-hash.c          |  2 ++
 preload-index.c      |  2 ++
 read-cache.c         | 11 +++++++++++
 refs/files-backend.c |  2 ++
 6 files changed, 23 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index bc49c70..7af7f9a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -90,6 +90,7 @@ int run_diff_files(struct rev_info *revs, unsigned in=
t option)
 	int diff_unmerged_stage =3D revs->max_count;
 	unsigned ce_option =3D ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
+	uint64_t start =3D getnanotime();
=20
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
=20
@@ -236,6 +237,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 	}
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-files");
 	return 0;
 }
=20
@@ -491,6 +493,7 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
+	uint64_t start =3D getnanotime();
=20
 	ent =3D revs->pending.objects;
 	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
@@ -500,6 +503,7 @@ int run_diff_index(struct rev_info *revs, int cache=
d)
 	diffcore_fix_diff_index(&revs->diffopt);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
+	trace_performance_since(start, "diff-index");
 	return 0;
 }
=20
diff --git a/dir.c b/dir.c
index 91003e5..1ebf9fe 100644
--- a/dir.c
+++ b/dir.c
@@ -1991,6 +1991,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 {
 	struct path_simplify *simplify;
 	struct untracked_cache_dir *untracked;
+	uint64_t start =3D getnanotime();
=20
 	/*
 	 * Check out create_simplify()
@@ -2026,6 +2027,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	trace_performance_since(start, "read directory %.*s", len, path);
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/name-hash.c b/name-hash.c
index 6d9f23e..b3966d8 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -115,6 +115,7 @@ static int cache_entry_cmp(const struct cache_entry=
 *ce1,
 static void lazy_init_name_hash(struct index_state *istate)
 {
 	int nr;
+	uint64_t start =3D getnanotime();
=20
 	if (istate->name_hash_initialized)
 		return;
@@ -124,6 +125,7 @@ static void lazy_init_name_hash(struct index_state =
*istate)
 	for (nr =3D 0; nr < istate->cache_nr; nr++)
 		hash_index_entry(istate, istate->cache[nr]);
 	istate->name_hash_initialized =3D 1;
+	trace_performance_since(start, "initialize name hash");
 }
=20
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
diff --git a/preload-index.c b/preload-index.c
index c1fe3a3..7bb4809 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -72,6 +72,7 @@ static void preload_index(struct index_state *index,
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
+	uint64_t start =3D getnanotime();
=20
 	if (!core_preload_index)
 		return;
@@ -100,6 +101,7 @@ static void preload_index(struct index_state *index=
,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	trace_performance_since(start, "preload index");
 }
 #endif
=20
diff --git a/read-cache.c b/read-cache.c
index a73487e..3a79581 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1187,6 +1187,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
+	uint64_t start =3D getnanotime();
=20
 	modified_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
@@ -1261,6 +1262,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
=20
 		replace_index_entry(istate, i, new);
 	}
+	trace_performance_since(start, "refresh index");
 	return has_errors;
 }
=20
@@ -2062,12 +2064,15 @@ int read_index_from(struct index_state *istate,=
 const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	uint64_t start;
=20
 	/* istate->initialized covers both .git/index and .git/sharedindex.xx=
x */
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	start =3D getnanotime();
 	ret =3D do_read_index(istate, path, 0);
+	trace_performance_since(start, "read cache %s", path);
=20
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
@@ -2082,6 +2087,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index->base->keep_mmap =3D istate->keep_mmap;
 	split_index->base->to_shm    =3D istate->to_shm;
 	split_index->base->from_shm  =3D istate->from_shm;
+	start =3D getnanotime();
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -2093,6 +2099,9 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	post_read_index_from(istate);
+	trace_performance_since(start, "read cache %s",
+				git_path("sharedindex.%s",
+					 sha1_to_hex(split_index->base_sha1)));
=20
 done:
 	if (ret > 0 && istate->from_shm && istate->last_update)
@@ -2437,6 +2446,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 	int entries =3D istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	uint64_t start =3D getnanotime();
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2552,6 +2562,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd,
 		return -1;
 	istate->timestamp.sec =3D (unsigned int)st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
+	trace_performance_since(start, "write index, changed mask =3D %x", is=
tate->cache_changed);
 	return 0;
 }
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ea78ce9..b88913f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1048,6 +1048,7 @@ static void read_packed_refs(FILE *f, struct ref_=
dir *dir)
 	struct ref_entry *last =3D NULL;
 	struct strbuf line =3D STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled =3D PEELED_NON=
E;
+	uint64_t start =3D getnanotime();
=20
 	while (strbuf_getwholeline(&line, f, '\n') !=3D EOF) {
 		unsigned char sha1[20];
@@ -1096,6 +1097,7 @@ static void read_packed_refs(FILE *f, struct ref_=
dir *dir)
 	}
=20
 	strbuf_release(&line);
+	trace_performance_since(start, "read packed refs");
 }
=20
 /*
--=20
2.8.0.rc0.210.gd302cd2
