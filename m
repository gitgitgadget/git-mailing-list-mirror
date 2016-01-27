From: tboegi@web.de
Subject: [PATCH v1 1/6] t0027: Add tests for get_stream_filter()
Date: Wed, 27 Jan 2016 16:15:25 +0100
Message-ID: <1453907725-31536-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 16:18:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aORoI-000322-U5
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533AbcA0PPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 10:15:01 -0500
Received: from mout.web.de ([212.227.17.12]:54260 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933513AbcA0POz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:14:55 -0500
Received: from tor.lan ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Martm-1aeJhG46cU-00KS67; Wed, 27 Jan 2016 16:14:53
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:0W8oiuY5ZP3oJl4Fc60kE7iiOsh2fSjTodFaLACXR76kZAUfd1q
 wqZUBpq1t6jKp/dNLrl9l0ajIyBYJBe4iTMvaH3joSllVRkIAYo7XEiEbEFqNH9CHkiArEj
 rdakCKmkKDefbPelRFLXthNmZ5gKgH07+YKTHQRzFoUe9p3EwaQXuPPYcsuXUKBk80o1T/b
 Qg1hKCB02VX9zyG7oVCxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgqxGccvseQ=:khTqVFvlbUSd5yUCJ/psxa
 ojGU6Ec8dwyt6hM4Fo5OKk+/1gyHZ/fGSaRjKofuHsRkYYfPJawcY7IHvzfmtjzXc1TfOn81k
 bFx+WPS/O1GSgcug5jiLkD699MkRAhw6Fx5kIsDWKD4v1NceR+XFjNSG31Vb5S9UTf0Ni/vQO
 su2MCwXKjDskIqUImyLFqFTTTWjREJKy5kAhPIL5nsDSGwuwnsGGAyVEijwmoNqZXGtnkU6wr
 Je9vldF0A7jubuPR4c0ym/cAAz8sHiuOrrFHS58GnR+kfh6+9dUpHbnCvbNCQiC+s07Wp+N9g
 q0NWRffihfne5/6UELm12tfQEEohN6HCiiyRqMqojiMy5DSt6IecjjE/xmhrZ0q+eFwIr87di
 HWxhHZFxu0wARJ9XlunjxKYfBXkYWtOxnOImcSdbT/jwjlhvJ8apOwzCchymLVi8ADz1CMzOe
 jynUewgmZL0297lRp+T6E1fC1YHf9eGMAXpXGdk8hdzrGCW7wxrMa9oBdon+8sNBaxvu7y1e7
 8Wl7WC41f2fn+2pCowrK7J+uHw1KtwlBS6E9KlhQVG3E/tvWPVTJFDCGlqsLi0Gac+9951rgr
 w4nUaR+8l39VNZIMFEo/uB5P/RHhpZF37m+cEm+VqL9jrfP1HKHOSe/GsdrQLlzXwTozQylOi
 SFIgr3HfUWm42Pp/SaBQXV/JFnbZ4zF91wYI40ClryZa7nCDET7K7p7LHbLezgvTYQCYO1rFT
 1BOqUKaKqGikNG2EjdXWoARK7usPXtj88SYtdd8iqXKU1ZiXqVtsAy59HRgw18GqEe4kYb69 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284914>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When a filter is configured, a different code-path is used in convert.c
and entry.c via get_stream_filter(), but there are no test cases yet.

Add tests for the filter API by configuring the ident filter.
The result of the SHA1 conversion is not checked, this is already
done in other TC.

Add a parameter to checkout_files() in t0027.
While changing the signature, add another parameter for the eol=3D attr=
ibute.
This is currently unused, tests for e.g.
"* text=3Dauto eol=3Dlf" will be added in a separate commit.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 262 ++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 146 insertions(+), 116 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 504e5a0..08fe6a5 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -21,32 +21,45 @@ compare_ws_file () {
 	pfx=3D$1
 	exp=3D$2.expect
 	act=3D$pfx.actual.$3
-	tr '\015\000' QN <"$2" >"$exp" &&
-	tr '\015\000' QN <"$3" >"$act" &&
+	tr '\015\000abcdef01234567890' QN00000000000000000 <"$2" >"$exp" &&
+	tr '\015\000abcdef01234567890' QN00000000000000000 <"$3" >"$act" &&
 	test_cmp $exp $act &&
 	rm $exp $act
 }
=20
 create_gitattributes () {
 	attr=3D$1
+	ident=3D$2
+	case "$2" in
+		"")
+			>.gitattributes
+			;;
+		i)
+			echo "* ident" >.gitattributes
+			;;
+		*)
+			echo >&2 invalid ident: $2
+			exit 1
+	esac
+		=20
 	case "$attr" in
 		auto)
