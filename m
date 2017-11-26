Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B4C20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbdKZMU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 07:20:56 -0500
Received: from mout.web.de ([212.227.15.14]:50925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdKZMUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 07:20:55 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4TR-1esGc03DMH-00Zh50; Sun, 26
 Nov 2017 13:20:53 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, ashishnegi33@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] convert: tighten the safe autocrlf handling
Date:   Sun, 26 Nov 2017 13:20:52 +0100
Message-Id: <20171126122052.13810-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.0.278.gbd97f72a1b.dirty
In-Reply-To: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qA/gUPeu5cYzfeVHr9jWiCr1iJoozPVqxCDuSrUo0maty0NrDIK
 Xq7KSPsxsJcqVDLSmi5WpHWVJNAccEXPzoEdDnFsRAhHtr5b29OrUUtfcKjT7YTm1k96C65
 vqjyZd3NK1NZaOvTSZ/s93nLzEgqYhnDlY9HKfo//Hts3J5nPfMaGvoLm6XBe1P1790acni
 Vd3i4+lN6iqst0Qmg3Qbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BakGVpRNaqY=:I0oGGMmDSBFuGVefMu6bU9
 kITVg9P9A/vQ7XQmdHB0jowFpFnWmamrM+TS+FdfWMZYRz5eNDOpSQdCXMnG92LMo+n28dmy+
 fveYjvBd+Xynj0az1Bg9SiLJQtFB5o63GkIFH5+jbW0EVNcQnJCfSAgTh2rBcmfFogYkZ52Zh
 ubA4atg+5QQCSxI79x0aDiV8LRhzcnkgjm72J7QMol7ZNezsbH/PNRNVOsaLjcFeRtyTsm+5/
 FB44Cn3l1B36K0JpIpYlSQs68rwuM95sVf4CgnOzrCGX2WfpKEVwkPe43VBQDbd21AXfOzMX8
 q0OKFLCs3tLFR6XwnNebc8JRmYrTwDy2mXC8AoTAW6bgp21o5pRSowogZqVxsKfnQ1K4veiNz
 U5MShNlDOjdpzoltSN4ROM65np6+JZVDJafigAKycLu3oD7AAkiHCK+1Jp6QzZFi2vlfIiYRe
 kfcZSBDiVI0KyGcxmxpuechsjXiby1pYjfs4kOsqm7SCGtla8DutwHAfxLdM+MKFiDJ9DLKrB
 3jRmnq+Dky3tliDy9X6IeLHumxVnBzegJbqzF498K4Bn0jHTOn9MLNsmyBy1YhO+rVlhAcuEZ
 EiRXdOUrzSuTdf3y9svItEut1RNlF+avsxkpuhQUQQZ6jtTyCoLQ44Rq93O6wjOARRJ3tuOAH
 A0XgWO3B5+rznwA2ovnwFAbdZIIYhR5olTOVVBDS2U47URVNNngkI5MH+cgIiPhByBRd8n4Ij
 z/o/EacmRFkpyIyQfJARuJ5j+tYQM48V373pPgUqLwcDwM4NHjHXd2kvk9Rq2T+jYPd123bir
 FDwgQfZo7BlLiOgU4pZnn33op0iAhoo5kND2iWYoXI95JxmyC4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When a text file had been commited with CRLF and the file is commited
again, the CRLF are kept if .gitattributs has "text=auto".
This is done by analyzing the content of the blob stored in the index:
If a '\r' is found, Git assumes that the blob was commited with CRLF.

The simple search for a '\r' does not always work as expected:
A file is encoded in UTF-16 with CRLF and commited. Git treats it as binary.
Now the content is converted into UTF-8. At the next commit Git treats the
file as text, the CRLF should be converted into LF, but isn't.

Replace has_cr_in_index() with has_crlf_in_index(). When no '\r' is found,
0 is returned directly, this is the most common case.
If a '\r' is found, the content is analyzed more deeply.

Reported-By: Ashish Negi <ashishnegi33@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

Changes against v1:
- change "if (crp && (crp[1] == '\n'))" to "if (crp)"
  (Thanks Eric. The new patch is more straightforward, and no risk to
   read out of data)
- Remove the "Solution:" in the commit message

Note:
  The original function has_cr_in_index() is from this commit:
    c4805393d73 (Finn Arne Gangstad   2010-05-12 00:37:57 +0200  225)
  And has this info:
    >Change autocrlf to not do any conversions to files that in the
    >repository already contain a CR. git with autocrlf set will never
    >create such a file, or change a LF only file to contain CRs, so the
    >(new) assumption is that if a file contains a CR, it is intentional,
    >and autocrlf should not change that.
  So the original assumption was slightly optimistic (but did work in 7 years)



convert.c            | 19 +++++++++----
 t/t0027-auto-crlf.sh | 76 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 20d7ab67bd..1a41a48e15 100644
