Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2ED61F667
	for <e@80x24.org>; Thu, 17 Aug 2017 06:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdHQGGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 02:06:44 -0400
Received: from mout.web.de ([212.227.15.4]:59145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbdHQGGm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 02:06:42 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGlGr-1dmIY738HB-00DaAI; Thu, 17
 Aug 2017 08:06:34 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/2] File commited with CRLF should roundtrip diff and apply
Date:   Thu, 17 Aug 2017 08:06:33 +0200
Message-Id: <20170817060633.28491-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:i2dxxAm1yyvxB3GWF3Xp9q7iAyUiOPNX091M1JEw1d5CR5pBigo
 FNDE5Nm6N8QvP1hhJSBManm+AhRUTOTL9E+nv4+7J1i7msOXHdeiPDjN5xnGWGKingVMbxA
 8qsCjCtEO+q0smomP4UVKrNNkOD7e8cq+Jx9ZjJVH/odNywIQIPU8n+YWYF2N4DREM1mpwf
 v5S7WQlYNSkaw+j0USJZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pQ3dyVl6EKI=:E5TBzt80U+K0KHSMzO6Cj5
 whZFBMJolab9aC5ou7/AebgxA/u+kK9mlhhqrkYSORWNcr5k3gM9bYNNaMmq5y3TW3irhgu28
 tHlST6j/N4E0xuMO2DD484GF+r8FyDJr2Z2yQ74bZzsUXAvGTaKBtOVGw2mGXxAaMTlHvQl9M
 o/RgcFp/qvsiifhsT0aQgbiH2ccd9KejnVhRPjasxcAsQnW5kOknjI7iAuOT3lV2yxfEQyHH+
 vJnm/rsWQ+Hkq0z2Jnghinn4+FOrfxDe+pDtSejmgB4VTK/+Yfs567QO0rBNoCvQSesf1n/Ym
 0/w11jOG83p8hVTeZAxsSSLbep6jM9g4yFtPd5eLvNqR9r3Txueq0jirbTtRLtb40xryyV94V
 0p9vxWLszLKJMdCuSIIliRtVzsZ1zu2sx/s7dTHJAzhwp7Lu+YuJvgN5gBKuCOrXcXAp8hv7I
 Q0kfABx0oYaTS0O7bRhkJwCdH0ngIleLGOX/P/ZWE7r9ES1lU+DqYAiSbgP+PfkgEGTZbI3ox
 ZtKEAoAnlXgqz8hS1CLnTsznI67MRXRSNjd8YqdlrMTpWDEBpSoF9a1na+3xBlNNxoj2kI7xO
 wd57S3ithKg4p6C2WvE5X/WyV3QJAZvyUDuxom0VIQggcagBidRCAyja0EUD7VfqpyJXqtjKc
 Be+tNYjy8hMyFheSJkYWCLHMnFm8R8mfHoVoTCOTLUNutqsPkWsnhzjnIZnrtMclAqTsJ/mNg
 Do4GCYt1wpYSY86CLUuYSv4xPofAF2O+EfZKVN3PwPmGa2omop/R9jhLoDJ3KCIPw/DVmko2x
 r1WdXA0Jpvk3NrlBsN6diwZ/ALaoGdGV5SvQpu26NXcwvpi8n4=
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
it looks like this (ignore the $ at the begin of the line):

$ diff --git a/one b/one
$ index 533790e..c30dea8 100644
$ --- a/one
$ +++ b/one
$ @@ -1 +1,2 @@
$  a\r
$ +b\r

And for b) it looks like this:

$ diff --git a/one b/one
$ index 533790e..485540d 100644
$ --- a/one
$ +++ b/one
$ @@ -1 +1 @@
$ -a\r
$ +b\r

If `git apply` detects that the patch itself has CRLF, (look at the line
" a\r" or "-a\r" above), the new flag has_crlf is set in "struct patch"
and two things will happen:
- read_old_data() will not convert CRLF into LF by calling
  convert_to_git(..., SAFE_CRLF_KEEP_CRLF);
- The WS_CR_AT_EOL bit is set in the "white space rule",
  CRLF are no longer treated as white space.

Thanks to Junio C Hamano, his input became the base for the changes in t4124.
One test case is split up into 3:
- Detect the " a\r" line in the patch
- Detect the "-a\r" line in the patch
- Use LF in repo and CLRF in the worktree. (*)

* This one proves that convert_to_git(&the_index,...) still needs to pass
the &index, otherwise Git will crash.

Reported-by: Anthony Sottile <asottile@umich.edu>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 apply.c                  | 28 +++++++++++++++++++++++-----
 t/t4124-apply-ws-rule.sh | 33 +++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index f2d599141d..bebb176099 100644
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
@@ -2268,8 +2282,11 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 		add, pluses, del, minuses);
 }
 
-static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
+static int read_old_data(struct stat *st, struct patch *patch,
+			 const char *path, struct strbuf *buf)
 {
+	enum safe_crlf safe_crlf = patch->has_crlf ?
+		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_FALSE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2278,7 +2295,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
+		convert_to_git(&the_index, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
@@ -3384,6 +3401,7 @@ static int load_patch_target(struct apply_state *state,
 			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
+			     struct patch *patch,
 			     const char *name,
 			     unsigned expected_mode)
 {
@@ -3399,7 +3417,7 @@ static int load_patch_target(struct apply_state *state,
 		} else if (has_symlink_leading_path(name, strlen(name))) {
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
-			if (read_old_data(st, name, buf))
+			if (read_old_data(st, patch, name, buf))
 				return error(_("failed to read %s"), name);
 		}
 	}
@@ -3432,7 +3450,7 @@ static int load_preimage(struct apply_state *state,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(state, &buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st, patch,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3520,7 +3538,7 @@ static int load_current(struct apply_state *state,
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