-		echo "*.txt text=3Dauto" >.gitattributes
+		echo "*.txt text=3Dauto" >>.gitattributes
 		;;
 		text)
-		echo "*.txt text" >.gitattributes
+		echo "*.txt text" >>.gitattributes
 		;;
 		-text)
-		echo "*.txt -text" >.gitattributes
+		echo "*.txt -text" >>.gitattributes
 		;;
 		crlf)
-		echo "*.txt eol=3Dcrlf" >.gitattributes
+		echo "*.txt eol=3Dcrlf" >>.gitattributes
 		;;
 		lf)
-		echo "*.txt eol=3Dlf" >.gitattributes
+		echo "*.txt eol=3Dlf" >>.gitattributes
 		;;
 		"")
-		echo >.gitattributes
+		#echo >.gitattributes
 		;;
 		*)
 		echo >&2 invalid attribute: $attr
@@ -90,7 +103,7 @@ commit_check_warn () {
 	lfmixcr=3D$6
 	crlfnul=3D$7
 	pfx=3Dcrlf_${crlf}_attr_${attr}
-	create_gitattributes "$attr" &&
+	create_gitattributes "$attr" "" &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
@@ -115,7 +128,7 @@ commit_chk_wrnNNO () {
 	crlfnul=3D$7
 	pfx=3DNNO_${crlf}_attr_${attr}
 	#Commit files on top of existing file
-	create_gitattributes "$attr" &&
+	create_gitattributes "$attr" "" &&
 	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
 	do
 		fname=3D${pfx}_$f.txt &&
@@ -208,28 +221,30 @@ check_in_repo_NNO () {
 }
=20
 checkout_files () {
-	eol=3D$1
-	crlf=3D$2
-	attr=3D$3
-	lfname=3D$4
-	crlfname=3D$5
-	lfmixcrlf=3D$6
-	lfmixcr=3D$7
-	crlfnul=3D$8
-	create_gitattributes $attr &&
+	attr=3D$1 ; shift
+	ident=3D$1; shift
+	aeol=3D$1 ; shift
+	crlf=3D$1 ; shift
+	ceol=3D$1 ; shift
+	lfname=3D$1 ; shift
+	crlfname=3D$1 ; shift
+	lfmixcrlf=3D$1 ; shift
+	lfmixcr=3D$1 ; shift
+	crlfnul=3D$1 ; shift
+	create_gitattributes "$attr" "$ident" &&
 	git config core.autocrlf $crlf &&
-	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
+	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
 		rm crlf_false_attr__$f.txt &&
-		if test -z "$eol"; then
+		if test -z "$ceol"; then
 			git checkout crlf_false_attr__$f.txt
 		else
-			git -c core.eol=3D$eol checkout crlf_false_attr__$f.txt
+			git -c core.eol=3D$ceol checkout crlf_false_attr__$f.txt
 		fi
 	done
=20
-	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" '
+	test_expect_success "ls-files --eol attr=3D$attr i=3D$ident $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
 		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
@@ -244,19 +259,19 @@ checkout_files () {
 		sort >actual &&
 		test_cmp expect actual
 	'
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF" "
 		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF" "
 		compare_ws_file $pfx $crlfname  crlf_false_attr__CRLF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_mix_LF" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DCRLF_mix_LF" "
 		compare_ws_file $pfx $lfmixcrlf crlf_false_attr__CRLF_mix_LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   crlf_false_attr__LF_mix_CR.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_nul" "
+	test_expect_success "checkout i=3D$ident attributes=3D$attr $aeol cor=
e.autocrlf=3D$crlf core.eol=3D$ceol file=3DLF_nul" "
 		compare_ws_file $pfx $crlfnul   crlf_false_attr__LF_nul.txt
 	"
 }
@@ -301,14 +316,13 @@ test_expect_success 'setup master' '
 	git checkout -b master &&
 	git add .gitattributes &&
 	git commit -m "add .gitattributes" "" &&
-	printf "line1\nline2\nline3"     >LF &&
-	printf "line1\r\nline2\r\nline3" >CRLF &&
-	printf "line1\r\nline2\nline3"   >repoMIX &&
-	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
-	printf "line1\nline2\rline3"     >LF_mix_CR &&
-	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
-	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
-	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nL=
INETWO\nLINETHREE"     >LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\=
r\nLINETWO\r\nLINETHREE" >CRLF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\=
nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nL=
INETWO\rLINETHREE"     >LF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\=
r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ=
\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\n=
LINETWO\nLINETHREE" | q_to_nul >LF_nul &&
 	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF=
_mix_LF &&
 	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
 	git commit -m "mixed line endings" &&
@@ -449,23 +463,18 @@ check_in_repo_NNO input "-text" LF        CRLF   =
   CRLF_mix_LF  LF_mix_CR 	CRLF
 # How to read the table below:
 # - checkout_files will check multiple files with a combination of set=
tings
 #   and attributes (core.autocrlf=3Dinput is forbidden with core.eol=3D=
crlf)
-# - parameter $1 : core.eol               lf | crlf
-# - parameter $2 : core.autocrlf          false | true | input
-# - parameter $3 : text in .gitattributs  "" (empty) | auto | text | -=
text
-# - parameter $4 : reference for a file with only LF in the repo
-# - parameter $5 : reference for a file with only CRLF in the repo
-# - parameter $6 : reference for a file with mixed LF and CRLF in the =
repo
-# - parameter $7 : reference for a file with LF and CR in the repo (do=
es somebody uses this ?)
-# - parameter $8 : reference for a file with CRLF and a NUL (should be=
 handled as binary when auto)
