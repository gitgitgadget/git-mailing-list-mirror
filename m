Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D091F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 10:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbcHNK4U (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:56:20 -0400
Received: from mout.web.de ([217.72.192.78]:50483 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbcHNK4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 06:56:18 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LfAsW-1asn6N2G6K-00opyh; Sat, 13 Aug 2016 23:20:07
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	peff@peff.net, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] convert: Correct NNO tests and missing `LF will be replaced by CRLF`
Date:	Sat, 13 Aug 2016 23:29:27 +0200
Message-Id: <20160813212927.11320-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:etItg3FsL7j1YqhVmw6ZDHXecPjXmdxpNwFcGKPBB4551ta5QB9
 hXrJMKr2/WtkmGyeNl7MUkWW/Cd//DK3jbwzoepSbWJ62Zu4MYKVcCivl/2+zqg+QqE7FdU
 idGqgiDKuBhl1+OjXXR9qu95vRwzdw9i/9W4hs4TLD1rAnZBT0qbbfMNk3/wLp9dyozpGhy
 pm34gBnjJB9E2tSrrNiwg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jnUHis5ssIM=:aVnsORfbPFb3UFRSLw8vbq
 Buz0CBzfvD0YadNNHDLZvEr22LfX0QbZjGJ9uDsvM54FF0vsZH7HINJ/ROElMLINbOgf4knr9
 VqO0SQQAT+ISQia67p/6kTPNlzqirWKVmrfVmnGZB5W0dpsh0um4DLrl5R5gpJtZmIlOe40oo
 1PgEO6X+dc81cMsKFPMVCoHmTK0DagdUXUsU7Yox0htHgXJX+Mek7gjcIe2YCh/n2e7kKJFEN
 922dwwY+khCLyU6tJWcQXIvHJASqTfu1DOAgI2o2REkmTFX3I3vIc66bNOCmFIMtz7QAF2Aag
 ORQIPFJ1C2rFRsgzk5aWli3Xvrlo15puVbGFa3nERJEXVm2LIUfjLXanPqY0ohGfgooPhBkmD
 BP+wEKbk1I/f0GOfgqJhLucuFtb6LGg+Ec47WcCX7ByeFkMOZnipOQF/ygXC/o4k517HCTGgW
 w5f5wXlW9qs0spDLywLt3adpx7boz8xrw695RKyrIIvM/tL2S2aKF7ZgBQfHY0+nUbQwc3qqi
 YLuFMdBtj56K/kV9ooH1UKmBImxCTl49jUi+/P4kjydeCAj1Rkg7d8Zr2TYtUJ2LsNSeCtODy
 h54+Ep5I53Vp3M2ZJavo6DBOb2cvnAImOS/4XsBhaMah/kOM30TyyxjBCgtqtlMTIJXMAXHkE
 /HSvTPQfblQe1hMdMgjzq1uaCyvE12TOfdbnFh8ZMTEbTYayquSoBjNqIXC1kNUI1Xj+SwtlB
 k31+YL+vxnX/LzuSaxG8v1hqcNbudwBkQmwfqI7ZsSZy3L+bel7kD/wtSbOK26J3ZnPUM72NY
 n3TR8l+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a non-reversible CRLF conversion is done in "git add",
a warning is printed on stderr (or Git dies, depending on checksafe)

The function commit_chk_wrnNNO() in t0027 was written to test this,
but did the wrong thing: Instead of looking at the warning
from "git add", it looked at the warning from "git commit".

This is racy because "git commit" may not have to do CRLF conversion
at all if it can use the sha1 value from the index (which depends on
whether "add" and "commit" run in a single second).

Correct t0027 and replace the commit for each and every file with a commit
of all files in one go.
The function commit_chk_wrnNNO() should be renamed in a separate commit.

Now that t0027 does the right thing, it detects a bug in covert.c:
This sequence should generate the warning `LF will be replaced by CRLF`,
but does not:

$ git init
$ git config core.autocrlf false
$ printf "Line\r\n" >file
$ git add file
$ git commit -m "commit with CRLF"
$ git config core.autocrlf true
$ printf "Line\n" >file
$ git add file

"git add" calls crlf_to_git() in convert.c, which calls check_safe_crlf().
When has_cr_in_index(path) is true, crlf_to_git() returns too early and
check_safe_crlf() is not called at all.

Factor out the code which determines if "git checkout" converts LF->CRLF
into will_convert_lf_to_crlf().

Update the logic around check_safe_crlf() and "simulate" the possible
LF->CRLF conversion at "git checkout" with help of will_convert_lf_to_crlf().
Thanks to Jeff King <peff@peff.net> for analyzing t0027.

Reported-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c            | 97 ++++++++++++++++++++++++++++++----------------------
 t/t0027-auto-crlf.sh |  6 ++--
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/convert.c b/convert.c
index 67d69b5..077f5e6 100644
--- a/convert.c
+++ b/convert.c
@@ -189,33 +189,25 @@ static enum eol output_eol(enum crlf_action crlf_action)
 }
 
 static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
