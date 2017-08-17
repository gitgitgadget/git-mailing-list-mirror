Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6996720899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbdHQVnT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:43:19 -0400
Received: from mout.web.de ([212.227.17.12]:52429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbdHQVnR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:43:17 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGaV-1dmdYr2Uqp-00E6zg; Thu, 17
 Aug 2017 23:43:10 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 2/2] File commited with CRLF should roundtrip diff and apply
Date:   Thu, 17 Aug 2017 23:43:08 +0200
Message-Id: <20170817214308.10727-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:X6ZjBKJ3e2Po6biBc+a8W5Mdk9TbCBki2mQjuv/9RC8dPjMDvRe
 m6puHxbOMBd2cSLkfWRAItjvVDV1jJ+nKDi7GpOCBNO04B/twQSqY8WZY4cS8/GGN1LU9H7
 f/MG8UxauU8ClRho6GngHCdT21tPrpQmlTyTCcpM+ll/iCV014OKY4FLYLW9HqBCndJOg6U
 IzBUNBKDo08HmADNm5pUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E8NmlKLkUns=:l5nsNnNgRa+45+Khq25KwB
 A3vnm7cu+n50fQbVyrYj6G2t6AIW+2unb4XntVCGlLOuZ95xMaXEkOk20SRX9EoMgApFcK1+f
 dRH1ntmQ5Y/oXKd89sFmkCVLnn75VHQ50zxsLVCchW9JRMC7GuMSVLbwS6rdzijobwTv7/qtB
 eRMFfGsNCQoj4x17g/6k+GADxEoEJid0g9mEH05Zz4W3RdPJHuErhhbxeE3FLB+ImtxNUEMKQ
 Y592WSZtVVJ3scHuHui9iYSOoV79co4UWahKd/NsXPHVpEjx6C51BkS3owtgyGBYLB0WM3zvj
 1XNWroW3JpCU5aB5GJ5na90m95qiGW1pI6ZBFvVL5dPwAiOK5AxgYFNkHH3YGLtrEmNwRCEbI
 qLJ9YDOuIXkHg/sFk/AfG721n7EmscgI21qoHGWYnpD9+LbOu1eMOj0xCUP7n4YK3gnfBXnnt
 rHe3Jl1om+jGnzK/++qaMRk4x1eprfRwdoivOzj4l5RBdSbGPfhrzN8172A7G6UT/l6yUg38n
 lRNc7OjQu/iB2J4+Gnw+0oiHN5wiD2Kl0LVXo0ItUQhqWW092zqRzoIl4r3BK2g9e15t0ZyGT
 BYXVdlwYEoFnZxs0Ro3f8kYK4DrHwSVqaPXa3k4WXsgNcXy+OEus+Yc1xP8nZ1d1EgCFS7OaV
 Shz2nV0XpBAOva+EOgbbI2pJ9O1UMcC2+157FBMvY7kyNmMMh9FFlN98fvOX2awB4oHj00S3e
 tqav//jdseCvSsqkh1m0j4eWioJ0hhrhWyDkWQaAegdg3VGQcpMpTVZQMEGv4UdgVLpt6pA7Q
 pyGmGZOctfnJG/BxzgDSSrWxI6dCwETVWCqkOOQ3yA2i6MaMBA=
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
it looks like this (ignore the * at the begin of the line):

* diff --git a/one b/one
* index 533790e..c30dea8 100644
* --- a/one
* +++ b/one
* @@ -1 +1,2 @@
*  a\r
* +b\r

And for b) it looks like this:

* diff --git a/one b/one
* index 533790e..485540d 100644
* --- a/one
* +++ b/one
* @@ -1 +1 @@
* -a\r
* +b\r

If `git apply` detects that the patch itself has CRLF, (look at the line
" a\r" or "-a\r" above), the new flag crlf_in_old is set in "struct patch"
and two things will happen:
- read_old_data() will not convert CRLF into LF by calling
  convert_to_git(..., SAFE_CRLF_KEEP_CRLF);
- The WS_CR_AT_EOL bit is set in the "white space rule",
  CRLF are no longer treated as white space.

Thanks to Junio C Hamano, his input became the base for the changes in t4124.
One test case is split up into 3:
- Detect the " a\r" line in the patch
- Detect the "-a\r" line in the patch
- Use LF in repo and CLRF in the worktree.

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
Changes since v2:
- Manually integrated all code changes from Junio
  (Thanks, I hope that I didn't miss something)
- Having examples of "git diff" in the commit message confuses "git apply",
  so that all examples for git diff have a '*' at the beginnig of the line
  (V2 used '$' which is typically an example for a shell script)
- The official version to apply the CRLF-rules without having an index is
  SAFE_CRLF_RENORMALIZE, that is already working today.
- Now we have convert_to_git(NULL, ..., safe_crlf) with
  enum safe_crlf safe_crlf = patch->crlf_in_old ?
          SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;

apply.c                  | 40 +++++++++++++++++++++++++++++++++++-----
 t/t4124-apply-ws-rule.sh | 33 +++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index f2d599141d..691f47c783 100644
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
@@ -1712,11 +1726,15 @@ static int parse_fragment(struct apply_state *state,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
+			if (!state->apply_in_reverse)
+				check_old_for_crlf(patch, line, len);
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
@@ -2268,8 +2286,11 @@ static void show_stats(struct apply_state *state, struct patch *patch)
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
@@ -2278,7 +2299,15 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
+	       /*
+		* "git apply" without "--index/--cached" should never look
+		* at the index; the target file may not have been added to
+		* the index yet, and we may not even be in any Git repository.
+		* Pass NULL to convert_to_git() to stress this; the function
+		* should never look at the index when explicit crlf option
+		* is given.
+		*/
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
@@ -3384,6 +3413,7 @@ static int load_patch_target(struct apply_state *state,
 			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
+			     struct patch *patch,
 			     const char *name,
 			     unsigned expected_mode)
 {
@@ -3399,7 +3429,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf))
+			if (read_old_data(st, patch, name, buf))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3432,7 +3462,7 @@ static int load_preimage(struct apply_state *state,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(state, &buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st, patch,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3520,7 +3550,7 @@ static int load_current(struct apply_state *state,
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
2.14.1.145.gb3622a4ee9