-
-#                                            What we have in the repo:
-#                                            ----------------- EOL in =
repo ----------------
-#                                            LF    CRLF  CRLF_mix_LF  =
LF_mix_CR    CRLF_nul
-#                   settings with checkout:
-#                   core.   core.   .gitattr
-#                    eol     acrlf
-#                                            -------------------------=
---------------------
-#                                            What we want to have in t=
he working tree:
+#
+# - parameter $1 	: text in .gitattributs  "" (empty) | auto | text | =
-text
+# - parameter $2 	: ident                  "" | i (i =3D=3D ident)
+# - parameter $3 	: eol in .gitattributs   "" (empty) | lf | crlf
+# - parameter $4 	: core.autocrlf          false | true | input
+# - parameter $5 	: core.eol               "" | lf | crlf | "native"
+# - parameter $6 	: reference for a file with only LF in the repo
+# - parameter $7 	: reference for a file with only CRLF in the repo
+# - parameter $8 	: reference for a file with mixed LF and CRLF in the=
 repo
+# - parameter $9 	: reference for a file with LF and CR in the repo
+# - parameter $10 : reference for a file with CRLF and a NUL (should b=
e handled as binary when auto)
+
 if test_have_prereq NATIVE_CRLF
 then
 MIX_CRLF_LF=3DCRLF
@@ -480,69 +489,90 @@ LFNUL=3DLF_nul
 fi
 export CRLF_MIX_LF_CR MIX NL
