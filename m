Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB521F404
	for <e@80x24.org>; Sat, 13 Jan 2018 22:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeAMWtw (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 17:49:52 -0500
Received: from mout.web.de ([212.227.17.12]:58528 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753414AbeAMWtu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 17:49:50 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPel-1eScUz13MF-00SQeG; Sat, 13
 Jan 2018 23:49:34 +0100
From:   tboegi@web.de
To:     randall.s.becker@rogers.com, rsbecker@nexbridge.com,
        git@vger.kernel.org, larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] convert_to_git(): safe_crlf/checksafe becomes int conv_flags
Date:   Sat, 13 Jan 2018 23:49:31 +0100
Message-Id: <20180113224931.27031-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g00e34bdac6.dirty
In-Reply-To: <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KX1rM0U+BBSM5WRFQ8heR6GPx1G6lldjSukTnLCyBPaj5Ilnlu5
 jmBgyzy93b9TA63K/BKYjeawlGwDEfhp7HVaKR9ccvzVL6T5dr4KWu3ryhkSDUYwSwipF7A
 IMu1dwoQw5xu4OPcCm7EtnaAaa6CYO18g/RChADFqWRBZmTeSmS4eAUWIL0l1afbXTyGHlO
 o0X0usxFncjanAjmMBiUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lsAm8Vce9xQ=:bVuK28UUCFGYROEGf/mvBg
 5I5oSWovyhK+KwDU21+a4cB5IaHgpTtKWIG7EM2h/dBCoPiQocGXVDkW0GiCVKe31rh5nk5FW
 LJndIzNS3uk0T9ly1WEczF6BRGpjJVZeMY/StX1YDTROdtLK80ElhULaaponINT24zF9PTt/X
 F7zSLPLlAr3SgWkKC/t4v8kMtaIlw4uO/IuxkkaoEb5ZQ3DaUIjXqWaOA8q5RbvS1cSs6FG/0
 U46LNiHmDsu0jbDlwWUaQhuCYWqI1V+OaS/G+Lavm6zVEKQY2mk16iI7+OkRhDvwBjF0uytNz
 lQpEg+AFPDfJVQb7U16Wz3n7y6CYcLVm45tHW1U5y/WLaVxqnfHwuk7aTAKYv4YzcexT4zHJN
 ZXwvxO2F3tryxbwjYHkuoBcYRo+Tf/4ykDU1n4WumMUr2UxrDaSolvnGs8zUtmOOTuv7Nvabs
 wEL3BJbEbkqfHyBG9koP6EOe4t8R0Z/tfoeP/e6doR2b7ze1L/ObrNAaZHC9aTbHEh3h9Yakv
 /ZBshs3N0cVgcJSVXfi7kb/hgs8/UNa6bZ7AYd/aRt+l5+LnttSq2CupGifYhOjA+BvDYhTUH
 c/UWcSnnyipp+dS2ERTcWgd7DJbe/aeJT/+o9hdJPaHWv0g/enMiaN2KVDzCJRqCjbVS4qG0e
 g4PCcNpK7rjo1ZjNBJFtpwxQMUvRQLvdTEDz7wuyzdHVWiGpKevO6fveENqVKzQgnPOeJRRtT
 tLRJG6V0asC224X/uYQ1F5akEm+gSrP676Ziq+pMk5xt/qIn8TJBSqObiKDwxXHna6ljL3W+r
 ne5i2QQvG5gQOVAfINybUbEU/pV1/9XLsQ5GEvbalkUhxJbYtY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When calling convert_to_git(), the checksafe parameter defined what
should happen if the EOL conversion (CRLF --> LF --> CRLF) does not
roundtrip cleanly. In addition, it also defined if line endings should
be renormalized (CRLF --> LF) or kept as they are.

checksafe was an safe_crlf enum with these values:
SAFE_CRLF_FALSE:       do nothing in case of EOL roundtrip errors
SAFE_CRLF_FAIL:        die in case of EOL roundtrip errors
SAFE_CRLF_WARN:        print a warning in case of EOL roundtrip errors
SAFE_CRLF_RENORMALIZE: change CRLF to LF
SAFE_CRLF_KEEP_CRLF:   keep all line endings as they are

In some cases the integer value 0 was passed as checksafe parameter
instead of the correct enum value SAFE_CRLF_FALSE. That was no problem
because SAFE_CRLF_FALSE is defined as 0.

FALSE/FAIL/WARN are different from RENORMALIZE and KEEP_CRLF. Therefore,
an enum is not ideal. Let's use a integer bit pattern instead and rename
the parameter to conv_flags to make it more generically usable. This
allows us to extend the bit pattern in a subsequent commit.

Reported-By: Randall S. Becker <rsbecker@nexbridge.com>
Helped-By: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

 >I think this is being solved a bit differently with a1fbf854
 >("convert_to_git(): safe_crlf/checksafe becomes int conv_flags",
 >2018-01-06), and 0 becomes the right value to pass at this caller to
 >say "I am passing none of the flag bit".

 >I am hoping that the series that ends at f3b11d54 ("convert: add
 >support for 'checkout-encoding' attribute", 2018-01-06) will be
 >rerolled and hit 'master' early in the next cycle.

  Thanks for the report & suggested patch. After reading it, I suggest
  to break out the enum/int fix into an own "series".


apply.c        |  6 +++---
 combine-diff.c |  2 +-
 config.c       |  7 +++++--
 convert.c      | 38 +++++++++++++++++++-------------------
 convert.h      | 17 +++++++----------
 diff.c         |  8 ++++----
 environment.c  |  2 +-
 sha1_file.c    | 12 ++++++------
 8 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68..f8b67bfee 100644
--- a/apply.c
+++ b/apply.c
@@ -2263,8 +2263,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 static int read_old_data(struct stat *st, struct patch *patch,
 			 const char *path, struct strbuf *buf)
 {
-	enum safe_crlf safe_crlf = patch->crlf_in_old ?
-		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
+	int conv_flags = patch->crlf_in_old ?
+		CONV_EOL_KEEP_CRLF : CONV_EOL_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, conv_flags);
 		return 0;
 	default:
 		return -1;
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119..19f30c335 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/config.c b/config.c
index e617c2018..1f003fbb9 100644
--- a/config.c
+++ b/config.c
@@ -1149,11 +1149,14 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.safecrlf")) {
+		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
-			safe_crlf = SAFE_CRLF_WARN;
+			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 			return 0;
 		}
-		safe_crlf = git_config_bool(var, value);
+		eol_rndtrp_die = git_config_bool(var, value);
+		global_conv_flags_eol = eol_rndtrp_die ?
+			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
 		return 0;
 	}
 
