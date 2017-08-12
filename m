Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C376208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 14:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdHLO4f (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 10:56:35 -0400
Received: from mout.web.de ([212.227.15.4]:50014 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdHLO4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 10:56:33 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ome-1dnBgI1YAy-00B7fw; Sat, 12
 Aug 2017 16:56:26 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC] File commited with CRLF should roundtrip diff and apply
Date:   Sat, 12 Aug 2017 16:56:25 +0200
Message-Id: <20170812145625.31560-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YwjeL4nHTMr9yjl7F20/Qm4V658zBfZA7DPMMBivLuc3LU6RjTR
 xF6yAEHr5/Qs8pgS+uRrcfei+FslvocQsrdhvhA0CPpuJknpR+TLc3FmpTE2gNvMxGC+R9o
 nABrvPFqJax9WZapgPm0nX0IzsutxOZPX8cQUfWvS71xEN7fZGfQZx6PkxQC2I9OjJTSvz5
 5et/DB6c8TwOdTE63Zo9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jezdleXlv9o=:JWORnToSpJtjT2RrZIhC4l
 6LUaAP6bFrNn5XkLr7+Vzt36gosqmMmpRwYzHfb1++TkoSI/MFnN7zjQQUJ9bwxFsMHZBBwaW
 0WzV4Tl9WNy2xGXwJuYf4JbIUh0n19foQg6ATKHIovV9cOuBlEiooMpq8oLuy/IsD9RcId8k6
 a09JRI4ckEz7BjsbuuQ0LgTDuyAVYKktx+ZXY+LbSBDu00jfWWjVJUp7uV+11vc/iuHLpNZAf
 Xv2d3xyRCjdRulW3M3LTtu0kyNH9B569FBTdF9CQxAOEjQf2Lyu5Wjk2NcggVx7dYnyVDWfLs
 603p5d1QMGmbvbwNLMzMmgz3ddoaFRKSHpLSmzS19eDCDr2a0Qu5HIzvy8dUUpEEmX4P42Vtr
 jwGJFf3GBMD6HeqVAO54KOQbuA4975bv6PYSiPNRuaj06rFh3uQKBfjU26F53yF0hTR8cDGXM
 T9MPPQ9hNWw0RfGbDZl/bqbJta2dqRcmvhDV3SYKadvIEtfbQWdUtcT/uvo1g8Y9tjTE4usCr
 GSl1lIKkQvgrCZtvPcCYrbNCXEi21qkyTjq+trO7vcluCkCkmLrPTMoGIWRO0O3YOapUwMMoT
 LABmwrn+bI9I58GooW4QCH1MGWceNLU51czESa5bhG+TmwhCf1ds3dzEDdyEzTh6pto8nkgqh
 JfIgY4bD20cnP/yiEdsfshnuKH3hdvJhmGw7p/hpoEY4ZzPRpfa6+6d6SG6liSyNWjhqbGi9C
 FQZrcj9f1kOfwLkz4mqBBDSztx/P+eiM1nrEnqVEFQ0K2NNAB4pIz7R1z13KlFO5LcYz8pMEn
 NBNm5UyBaMzmQ40xfd945mHL1CM2lWxiYAJH1Y6gYC+4XatJyE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a file had been commited with CRLF and core.autocrlf is true,
the following does not roundtrip, `git apply` fails:

printf "Added line\r\n" >>file &&
git diff >patch &&
git checkout -- . &&
git apply patch

Before applying the patch, the file from working tree is converted into the
index format (clean filter, CRLF conversion, ...)
Here, when commited with CRLF, the line endings should not be converted.

Analyze the patch if there is any context line with CRLF,
or if any line with CRLF is to be removed.

If yes, the new flag has_crlf is set in "struct patch", and two things
will happen:
- read_old_data() will not convert CRLF into LF by calling
  convert_to_git(..., SAFE_CRLF_KEEP_CRLF);
- The WS_CR_AT_EOL bit is set in the "white space rule",
  CRLF are no longer treated as white space.

Thanks to Junio C Hamano, his input became the base for t4140.

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 apply.c               | 37 ++++++++++++++++++++++++++++---------
 apply.h               |  4 ++++
 t/t4140-apply-CRLF.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 9 deletions(-)
 create mode 100755 t/t4140-apply-CRLF.sh

diff --git a/apply.c b/apply.c
index f2d599141d..63455cd65f 100644
--- a/apply.c
+++ b/apply.c
@@ -220,6 +220,7 @@ struct patch {
 	unsigned int recount:1;
 	unsigned int conflicted_threeway:1;
 	unsigned int direct_to_threeway:1;
+	unsigned int has_crlf:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -1662,6 +1663,17 @@ static void check_whitespace(struct apply_state *state,
 	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
+/* Check if the patch has context lines with CRLF or
+   the patch wants to remove lines with CRLF */
+static void check_old_for_crlf(struct patch *patch, const char *line, int len)
+{
+	if (len >= 2 && line[len-1] == '\n' && line[len-2] == '\r') {
+		patch->ws_rule |= WS_CR_AT_EOL;
+		patch->has_crlf = 1;
+	}
+}
+
+
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
@@ -1712,11 +1724,13 @@ static int parse_fragment(struct apply_state *state,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
+			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action == correct_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
+			check_old_for_crlf(patch, line, len);
 			if (state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -2268,8 +2282,10 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
-static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
+static int read_old_data(struct stat *st, const char *path, struct strbuf *buf, int flags)
 {
+	enum safe_crlf safe_crlf = flags & APPLY_FLAGS_CR_AT_EOL ?
+		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_FALSE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2278,7 +2294,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
+		convert_to_git(&the_index, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
@@ -3385,7 +3401,8 @@ static int load_patch_target(struct apply_state *state,
 			     const struct cache_entry *ce,
 			     struct stat *st,
 			     const char *name,
-			     unsigned expected_mode)
+			     unsigned expected_mode,
+			     int flags)
 {
 	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
@@ -3399,7 +3416,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf))
+			if (read_old_data(st, name, buf, flags))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3423,6 +3440,7 @@ static int load_preimage(struct apply_state *state,
 	char *img;
 	struct patch *previous;
 	int status;
+	int flags = patch->has_crlf ? APPLY_FLAGS_CR_AT_EOL : 0;
 
 	previous = previous_patch(state, patch, &status);
 	if (status)
@@ -3433,7 +3451,7 @@ static int load_preimage(struct apply_state *state,
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
 		status = load_patch_target(state, &buf, ce, st,
-					   patch->old_name, patch->old_mode);
+					   patch->old_name, patch->old_mode, flags);
 		if (status < 0)
 			return status;
 		else if (status == SUBMODULE_PATCH_WITHOUT_INDEX) {
@@ -3493,7 +3511,8 @@ static int three_way_merge(struct image *image,
  */
 static int load_current(struct apply_state *state,
 			struct image *image,
-			struct patch *patch)
+			struct patch *patch,
+			int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status, pos;
@@ -3520,7 +3539,7 @@ static int load_current(struct apply_state *state,
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(state, &buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, name, mode, flags);
 	if (status < 0)
 		return status;
 	else if (status)
@@ -3571,7 +3590,8 @@ static int try_threeway(struct apply_state *state,
 
 	/* our_oid is ours */
 	if (patch->is_new) {
-		if (load_current(state, &tmp_image, patch))
+		int flags = 0;
+		if (load_current(state, &tmp_image, patch, flags))
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->new_name);
 	} else {
@@ -3617,7 +3637,6 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
-
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
diff --git a/apply.h b/apply.h
index b3d6783d55..192140280f 100644
--- a/apply.h
+++ b/apply.h
@@ -33,9 +33,13 @@ enum apply_verbosity {
 #define APPLY_SYMLINK_GOES_AWAY 01
 #define APPLY_SYMLINK_IN_RESULT 02
 
+
+#define APPLY_FLAGS_CR_AT_EOL   (1<<0)
+
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
+	int flags;
 
 	/* These are lock_file related */
 	struct lock_file *lock_file;
diff --git a/t/t4140-apply-CRLF.sh b/t/t4140-apply-CRLF.sh
new file mode 100755
index 0000000000..fd528daabd
--- /dev/null
+++ b/t/t4140-apply-CRLF.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='CRLF diff and apply'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir upstream &&
+	(
+		cd upstream &&
+		git init &&
+		git config core.autocrlf false &&
+		>.gitignore &&
+		git add . &&
+		git commit -m gitignore &&
+		printf "F1\r\n" >FileCRLF &&
+		git add . &&
+		git commit -m initial &&
+		git diff HEAD^1 HEAD -- >../patch1
+	) &&
+	git config core.autocrlf true
+'
+
+test_expect_success 'apply patches Replace lines' '
+	(
+		cd upstream &&
+		printf "F11\r\nF12\r\n" >FileCRLF &&
+		git diff  >../patch2Replace
+	) &&
+	git apply patch1 &&
+	git apply patch2Replace
+'
+
+test_expect_success 'apply patches Add lines' '
+	(
+		cd upstream &&
+		git checkout FileCRLF &&
+		printf "F2\r\n" >>FileCRLF &&
+		git diff  >../patch2Add
+	) &&
+	rm -f FileCRLF &&
+	git apply patch1 &&
+	git apply patch2Add
+'
+
+test_done
-- 
2.14.1.145.gb3622a4ee9