=20
-checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    lf      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    lf      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    crlf    false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    crlf    true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
-checkout_files    ""      true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    ""      false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    ""      input "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-
-checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF LF_=
mix_CR    LF_nul
-checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         LF_=
mix_CR    LF_nul
-checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $MI=
X_LF_CR   $LFNUL
-checkout_files    native  true  "text"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  LF_=
mix_CR    LF_nul
-checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
-checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRL=
=46_mix_CR  CRLF_nul
+checkout_files ""      "" ""    false  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    false  native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   ""       CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   crlf     CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   lf       CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      "" ""    true   native   CRLF  CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    false  native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files ""      i  ""    true   native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  ""       $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  crlf     CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    false  native   $NL   CRLF  $MIX_CRLF_=
LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   ""       CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   crlf     CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   lf       CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  "" ""    true   native   CRLF  CRLF  CRLF      =
   LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    false  native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    input  ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    input  lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   ""       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   crlf     LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   lf       LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+checkout_files "auto"  i  ""    true   native   LF    CRLF  CRLF_mix_L=
=46  LF_mix_CR    LF_nul
+
+for id in "" i;
+do
+	checkout_files "crlf"  "$id" ""    false  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    false  native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    input  ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    input  lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "crlf"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "lf"    "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "lf"    "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    false  ""       $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id" ""    false  crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    false  native   $NL   CRLF  $MIX_C=
RLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "text"  "$id" ""    true   ""       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   crlf     CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   lf       CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id" ""    true   native   CRLF  CRLF  CRLF  =
       CRLF_mix_CR  CRLF_nul
+	checkout_files "-text" "$id" ""    false  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    false  native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    input  ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    input  lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   ""       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   crlf     LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   lf       LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+	checkout_files "-text" "$id" ""    true   native   LF    CRLF  CRLF_m=
ix_LF  LF_mix_CR    LF_nul
+done
=20
 # Should be the last test case: remove some files from the worktree
 test_expect_success 'ls-files --eol -d -z' '
--=20
2.7.0.303.g2c4f448.dirty


=46rom e6124e6a186c736cf030c13b1073a66f43cc5841 Mon Sep 17 00:00:00 200=
1
In-Reply-To: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.=
de>
References: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.d=
e>
=46rom: =3D?UTF-8?q?Torsten=3D20B=3DC3=3DB6gershausen?=3D <tboegi@web.d=
e>
Date: Sat, 2 Jan 2016 22:35:36 +0100
Subject: [PATCH v1 2/6] convert.c: Remove path when not needed
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Some functions get a parameter path, but don't use it.
Remove the unused parameter.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 4bb4ec1..a24c2a2 100644
--- a/convert.c
+++ b/convert.c
@@ -696,7 +696,7 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
 	return 1;
 }