--- a/convert.c
+++ b/convert.c
@@ -220,18 +220,27 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const struct index_state *istate, const char *path)
+static int has_crlf_in_index(const struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
+	const char *crp;
+	int has_crlf = 0;
 
 	data = read_blob_data_from_index(istate, path, &sz);
 	if (!data)
 		return 0;
-	has_cr = memchr(data, '\r', sz) != NULL;
+
+	crp = memchr(data, '\r', sz);
+	if (crp) {
+		unsigned int ret_stats;
+		ret_stats = gather_convert_stats(data, sz);
+		if (!(ret_stats & CONVERT_STAT_BITS_BIN) &&
+		    (ret_stats & CONVERT_STAT_BITS_TXT_CRLF))
+			has_crlf = 1;
+	}
 	free(data);
-	return has_cr;
+	return has_crlf;
 }
 
 static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
@@ -290,7 +299,7 @@ static int crlf_to_git(const struct index_state *istate,
 		 * cherry-pick.
 		 */
 		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
-		    has_cr_in_index(istate, path))
+		    has_crlf_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 68108d956a..0af35cfb1f 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -43,19 +43,31 @@ create_gitattributes () {
 	} >.gitattributes
 }
 
-create_NNO_files () {
+# Create 2 sets of files:
+# The NNO files are "Not NOrmalized in the repo. We use CRLF_mix_LF and store
+#   it under different names for the different test cases, see ${pfx}
+#   Depending on .gitattributes they are normalized at the next commit (or not)
+# The MIX files have different contents in the repo.
+#   Depending on its contents, the "new safer autocrlf" may kick in.
+create_NNO_MIX_files () {
 	for crlf in false true input
 	do
 		for attr in "" auto text -text
 		do
 			for aeol in "" lf crlf
 			do
-				pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
+				pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf} &&
 				cp CRLF_mix_LF ${pfx}_LF.txt &&
 				cp CRLF_mix_LF ${pfx}_CRLF.txt &&
 				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
 				cp CRLF_mix_LF ${pfx}_LF_mix_CR.txt &&
-				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt
+				cp CRLF_mix_LF ${pfx}_CRLF_nul.txt &&
+				pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf} &&
+				cp LF          ${pfx}_LF.txt &&
+				cp CRLF        ${pfx}_CRLF.txt &&
+				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
+				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
+				cp CRLF_nul    ${pfx}_CRLF_nul.txt
 			done
 		done
 	done
@@ -136,6 +148,49 @@ commit_chk_wrnNNO () {
 	'
 }
 
+# Commit a file with mixed line endings on top of different files
+# in the index. Check for warnings
+commit_MIX_chkwrn () {
+	attr=$1 ; shift
+	aeol=$1 ; shift
+	crlf=$1 ; shift
+	lfwarn=$1 ; shift
+	crlfwarn=$1 ; shift
+	lfmixcrlf=$1 ; shift
+	lfmixcr=$1 ; shift
+	crlfnul=$1 ; shift
+	pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf}
+	#Commit file with CLRF_mix_LF on top of existing file
+	create_gitattributes "$attr" $aeol &&
+	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+	do
+		fname=${pfx}_$f.txt &&
+		cp CRLF_mix_LF $fname &&
+		printf Z >>"$fname" &&
+		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
+	done
+
+	test_expect_success "commit file with mixed EOL crlf=$crlf attr=$attr LF" '
+		check_warning "$lfwarn" ${pfx}_LF.err
+	'
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF" '
+		check_warning "$crlfwarn" ${pfx}_CRLF.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
+		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
+		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
+	'
+
+	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
+		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	'
+}
+
+
 stats_ascii () {
 	case "$1" in
 	LF)
@@ -323,8 +378,8 @@ test_expect_success 'setup master' '
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
-	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
-	git -c core.autocrlf=false add NNO_*.txt &&
+	create_NNO_MIX_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
+	git -c core.autocrlf=false add NNO_*.txt MIX_*.txt &&
 	git commit -m "mixed line endings" &&
 	test_tick
 '
@@ -385,6 +440,17 @@ test_expect_success 'commit files attr=crlf' '
 	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF" ""
 '
 
+# Commit "CRLFmixLF" on top of these files already in the repo:
+# LF, CRLF, CRLFmixLF LF_mix_CR CRLFNULL
+#                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
+commit_MIX_chkwrn ""      ""      false   ""        ""        ""          ""          ""
+commit_MIX_chkwrn ""      ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
+commit_MIX_chkwrn ""      ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+
+commit_MIX_chkwrn "auto"  ""      false   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+commit_MIX_chkwrn "auto"  ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
+commit_MIX_chkwrn "auto"  ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+
 #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
 commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
-- 
2.15.0.278.gbd97f72a1b.dirty

