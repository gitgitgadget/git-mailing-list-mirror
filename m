Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D6920899
	for <e@80x24.org>; Sat, 19 Aug 2017 11:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdHSL2M (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 07:28:12 -0400
Received: from mout.web.de ([212.227.15.14]:50344 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdHSL2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 07:28:11 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC6ZE-1drnMY3Pii-008v6l; Sat, 19
 Aug 2017 13:28:02 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 2/2] File commited with CRLF should roundtrip diff and apply
Date:   Sat, 19 Aug 2017 13:28:01 +0200
Message-Id: <20170819112801.18564-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:tuVMWie4idetcbQ0iinVsC8ZH+poadYFlYzcDp4howmxnMknvOA
 S9WqIwMx5mqW98cMHRkw8Cy8kpAaahCFde/db1rmFiP6TdVVdDu8p4dJX9uFaRcDqWzNJdr
 HQTDpXa8YLV0XmA12I2RVik+WOcBSZD6BD3MYxGpBt4btt6VqVDEBL3qKd0bOXjnZ4HPEpK
 5DE0mVpqsEW949EBtMPKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AmQR3bapRNg=:4eXR3ijAer8kvFZGBXphti
 l8ImIUbO/fRDX1Qs+pD0dNzzGOEouIH+sJUG2hVxT4VRGFOMxzbtPFSDWeNsaFwGtvPaGsqAR
 Y+MY6GHHeRYoBEZ2PlIlSxSuRhqpbJio9hm3ekvT60wLS+jedJ5Bkl2Xa4yeEbzKyZBJGQKAn
 tD0eZfr3fpSPIZOPqAjhPpnYM6KoV/htjkI2YG954qZ1/t1QVmdnJvVP4gMntLhCwFRzn5SuB
 L8UXqj9s054sqdJ2SPH/q1HESGccAn/n+MYWe6SqzP9S05hDxIa6m8DzSwrMhZDvYxPEB527d
 RuMbjSKJKhrHv42UkJuFHoSk1MQ+WCmIUDqrKCGWjd7g2LcIFzAJjx6X2ZPCOjvpaK9fbr30i
 LlwgjMIMMlRW4NvymGQLluZY1p7/ZGCVfl/L1vC/8LbMSBHiwrwtkdtnenJWRwBn0pHPknvO9
 vlinxcOIBWxaBH5sgG/xNnYbdg7wvenPgHcC7q1JwsIvQtTVgX9DaqIJykEHwv37YicXHKcyh
 KfsIZJ4WC2i/cpP6WEXcFFIAMBx8oAURbq3dZ6BNzc/VWKRG++p+2VK/gPfm7+21u9Cy4en1x
 2/6vS3xF8ROvrZRM4/kp+Rj0ockjFYIz2YwtU7voC8Cs2+JaMkMBCHneMO20RUV9hbNQ7Kd4J
 mDrlJ6rGv1nV11dizCd5PM/bC3qTtsodWsrsUuE0FM9rFtwLLxRJ2o5IwV418hMzYnOJ6pneh
 quiKse4U04sHyYqq8xEFF90oKnCrrdCczAlRozaTuNqrK2QJu1Nmeoy4n9q+RaELH2+qTv9+D
 wPGX3s3LsIc+3VTy/7rohf7xelF/e3JVydJHuZPPYmHFRCq0yQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a file had been commited with CRLF but now .gitattributes say
"* text=auto" (or core.autocrlf is true),
the following does not roundtrip, `git apply` fails:

printf "Added line\r\n" >>file &&
git diff >patch &&
git checkout -- . &&
git apply patch

Before applying the patch, the file from working tree is converted into the
index format (clean filter, CRLF conversion, ...)
Here, when commited with CRLF, the line endings should not be converted.

Note that `git apply --index` or `git apply --cache` doesn't call
convert_to_git() because the source material is already in index format.

Analyze the patch if there is a) any context line with CRLF,
or b) if any line with CRLF is to be removed.
In this case the patch file `patch` has mixed line endings, for a)
it looks like this:

 diff --git a/one b/one
 index 533790e..c30dea8 100644
 --- a/one
 +++ b/one
 @@ -1 +1,2 @@
  a\r
 +b\r

And for b) it looks like this:

 diff --git a/one b/one
 index 533790e..485540d 100644
 --- a/one
 +++ b/one
 @@ -1 +1 @@
 -a\r
 +b\r

If `git apply` detects that the patch itself has CRLF, (look at the line
" a\r" or "-a\r" above), the new flag crlf_in_old is set in "struct patch"
and two things will happen:
- read_old_data() will not convert CRLF into LF by calling
  convert_to_git(..., SAFE_CRLF_KEEP_CRLF);
- The WS_CR_AT_EOL bit is set in the "white space rule",
  CRLF are no longer treated as white space.