=20
-static enum crlf_action git_path_check_crlf(const char *path, struct g=
it_attr_check *check)
+static enum crlf_action git_path_check_crlf(struct git_attr_check *che=
ck)
 {
 	const char *value =3D check->value;
=20
@@ -713,7 +713,7 @@ static enum crlf_action git_path_check_crlf(const c=
har *path, struct git_attr_ch
 	return CRLF_GUESS;
 }
=20
-static enum eol git_path_check_eol(const char *path, struct git_attr_c=
heck *check)
+static enum eol git_path_check_eol(struct git_attr_check *check)
 {
 	const char *value =3D check->value;
=20
@@ -726,8 +726,7 @@ static enum eol git_path_check_eol(const char *path=
, struct git_attr_check *chec
 	return EOL_UNSET;
 }
=20
-static struct convert_driver *git_path_check_convert(const char *path,
-					     struct git_attr_check *check)
+static struct convert_driver *git_path_check_convert(struct git_attr_c=
heck *check)
 {
 	const char *value =3D check->value;
 	struct convert_driver *drv;
@@ -740,7 +739,7 @@ static struct convert_driver *git_path_check_conver=
t(const char *path,
 	return NULL;
 }
=20
-static int git_path_check_ident(const char *path, struct git_attr_chec=
k *check)
+static int git_path_check_ident(struct git_attr_check *check)
 {
 	const char *value =3D check->value;
=20
@@ -783,12 +782,12 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 	}
=20
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
-		ca->crlf_action =3D git_path_check_crlf(path, ccheck + 4);
+		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
 		if (ca->crlf_action =3D=3D CRLF_GUESS)
-			ca->crlf_action =3D git_path_check_crlf(path, ccheck + 0);
-		ca->ident =3D git_path_check_ident(path, ccheck + 1);
-		ca->drv =3D git_path_check_convert(path, ccheck + 2);
-		ca->eol_attr =3D git_path_check_eol(path, ccheck + 3);
+			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
+		ca->ident =3D git_path_check_ident(ccheck + 1);
+		ca->drv =3D git_path_check_convert(ccheck + 2);
+		ca->eol_attr =3D git_path_check_eol(ccheck + 3);
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_GUESS;
--=20
2.7.0.303.g2c4f448.dirty


=46rom 2183b7fe810a6567adba8d95dbf4a582d1d92521 Mon Sep 17 00:00:00 200=
1
In-Reply-To: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.=
de>
References: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.d=
e>
=46rom: =3D?UTF-8?q?Torsten=3D20B=3DC3=3DB6gershausen?=3D <tboegi@web.d=
e>
Date: Sun, 3 Jan 2016 22:22:35 +0100
Subject: [PATCH v1 3/6] convert.c: Remove input_crlf_action()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Integrate the code of input_crlf_action() into convert_attrs(),
so that ca.crlf_action is aleays valid after calling convert_attrs().
Keep a copy of crlf_action in attr_action, this is needed for
get_convert_attr_ascii().

Remove eol_attr from struct conv_attrs, as it is now used temporally.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/convert.c b/convert.c
index a24c2a2..bca3d0c 100644
--- a/convert.c
+++ b/convert.c
@@ -746,21 +746,10 @@ static int git_path_check_ident(struct git_attr_c=
heck *check)
 	return !!ATTR_TRUE(value);
 }
=20
-static enum crlf_action input_crlf_action(enum crlf_action text_attr, =
enum eol eol_attr)
-{
-	if (text_attr =3D=3D CRLF_BINARY)
-		return CRLF_BINARY;
-	if (eol_attr =3D=3D EOL_LF)
-		return CRLF_INPUT;
-	if (eol_attr =3D=3D EOL_CRLF)
-		return CRLF_CRLF;
-	return text_attr;
-}
-
 struct conv_attrs {
 	struct convert_driver *drv;
-	enum crlf_action crlf_action;
-	enum eol eol_attr;
+	enum crlf_action attr_action; /* What attr says */
+	enum crlf_action crlf_action; /* When no attr is set, use core.autocr=
lf */
 	int ident;
 };
=20
@@ -782,16 +771,23 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 	}
=20
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
 		if (ca->crlf_action =3D=3D CRLF_GUESS)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
+		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
 		ca->drv =3D git_path_check_convert(ccheck + 2);
-		ca->eol_attr =3D git_path_check_eol(ccheck + 3);
+		if (ca->crlf_action =3D=3D CRLF_BINARY)
+			return;
+		eol_attr =3D git_path_check_eol(ccheck + 3);
+		if (eol_attr =3D=3D EOL_LF)
+			ca->crlf_action =3D CRLF_INPUT;
+		else if (eol_attr =3D=3D EOL_CRLF)
+			ca->crlf_action =3D CRLF_CRLF;
 	} else {
 		ca->drv =3D NULL;
 		ca->crlf_action =3D CRLF_GUESS;
-		ca->eol_attr =3D EOL_UNSET;
 		ca->ident =3D 0;
 	}
 }