diff --git a/convert.c b/convert.c
index 1a41a48e1..b976eb968 100644
--- a/convert.c
+++ b/convert.c
@@ -193,30 +193,30 @@ static enum eol output_eol(enum crlf_action crlf_action)
 	return core_eol;
 }
 
-static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
+static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_action,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
-			    enum safe_crlf checksafe)
+			    int conv_flags)
 {
 	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
 		 * CRLFs would not be restored by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("CRLF would be replaced by LF in %s."), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("CRLF would be replaced by LF in %s."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("LF would be replaced by CRLF in %s"), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("LF would be replaced by CRLF in %s"), path);
 	}
 }
 
@@ -268,7 +268,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, int conv_flags)
 {
 	struct text_stat stats;
 	char *dst;
@@ -298,12 +298,12 @@ static int crlf_to_git(const struct index_state *istate,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
 		    has_crlf_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
-	if ((checksafe == SAFE_CRLF_WARN ||
-	    (checksafe == SAFE_CRLF_FAIL)) && len) {
+	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
+	     ((conv_flags & CONV_EOL_RNDTRP_DIE) && len))) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
@@ -316,7 +316,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
-		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+		check_global_conv_flags_eol(path, crlf_action, &stats, &new_stats, conv_flags);
 	}
 	if (!convert_crlf_into_lf)
 		return 0;
@@ -1129,7 +1129,7 @@ const char *get_convert_attr_ascii(const char *path)
 
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, int conv_flags)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1144,8 +1144,8 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
-		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
 			src = dst->buf;
 			len = dst->len;
@@ -1156,7 +1156,7 @@ int convert_to_git(const struct index_state *istate,
 
 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      int conv_flags)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1167,7 +1167,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
@@ -1226,7 +1226,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, CONV_EOL_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 4f2da225a..65ab3e516 100644
--- a/convert.h
+++ b/convert.h
@@ -8,15 +8,12 @@
 
 struct index_state;
 
-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3,
-	SAFE_CRLF_KEEP_CRLF = 4
-};
+#define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is different */
+#define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
+#define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
+#define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
 
-extern enum safe_crlf safe_crlf;
+extern int global_conv_flags_eol;
 
 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
@@ -66,7 +63,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, int conv_flags);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -85,7 +82,7 @@ static inline int would_convert_to_git(const struct index_state *istate,
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     int conv_flags);
 extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
diff --git a/diff.c b/diff.c
index fb22b19f0..35cca04f2 100644
--- a/diff.c
+++ b/diff.c
@@ -3520,13 +3520,13 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 {
 	int size_only = flags & CHECK_SIZE_ONLY;
 	int err = 0;
+	int conv_flags = global_conv_flags_eol;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
 	 */
-	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
-				    ? SAFE_CRLF_WARN
-				    : safe_crlf);
+	if (conv_flags & CONV_EOL_RNDTRP_DIE)
+		conv_flags = CONV_EOL_RNDTRP_WARN;
 
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
@@ -3603,7 +3603,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, conv_flags)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/environment.c b/environment.c
index 63ac38a46..10a32c20a 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
-enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
+int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac65..6bc7c6ada 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -133,14 +133,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 }
 
 
-static enum safe_crlf get_safe_crlf(unsigned flags)
+static int get_conv_flags(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
-		return SAFE_CRLF_RENORMALIZE;
+		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-		return safe_crlf;
+	  return global_conv_flags_eol;
 	else
-		return SAFE_CRLF_FALSE;
+		return 0;
 }
 
 
@@ -1752,7 +1752,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags))) {
+				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1786,7 +1786,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags));
+				 get_conv_flags(flags));
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-- 
2.16.0.rc0.2.g00e34bdac6.dirty

