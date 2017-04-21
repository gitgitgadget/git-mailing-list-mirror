Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3B31FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037770AbdDUKqA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:46:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:55640 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037715AbdDUKpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:45:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXEs5-1cXSjS1RXJ-00WHQ8; Fri, 21
 Apr 2017 12:45:51 +0200
Date:   Fri, 21 Apr 2017 12:45:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 6/9] Introduce a new data type for timestamps
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <e4650b9bea37ddce5b044cd80ffa319ffa2acd1b.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ev2ERbF5M2tcIHCElfoEuCaVR3GaOaZ4SpspIn87k37E1RENcfj
 QIRPK2MLO+PbZkgDB8HF2ZgetU2DC5d0ulQrNFcWB+LgIIv06fE4AplbwtGBamObKOG53y1
 eLV3ll/Y9UGF45c5p0BfSvRxlMYx+uWNGnvgfE9YkT1AxMKAd2yXNwba4OHTVYc663Drwxa
 uAtCmLNlhAGjE0Ec9bxoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jHpRmZ9bTy0=:eaqW2sx5CjFTlavvnWP2Su
 IWtOILPZGq+r7TJsTY8amWQtsk+4Q8i8sprXD1tfU1R1g/1sLOUh8K3PlDwL1Cv7kcuz04V/p
 gbrT+hW/YOpiuRjZTvlEJmSToeG9qqTSU2KOfJh1Bvf211/IqvpeU9L2CN8aBXeGgItz5c4XA
 BBe3+j/Dffn6BSJRBreylQgs0XmwbdMQSs91dWcz7r4ukzLFDMi59GTYFIyS9qa8iwY84iDTQ
 JjodKSFHbCX+/aT+qJ7I8Hqm13Qoc1SMqRiulbyttbK8N8yUCeNSp1eb/mqIo9E83FbXQnH3k
 iOwOy907htShd0MSXic+IFIjYrNcHL+bBlehIcQStbqHOTiijxlLvZDFB9J/bY0mM5dkGgeLY
 XOfgN/+h//daZK6Hzg/De+scERGTVrlfcNoIsTcJROxJ+1ZZinWmLicMwBxM/nh2+RKPl1Hm4
 m9B0ZkgJeLgBbsTOqNRMStXLIOi3PZ1iuiF3xqU/CRdY1jPSJeDz/B84FUjOuGHX+00r+Oy8R
 WlxJLahdrkAWob2Ukxwk9614CixgETz2GPgTmlnyZUy/j9tNZmfbZyXWdD3j1n0VhYFMMCG6D
 Go40ItLA5ALGlNbRB7MilAcQozy8RUdfPpjaXPnNv+C35XOMIy1+dBQuOHYIIoHkZSHJhFlEE
 Paujzobk1SRcoQXwKZ19S8Smgh03KAg6/kkhwDlYDgprx6TPclMEvcCZtAEkqSvj+BjgGPFRA
 2V/gw3V1LpYvPTV4gwTsxkQQa0s/0u3MdsU9SxTGjiruaaTaeSzaDMwruhuiQrYXEjKQbfwyb
 TQukcm0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code assumes that unsigned long is at least as precise as
time_t. Which is incorrect, and causes a lot of problems, in particular
where unsigned long is only 32-bit (notably on Windows, even in 64-bit
versions).

So let's just use a more appropriate data type instead. In preparation
for this, we introduce the new `timestamp_t` data type.

By necessity, this is a very, very large patch, as it has to replace all
timestamps' data type in one go.

As we will use a data type that is not necessarily identical to `time_t`,
we need to be very careful to use `time_t` whenever we interact with the
system functions, and `timestamp_t` everywhere else.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-parse-options.txt |  8 ++--
 archive-tar.c                                 |  5 +-
 archive-zip.c                                 | 12 ++++-
 archive.h                                     |  2 +-
 builtin/am.c                                  |  2 +-
 builtin/blame.c                               |  8 ++--
 builtin/fsck.c                                |  4 +-
 builtin/gc.c                                  |  2 +-
 builtin/log.c                                 |  2 +-
 builtin/merge-base.c                          |  2 +-
 builtin/name-rev.c                            |  6 +--
 builtin/pack-objects.c                        |  4 +-
 builtin/prune.c                               |  4 +-
 builtin/receive-pack.c                        |  6 +--
 builtin/reflog.c                              | 24 +++++-----
 builtin/show-branch.c                         |  4 +-
 builtin/worktree.c                            |  4 +-
 bundle.c                                      |  2 +-
 cache.h                                       | 14 +++---
 commit.c                                      | 12 ++---
 commit.h                                      |  2 +-
 config.c                                      |  2 +-
 credential-cache--daemon.c                    | 12 ++---
 date.c                                        | 66 +++++++++++++--------------
 fetch-pack.c                                  |  6 +--
 git-compat-util.h                             |  2 +
 http-backend.c                                |  4 +-
 parse-options-cb.c                            |  4 +-
 pretty.c                                      |  2 +-
 reachable.c                                   |  9 ++--
 reachable.h                                   |  4 +-
 ref-filter.c                                  |  4 +-
 reflog-walk.c                                 |  8 ++--
 refs.c                                        | 14 +++---
 refs.h                                        |  8 ++--
 refs/files-backend.c                          |  4 +-
 revision.c                                    |  6 +--
 revision.h                                    |  4 +-
 sha1_name.c                                   |  6 +--
 t/helper/test-date.c                          |  8 ++--
 t/helper/test-parse-options.c                 |  2 +-
 t/helper/test-ref-store.c                     |  2 +-
 tag.c                                         |  2 +-
 tag.h                                         |  2 +-
 upload-pack.c                                 |  4 +-
 vcs-svn/fast_export.c                         |  4 +-
 vcs-svn/fast_export.h                         |  4 +-
 vcs-svn/svndump.c                             |  2 +-
 wt-status.c                                   |  2 +-
 49 files changed, 169 insertions(+), 157 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 36768b479e1..829b5581105 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -183,13 +183,13 @@ There are some macros to easily define options:
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `unsigned_long_var`.
 