@@ -818,11 +814,9 @@ int would_convert_to_git_filter_fd(const char *pat=
h)
 const char *get_convert_attr_ascii(const char *path)
 {
 	struct conv_attrs ca;
-	enum crlf_action crlf_action;
=20
 	convert_attrs(&ca, path);
-	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
-	switch (crlf_action) {
+	switch (ca.attr_action) {
 	case CRLF_GUESS:
 		return "";
 	case CRLF_BINARY:
@@ -861,7 +855,6 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src =3D dst->buf;
@@ -882,7 +875,6 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-	ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -912,7 +904,6 @@ static int convert_to_working_tree_internal(const c=
har *path, const char *src,
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
-		ca.crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
 		ret |=3D crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src =3D dst->buf;
@@ -1381,7 +1372,7 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
 	if (ca.ident)
 		filter =3D ident_filter(sha1);
=20
-	crlf_action =3D input_crlf_action(ca.crlf_action, ca.eol_attr);
+	crlf_action =3D ca.crlf_action;
=20
 	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T) ||
 	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
--=20
2.7.0.303.g2c4f448.dirty


=46rom 4b0a119f136ff1b4711cd2e588c8ce183ffd2e8e Mon Sep 17 00:00:00 200=
1
In-Reply-To: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.=
de>
References: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.d=
e>
=46rom: =3D?UTF-8?q?Torsten=3D20B=3DC3=3DB6gershausen?=3D <tboegi@web.d=
e>
Date: Mon, 4 Jan 2016 22:06:11 +0100
Subject: [PATCH v1 4/6] convert.c: Use text_eol_is_crlf()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Add a helper function to find out, which line endings
text files should get at checkout, depending on
core.autocrlf and core.eol

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index bca3d0c..a5701a1 100644
--- a/convert.c
+++ b/convert.c
@@ -149,6 +149,19 @@ const char *get_wt_convert_stats_ascii(const char =
*path)
 	return ret;
 }
=20
+static int text_eol_is_crlf(void)
+{
+	if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
+		return 1;
+	else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
+		return 0;
+	if (core_eol =3D=3D EOL_CRLF)
+		return 1;
+	if (core_eol =3D=3D EOL_UNSET && EOL_NATIVE =3D=3D EOL_CRLF)
+		return 1;
+	return 0;
+}
+
 static enum eol output_eol(enum crlf_action crlf_action)
 {
 	switch (crlf_action) {
@@ -164,12 +177,7 @@ static enum eol output_eol(enum crlf_action crlf_a=
ction)
 		/* fall through */
 	case CRLF_TEXT:
 	case CRLF_AUTO:
-		if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
-			return EOL_CRLF;
-		else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
-			return EOL_LF;
-		else if (core_eol =3D=3D EOL_UNSET)
-			return EOL_NATIVE;
+		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
 	return core_eol;
 }
@@ -1378,8 +1386,9 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
 	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
-	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS))
+	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUE=
SS))
+		;
+	else if (output_eol(crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
=20
 	return filter;
--=20
2.7.0.303.g2c4f448.dirty


=46rom e6345a0f0972ae5b7c58a00c476a7e2544e6eda8 Mon Sep 17 00:00:00 200=
1
In-Reply-To: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.=
de>
References: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.d=
e>
=46rom: =3D?UTF-8?q?Torsten=3D20B=3DC3=3DB6gershausen?=3D <tboegi@web.d=
e>
Date: Tue, 5 Jan 2016 21:50:15 +0100
Subject: [PATCH v1 5/6] convert: auto_crlf=3Dfalse and no attributes se=
t: same
 as binary
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

When core.autocrlf is set to false, and no attributes are set, the file
is treated as binary.
Simplify the logic and remove duplicated code when dealing with
(crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALSE) by =
setting
crlf_action=3DCRLF_BINARY already in convert_attrs().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index a5701a1..50bdc42 100644
--- a/convert.c
+++ b/convert.c
@@ -235,7 +235,6 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	char *dst;
=20
 	if (crlf_action =3D=3D CRLF_BINARY ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E) ||
 	    (src && !len))
 		return 0;
=20
@@ -798,6 +797,8 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 		ca->crlf_action =3D CRLF_GUESS;
 		ca->ident =3D 0;
 	}
+	if (ca->crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_F=
ALSE)
+		ca->crlf_action =3D CRLF_BINARY;
 }
=20
 int would_convert_to_git_filter_fd(const char *path)
@@ -1382,8 +1383,7 @@ struct stream_filter *get_stream_filter(const cha=
r *path, const unsigned char *s
=20
 	crlf_action =3D ca.crlf_action;
=20
-	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T) ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
+	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUE=
SS))
--=20
2.7.0.303.g2c4f448.dirty


