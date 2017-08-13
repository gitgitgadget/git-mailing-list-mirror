Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513FF20899
	for <e@80x24.org>; Sun, 13 Aug 2017 08:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbdHMIvR (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 04:51:17 -0400
Received: from mout.web.de ([212.227.17.11]:52802 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdHMIvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 04:51:15 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK20H-1diCBl3OJZ-001Tud; Sun, 13
 Aug 2017 10:51:08 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 2/2] File commited with CRLF should roundtrip diff and apply
Date:   Sun, 13 Aug 2017 10:51:06 +0200
Message-Id: <20170813085106.1731-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:t4aZxuBQncEWmMu+N64A5Qx53FeA3D/4yiKCVBxAAbAo3p73HBF
 bnhG2XRu6fQziAJ6NSLQu1kS6jUoAOL3FyH1EAKRuOJ9hQYRliAmAESjO/jq1tyEK/i4wed
 xyzbXxvNAXVr5wekzccawV/DX1xqDcscoAEdXf+e4QHmwEqmzLBII1VUjMfhYtGwYciYqkc
 jTSl661rgr7+1veF2LG6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1W31w7b9gJU=:tpmNuKbcetBwp2ICVtHDah
 TATPZro0VNPXIqSBRCLD7eXYHNv8h3E2Ry1QLZ2UQqhU6BT+lrmt4s77UoL/xgcS8SxLit2fE
 CpsgKgaMVTapP1kUGM8OefkxovrbfV6FKr/2lef81PhYhQMp78sz7vaqyv7MopfH6gdls+o6y
 7i3KsFHiq4iHDsPG5WY10xkyHWsmSBGo8fRUIvUD6P65yzHlpxFZr1ahiESm+niO+zMexf+s8
 vno4ArZnJi9+MSC785HE3mU7zDy8rMa4BqSBqQsTC/PqkDitjCYnIrpY5QhVHU+Ne3bGERZtp
 jr73wGTLxtrP+o/2fFnl4VEPM4tOqcfuoji7CCW+1pmrirAwJKXzqfRcG8RR9ZoalxKF85sgD
 lBVNxvVAdMsJvj7eFfROpoaDQHLeqXLSfUOXI2jyHN/i3jnW+E3LE3R4kp50wsapd7MDWmzT4
 TPeS2mdgllRt3Muk9WnzJd0qVOuXA3YMO4wjDmb0tfhaY/3wnG1aMgPyGXQGoiJscD3Pbqsfq
 s/J4p54vefKWMKiY935JPx/GYYnrzehvwtbQm45DsCYilgHqNbuYB4AA8wsAKcdZ02HlAhs/3
 7lkuBePbo4ynor+aDDJT9OxixumrNkpxdfnAEKY6P+apQ8yobUfXCFLitX7Hax8cm9/eGZonU
 eNxXVn8Su8RpLFomCebyVmqy5ZaKT21TGfDOIVoin8ZWWpK/G8L7c0Z8ttHghbkEjotH03Vk7
 mOv6Gt6IFj+sYLsfWracW4++8PUabelAAmdoM44Zbj+ELVERpY5GvwnNx3E97bPyx3ERA4AJB
 unrazP4RpD5C002RFwLSxAkQIcbS1YfzzX79pzq8Onv0FOVVpo=
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


The last version did not pass t4124, fix this.



apply.c                  | 37 ++++++++++++++++++++++++++++---------
 apply.h                  |  4 ++++
 t/t4124-apply-ws-rule.sh |  3 +--
 t/t4140-apply-CRLF.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 11 deletions(-)
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
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index d350065f25..4da6e6e894 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -475,11 +475,10 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol unset' '
 	cp one save-one &&
 	printf "                 \r\n" >>one &&
 	git add one &&
-	cp one expect &&
 	printf "d\r\n" >>one &&
+	cp one expect &&
 	git diff -- one >patch &&
 	mv save-one one &&
-	echo d >>expect &&
 
 	git apply --ignore-space-change --whitespace=fix patch &&
 	test_cmp one expect
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