While at there, make clear that read_old_data() in apply.c
knows what it wants convert_to_git() to do with respect to CRLF.  In
fact, this codepath is about applying a patch to a file in the
filesystem, which may not exist in the index, or may exist but may
not match what is recorded in the index, or in the extreme case, we
may not even be in a Git repository.  If convert_to_git() peeked at
the index while doing its work, it *would* be a bug.

Pass NULL instead of &the_index to convert_to_git() to make sure we
catch future bugs to clarify this.

Update the test in t4124: split one test case into 3:
- Detect the " a\r" line in the patch
- Detect the "-a\r" line in the patch
- Use LF in repo and CLRF in the worktree.

Reported-by: Anthony Sottile <asottile@umich.edu>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

Changes since v3:
- took apply.c from junio/tb/apply-with-crlf
- Remove the leading asterix in the commit message, at the place
  where the "git diff" is cited.
- Mention "Pass NULL instead of &the_index to convert_to_git()"

apply.c                  | 41 ++++++++++++++++++++++++++++++++++++-----
 t/t4124-apply-ws-rule.sh | 33 +++++++++++++++++++++++++++------
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index f2d599141d..66c68f193a 100644
--- a/apply.c
+++ b/apply.c
@@ -220,6 +220,7 @@ struct patch {
 	unsigned int recount:1;
 	unsigned int conflicted_threeway:1;
 	unsigned int direct_to_threeway:1;
+	unsigned int crlf_in_old:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -1662,6 +1663,19 @@ static void check_whitespace(struct apply_state *state,
 	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
+/*
+ * Check if the patch has context lines with CRLF or
+ * the patch wants to remove lines with CRLF.
+ */
+static void check_old_for_crlf(struct patch *patch, const char *line, int len)
+{
+	if (len >= 2 && line[len-1] == '\n' && line[len-2] == '\r') {
+		patch->ws_rule |= WS_CR_AT_EOL;
+		patch->crlf_in_old = 1;
+	}
+}
+
+
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
@@ -1712,11 +1726,14 @@ static int parse_fragment(struct apply_state *state,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
+			check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action == correct_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
+			if (!state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -1725,6 +1742,8 @@ static int parse_fragment(struct apply_state *state,
 			trailing = 0;
 			break;
 		case '+':
+			if (state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
 			if (!state->apply_in_reverse &&
 			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
@@ -2268,8 +2287,11 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
-static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
+static int read_old_data(struct stat *st, struct patch *patch,
+			 const char *path, struct strbuf *buf)
 {
+	enum safe_crlf safe_crlf = patch->crlf_in_old ?
+		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2278,7 +2300,15 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
+		/*
+		 * "git apply" without "--index/--cached" should never look
+		 * at the index; the target file may not have been added to
+		 * the index yet, and we may not even be in any Git repository.
+		 * Pass NULL to convert_to_git() to stress this; the function
+		 * should never look at the index when explicit crlf option
+		 * is given.
+		 */
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
@@ -3384,6 +3414,7 @@ static int load_patch_target(struct apply_state *state,
 			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
+			     struct patch *patch,
 			     const char *name,
 			     unsigned expected_mode)
 {
@@ -3399,7 +3430,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf))
+			if (read_old_data(st, patch, name, buf))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3432,7 +3463,7 @@ static int load_preimage(struct apply_state *state,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(state, &buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st, patch,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3520,7 +3551,7 @@ static int load_current(struct apply_state *state,
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(state, &buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index d350065f25..4fc27c51f7 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -467,21 +467,42 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol set' '
 	test_cmp one expect
 '
 
-test_expect_success 'same, but with CR-LF line endings && cr-at-eol unset' '
+test_expect_success 'CR-LF line endings && add line && text=auto' '
 	git config --unset core.whitespace &&
 	printf "a\r\n" >one &&
+	cp one save-one &&
+	git add one &&
 	printf "b\r\n" >>one &&
-	printf "c\r\n" >>one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	mv save-one one &&
+	echo "one text=auto" >.gitattributes &&
+	git apply patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'CR-LF line endings && change line && text=auto' '
+	printf "a\r\n" >one &&
 	cp one save-one &&
-	printf "                 \r\n" >>one &&
 	git add one &&
+	printf "b\r\n" >one &&
 	cp one expect &&
-	printf "d\r\n" >>one &&
 	git diff -- one >patch &&
 	mv save-one one &&
-	echo d >>expect &&
+	echo "one text=auto" >.gitattributes &&
+	git apply patch &&
+	test_cmp one expect
+'
 
-	git apply --ignore-space-change --whitespace=fix patch &&
+test_expect_success 'LF in repo, CRLF in worktree && change line && text=auto' '
+	printf "a\n" >one &&
+	git add one &&
+	printf "b\r\n" >one &&
+	git diff -- one >patch &&
+	printf "a\r\n" >one &&
+	echo "one text=auto" >.gitattributes &&
+	git -c core.eol=CRLF apply patch &&
+	printf "b\r\n" >expect &&
 	test_cmp one expect
 '
 
-- 
2.14.0.rc1.15.gd40c2d4e85.dirty