=46rom 44aae1e1e06f7e16e2e8f2db83bfa130f0b89f34 Mon Sep 17 00:00:00 200=
1
In-Reply-To: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.=
de>
References: <Message-Id=3D1453558101-6858-1-git-send-email-tboegi@web.d=
e>
=46rom: =3D?UTF-8?q?Torsten=3D20B=3DC3=3DB6gershausen?=3D <tboegi@web.d=
e>
Date: Wed, 27 Jan 2016 15:48:04 +0100
Subject: [PATCH v1 6/6] convert.c: Refactor crlf_action
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Refactor the determination and usage of crlf_action.
Today, when no attributes are set on a file,  crlf_action is set to CRL=
=46_GUESS,
and later, CRLF_GUESS is used as an indication that core.autocrlf is no=
t false
and that some automatic eol conversion is needed.
Make more clear, what is what, by defining:

- CRLF_UNDEFINED : No attributes set. Temparally used, until core.autoc=
rlf and
                   core.eol is evaluated and one
                   CRLF_BINARY, CRLF_AUTO_INPUT or CRLF_AUTO_CRLF is se=
lected
- CRLF_BINARY    : No processing of line endings.
- CRLF_TEXT      : attribute "text" is set, line endings are processed.
- CRLF_TEXT_LF   : attribute "input" or "eol=3Dlf" is set. This implies=
 text.
- CRLF_TEXT_CRLF : attribute "eol=3Dcrlf" is set. This implies text.
- CRLF_AUTO      : attribute "auto" is set.
- CRLF_AUTO_INPUT: No attributes, core.autocrlf=3Dinput
- CRLF_AUTO_CRLF : No attributes, core.autocrlf=3Dtrue

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 77 ++++++++++++++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/convert.c b/convert.c
index 50bdc42..84fe714 100644
--- a/convert.c
+++ b/convert.c
@@ -19,12 +19,14 @@
 #define CONVERT_STAT_BITS_BIN       0x4
=20
 enum crlf_action {
-	CRLF_GUESS =3D -1,
-	CRLF_BINARY =3D 0,
+	CRLF_UNDEFINED,
+	CRLF_BINARY,
 	CRLF_TEXT,
-	CRLF_INPUT,
-	CRLF_CRLF,
-	CRLF_AUTO
+	CRLF_TEXT_LF,
+	CRLF_TEXT_CRLF,
+	CRLF_AUTO,
+	CRLF_AUTO_INPUT,
+	CRLF_AUTO_CRLF
 };