-                            struct text_stat *stats, enum safe_crlf checksafe)
+			    struct text_stat *old_stats, struct text_stat *new_stats,
+			    enum safe_crlf checksafe)
 {
-	if (!checksafe)
-		return;
-
-	if (output_eol(crlf_action) == EOL_LF) {
+	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
-		 * CRLFs would not be restored by checkout:
-		 * check if we'd remove CRLFs
+		 * CRLFs would not be restored by checkout
 		 */
-		if (stats->crlf) {
-			if (checksafe == SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("CRLF would be replaced by LF in %s.", path);
-		}
-	} else if (output_eol(crlf_action) == EOL_CRLF) {
+		if (checksafe == SAFE_CRLF_WARN)
+			warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("CRLF would be replaced by LF in %s.", path);
+	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
-		 * CRLFs would be added by checkout:
-		 * check if we have "naked" LFs
+		 * CRLFs would be added by checkout
 		 */
-		if (stats->lonelf) {
-			if (checksafe == SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("LF would be replaced by CRLF in %s", path);
-		}
+		if (checksafe == SAFE_CRLF_WARN)
+			warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("LF would be replaced by CRLF in %s", path);
 	}
 }
 
@@ -233,12 +225,35 @@ static int has_cr_in_index(const char *path)
 	return has_cr;
 }
 
+static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
+				   enum crlf_action crlf_action)
+{
+	if (output_eol(crlf_action) != EOL_CRLF)
+		return 0;
+	/* No "naked" LF? Nothing to convert, regardless. */
+	if (!stats->lonelf)
+		return 0;
+
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
+		/* If we have any CR or CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats->lonecr || stats->crlf)
+			return 0;
+
+		if (convert_is_binary(len, stats))
+			return 0;
+	}
+	return 1;
+
+}
+
 static int crlf_to_git(const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
+	int convert_crlf_into_lf;
 
 	if (crlf_action == CRLF_BINARY ||
 	    (src && !len))
@@ -252,6 +267,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		return 1;
 
 	gather_stats(src, len, &stats);
+	/* Optimization: No CRLF? Nothing to convert, regardless. */
+	convert_crlf_into_lf = !!stats.crlf;
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
@@ -263,12 +280,24 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		if (checksafe == SAFE_CRLF_RENORMALIZE)
 			checksafe = SAFE_CRLF_FALSE;
 		else if (has_cr_in_index(path))
-			return 0;
+			convert_crlf_into_lf = 0;
 	}
-	check_safe_crlf(path, crlf_action, &stats, checksafe);
-
-	/* Optimization: No CRLF? Nothing to convert, regardless. */
-	if (!stats.crlf)
+	if (checksafe && len) {
+		struct text_stat new_stats;
+		memcpy(&new_stats, &stats, sizeof(new_stats));
+		/* simulate "git add" */
+		if (convert_crlf_into_lf) {
+			new_stats.lonelf += new_stats.crlf;
+			new_stats.crlf = 0;
+		}
+		/* simulate "git checkout" */
+		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
+			new_stats.crlf += new_stats.lonelf;
+			new_stats.lonelf = 0;
+		}
+		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+	}
+	if (!convert_crlf_into_lf)
 		return 0;
 
 	/*
@@ -314,21 +343,9 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-
-	/* No "naked" LF? Nothing to convert, regardless. */
-	if (!stats.lonelf)
+	if (!will_convert_lf_to_crlf(len, &stats, crlf_action))
 		return 0;
 
-	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-		/* If we have any CR or CRLF line endings, we do not touch it */
-		/* This is the new safer autocrlf-handling */
-		if (stats.lonecr || stats.crlf )
-			return 0;
-
-		if (convert_is_binary(len, &stats))
-			return 0;
-	}
-
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2860d2d..90db54c 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -119,8 +119,7 @@ commit_chk_wrnNNO () {
 		fname=${pfx}_$f.txt &&
 		cp $f $fname &&
 		printf Z >>"$fname" &&
-		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
-		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
+		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done
 
 	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
@@ -417,7 +416,8 @@ commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC
 commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
 commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
 
-test_expect_success 'create files cleanup' '
+test_expect_success 'commit NNO and cleanup' '
+	git commit -m "commit files on top of NNO" &&
 	rm -f *.txt &&
 	git -c core.autocrlf=false reset --hard
 '
-- 
2.9.3.599.g2376d31.dirty