-`OPT_DATE(short, long, &int_var, description)`::
+`OPT_DATE(short, long, &timestamp_t_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
-	The timestamp is put into `int_var`.
+	The timestamp is put into `timestamp_t_var`.
 
-`OPT_EXPIRY_DATE(short, long, &int_var, description)`::
+`OPT_EXPIRY_DATE(short, long, &timestamp_t_var, description)`::
 	Introduce an option with expiry date argument, see `parse_expiry_date()`.
-	The timestamp is put into `int_var`.
+	The timestamp is put into `timestamp_t_var`.
 
 `OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
 	Introduce an option with argument.
diff --git a/archive-tar.c b/archive-tar.c
index 380e3aedd23..695339a2369 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -27,9 +27,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
  */
 #if ULONG_MAX == 0xFFFFFFFF
 #define USTAR_MAX_SIZE ULONG_MAX
-#define USTAR_MAX_MTIME ULONG_MAX
 #else
 #define USTAR_MAX_SIZE 077777777777UL
+#endif
+#if TIME_MAX == 0xFFFFFFFF
+#define USTAR_MAX_MTIME TIME_MAX
+#else
 #define USTAR_MAX_MTIME 077777777777UL
 #endif
 
diff --git a/archive-zip.c b/archive-zip.c
index b429a8d974a..68df3d64402 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -545,9 +545,17 @@ static void write_zip_trailer(const unsigned char *sha1)
 		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
 }
 