=20
 struct text_stat {
@@ -167,18 +169,19 @@ static enum eol output_eol(enum crlf_action crlf_=
action)
 	switch (crlf_action) {
 	case CRLF_BINARY:
 		return EOL_UNSET;
-	case CRLF_CRLF:
+	case CRLF_TEXT_CRLF:
 		return EOL_CRLF;
-	case CRLF_INPUT:
+	case CRLF_TEXT_LF:
 		return EOL_LF;
-	case CRLF_GUESS:
-		if (!auto_crlf)
-			return EOL_UNSET;
-		/* fall through */
+	case CRLF_UNDEFINED:
+	case CRLF_AUTO_CRLF:
+	case CRLF_AUTO_INPUT:
 	case CRLF_TEXT:
 	case CRLF_AUTO:
+		/* fall through */
 		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
+	warning("Illegal crlf_action %d\n", (int)crlf_action);
 	return core_eol;
 }
=20
@@ -247,11 +250,11 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
=20
 	gather_stats(src, len, &stats);
=20
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
=20
-		if (crlf_action =3D=3D CRLF_GUESS) {
+		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/*
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
@@ -278,7 +281,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst =3D buf->buf;
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -319,8 +322,8 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (stats.lf =3D=3D stats.crlf)
 		return 0;
=20
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
-		if (crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
+		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/* If we have any CR or CRLF line endings, we do not touch it */
 			/* This is the new safer autocrlf-handling */
 			if (stats.cr > 0 || stats.crlf > 0)
@@ -708,16 +711,16 @@ static enum crlf_action git_path_check_crlf(struc=
t git_attr_check *check)
 	const char *value =3D check->value;
=20
 	if (ATTR_TRUE(value))
-		return CRLF_TEXT;
+		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_LF;
 	else if (ATTR_FALSE(value))
 		return CRLF_BINARY;
 	else if (ATTR_UNSET(value))
 		;
 	else if (!strcmp(value, "input"))
-		return CRLF_INPUT;
+		return CRLF_TEXT_LF;
 	else if (!strcmp(value, "auto"))
 		return CRLF_AUTO;
-	return CRLF_GUESS;
+	return CRLF_UNDEFINED;
 }
=20
 static enum eol git_path_check_eol(struct git_attr_check *check)
@@ -780,7 +783,7 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
 		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf( ccheck + 4);
-		if (ca->crlf_action =3D=3D CRLF_GUESS)
+		if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
 		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
@@ -789,16 +792,22 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 			return;
 		eol_attr =3D git_path_check_eol(ccheck + 3);
 		if (eol_attr =3D=3D EOL_LF)
-			ca->crlf_action =3D CRLF_INPUT;
+			ca->crlf_action =3D CRLF_TEXT_LF;
 		else if (eol_attr =3D=3D EOL_CRLF)
-			ca->crlf_action =3D CRLF_CRLF;
+			ca->crlf_action =3D CRLF_TEXT_CRLF;
 	} else {
 		ca->drv =3D NULL;
-		ca->crlf_action =3D CRLF_GUESS;
+		ca->crlf_action =3D CRLF_UNDEFINED;
 		ca->ident =3D 0;
 	}
-	if (ca->crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_F=
ALSE)
+	if (ca->crlf_action =3D=3D CRLF_TEXT)
+		ca->crlf_action =3D text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_=
LF;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_FALSE)
 		ca->crlf_action =3D CRLF_BINARY;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_TRUE)
+		ca->crlf_action =3D CRLF_AUTO_CRLF;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_INPUT)
+		ca->crlf_action =3D CRLF_AUTO_INPUT;
 }
=20
 int would_convert_to_git_filter_fd(const char *path)
@@ -826,18 +835,22 @@ const char *get_convert_attr_ascii(const char *pa=
th)
=20
 	convert_attrs(&ca, path);
 	switch (ca.attr_action) {
-	case CRLF_GUESS:
+	case CRLF_UNDEFINED:
 		return "";
 	case CRLF_BINARY:
 		return "-text";
 	case CRLF_TEXT:
 		return "text";
-	case CRLF_INPUT:
+	case CRLF_TEXT_LF:
 		return "text eol=3Dlf";
-	case CRLF_CRLF:
-		return "text=3Dauto eol=3Dcrlf";
+	case CRLF_TEXT_CRLF:
+		return "text eol=3Dcrlf";
 	case CRLF_AUTO:
 		return "text=3Dauto";
+	case CRLF_AUTO_CRLF:
+		return "text=3Dauto eol=3Dcrlf"; /* This is not supported yet */
+	case CRLF_AUTO_INPUT:
+		return "text=3Dauto eol=3Dlf"; /* This is not supported yet */
 	}
 	return "";
 }
@@ -1382,11 +1395,13 @@ struct stream_filter *get_stream_filter(const c=
har *path, const unsigned char *s
 		filter =3D ident_filter(sha1);
=20
 	crlf_action =3D ca.crlf_action;
-
-	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T))
+	if ((crlf_action =3D=3D CRLF_BINARY) ||
+			(crlf_action =3D=3D CRLF_TEXT_LF))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
-	else if ((crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUE=
SS))
+	else if ((crlf_action =3D=3D CRLF_AUTO ||
+						crlf_action =3D=3D CRLF_AUTO_INPUT ||
+						crlf_action =3D=3D CRLF_AUTO_CRLF))
 		;
 	else if (output_eol(crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
--=20
2.7.0.303.g2c4f448.dirty
