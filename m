Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE4F20966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdDBTGO (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:06:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:62020 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbdDBTGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:06:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvVUR-1bvX6V42Wx-010guc; Sun, 02
 Apr 2017 21:06:05 +0200
Date:   Sun, 2 Apr 2017 21:06:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:m1YtXZd9ou3Wy5s301T9LwK4e6rlvAZV1/CXoj5uQFGW+J/HY2b
 cGvjRPIVdmO8C0Wps2H1rQYbhfj2d6tggGu46m9O4fD7R47YOjskr3p5yinbOG/S8JwVKl4
 w4rzdpbsdAfImprj5QHwQB8Sp9OVaePvZB1pwPGxOLbFnA+m3/RZArzTZ+8ZR5T+bnfoGpC
 RI3heJa1JqvFh29xrPurQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IaynNZvr444=:rV4e4wbxEThFpTTMExZOZX
 O1W1y+UAdBBfTKjN8A+tqykw3qsfxfs+DL33Fk224bn4A5Jv5c71U4ax4ND05VYvpxuV7oQYi
 Ola/JnF6GmsaRBfBkttIvKbZwkMOVtn7PlrqpCqNA3nlGnp3JXp/3JBvAEwBNUIKlq1ljP8T2
 lK9in5hXJ2ojMTES2vx4R0vS6UA+SIrrhr9FzLbWBKhqyvENDEq4vgxaZDuZDvstcHcaN5V1h
 9g2hCXFLcj0vSNcu2GpD0PpIav9HGGppkBR7AWnjz4B5gmfs02gVlpy5wKzLFp6IPeX4wvGGH
 iRW5rcEQfVVWSvC2CDymd/Cd8ExNT3SWQNNvcVfwaxhRUyWwi+Yge6DRJhtn4enwgK6z0sPaH
 vSDvxmDIQCJ+fa1J1ffOYB/pVzkN3pMdAZyFCactKbgBjXaYEGB7AbvsUiJx1p/3SokDH1l6U
 Z+tdzB5ptG4xR5k8hYByv7cmSNs2jL7PUYx99ewpgEqpyiPxXJ9I8JCWC7+mg5jD5dp/e2Srb
 eA540CQl42ZVq1NV97I7HnOhn/BIc1XLSVN8AHqozyJecLqzoiseSt/JbDWaS/zoS/q+kMMzH
 shynKgWXzMiEG6DFy0kkRGSMfHlv6qjfcn3JOe2YqaGBKvswoXiaGxFuBN9bmNBCJNRgIIbD9
 nnVru1KMJ8MHS1LO/nvA/0AsDzPVJ9ywgxuVV8KrH6AeAfIv+dkxzg4RY4IPLOCHYth971d6w
 y+62pIMfv17DUhIuK8fxk3ODzaQv6+2wIzeF0mm79xx/da3zZFFoLOk0g5XBGI9jT7VSleFZQ
 eLrdTCS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.9.2 was released in a hurry to accomodate for platforms like
Windows, where the `unsigned long` data type is 32-bit even for 64-bit
setups.

The quick fix was to simply disable all the testing with "absurd" future
dates.

However, we can do much better than that, as we already make use of
64-bit data types internally. There is no good reason why we should not
use the same for timestamps. Hence, let's use uintmax_t for timestamps.

Note: while the `time_t` data type exists and is meant to be used for
timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
used `time_t` for that reason, but it came with a few serious downsides:
as `time_t` can be signed (and indeed, on Windows it is an int64_t),
Git's expectation that 0 is the minimal value does no longer hold true,
introducing its own set of interesting challenges. Besides, if we *can*
handle far in the future timestamps (except for formatting them using
the system libraries), it is more consistent to do so.

The upside of using `uintmax_t` for timestamps is that we do a much
better job to support far in the future timestamps across all platforms,
including 32-bit ones. The downside is that those platforms that use a
32-bit `time_t` will barf when parsing or formatting those timestamps.

Changes since v1 (sorry, the interdiff is huge due to the switch from
time_t to uintmax_t):

- moved an `unsigned long` -> `time_t` change into 6/6 (it inadvertently
  was done as part of the patch that wanted to introduce
  parse_timestamp()).

- using `uintmax_t` for timestamps instead of `time_t` now.

- as 32-bit Linux still uses 32-bit time_t, while we may be able to
  represent timestamps far in the future internally, as soon as we try
  to format them using strftime() it will fail. Added safeguards against
  that and prepared t0006 and t5000 for this scenario (i.e. skip those
  tests that require strftime() to handle 64-bit timestamps).

- found a couple more places where strtoul() was still hardcoded for
  parsing timestamps, and fixed them.


Johannes Schindelin (8):
  ref-filter: avoid using `unsigned long` for catch-all data type
  t0006 & t5000: prepare for 64-bit timestamps
  t0006 & t5000: skip "far in the future" test when time_t is too
    limited
  Specify explicitly where we parse timestamps
  Introduce a new "printf format" for timestamps
  Introduce a new data type for timestamps
  Abort if the system time cannot handle one of our timestamps
  Use uintmax_t for timestamps

 Documentation/technical/api-parse-options.txt |   8 +-
 archive-tar.c                                 |   5 +-
 archive-zip.c                                 |   6 +-
 archive.h                                     |   2 +-
 builtin/am.c                                  |   4 +-
 builtin/blame.c                               |  14 ++--
 builtin/fsck.c                                |   6 +-
 builtin/gc.c                                  |   2 +-
 builtin/log.c                                 |   4 +-
 builtin/merge-base.c                          |   2 +-
 builtin/name-rev.c                            |   6 +-
 builtin/pack-objects.c                        |   4 +-
 builtin/prune.c                               |   4 +-
 builtin/receive-pack.c                        |  14 ++--
 builtin/reflog.c                              |  24 +++---
 builtin/rev-list.c                            |   2 +-
 builtin/rev-parse.c                           |   3 +-
 builtin/show-branch.c                         |   4 +-
 builtin/worktree.c                            |   4 +-
 bundle.c                                      |   4 +-
 cache.h                                       |  14 ++--
 commit.c                                      |  18 ++--
 commit.h                                      |   2 +-
 config.c                                      |   2 +-
 credential-cache--daemon.c                    |  12 +--
 date.c                                        | 113 ++++++++++++++------------
 fetch-pack.c                                  |   8 +-
 fsck.c                                        |   2 +-
 git-compat-util.h                             |   9 ++
 http-backend.c                                |   4 +-
 parse-options-cb.c                            |   4 +-
 pretty.c                                      |   4 +-
 reachable.c                                   |   9 +-
 reachable.h                                   |   4 +-
 ref-filter.c                                  |  22 ++---
 reflog-walk.c                                 |   8 +-
 refs.c                                        |  14 ++--
 refs.h                                        |   8 +-
 refs/files-backend.c                          |   8 +-
 revision.c                                    |   6 +-
 revision.h                                    |   4 +-
 sha1_name.c                                   |   6 +-
 t/helper/test-date.c                          |  18 ++--
 t/helper/test-parse-options.c                 |   4 +-
 t/t0006-date.sh                               |   4 +-
 t/t5000-tar-tree.sh                           |   6 +-
 t/test-lib.sh                                 |   3 +
 tag.c                                         |   6 +-
 tag.h                                         |   2 +-
 upload-pack.c                                 |   8 +-
 vcs-svn/fast_export.c                         |   8 +-
 vcs-svn/fast_export.h                         |   4 +-
 vcs-svn/svndump.c                             |   2 +-
 wt-status.c                                   |   2 +-
 54 files changed, 252 insertions(+), 218 deletions(-)


base-commit: b14f27f91770e0f99f64135348977a0ce1c7993a
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v2
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v2

Interdiff vs v1:

 diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
 index ed16519da8f..829b5581105 100644
 --- a/Documentation/technical/api-parse-options.txt
 +++ b/Documentation/technical/api-parse-options.txt
 @@ -183,13 +183,13 @@ There are some macros to easily define options:
  	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
  	The scaled value is put into `unsigned_long_var`.
  
 -`OPT_DATE(short, long, &time_t_var, description)`::
 +`OPT_DATE(short, long, &timestamp_t_var, description)`::
  	Introduce an option with date argument, see `approxidate()`.
 -	The timestamp is put into `time_t_var`.
 +	The timestamp is put into `timestamp_t_var`.
  
 -`OPT_EXPIRY_DATE(short, long, &time_t_var, description)`::
 +`OPT_EXPIRY_DATE(short, long, &timestamp_t_var, description)`::
  	Introduce an option with expiry date argument, see `parse_expiry_date()`.
 -	The timestamp is put into `time_t_var`.
 +	The timestamp is put into `timestamp_t_var`.
  
  `OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
  	Introduce an option with argument.
 diff --git a/Makefile b/Makefile
 index 7dafef138c0..9b36068ac5e 100644
 --- a/Makefile
 +++ b/Makefile
 @@ -1530,10 +1530,6 @@ ifdef HAVE_GETDELIM
  	BASIC_CFLAGS += -DHAVE_GETDELIM
  endif
  
 -ifdef TIME_T_IS_INT64
 -	BASIC_CFLAGS += -DTIME_T_IS_INT64
 -endif
 -
  ifeq ($(TCLTK_PATH),)
  NO_TCLTK = NoThanks
  endif
 diff --git a/archive-zip.c b/archive-zip.c
 index b429a8d974a..4f715d40450 100644
 --- a/archive-zip.c
 +++ b/archive-zip.c
 @@ -545,10 +545,12 @@ static void write_zip_trailer(const unsigned char *sha1)
  		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
  }
  
 -static void dos_time(time_t *time, int *dos_date, int *dos_time)
 +static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
  {
 -	struct tm *t = localtime(time);
 +	time_t time;
 +	struct tm *t = localtime(&time);
  
 +	*timestamp = time;
  	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
  	            (t->tm_year + 1900 - 1980) * 512;
  	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
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
 index d683268790e..89914ed8757 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -877,7 +877,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
  		if (skip_prefix(sb.buf, "# User ", &str))
  			fprintf(out, "From: %s\n", str);
  		else if (skip_prefix(sb.buf, "# Date ", &str)) {
 -			time_t timestamp;
 +			timestamp_t timestamp;
  			long tz, tz2;
  			char *end;
  
 diff --git a/builtin/blame.c b/builtin/blame.c
 index 9a7e9a2fe52..e508694f9ab 100644
 --- a/builtin/blame.c
 +++ b/builtin/blame.c
 @@ -1561,13 +1561,13 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
  struct commit_info {
  	struct strbuf author;
  	struct strbuf author_mail;
 -	time_t author_time;
 +	timestamp_t author_time;
  	struct strbuf author_tz;
  
  	/* filled only when asked for details */
  	struct strbuf committer;
  	struct strbuf committer_mail;
 -	time_t committer_time;
 +	timestamp_t committer_time;
  	struct strbuf committer_tz;
  
  	struct strbuf summary;
 @@ -1578,7 +1578,7 @@ struct commit_info {
   */
  static void get_ac_line(const char *inbuf, const char *what,
  	struct strbuf *name, struct strbuf *mail,
 -	time_t *time, struct strbuf *tz)
 +	timestamp_t *time, struct strbuf *tz)
  {
  	struct ident_split ident;
  	size_t len, maillen, namelen;
 @@ -1837,7 +1837,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
  	stop_progress(&pi.progress);
  }
  
 -static const char *format_time(time_t time, const char *tz_str,
 +static const char *format_time(timestamp_t time, const char *tz_str,
  			       int show_raw_time)
  {
  	static struct strbuf time_buf = STRBUF_INIT;
 diff --git a/builtin/gc.c b/builtin/gc.c
 index c2c61a57bb3..d38677cf44c 100644
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
 index 84230d946d3..6d457f3b54a 100644
 --- a/builtin/log.c
 +++ b/builtin/log.c
 @@ -904,7 +904,7 @@ static void gen_message_id(struct rev_info *info, char *base)
  {
  	struct strbuf buf = STRBUF_INIT;
  	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
 -		    (time_t) time(NULL),
 +		    (timestamp_t) time(NULL),
  		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
  	info->message_id = strbuf_detach(&buf, NULL);
  }
 diff --git a/builtin/name-rev.c b/builtin/name-rev.c
 index cf4faf27730..ee4b6950e5a 100644
 --- a/builtin/name-rev.c
 +++ b/builtin/name-rev.c
 @@ -10,7 +10,7 @@
  
  typedef struct rev_name {
  	const char *tip_name;
 -	time_t taggerdate;
 +	timestamp_t taggerdate;
  	int generation;
  	int distance;
  } rev_name;
 @@ -21,7 +21,7 @@ static long cutoff = LONG_MAX;
  #define MERGE_TRAVERSAL_WEIGHT 65535
  
  static void name_rev(struct commit *commit,
 -		const char *tip_name, time_t taggerdate,
 +		const char *tip_name, timestamp_t taggerdate,
  		int generation, int distance,
  		int deref)
  {
 @@ -146,7 +146,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
  	struct name_ref_data *data = cb_data;
  	int can_abbreviate_output = data->tags_only && data->name_only;
  	int deref = 0;
 -	time_t taggerdate = TIME_MAX;
 +	timestamp_t taggerdate = TIME_MAX;
  
  	if (data->tags_only && !starts_with(path, "refs/tags/"))
  		return 0;
 diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
 index 0ab7a0e6c2e..9d0fef2e49a 100644
 --- a/builtin/pack-objects.c
 +++ b/builtin/pack-objects.c
 @@ -44,7 +44,7 @@ static uint32_t nr_result, nr_written;
  static int non_empty;
  static int reuse_delta = 1, reuse_object = 1;
  static int keep_unreachable, unpack_unreachable, include_tag;
 -static time_t unpack_unreachable_expiration;
 +static timestamp_t unpack_unreachable_expiration;
  static int pack_loose_unreachable;
  static int local;
  static int have_non_local_packs;
 @@ -2675,7 +2675,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
  static struct sha1_array recent_objects;
  
  static int loosened_object_can_be_discarded(const unsigned char *sha1,
 -					    time_t mtime)
 +					    timestamp_t mtime)
  {
  	if (!unpack_unreachable_expiration)
  		return 0;
 diff --git a/builtin/prune.c b/builtin/prune.c
 index a28d2c71b28..8dcfecde0f3 100644
 --- a/builtin/prune.c
 +++ b/builtin/prune.c
 @@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
  };
  static int show_only;
  static int verbose;
 -static time_t expire;
 +static timestamp_t expire;
  static int show_progress = -1;
  
  static int prune_tmp_file(const char *fullpath)
 diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
 index eba38524351..f8f4242719b 100644
 --- a/builtin/receive-pack.c
 +++ b/builtin/receive-pack.c
 @@ -78,7 +78,7 @@ static const char *NONCE_OK = "OK";
  static const char *NONCE_SLOP = "SLOP";
  static const char *nonce_status;
  static long nonce_stamp_slop;
 -static time_t nonce_stamp_slop_limit;
 +static timestamp_t nonce_stamp_slop_limit;
  static struct ref_transaction *transaction;
  
  static enum {
 @@ -454,7 +454,7 @@ static void hmac_sha1(unsigned char *out,
  	git_SHA1_Final(out, &ctx);
  }
  
 -static char *prepare_push_cert_nonce(const char *path, time_t stamp)
 +static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
  {
  	struct strbuf buf = STRBUF_INIT;
  	unsigned char sha1[20];
 @@ -496,7 +496,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
  static const char *check_nonce(const char *buf, size_t len)
  {
  	char *nonce = find_header(buf, len, "nonce");
 -	time_t stamp, ostamp;
 +	timestamp_t stamp, ostamp;
  	char *bohmac, *expect = NULL;
  	const char *retval = NONCE_BAD;
  
 @@ -534,7 +534,7 @@ static const char *check_nonce(const char *buf, size_t len)
  		retval = NONCE_BAD;
  		goto leave;
  	}
 -	stamp = strtoul(nonce, &bohmac, 10);
 +	stamp = parse_timestamp(nonce, &bohmac, 10);
  	if (bohmac == nonce || bohmac[0] != '-') {
  		retval = NONCE_BAD;
  		goto leave;
 @@ -552,7 +552,7 @@ static const char *check_nonce(const char *buf, size_t len)
  	 * would mean it was issued by another server with its clock
  	 * skewed in the future.
  	 */
 -	ostamp = strtoul(push_cert_nonce, NULL, 10);
 +	ostamp = parse_timestamp(push_cert_nonce, NULL, 10);
  	nonce_stamp_slop = (long)ostamp - (long)stamp;
  
  	if (nonce_stamp_slop_limit &&
 diff --git a/builtin/reflog.c b/builtin/reflog.c
 index 2dc05121b77..4228d9ff4db 100644
 --- a/builtin/reflog.c
 +++ b/builtin/reflog.c
 @@ -16,14 +16,14 @@ static const char reflog_delete_usage[] =
  static const char reflog_exists_usage[] =
  "git reflog exists <ref>";
  
 -static time_t default_reflog_expire;
 -static time_t default_reflog_expire_unreachable;
 +static timestamp_t default_reflog_expire;
 +static timestamp_t default_reflog_expire_unreachable;
  
  struct cmd_reflog_expire_cb {
  	struct rev_info revs;
  	int stalefix;
 -	time_t expire_total;
 -	time_t expire_unreachable;
 +	timestamp_t expire_total;
 +	timestamp_t expire_unreachable;
  	int recno;
  };
  
 @@ -219,7 +219,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
  static void mark_reachable(struct expire_reflog_policy_cb *cb)
  {
  	struct commit_list *pending;
 -	time_t expire_limit = cb->mark_limit;
 +	timestamp_t expire_limit = cb->mark_limit;
  	struct commit_list *leftover = NULL;
  
  	for (pending = cb->mark_list; pending; pending = pending->next)
 @@ -284,7 +284,7 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
   * Return true iff the specified reflog entry should be expired.
   */
  static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 -				    const char *email, time_t timestamp, int tz,
 +				    const char *email, timestamp_t timestamp, int tz,
  				    const char *message, void *cb_data)
  {
  	struct expire_reflog_policy_cb *cb = cb_data;
 @@ -392,8 +392,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
  
  static struct reflog_expire_cfg {
  	struct reflog_expire_cfg *next;
 -	time_t expire_total;
 -	time_t expire_unreachable;
 +	timestamp_t expire_total;
 +	timestamp_t expire_unreachable;
  	char pattern[FLEX_ARRAY];
  } *reflog_expire_cfg, **reflog_expire_cfg_tail;
  
 @@ -415,7 +415,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
  	return ent;
  }
  
 -static int parse_expire_cfg_value(const char *var, const char *value, time_t *expire)
 +static int parse_expire_cfg_value(const char *var, const char *value, timestamp_t *expire)
  {
  	if (!value)
  		return config_error_nonbool(var);
 @@ -433,7 +433,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
  {
  	const char *pattern, *key;
  	int pattern_len;
 -	time_t expire;
 +	timestamp_t expire;
  	int slot;
  	struct reflog_expire_cfg *ent;
  
 @@ -515,7 +515,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
  static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
  {
  	struct expire_reflog_policy_cb cb;
 -	time_t now = time(NULL);
 +	timestamp_t now = time(NULL);
  	int i, status, do_all;
  	int explicit_expiry = 0;
  	unsigned int flags = 0;
 diff --git a/builtin/rev-list.c b/builtin/rev-list.c
 index 0aa93d58919..a30fbce3341 100644
 --- a/builtin/rev-list.c
 +++ b/builtin/rev-list.c
 @@ -80,7 +80,7 @@ static void show_commit(struct commit *commit, void *data)
  	}
  
  	if (info->show_timestamp)
 -		printf("%lu ", commit->date);
 +		printf("%"PRItime" ", commit->date);
  	if (info->header_prefix)
  		fputs(info->header_prefix, stdout);
  
 diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
 index 9e53a1a7ca4..f1c26ca6e62 100644
 --- a/builtin/rev-parse.c
 +++ b/builtin/rev-parse.c
 @@ -218,7 +218,8 @@ static void show_datestring(const char *flag, const char *datestr)
  	/* date handling requires both flags and revs */
  	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
  		return;
 -	snprintf(buffer, sizeof(buffer), "%s%lu", flag, approxidate(datestr));
 +	snprintf(buffer, sizeof(buffer), "%s%"PRItime,
 +		 flag, approxidate(datestr));
  	show(buffer);
  }
  
 diff --git a/builtin/show-branch.c b/builtin/show-branch.c
 index ebd46fe6363..8860f429b06 100644
 --- a/builtin/show-branch.c
 +++ b/builtin/show-branch.c
 @@ -735,7 +735,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
  			base = strtoul(reflog_base, &ep, 10);
  			if (*ep) {
  				/* Ah, that is a date spec... */
 -				time_t at;
 +				timestamp_t at;
  				at = approxidate(reflog_base);
  				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
  					    NULL, NULL, &base);
 @@ -746,7 +746,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
  			char *logmsg;
  			char *nth_desc;
  			const char *msg;
 -			time_t timestamp;
 +			timestamp_t timestamp;
  			int tz;
  
  			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
 diff --git a/builtin/worktree.c b/builtin/worktree.c
 index 15e29e9e385..74f9b18d40c 100644
 --- a/builtin/worktree.c
 +++ b/builtin/worktree.c
 @@ -30,7 +30,7 @@ struct add_opts {
  
  static int show_only;
  static int verbose;
 -static time_t expire;
 +static timestamp_t expire;
  
  static int prune_worktree(const char *id, struct strbuf *reason)
  {
 diff --git a/bundle.c b/bundle.c
 index 75b82e6b653..05e014fc5ab 100644
 --- a/bundle.c
 +++ b/bundle.c
 @@ -211,7 +211,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
  	unsigned long size;
  	enum object_type type;
  	char *buf = NULL, *line, *lineend;
 -	time_t date;
 +	timestamp_t date;
  	int result = 1;
  
  	if (revs->max_age == -1 && revs->min_age == -1)
 diff --git a/cache.h b/cache.h
 index 6226634bf23..38f5c7dd3a5 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -1472,18 +1472,18 @@ struct date_mode {
  #define DATE_MODE(t) date_mode_from_type(DATE_##t)
  struct date_mode *date_mode_from_type(enum date_mode_type type);
  
 -const char *show_date(time_t time, int timezone, const struct date_mode *mode);
 -void show_date_relative(time_t time, int tz, const struct timeval *now,
 +const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 +void show_date_relative(timestamp_t time, int tz, const struct timeval *now,
  			struct strbuf *timebuf);
  int parse_date(const char *date, struct strbuf *out);
 -int parse_date_basic(const char *date, time_t *timestamp, int *offset);
 -int parse_expiry_date(const char *date, time_t *timestamp);
 +int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
 +int parse_expiry_date(const char *date, timestamp_t *timestamp);
  void datestamp(struct strbuf *out);
  #define approxidate(s) approxidate_careful((s), NULL)
 -time_t approxidate_careful(const char *, int *);
 -time_t approxidate_relative(const char *date, const struct timeval *now);
 +timestamp_t approxidate_careful(const char *, int *);
 +timestamp_t approxidate_relative(const char *date, const struct timeval *now);
  void parse_date_format(const char *format, struct date_mode *mode);
 -int date_overflows(time_t date);
 +int date_overflows(timestamp_t date);
  
  #define IDENT_STRICT	       1
  #define IDENT_NO_DATE	       2
 diff --git a/commit.c b/commit.c
 index 5ddaa939ce4..99a62b90ee2 100644
 --- a/commit.c
 +++ b/commit.c
 @@ -66,7 +66,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
  	return commit;
  }
  
 -static time_t parse_commit_date(const char *buf, const char *tail)
 +static timestamp_t parse_commit_date(const char *buf, const char *tail)
  {
  	const char *dateptr;
  
 @@ -89,7 +89,7 @@ static time_t parse_commit_date(const char *buf, const char *tail)
  		/* nada */;
  	if (buf >= tail)
  		return 0;
 -	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
 +	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
  	return parse_timestamp(dateptr, NULL, 10);
  }
  
 @@ -473,8 +473,8 @@ struct commit_list * commit_list_insert_by_date(struct commit *item, struct comm
  
  static int commit_list_compare_by_date(const void *a, const void *b)
  {
 -	time_t a_date = ((const struct commit_list *)a)->item->date;
 -	time_t b_date = ((const struct commit_list *)b)->item->date;
 +	timestamp_t a_date = ((const struct commit_list *)a)->item->date;
 +	timestamp_t b_date = ((const struct commit_list *)b)->item->date;
  	if (a_date < b_date)
  		return 1;
  	if (a_date > b_date)
 @@ -598,7 +598,7 @@ static void record_author_date(struct author_date_slab *author_date,
  	const char *ident_line;
  	size_t ident_len;
  	char *date_end;
 -	time_t date;
 +	timestamp_t date;
  
  	ident_line = find_commit_header(buffer, "author", &ident_len);
  	if (!ident_line)
 @@ -621,8 +621,8 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
  {
  	const struct commit *a = a_, *b = b_;
  	struct author_date_slab *author_date = cb_data;
 -	time_t a_date = *(author_date_slab_at(author_date, a));
 -	time_t b_date = *(author_date_slab_at(author_date, b));
 +	timestamp_t a_date = *(author_date_slab_at(author_date, a));
 +	timestamp_t b_date = *(author_date_slab_at(author_date, b));
  
  	/* newer commits with larger date first */
  	if (a_date < b_date)
 diff --git a/commit.h b/commit.h
 index f445fbea49b..5f2a837b067 100644
 --- a/commit.h
 +++ b/commit.h
 @@ -17,7 +17,7 @@ struct commit {
  	struct object object;
  	void *util;
  	unsigned int index;
 -	time_t date;
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
 diff --git a/config.mak.uname b/config.mak.uname
 index aa18ed0af4d..399fe192719 100644
 --- a/config.mak.uname
 +++ b/config.mak.uname
 @@ -357,7 +357,6 @@ ifeq ($(uname_S),Windows)
  	NO_INET_PTON = YesPlease
  	NO_INET_NTOP = YesPlease
  	NO_POSIX_GOODIES = UnfortunatelyYes
 -	TIME_T_IS_INT64 = YesItIs
  	NATIVE_CRLF = YesPlease
  	DEFAULT_HELP_FORMAT = html
  
 @@ -504,7 +503,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
  	NO_INET_PTON = YesPlease
  	NO_INET_NTOP = YesPlease
  	NO_POSIX_GOODIES = UnfortunatelyYes
 -	TIME_T_IS_INT64 = YesItIs
  	DEFAULT_HELP_FORMAT = html
  	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
 index 364e5e0c5be..f3814cc47a0 100644
 --- a/credential-cache--daemon.c
 +++ b/credential-cache--daemon.c
 @@ -8,7 +8,7 @@ static struct tempfile socket_file;
  
  struct credential_cache_entry {
  	struct credential item;
 -	time_t expiration;
 +	timestamp_t expiration;
  };
  static struct credential_cache_entry *entries;
  static int entries_nr;
 @@ -47,12 +47,12 @@ static void remove_credential(const struct credential *c)
  		e->expiration = 0;
  }
  
 -static time_t check_expirations(void)
 +static timestamp_t check_expirations(void)
  {
 -	static time_t wait_for_entry_until;
 +	static timestamp_t wait_for_entry_until;
  	int i = 0;
 -	time_t now = time(NULL);
 -	time_t next = TIME_MAX;
 +	timestamp_t now = time(NULL);
 +	timestamp_t next = TIME_MAX;
  
  	/*
  	 * Initially give the client 30 seconds to actually contact us
 @@ -159,7 +159,7 @@ static void serve_one_client(FILE *in, FILE *out)
  static int serve_cache_loop(int fd)
  {
  	struct pollfd pfd;
 -	time_t wakeup;
 +	timestamp_t wakeup;
  
  	wakeup = check_expirations();
  	if (!wakeup)
 diff --git a/date.c b/date.c
 index dad2d0c807e..db3435df3e4 100644
 --- a/date.c
 +++ b/date.c
 @@ -39,14 +39,17 @@ static const char *weekday_names[] = {
  	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
  };
  
 -static time_t gm_time_t(time_t time, int tz)
 +static time_t gm_time_t(timestamp_t time, int tz)
  {
  	int minutes;
  
 +	if (date_overflows(time))
 +		die("Timestamp too large for this system: %"PRItime, time);
 +
  	minutes = tz < 0 ? -tz : tz;
  	minutes = (minutes / 100)*60 + (minutes % 100);
  	minutes = tz < 0 ? -minutes : minutes;
 -	return time + minutes * 60;
 +	return (time_t)time + minutes * 60;
  }
  
  /*
 @@ -54,9 +57,14 @@ static time_t gm_time_t(time_t time, int tz)
   * thing, which means that tz -0100 is passed in as the integer -100,
   * even though it means "sixty minutes off"
   */
 -static struct tm *time_to_tm(time_t time, int tz)
 +static struct tm *time_to_tm(timestamp_t time, int tz)
  {
 -	time_t t = gm_time_t(time, tz);
 +	time_t t;
 +
 +	if (date_overflows(time))
 +		die("Timestamp too large for this system: %"PRItime, time);
 +
 +	t = gm_time_t((time_t)time, tz);
  	return gmtime(&t);
  }
  
 @@ -64,13 +72,16 @@ static struct tm *time_to_tm(time_t time, int tz)
   * What value of "tz" was in effect back then at "time" in the
   * local timezone?
   */
 -static int local_tzoffset(time_t time)
 +static int local_tzoffset(timestamp_t time)
  {
  	time_t t, t_local;
  	struct tm tm;
  	int offset, eastwest;
  
 -	t = time;
 +	if (date_overflows(time))
 +		die("Timestamp too large for this system: %"PRItime, time);
 +
 +	t = (time_t)time;
  	localtime_r(&t, &tm);
  	t_local = tm_to_time_t(&tm);
  
 @@ -88,11 +99,11 @@ static int local_tzoffset(time_t time)
  	return offset * eastwest;
  }
  
 -void show_date_relative(time_t time, int tz,
 +void show_date_relative(timestamp_t time, int tz,
  			       const struct timeval *now,
  			       struct strbuf *timebuf)
  {
 -	time_t diff;
 +	timestamp_t diff;
  	if (now->tv_sec < time) {
  		strbuf_addstr(timebuf, _("in the future"));
  		return;
 @@ -140,9 +151,9 @@ void show_date_relative(time_t time, int tz,
  	}
  	/* Give years and months for 5 years or so */
  	if (diff < 1825) {
 -		time_t totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
 -		time_t years = totalmonths / 12;
 -		time_t months = totalmonths % 12;
 +		timestamp_t totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
 +		timestamp_t years = totalmonths / 12;
 +		timestamp_t months = totalmonths % 12;
  		if (months) {
  			struct strbuf sb = STRBUF_INIT;
  			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
 @@ -172,7 +183,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
  	return &mode;
  }
  
 -const char *show_date(time_t time, int tz, const struct date_mode *mode)
 +const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
  {
  	struct tm *tm;
  	static struct strbuf timebuf = STRBUF_INIT;
 @@ -425,7 +436,7 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
  	return 0;
  }
  
 -static int match_multi_number(time_t num, char c, const char *date,
 +static int match_multi_number(timestamp_t num, char c, const char *date,
  			      char *end, struct tm *tm, time_t now)
  {
  	struct tm now_tm;
 @@ -508,7 +519,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
  {
  	int n;
  	char *end;
 -	time_t num;
 +	timestamp_t num;
  
  	num = parse_timestamp(date, &end, 10);
  
 @@ -635,7 +646,7 @@ static int match_tz(const char *date, int *offp)
  	return end - date;
  }
  
 -static void date_string(time_t date, int offset, struct strbuf *buf)
 +static void date_string(timestamp_t date, int offset, struct strbuf *buf)
  {
  	int sign = '+';
  
 @@ -650,10 +661,10 @@ static void date_string(time_t date, int offset, struct strbuf *buf)
   * Parse a string like "0 +0000" as ancient timestamp near epoch, but
   * only when it appears not as part of any other string.
   */
 -static int match_object_header_date(const char *date, time_t *timestamp, int *offset)
 +static int match_object_header_date(const char *date, timestamp_t *timestamp, int *offset)
  {
  	char *end;
 -	time_t stamp;
 +	timestamp_t stamp;
  	int ofs;
  
  	if (*date < '0' || '9' < *date)
 @@ -675,11 +686,11 @@ static int match_object_header_date(const char *date, time_t *timestamp, int *of
  
  /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
     (i.e. English) day/month names, and it doesn't work correctly with %z. */
 -int parse_date_basic(const char *date, time_t *timestamp, int *offset)
 +int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
  {
  	struct tm tm;
  	int tm_gmt;
 -	time_t dummy_timestamp;
 +	timestamp_t dummy_timestamp;
  	int dummy_offset;
  
  	if (!timestamp)
 @@ -747,7 +758,7 @@ int parse_date_basic(const char *date, time_t *timestamp, int *offset)
  	return 0; /* success */
  }
  
 -int parse_expiry_date(const char *date, time_t *timestamp)
 +int parse_expiry_date(const char *date, timestamp_t *timestamp)
  {
  	int errors = 0;
  
 @@ -771,7 +782,7 @@ int parse_expiry_date(const char *date, time_t *timestamp)
  
  int parse_date(const char *date, struct strbuf *result)
  {
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	int offset;
  	if (parse_date_basic(date, &timestamp, &offset))
  		return -1;
 @@ -1066,7 +1077,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
  				     time_t now)
  {
  	char *end;
 -	time_t number = parse_timestamp(date, &end, 10);
 +	timestamp_t number = parse_timestamp(date, &end, 10);
  
  	switch (*end) {
  	case ':':
 @@ -1114,9 +1125,9 @@ static void pending_number(struct tm *tm, int *num)
  	}
  }
  
 -static time_t approxidate_str(const char *date,
 -				     const struct timeval *tv,
 -				     int *error_ret)
 +static timestamp_t approxidate_str(const char *date,
 +				   const struct timeval *tv,
 +				   int *error_ret)
  {
  	int number = 0;
  	int touched = 0;
 @@ -1148,12 +1159,12 @@ static time_t approxidate_str(const char *date,
  	pending_number(&tm, &number);
  	if (!touched)
  		*error_ret = 1;
 -	return update_tm(&tm, &now, 0);
 +	return (timestamp_t)update_tm(&tm, &now, 0);
  }
  
 -time_t approxidate_relative(const char *date, const struct timeval *tv)
 +timestamp_t approxidate_relative(const char *date, const struct timeval *tv)
  {
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	int offset;
  	int errors = 0;
  
 @@ -1162,10 +1173,10 @@ time_t approxidate_relative(const char *date, const struct timeval *tv)
  	return approxidate_str(date, tv, &errors);
  }
  
 -time_t approxidate_careful(const char *date, int *error_ret)
 +timestamp_t approxidate_careful(const char *date, int *error_ret)
  {
  	struct timeval tv;
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	int offset;
  	int dummy = 0;
  	if (!error_ret)
 @@ -1180,7 +1191,7 @@ time_t approxidate_careful(const char *date, int *error_ret)
  	return approxidate_str(date, &tv, error_ret);
  }
  
 -int date_overflows(time_t t)
 +int date_overflows(timestamp_t t)
  {
  	time_t sys;
  
 diff --git a/fetch-pack.c b/fetch-pack.c
 index bea2f59299d..b4b2475e7a6 100644
 --- a/fetch-pack.c
 +++ b/fetch-pack.c
 @@ -392,7 +392,7 @@ static int find_common(struct fetch_pack_args *args,
  	if (args->depth > 0)
  		packet_buf_write(&req_buf, "deepen %d", args->depth);
  	if (args->deepen_since) {
 -		time_t max_age = approxidate(args->deepen_since);
 +		timestamp_t max_age = approxidate(args->deepen_since);
  		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
  	}
  	if (args->deepen_not) {
 @@ -581,7 +581,7 @@ static int mark_complete_oid(const char *refname, const struct object_id *oid,
  }
  
  static void mark_recent_complete_commits(struct fetch_pack_args *args,
 -					 time_t cutoff)
 +					 timestamp_t cutoff)
  {
  	while (complete && cutoff <= complete->item->date) {
  		print_verbose(args, _("Marking %s as complete"),
 @@ -668,7 +668,7 @@ static int everything_local(struct fetch_pack_args *args,
  {
  	struct ref *ref;
  	int retval;
 -	time_t cutoff = 0;
 +	timestamp_t cutoff = 0;
  
  	save_commit_buffer = 0;
  
 diff --git a/git-compat-util.h b/git-compat-util.h
 index cb68e700d5e..c678ca94b8f 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -319,14 +319,13 @@ extern char *gitdirname(char *);
  #define PRIo32 "o"
  #endif
  
 -#ifdef TIME_T_IS_INT64
 -#define PRItime PRId64
 -#define parse_timestamp strtoull
 -#define TIME_MAX INT64_MAX
 +typedef uintmax_t timestamp_t;
 +#define PRItime PRIuMAX
 +#define parse_timestamp strtoumax
 +#ifdef ULLONG_MAX
 +#define TIME_MAX ULLONG_MAX
  #else
 -#define PRItime "lu"
 -#define parse_timestamp strtoul
 -#define TIME_MAX LONG_MAX
 +#define TIME_MAX ULONG_MAX
  #endif
  
  #ifndef PATH_SEP
 diff --git a/http-backend.c b/http-backend.c
 index 4e88735a9e3..d6ea6075339 100644
 --- a/http-backend.c
 +++ b/http-backend.c
 @@ -90,7 +90,7 @@ static void hdr_int(struct strbuf *hdr, const char *name, uintmax_t value)
  	strbuf_addf(hdr, "%s: %" PRIuMAX "\r\n", name, value);
  }
  
 -static void hdr_date(struct strbuf *hdr, const char *name, time_t when)
 +static void hdr_date(struct strbuf *hdr, const char *name, timestamp_t when)
  {
  	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
  	hdr_str(hdr, name, value);
 @@ -105,7 +105,7 @@ static void hdr_nocache(struct strbuf *hdr)
  
  static void hdr_cache_forever(struct strbuf *hdr)
  {
 -	time_t now = time(NULL);
 +	timestamp_t now = time(NULL);
  	hdr_date(hdr, "Date", now);
  	hdr_date(hdr, "Expires", now + 31536000);
  	hdr_str(hdr, "Cache-Control", "public, max-age=31536000");
 diff --git a/parse-options-cb.c b/parse-options-cb.c
 index a560d8d0b8c..ff3b7fa7aaa 100644
 --- a/parse-options-cb.c
 +++ b/parse-options-cb.c
 @@ -31,14 +31,14 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
  int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
  			     int unset)
  {
 -	*(time_t *)(opt->value) = approxidate(arg);
 +	*(timestamp_t *)(opt->value) = approxidate(arg);
  	return 0;
  }
  
  int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
  			     int unset)
  {
 -	return parse_expiry_date(arg, (time_t *)opt->value);
 +	return parse_expiry_date(arg, (timestamp_t *)opt->value);
  }
  
  int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 diff --git a/pretty.c b/pretty.c
 index 703eaf66586..587d48371b0 100644
 --- a/pretty.c
 +++ b/pretty.c
 @@ -405,7 +405,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
  const char *show_ident_date(const struct ident_split *ident,
  			    const struct date_mode *mode)
  {
 -	time_t date = 0;
 +	timestamp_t date = 0;
  	long tz = 0;
  
  	if (ident->date_begin && ident->date_end)
 diff --git a/reachable.c b/reachable.c
 index f6285f66726..682418f5d23 100644
 --- a/reachable.c
 +++ b/reachable.c
 @@ -55,7 +55,7 @@ static void mark_commit(struct commit *c, void *data)
  
  struct recent_data {
  	struct rev_info *revs;
 -	time_t timestamp;
 +	timestamp_t timestamp;
  };
  
  static void add_recent_object(const struct object_id *oid,
 @@ -139,7 +139,7 @@ static int add_recent_packed(const struct object_id *oid,
  }
  
  int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 -					   time_t timestamp)
 +					   timestamp_t timestamp)
  {
  	struct recent_data data;
  	int r;
 @@ -156,7 +156,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
  }
  
  void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 -			    time_t mark_recent, struct progress *progress)
 +			    timestamp_t mark_recent, struct progress *progress)
  {
  	struct connectivity_progress cp;
  
 diff --git a/reachable.h b/reachable.h
 index 2a7f6588941..3c00fa0526c 100644
 --- a/reachable.h
 +++ b/reachable.h
 @@ -3,8 +3,8 @@
  
  struct progress;
  extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 -						  time_t timestamp);
 +						  timestamp_t timestamp);
  extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 -				   time_t mark_recent, struct progress *);
 +				   timestamp_t mark_recent, struct progress *);
  
  #endif
 diff --git a/ref-filter.c b/ref-filter.c
 index 08ded90f363..4fdacda0887 100644
 --- a/ref-filter.c
 +++ b/ref-filter.c
 @@ -849,7 +849,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
  {
  	const char *eoemail = strstr(buf, "> ");
  	char *zone;
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	long tz;
  	struct date_mode date_mode = { DATE_NORMAL };
  	const char *formatp;
 diff --git a/reflog-walk.c b/reflog-walk.c
 index 674930e47d3..3ca5ed8415a 100644
 --- a/reflog-walk.c
 +++ b/reflog-walk.c
 @@ -12,7 +12,7 @@ struct complete_reflogs {
  	struct reflog_info {
  		struct object_id ooid, noid;
  		char *email;
 -		time_t timestamp;
 +		timestamp_t timestamp;
  		int tz;
  		char *message;
  	} *items;
 @@ -69,7 +69,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
  }
  
  static int get_reflog_recno_by_time(struct complete_reflogs *array,
 -	time_t timestamp)
 +	timestamp_t timestamp)
  {
  	int i;
  	for (i = array->nr - 1; i >= 0; i--)
 @@ -141,7 +141,7 @@ void init_reflog_walk(struct reflog_walk_info **info)
  int add_reflog_for_walk(struct reflog_walk_info *info,
  		struct commit *commit, const char *name)
  {
 -	time_t timestamp = 0;
 +	timestamp_t timestamp = 0;
  	int recno = -1;
  	struct string_list_item *item;
  	struct complete_reflogs *reflogs;
 diff --git a/refs.c b/refs.c
 index 2549caa9403..6018b3104c6 100644
 --- a/refs.c
 +++ b/refs.c
 @@ -659,7 +659,7 @@ int is_branch(const char *refname)
  
  struct read_ref_at_cb {
  	const char *refname;
 -	time_t at_time;
 +	timestamp_t at_time;
  	int cnt;
  	int reccnt;
  	unsigned char *sha1;
 @@ -668,9 +668,9 @@ struct read_ref_at_cb {
  	unsigned char osha1[20];
  	unsigned char nsha1[20];
  	int tz;
 -	time_t date;
 +	timestamp_t date;
  	char **msg;
 -	time_t *cutoff_time;
 +	timestamp_t *cutoff_time;
  	int *cutoff_tz;
  	int *cutoff_cnt;
  };
 @@ -743,9 +743,9 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
  	return 1;
  }
  
 -int read_ref_at(const char *refname, unsigned int flags, time_t at_time, int cnt,
 +int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
  		unsigned char *sha1, char **msg,
 -		time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 +		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
  {
  	struct read_ref_at_cb cb;
  
 diff --git a/refs.h b/refs.h
 index 747cd10af46..cc79ae4b8ed 100644
 --- a/refs.h
 +++ b/refs.h
 @@ -262,9 +262,9 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
  
  /** Reads log for the value of ref during at_time. **/
  int read_ref_at(const char *refname, unsigned int flags,
 -		time_t at_time, int cnt,
 +		timestamp_t at_time, int cnt,
  		unsigned char *sha1, char **msg,
 -		time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 +		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
  
  /** Check if a particular reflog exists */
  int reflog_exists(const char *refname);
 @@ -537,7 +537,7 @@ typedef void reflog_expiry_prepare_fn(const char *refname,
  typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
  					  unsigned char *nsha1,
  					  const char *email,
 -					  time_t timestamp, int tz,
 +					  timestamp_t timestamp, int tz,
  					  const char *message, void *cb_data);
  typedef void reflog_expiry_cleanup_fn(void *cb_data);
  
 diff --git a/refs/files-backend.c b/refs/files-backend.c
 index a5486577b47..a27a67dd2ad 100644
 --- a/refs/files-backend.c
 +++ b/refs/files-backend.c
 @@ -3104,7 +3104,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
  {
  	struct object_id ooid, noid;
  	char *email_end, *message;
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	int tz;
  	const char *p = sb->buf;
  
 @@ -3114,7 +3114,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
  	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
  	    !(email_end = strchr(p, '>')) ||
  	    email_end[1] != ' ' ||
 -	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
 +	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
  	    !message || message[0] != ' ' ||
  	    (message[1] != '+' && message[1] != '-') ||
  	    !isdigit(message[2]) || !isdigit(message[3]) ||
 @@ -3976,7 +3976,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
  			printf("prune %s", message);
  	} else {
  		if (cb->newlog) {
 -			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
 +			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
  				oid_to_hex(ooid), oid_to_hex(noid),
  				email, timestamp, tz, message);
  			oidcpy(&cb->last_kept_oid, noid);
 diff --git a/revision.c b/revision.c
 index e95d680ca68..8a8c1789c7b 100644
 --- a/revision.c
 +++ b/revision.c
 @@ -884,7 +884,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
  /* How many extra uninteresting commits we want to see.. */
  #define SLOP 5
  
 -static int still_interesting(struct commit_list *src, time_t date, int slop,
 +static int still_interesting(struct commit_list *src, timestamp_t date, int slop,
  			     struct commit **interesting_cache)
  {
  	/*
 @@ -1018,7 +1018,7 @@ static void limit_left_right(struct commit_list *list, struct rev_info *revs)
  static int limit_list(struct rev_info *revs)
  {
  	int slop = SLOP;
 -	time_t date = ~0ul;
 +	timestamp_t date = TIME_MAX;
  	struct commit_list *list = revs->commits;
  	struct commit_list *newlist = NULL;
  	struct commit_list **p = &newlist;
 diff --git a/revision.h b/revision.h
 index 623bb588cb1..0d9e68b36e9 100644
 --- a/revision.h
 +++ b/revision.h
 @@ -181,8 +181,8 @@ struct rev_info {
  	/* special limits */
  	int skip_count;
  	int max_count;
 -	time_t max_age;
 -	time_t min_age;
 +	timestamp_t max_age;
 +	timestamp_t min_age;
  	int min_parents;
  	int max_parents;
  	int (*include_check)(struct commit *, void *);
 diff --git a/sha1_name.c b/sha1_name.c
 index 42e794d4c0b..8ab1744ebab 100644
 --- a/sha1_name.c
 +++ b/sha1_name.c
 @@ -658,8 +658,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
  
  	if (reflog_len) {
  		int nth, i;
 -		time_t at_time;
 -		time_t co_time;
 +		timestamp_t at_time;
 +		timestamp_t co_time;
  		int co_tz, co_cnt;
  
  		/* Is it asking for N-th entry, or approxidate? */
 diff --git a/t/helper/test-date.c b/t/helper/test-date.c
 index 371f9d259c6..f414a3ac670 100644
 --- a/t/helper/test-date.c
 +++ b/t/helper/test-date.c
 @@ -5,7 +5,8 @@ static const char *usage_msg = "\n"
  "  test-date show:<format> [time_t]...\n"
  "  test-date parse [date]...\n"
  "  test-date approxidate [date]...\n"
 -"  test-date is64bit\n";
 +"  test-date is64bit\n"
 +"  test-date time_t-is64bit\n";
  
  static void show_relative_dates(const char **argv, struct timeval *now)
  {
 @@ -26,7 +27,7 @@ static void show_dates(const char **argv, const char *format)
  	parse_date_format(format, &mode);
  	for (; *argv; argv++) {
  		char *arg;
 -		time_t t;
 +		timestamp_t t;
  		int tz;
  
  		/*
 @@ -47,7 +48,7 @@ static void parse_dates(const char **argv, struct timeval *now)
  	struct strbuf result = STRBUF_INIT;
  
  	for (; *argv; argv++) {
 -		time_t t;
 +		timestamp_t t;
  		int tz;
  
  		strbuf_reset(&result);
 @@ -64,7 +65,7 @@ static void parse_dates(const char **argv, struct timeval *now)
  static void parse_approxidate(const char **argv, struct timeval *now)
  {
  	for (; *argv; argv++) {
 -		time_t t;
 +		timestamp_t t;
  		t = approxidate_relative(*argv, now);
  		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
  	}
 @@ -95,6 +96,8 @@ int cmd_main(int argc, const char **argv)
  	else if (!strcmp(*argv, "approxidate"))
  		parse_approxidate(argv+1, &now);
  	else if (!strcmp(*argv, "is64bit"))
 +		return sizeof(timestamp_t) == 8 ? 0 : 1;
 +	else if (!strcmp(*argv, "time_t-is64bit"))
  		return sizeof(time_t) == 8 ? 0 : 1;
  	else
  		usage(usage_msg);
 diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
 index 8af62dd7501..75fe883aac1 100644
 --- a/t/helper/test-parse-options.c
 +++ b/t/helper/test-parse-options.c
 @@ -5,7 +5,7 @@
  static int boolean = 0;
  static int integer = 0;
  static unsigned long magnitude = 0;
 -static time_t timestamp;
 +static timestamp_t timestamp;
  static int abbrev = 7;
  static int verbose = -1; /* unspecified */
  static int dry_run = 0, quiet = 0;
 diff --git a/t/t0006-date.sh b/t/t0006-date.sh
 index 9539b425ffb..42d4ea61ef5 100755
 --- a/t/t0006-date.sh
 +++ b/t/t0006-date.sh
 @@ -53,8 +53,8 @@ check_show unix-local "$TIME" '1466000000'
  
  # arbitrary time absurdly far in the future
  FUTURE="5758122296 -0400"
 -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT
 -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT
 +check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
 +check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
  
  check_parse() {
  	echo "$1 -> $2" >expect
 diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
 index 997aa9dea28..fe2d4f15a73 100755
 --- a/t/t5000-tar-tree.sh
 +++ b/t/t5000-tar-tree.sh
 @@ -402,7 +402,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
  	git archive HEAD >future.tar
  '
  
 -test_expect_success TAR_HUGE,TIME_IS_64BIT 'system tar can read our future mtime' '
 +test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
  	echo 4147 >expect &&
  	tar_info future.tar | cut -d" " -f2 >actual &&
  	test_cmp expect actual
 diff --git a/t/test-lib.sh b/t/test-lib.sh
 index beee1d847ff..8d25cb7c183 100644
 --- a/t/test-lib.sh
 +++ b/t/test-lib.sh
 @@ -1166,3 +1166,4 @@ test_lazy_prereq LONG_IS_64BIT '
  '
  
  test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
 +test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
 diff --git a/tag.c b/tag.c
 index a0b22c788b6..d71b67e8d83 100644
 --- a/tag.c
 +++ b/tag.c
 @@ -97,7 +97,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
  	return object_as_type(obj, OBJ_TAG, 0);
  }
  
 -static time_t parse_tag_date(const char *buf, const char *tail)
 +static timestamp_t parse_tag_date(const char *buf, const char *tail)
  {
  	const char *dateptr;
  
 @@ -110,7 +110,7 @@ static time_t parse_tag_date(const char *buf, const char *tail)
  		/* nada */;
  	if (buf >= tail)
  		return 0;
 -	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
 +	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
  	return parse_timestamp(dateptr, NULL, 10);
  }
  
 diff --git a/tag.h b/tag.h
 index aaf56849de8..2abb3726fb5 100644
 --- a/tag.h
 +++ b/tag.h
 @@ -9,7 +9,7 @@ struct tag {
  	struct object object;
  	struct object *tagged;
  	char *tag;
 -	time_t date;
 +	timestamp_t date;
  };
  
  extern struct tag *lookup_tag(const unsigned char *sha1);
 diff --git a/upload-pack.c b/upload-pack.c
 index df9b8476991..97da13e6a54 100644
 --- a/upload-pack.c
 +++ b/upload-pack.c
 @@ -35,7 +35,7 @@ static const char * const upload_pack_usage[] = {
  #define CLIENT_SHALLOW	(1u << 18)
  #define HIDDEN_REF	(1u << 19)
  
 -static time_t oldest_have;
 +static timestamp_t oldest_have;
  
  static int deepen_relative;
  static int multi_ack;
 @@ -735,7 +735,7 @@ static void receive_needs(void)
  	struct string_list deepen_not = STRING_LIST_INIT_DUP;
  	int depth = 0;
  	int has_non_tip = 0;
 -	time_t deepen_since = 0;
 +	timestamp_t deepen_since = 0;
  	int deepen_rev_list = 0;
  
  	shallow_nr = 0;
 diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
 index 5df87ce6bb4..5a89db30e3f 100644
 --- a/vcs-svn/fast_export.c
 +++ b/vcs-svn/fast_export.c
 @@ -68,7 +68,7 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
  }
  
  void fast_export_begin_note(uint32_t revision, const char *author,
 -		const char *log, time_t timestamp, const char *note_ref)
 +		const char *log, timestamp_t timestamp, const char *note_ref)
  {
  	static int firstnote = 1;
  	size_t loglen = strlen(log);
 @@ -93,7 +93,7 @@ static char gitsvnline[MAX_GITSVN_LINE_LEN];
  void fast_export_begin_commit(uint32_t revision, const char *author,
  			const struct strbuf *log,
  			const char *uuid, const char *url,
 -			time_t timestamp, const char *local_ref)
 +			timestamp_t timestamp, const char *local_ref)
  {
  	static const struct strbuf empty = STRBUF_INIT;
  	if (!log)
 diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
 index 864dada2b31..b9a3b71c99f 100644
 --- a/vcs-svn/fast_export.h
 +++ b/vcs-svn/fast_export.h
 @@ -11,10 +11,10 @@ void fast_export_delete(const char *path);
  void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
  void fast_export_note(const char *committish, const char *dataref);
  void fast_export_begin_note(uint32_t revision, const char *author,
 -		const char *log, time_t timestamp, const char *note_ref);
 +		const char *log, timestamp_t timestamp, const char *note_ref);
  void fast_export_begin_commit(uint32_t revision, const char *author,
  			const struct strbuf *log, const char *uuid,const char *url,
 -			time_t timestamp, const char *local_ref);
 +			timestamp_t timestamp, const char *local_ref);
  void fast_export_end_commit(uint32_t revision);
  void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
  void fast_export_buf_to_data(const struct strbuf *data);
 diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
 index 9e1eb8d4176..1846685a21a 100644
 --- a/vcs-svn/svndump.c
 +++ b/vcs-svn/svndump.c
 @@ -47,7 +47,7 @@ static struct {
  
  static struct {
  	uint32_t revision;
 -	time_t timestamp;
 +	timestamp_t timestamp;
  	struct strbuf log, author, note;
  } rev_ctx;
  

-- 
2.12.2.windows.1