-static void dos_time(time_t *time, int *dos_date, int *dos_time)
+static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 {
-	struct tm *t = localtime(time);
+	time_t time;
+	struct tm *t;
+
+	if (date_overflows(*timestamp))
+		die("timestamp too large for this system: %"PRItime,
+		    *timestamp);
+	time = (time_t)*timestamp;
+	t = localtime(&time);
+	*timestamp = time;
 
 	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
 	            (t->tm_year + 1900 - 1980) * 512;
diff --git a/archive.h b/archive.h
index 415e0152e2c..62d1d82c1af 100644
--- a/archive.h
+++ b/archive.h
@@ -9,7 +9,7 @@ struct archiver_args {
 	struct tree *tree;
 	const unsigned char *commit_sha1;
 	const struct commit *commit;
-	time_t time;
+	timestamp_t time;
 	struct pathspec pathspec;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
diff --git a/builtin/am.c b/builtin/am.c
index 2c93adc69c3..89914ed8757 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -877,7 +877,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 		if (skip_prefix(sb.buf, "# User ", &str))
 			fprintf(out, "From: %s\n", str);
 		else if (skip_prefix(sb.buf, "# Date ", &str)) {
-			unsigned long timestamp;
+			timestamp_t timestamp;
 			long tz, tz2;
 			char *end;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index e4b3c7b0ebf..f00eda16378 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1561,13 +1561,13 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 struct commit_info {
 	struct strbuf author;
 	struct strbuf author_mail;
-	unsigned long author_time;
+	timestamp_t author_time;
 	struct strbuf author_tz;
 
 	/* filled only when asked for details */
 	struct strbuf committer;
 	struct strbuf committer_mail;
-	unsigned long committer_time;
+	timestamp_t committer_time;
 	struct strbuf committer_tz;
 
 	struct strbuf summary;
@@ -1578,7 +1578,7 @@ struct commit_info {
  */
 static void get_ac_line(const char *inbuf, const char *what,
 	struct strbuf *name, struct strbuf *mail,
-	unsigned long *time, struct strbuf *tz)
+	timestamp_t *time, struct strbuf *tz)
 {
 	struct ident_split ident;
 	size_t len, maillen, namelen;
@@ -1837,7 +1837,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	stop_progress(&pi.progress);
 }
 
-static const char *format_time(unsigned long time, const char *tz_str,
+static const char *format_time(timestamp_t time, const char *tz_str,
 			       int show_raw_time)
 {
 	static struct strbuf time_buf = STRBUF_INIT;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index af7b985c6eb..ea3a9f8a70a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -397,7 +397,7 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 static int default_refs;
 
 static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
-	unsigned long timestamp)
+	timestamp_t timestamp)
 {
 	struct object *obj;
 
@@ -418,7 +418,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 }
 
 static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	const char *refname = cb_data;
diff --git a/builtin/gc.c b/builtin/gc.c
index 2daede78205..cb1e20aae4a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,7 +33,7 @@ static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
-static unsigned long gc_log_expire_time;
+static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
diff --git a/builtin/log.c b/builtin/log.c
index f93ef6c7100..fd3d10ec217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -911,7 +911,7 @@ static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
-		    (unsigned long) time(NULL),
+		    (timestamp_t) time(NULL),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
 }
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index cfe2a796f85..8ed96391c1d 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -132,7 +132,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 }
 
 static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *ident, unsigned long timestamp,
+				  const char *ident, timestamp_t timestamp,
 				  int tz, const char *message, void *cbdata)
 {
 	struct rev_collect *revs = cbdata;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d26..44374750170 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -10,7 +10,7 @@
 
 typedef struct rev_name {
 	const char *tip_name;
-	unsigned long taggerdate;
+	timestamp_t taggerdate;
 	int generation;
 	int distance;
 } rev_name;
@@ -21,7 +21,7 @@ static long cutoff = LONG_MAX;
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
 static void name_rev(struct commit *commit,
-		const char *tip_name, unsigned long taggerdate,
+		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance,
 		int deref)
 {
@@ -146,7 +146,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
-	unsigned long taggerdate = ULONG_MAX;
+	timestamp_t taggerdate = TIME_MAX;
 
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fe35d1b5ae..9b4ba8a80d7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,7 +44,7 @@ static uint32_t nr_result, nr_written;
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
-static unsigned long unpack_unreachable_expiration;
+static timestamp_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int local;
 static int have_non_local_packs;
@@ -2675,7 +2675,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 static struct oid_array recent_objects;
 
 static int loosened_object_can_be_discarded(const struct object_id *oid,
-					    unsigned long mtime)
+					    timestamp_t mtime)
 {
 	if (!unpack_unreachable_expiration)
 		return 0;
diff --git a/builtin/prune.c b/builtin/prune.c
index 42633e0c6e6..8dcfecde0f3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
 };
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static timestamp_t expire;
 static int show_progress = -1;
 
 static int prune_tmp_file(const char *fullpath)
@@ -111,7 +111,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	};
 	char *s;
 
-	expire = ULONG_MAX;
+	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	check_replace_refs = 0;
 	ref_paranoia = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c49333c9b66..b4e22f44497 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -78,7 +78,7 @@ static const char *NONCE_OK = "OK";
 static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
-static unsigned long nonce_stamp_slop_limit;
+static timestamp_t nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
 static enum {
@@ -454,7 +454,7 @@ static void hmac_sha1(unsigned char *out,
 	git_SHA1_Final(out, &ctx);
 }
 
-static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
+static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
@@ -496,7 +496,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
 static const char *check_nonce(const char *buf, size_t len)
 {
 	char *nonce = find_header(buf, len, "nonce");
-	unsigned long stamp, ostamp;
+	timestamp_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 74727757785..4228d9ff4db 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -16,14 +16,14 @@ static const char reflog_delete_usage[] =
 static const char reflog_exists_usage[] =
 "git reflog exists <ref>";
 
-static unsigned long default_reflog_expire;
-static unsigned long default_reflog_expire_unreachable;
+static timestamp_t default_reflog_expire;
+static timestamp_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	timestamp_t expire_total;
+	timestamp_t expire_unreachable;
 	int recno;
 };
 
@@ -219,7 +219,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 static void mark_reachable(struct expire_reflog_policy_cb *cb)
 {
 	struct commit_list *pending;
-	unsigned long expire_limit = cb->mark_limit;
+	timestamp_t expire_limit = cb->mark_limit;
 	struct commit_list *leftover = NULL;
 
 	for (pending = cb->mark_list; pending; pending = pending->next)
@@ -284,7 +284,7 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-				    const char *email, unsigned long timestamp, int tz,
+				    const char *email, timestamp_t timestamp, int tz,
 				    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
@@ -392,8 +392,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 
 static struct reflog_expire_cfg {
 	struct reflog_expire_cfg *next;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	timestamp_t expire_total;
+	timestamp_t expire_unreachable;
 	char pattern[FLEX_ARRAY];
 } *reflog_expire_cfg, **reflog_expire_cfg_tail;
 
@@ -415,7 +415,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
+static int parse_expire_cfg_value(const char *var, const char *value, timestamp_t *expire)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -433,7 +433,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	const char *pattern, *key;
 	int pattern_len;
-	unsigned long expire;
+	timestamp_t expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
 
@@ -515,7 +515,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
-	unsigned long now = time(NULL);
+	timestamp_t now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
@@ -616,7 +616,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 19756595d57..8860f429b06 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -735,7 +735,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			base = strtoul(reflog_base, &ep, 10);
 			if (*ep) {
 				/* Ah, that is a date spec... */
-				unsigned long at;
+				timestamp_t at;
 				at = approxidate(reflog_base);
 				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
 					    NULL, NULL, &base);
@@ -746,7 +746,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
-			unsigned long timestamp;
+			timestamp_t timestamp;
 			int tz;
 
 			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9993ded41aa..74f9b18d40c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -30,7 +30,7 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static timestamp_t expire;
 
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
@@ -131,7 +131,7 @@ static int prune(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	expire = ULONG_MAX;
+	expire = TIME_MAX;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
diff --git a/bundle.c b/bundle.c
index f43bfcf5ff3..05e014fc5ab 100644
--- a/bundle.c
+++ b/bundle.c
@@ -211,7 +211,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	unsigned long size;
 	enum object_type type;
 	char *buf = NULL, *line, *lineend;
-	unsigned long date;
+	timestamp_t date;
 	int result = 1;
 
 	if (revs->max_age == -1 && revs->min_age == -1)
diff --git a/cache.h b/cache.h
index ba27595d54d..f3a02993b20 100644
--- a/cache.h
+++ b/cache.h
@@ -1476,18 +1476,18 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
-const char *show_date(unsigned long time, int timezone, const struct date_mode *mode);
-void show_date_relative(unsigned long time, int tz, const struct timeval *now,
+const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
+void show_date_relative(timestamp_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
-int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
-int parse_expiry_date(const char *date, unsigned long *timestamp);
+int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
+int parse_expiry_date(const char *date, timestamp_t *timestamp);
 void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
-unsigned long approxidate_careful(const char *, int *);
-unsigned long approxidate_relative(const char *date, const struct timeval *now);
+timestamp_t approxidate_careful(const char *, int *);
+timestamp_t approxidate_relative(const char *date, const struct timeval *now);
 void parse_date_format(const char *format, struct date_mode *mode);
-int date_overflows(unsigned long date);
+int date_overflows(timestamp_t date);
 
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
diff --git a/commit.c b/commit.c
index 0d2d0fa1984..99a62b90ee2 100644
--- a/commit.c
+++ b/commit.c
@@ -66,7 +66,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	return commit;
 }
 
-static unsigned long parse_commit_date(const char *buf, const char *tail)
+static timestamp_t parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
 
@@ -473,8 +473,8 @@ struct commit_list * commit_list_insert_by_date(struct commit *item, struct comm
 
 static int commit_list_compare_by_date(const void *a, const void *b)
 {
-	unsigned long a_date = ((const struct commit_list *)a)->item->date;
-	unsigned long b_date = ((const struct commit_list *)b)->item->date;
+	timestamp_t a_date = ((const struct commit_list *)a)->item->date;
+	timestamp_t b_date = ((const struct commit_list *)b)->item->date;
 	if (a_date < b_date)
 		return 1;
 	if (a_date > b_date)
@@ -598,7 +598,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	const char *ident_line;
 	size_t ident_len;
 	char *date_end;
-	unsigned long date;
+	timestamp_t date;
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
@@ -621,8 +621,8 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
 {
 	const struct commit *a = a_, *b = b_;
 	struct author_date_slab *author_date = cb_data;
-	unsigned long a_date = *(author_date_slab_at(author_date, a));
-	unsigned long b_date = *(author_date_slab_at(author_date, b));
+	timestamp_t a_date = *(author_date_slab_at(author_date, a));
+	timestamp_t b_date = *(author_date_slab_at(author_date, b));
 
 	/* newer commits with larger date first */
 	if (a_date < b_date)
diff --git a/commit.h b/commit.h
index 7b1986d5c8a..c9d887b5e53 100644
--- a/commit.h
+++ b/commit.h
@@ -17,7 +17,7 @@ struct commit {
 	struct object object;
 	void *util;
 	unsigned int index;
-	unsigned long date;
+	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
 };
diff --git a/config.c b/config.c
index 1a4d85537b3..3247bfaa020 100644
--- a/config.c
+++ b/config.c
@@ -1926,7 +1926,7 @@ int git_config_get_expiry(const char *key, const char **output)
 	if (ret)
 		return ret;
 	if (strcmp(*output, "now")) {
-		unsigned long now = approxidate("now");
+		timestamp_t now = approxidate("now");
 		if (approxidate(*output) >= now)
 			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
 	}
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 46c5937526a..f3814cc47a0 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -8,7 +8,7 @@ static struct tempfile socket_file;
 
 struct credential_cache_entry {
 	struct credential item;
-	unsigned long expiration;
+	timestamp_t expiration;
 };
 static struct credential_cache_entry *entries;
 static int entries_nr;
@@ -47,12 +47,12 @@ static void remove_credential(const struct credential *c)
 		e->expiration = 0;
 }
 
-static int check_expirations(void)
+static timestamp_t check_expirations(void)
 {
-	static unsigned long wait_for_entry_until;
+	static timestamp_t wait_for_entry_until;
 	int i = 0;
-	unsigned long now = time(NULL);
-	unsigned long next = (unsigned long)-1;
+	timestamp_t now = time(NULL);
+	timestamp_t next = TIME_MAX;
 
 	/*
 	 * Initially give the client 30 seconds to actually contact us
@@ -159,7 +159,7 @@ static void serve_one_client(FILE *in, FILE *out)
 static int serve_cache_loop(int fd)
 {
 	struct pollfd pfd;
-	unsigned long wakeup;
+	timestamp_t wakeup;
 
 	wakeup = check_expirations();
 	if (!wakeup)
diff --git a/date.c b/date.c
index 5c33dfd8ee7..92ab31aa441 100644
--- a/date.c
+++ b/date.c
@@ -39,7 +39,7 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
-static time_t gm_time_t(unsigned long time, int tz)
+static time_t gm_time_t(timestamp_t time, int tz)
 {
 	int minutes;
 
@@ -54,7 +54,7 @@ static time_t gm_time_t(unsigned long time, int tz)
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(unsigned long time, int tz)
+static struct tm *time_to_tm(timestamp_t time, int tz)
 {
 	time_t t = gm_time_t(time, tz);
 	return gmtime(&t);
@@ -64,7 +64,7 @@ static struct tm *time_to_tm(unsigned long time, int tz)
  * What value of "tz" was in effect back then at "time" in the
  * local timezone?
  */
-static int local_tzoffset(unsigned long time)
+static int local_tzoffset(timestamp_t time)
 {
 	time_t t, t_local;
 	struct tm tm;
@@ -88,11 +88,11 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
-void show_date_relative(unsigned long time, int tz,
+void show_date_relative(timestamp_t time, int tz,
 			       const struct timeval *now,
 			       struct strbuf *timebuf)
 {
-	unsigned long diff;
+	timestamp_t diff;
 	if (now->tv_sec < time) {
 		strbuf_addstr(timebuf, _("in the future"));
 		return;
@@ -140,9 +140,9 @@ void show_date_relative(unsigned long time, int tz,
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
-		unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
-		unsigned long years = totalmonths / 12;
-		unsigned long months = totalmonths % 12;
+		timestamp_t totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
+		timestamp_t years = totalmonths / 12;
+		timestamp_t months = totalmonths % 12;
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
@@ -172,7 +172,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
-const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
+const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
@@ -425,7 +425,7 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return 0;
 }
 
-static int match_multi_number(unsigned long num, char c, const char *date,
+static int match_multi_number(timestamp_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
 	struct tm now_tm;
@@ -508,7 +508,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 {
 	int n;
 	char *end;
-	unsigned long num;
+	timestamp_t num;
 
 	num = parse_timestamp(date, &end, 10);
 
@@ -635,7 +635,7 @@ static int match_tz(const char *date, int *offp)
 	return end - date;
 }
 
-static void date_string(unsigned long date, int offset, struct strbuf *buf)
+static void date_string(timestamp_t date, int offset, struct strbuf *buf)
 {
 	int sign = '+';
 
@@ -650,16 +650,16 @@ static void date_string(unsigned long date, int offset, struct strbuf *buf)
  * Parse a string like "0 +0000" as ancient timestamp near epoch, but
  * only when it appears not as part of any other string.
  */
-static int match_object_header_date(const char *date, unsigned long *timestamp, int *offset)
+static int match_object_header_date(const char *date, timestamp_t *timestamp, int *offset)
 {
 	char *end;
-	unsigned long stamp;
+	timestamp_t stamp;
 	int ofs;
 
 	if (*date < '0' || '9' < *date)
 		return -1;
 	stamp = parse_timestamp(date, &end, 10);
-	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
+	if (*end != ' ' || stamp == TIME_MAX || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
 	ofs = strtol(date, &end, 10);
@@ -675,11 +675,11 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
+int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 {
 	struct tm tm;
 	int tm_gmt;
-	unsigned long dummy_timestamp;
+	timestamp_t dummy_timestamp;
 	int dummy_offset;
 
 	if (!timestamp)
@@ -747,7 +747,7 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	return 0; /* success */
 }
 
-int parse_expiry_date(const char *date, unsigned long *timestamp)
+int parse_expiry_date(const char *date, timestamp_t *timestamp)
 {
 	int errors = 0;
 
@@ -762,7 +762,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 		 * of the past, and there is nothing from the future
 		 * to be kept.
 		 */
-		*timestamp = ULONG_MAX;
+		*timestamp = TIME_MAX;
 	else
 		*timestamp = approxidate_careful(date, &errors);
 
@@ -771,7 +771,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 
 int parse_date(const char *date, struct strbuf *result)
 {
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	int offset;
 	if (parse_date_basic(date, &timestamp, &offset))
 		return -1;
@@ -845,7 +845,7 @@ void datestamp(struct strbuf *out)
  * Relative time update (eg "2 days ago").  If we haven't set the time
  * yet, we need to set it from current time.
  */
-static unsigned long update_tm(struct tm *tm, struct tm *now, unsigned long sec)
+static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
 {
 	time_t n;
 
@@ -1066,7 +1066,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 				     time_t now)
 {
 	char *end;
-	unsigned long number = parse_timestamp(date, &end, 10);
+	timestamp_t number = parse_timestamp(date, &end, 10);
 
 	switch (*end) {
 	case ':':
@@ -1114,9 +1114,9 @@ static void pending_number(struct tm *tm, int *num)
 	}
 }
 
-static unsigned long approxidate_str(const char *date,
-				     const struct timeval *tv,
-				     int *error_ret)
+static timestamp_t approxidate_str(const char *date,
+				   const struct timeval *tv,
+				   int *error_ret)
 {
 	int number = 0;
 	int touched = 0;
@@ -1148,12 +1148,12 @@ static unsigned long approxidate_str(const char *date,
 	pending_number(&tm, &number);
 	if (!touched)
 		*error_ret = 1;
-	return update_tm(&tm, &now, 0);
+	return (timestamp_t)update_tm(&tm, &now, 0);
 }
 
-unsigned long approxidate_relative(const char *date, const struct timeval *tv)
+timestamp_t approxidate_relative(const char *date, const struct timeval *tv)
 {
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	int offset;
 	int errors = 0;
 
@@ -1162,10 +1162,10 @@ unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 	return approxidate_str(date, tv, &errors);
 }
 
-unsigned long approxidate_careful(const char *date, int *error_ret)
+timestamp_t approxidate_careful(const char *date, int *error_ret)
 {
 	struct timeval tv;
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	int offset;
 	int dummy = 0;
 	if (!error_ret)
@@ -1180,12 +1180,12 @@ unsigned long approxidate_careful(const char *date, int *error_ret)
 	return approxidate_str(date, &tv, error_ret);
 }
 
-int date_overflows(unsigned long t)
+int date_overflows(timestamp_t t)
 {
 	time_t sys;
 
-	/* If we overflowed our unsigned long, that's bad... */
-	if (t == ULONG_MAX)
+	/* If we overflowed our timestamp data type, that's bad... */
+	if ((uintmax_t)t >= TIME_MAX)
 		return 1;
 
 	/*
diff --git a/fetch-pack.c b/fetch-pack.c
index a1b8ea59e8d..fbe52f02346 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -392,7 +392,7 @@ static int find_common(struct fetch_pack_args *args,
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	if (args->deepen_since) {
-		unsigned long max_age = approxidate(args->deepen_since);
+		timestamp_t max_age = approxidate(args->deepen_since);
 		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
@@ -581,7 +581,7 @@ static int mark_complete_oid(const char *refname, const struct object_id *oid,
 }
 
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
-					 unsigned long cutoff)
+					 timestamp_t cutoff)
 {
 	while (complete && cutoff <= complete->item->date) {
 		print_verbose(args, _("Marking %s as complete"),
@@ -668,7 +668,7 @@ static int everything_local(struct fetch_pack_args *args,
 {
 	struct ref *ref;
 	int retval;
-	unsigned long cutoff = 0;
+	timestamp_t cutoff = 0;
 
 	save_commit_buffer = 0;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index cd522903eda..72c12173a14 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,8 +319,10 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+typedef unsigned long timestamp_t;
 #define PRItime "lu"
 #define parse_timestamp strtoul
+#define TIME_MAX ULONG_MAX
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
diff --git a/http-backend.c b/http-backend.c
index eef0a361f4f..d6ea6075339 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -90,7 +90,7 @@ static void hdr_int(struct strbuf *hdr, const char *name, uintmax_t value)
 	strbuf_addf(hdr, "%s: %" PRIuMAX "\r\n", name, value);
 }
 
-static void hdr_date(struct strbuf *hdr, const char *name, unsigned long when)
+static void hdr_date(struct strbuf *hdr, const char *name, timestamp_t when)
 {
 	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
 	hdr_str(hdr, name, value);
@@ -105,7 +105,7 @@ static void hdr_nocache(struct strbuf *hdr)
 
 static void hdr_cache_forever(struct strbuf *hdr)
 {
-	unsigned long now = time(NULL);
+	timestamp_t now = time(NULL);
 	hdr_date(hdr, "Date", now);
 	hdr_date(hdr, "Expires", now + 31536000);
 	hdr_str(hdr, "Cache-Control", "public, max-age=31536000");
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7419780a9b6..a6810f295cb 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -31,14 +31,14 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	*(unsigned long *)(opt->value) = approxidate(arg);
+	*(timestamp_t *)(opt->value) = approxidate(arg);
 	return 0;
 }
 
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	return parse_expiry_date(arg, (unsigned long *)opt->value);
+	return parse_expiry_date(arg, (timestamp_t *)opt->value);
 }
 
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
diff --git a/pretty.c b/pretty.c
index 24fb0c79062..587d48371b0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -405,7 +405,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 const char *show_ident_date(const struct ident_split *ident,
 			    const struct date_mode *mode)
 {
-	unsigned long date = 0;
+	timestamp_t date = 0;
 	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
diff --git a/reachable.c b/reachable.c
index a8a979bd4fc..682418f5d23 100644
--- a/reachable.c
+++ b/reachable.c
@@ -55,11 +55,11 @@ static void mark_commit(struct commit *c, void *data)
 
 struct recent_data {
 	struct rev_info *revs;
-	unsigned long timestamp;
+	timestamp_t timestamp;
 };
 
 static void add_recent_object(const struct object_id *oid,
-			      unsigned long mtime,
+			      timestamp_t mtime,
 			      struct recent_data *data)
 {
 	struct object *obj;
@@ -139,7 +139,7 @@ static int add_recent_packed(const struct object_id *oid,
 }
 
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-					   unsigned long timestamp)
+					   timestamp_t timestamp)
 {
 	struct recent_data data;
 	int r;
@@ -156,8 +156,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 }
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-			    unsigned long mark_recent,
-			    struct progress *progress)
+			    timestamp_t mark_recent, struct progress *progress)
 {
 	struct connectivity_progress cp;
 
diff --git a/reachable.h b/reachable.h
index d23efc36ec5..3c00fa0526c 100644
--- a/reachable.h
+++ b/reachable.h
@@ -3,8 +3,8 @@
 
 struct progress;
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-						  unsigned long timestamp);
+						  timestamp_t timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   unsigned long mark_recent, struct progress *);
+				   timestamp_t mark_recent, struct progress *);
 
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index c7836ae07bd..1fc5e9970db 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -849,7 +849,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 {
 	const char *eoemail = strstr(buf, "> ");
 	char *zone;
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	long tz;
 	struct date_mode date_mode = { DATE_NORMAL };
 	const char *formatp;
@@ -869,7 +869,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if (!eoemail)
 		goto bad;
 	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
-	if (timestamp == ULONG_MAX)
+	if (timestamp == TIME_MAX)
 		goto bad;
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
diff --git a/reflog-walk.c b/reflog-walk.c
index 99679f58255..3ca5ed8415a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -12,7 +12,7 @@ struct complete_reflogs {
 	struct reflog_info {
 		struct object_id ooid, noid;
 		char *email;
-		unsigned long timestamp;
+		timestamp_t timestamp;
 		int tz;
 		char *message;
 	} *items;
@@ -20,7 +20,7 @@ struct complete_reflogs {
 };
 
 static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct complete_reflogs *array = cb_data;
@@ -69,7 +69,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 }
 
 static int get_reflog_recno_by_time(struct complete_reflogs *array,
-	unsigned long timestamp)
+	timestamp_t timestamp)
 {
 	int i;
 	for (i = array->nr - 1; i >= 0; i--)
@@ -141,7 +141,7 @@ void init_reflog_walk(struct reflog_walk_info **info)
 int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name)
 {
-	unsigned long timestamp = 0;
+	timestamp_t timestamp = 0;
 	int recno = -1;
 	struct string_list_item *item;
 	struct complete_reflogs *reflogs;
diff --git a/refs.c b/refs.c
index d1e1b4399b3..6841bd9f712 100644
--- a/refs.c
+++ b/refs.c
@@ -712,7 +712,7 @@ int is_branch(const char *refname)
 
 struct read_ref_at_cb {
 	const char *refname;
-	unsigned long at_time;
+	timestamp_t at_time;
 	int cnt;
 	int reccnt;
 	unsigned char *sha1;
@@ -721,15 +721,15 @@ struct read_ref_at_cb {
 	unsigned char osha1[20];
 	unsigned char nsha1[20];
 	int tz;
-	unsigned long date;
+	timestamp_t date;
 	char **msg;
-	unsigned long *cutoff_time;
+	timestamp_t *cutoff_time;
 	int *cutoff_tz;
 	int *cutoff_cnt;
 };
 
 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -776,7 +776,7 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
-				  const char *email, unsigned long timestamp,
+				  const char *email, timestamp_t timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -796,9 +796,9 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
+int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
 		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	struct read_ref_at_cb cb;
 
diff --git a/refs.h b/refs.h
index 49e97d7d5fd..2b80d37fd34 100644
--- a/refs.h
+++ b/refs.h
@@ -317,9 +317,9 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(const char *refname, unsigned int flags,
-		unsigned long at_time, int cnt,
+		timestamp_t at_time, int cnt,
 		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
 int refs_reflog_exists(struct ref_store *refs, const char *refname);
@@ -356,7 +356,7 @@ int delete_reflog(const char *refname);
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
-		const char *committer, unsigned long timestamp,
+		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
@@ -616,7 +616,7 @@ typedef void reflog_expiry_prepare_fn(const char *refname,
 typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
 					  unsigned char *nsha1,
 					  const char *email,
-					  unsigned long timestamp, int tz,
+					  timestamp_t timestamp, int tz,
 					  const char *message, void *cb_data);
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ecbb13dc4b8..6646dcfc838 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3237,7 +3237,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 {
 	struct object_id ooid, noid;
 	char *email_end, *message;
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	int tz;
 	const char *p = sb->buf;
 
@@ -4114,7 +4114,7 @@ struct expire_reflog_cb {
 };
 
 static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *email, unsigned long timestamp, int tz,
+			     const char *email, timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
diff --git a/revision.c b/revision.c
index 7ff61ff5f73..8a8c1789c7b 100644
--- a/revision.c
+++ b/revision.c
@@ -884,7 +884,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 /* How many extra uninteresting commits we want to see.. */
 #define SLOP 5
 
-static int still_interesting(struct commit_list *src, unsigned long date, int slop,
+static int still_interesting(struct commit_list *src, timestamp_t date, int slop,
 			     struct commit **interesting_cache)
 {
 	/*
@@ -1018,7 +1018,7 @@ static void limit_left_right(struct commit_list *list, struct rev_info *revs)
 static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
-	unsigned long date = ~0ul;
+	timestamp_t date = TIME_MAX;
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
@@ -1215,7 +1215,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 }
 
 static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	handle_one_reflog_commit(ooid, cb_data);
diff --git a/revision.h b/revision.h
index 14886ec92b4..0d9e68b36e9 100644
--- a/revision.h
+++ b/revision.h
@@ -181,8 +181,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
-	unsigned long max_age;
-	unsigned long min_age;
+	timestamp_t max_age;
+	timestamp_t min_age;
 	int min_parents;
 	int max_parents;
 	int (*include_check)(struct commit *, void *);
diff --git a/sha1_name.c b/sha1_name.c
index 8eec9f7c1bb..35c1e2a9e32 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -660,8 +660,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (reflog_len) {
 		int nth, i;
-		unsigned long at_time;
-		unsigned long co_time;
+		timestamp_t at_time;
+		timestamp_t co_time;
 		int co_tz, co_cnt;
 
 		/* Is it asking for N-th entry, or approxidate? */
@@ -1054,7 +1054,7 @@ struct grab_nth_branch_switch_cbdata {
 };
 
 static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid,
-				  const char *email, unsigned long timestamp, int tz,
+				  const char *email, timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 269040f028f..f414a3ac670 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -27,7 +27,7 @@ static void show_dates(const char **argv, const char *format)
 	parse_date_format(format, &mode);
 	for (; *argv; argv++) {
 		char *arg;
-		time_t t;
+		timestamp_t t;
 		int tz;
 
 		/*
@@ -48,7 +48,7 @@ static void parse_dates(const char **argv, struct timeval *now)
 	struct strbuf result = STRBUF_INIT;
 
 	for (; *argv; argv++) {
-		unsigned long t;
+		timestamp_t t;
 		int tz;
 
 		strbuf_reset(&result);
@@ -65,7 +65,7 @@ static void parse_dates(const char **argv, struct timeval *now)
 static void parse_approxidate(const char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
-		time_t t;
+		timestamp_t t;
 		t = approxidate_relative(*argv, now);
 		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
 	}
@@ -96,7 +96,7 @@ int cmd_main(int argc, const char **argv)
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
-		return sizeof(unsigned long) == 8 ? 0 : 1;
+		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
 		return sizeof(time_t) == 8 ? 0 : 1;
 	else
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 7d93627e454..75fe883aac1 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -5,7 +5,7 @@
 static int boolean = 0;
 static int integer = 0;
 static unsigned long magnitude = 0;
-static unsigned long timestamp;
+static timestamp_t timestamp;
 static int abbrev = 7;
 static int verbose = -1; /* unspecified */
 static int dry_run = 0, quiet = 0;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a436bfdb053..9077ec2c330 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -138,7 +138,7 @@ static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
 }
 
 static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
-		       const char *committer, unsigned long timestamp,
+		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
 	printf("%s %s %s %"PRItime" %d %s\n",
diff --git a/tag.c b/tag.c
index 9b6725e02c9..d71b67e8d83 100644
--- a/tag.c
+++ b/tag.c
@@ -97,7 +97,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
-static unsigned long parse_tag_date(const char *buf, const char *tail)
+static timestamp_t parse_tag_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
 
diff --git a/tag.h b/tag.h
index a5721b6731e..2abb3726fb5 100644
--- a/tag.h
+++ b/tag.h
@@ -9,7 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;
-	unsigned long date;
+	timestamp_t date;
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
diff --git a/upload-pack.c b/upload-pack.c
index 4966f0b8a09..97da13e6a54 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,7 +35,7 @@ static const char * const upload_pack_usage[] = {
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
 
-static unsigned long oldest_have;
+static timestamp_t oldest_have;
 
 static int deepen_relative;
 static int multi_ack;
@@ -735,7 +735,7 @@ static void receive_needs(void)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	int depth = 0;
 	int has_non_tip = 0;
-	unsigned long deepen_since = 0;
+	timestamp_t deepen_since = 0;
 	int deepen_rev_list = 0;
 
 	shallow_nr = 0;
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6c9f2866d8b..5a89db30e3f 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,7 +68,7 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 }
 
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp, const char *note_ref)
+		const char *log, timestamp_t timestamp, const char *note_ref)
 {
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
@@ -93,7 +93,7 @@ static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
 			const char *uuid, const char *url,
-			unsigned long timestamp, const char *local_ref)
+			timestamp_t timestamp, const char *local_ref)
 {
 	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index c8b5adb811c..b9a3b71c99f 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -11,10 +11,10 @@ void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp, const char *note_ref);
+		const char *log, timestamp_t timestamp, const char *note_ref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,const char *url,
-			unsigned long timestamp, const char *local_ref);
+			timestamp_t timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_buf_to_data(const struct strbuf *data);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index e4b395963b9..1846685a21a 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -47,7 +47,7 @@ static struct {
 
 static struct {
 	uint32_t revision;
-	unsigned long timestamp;
+	timestamp_t timestamp;
 	struct strbuf log, author, note;
 } rev_ctx;
 
diff --git a/wt-status.c b/wt-status.c
index 03754849626..1b1d644b85f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1387,7 +1387,7 @@ struct grab_1st_switch_cbdata {
 };
 
 static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
-			   const char *email, unsigned long timestamp, int tz,
+			   const char *email, timestamp_t timestamp, int tz,
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
-- 
2.12.2.windows.2.406.gd14a8f8640f


