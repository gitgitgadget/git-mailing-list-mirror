From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: [PATCH] t0027: Improve test for not-normalized files
Date: Fri, 9 Oct 2015 04:58:42 +0200
Message-ID: <56172D62.9060408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 04:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkNtT-000456-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 04:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbbJIC6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 22:58:47 -0400
Received: from mout.web.de ([212.227.15.14]:58627 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbbJIC6q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 22:58:46 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MIeTI-1ZmZkh1BSS-002H49; Fri, 09 Oct 2015 04:58:43
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
X-Provags-ID: V03:K0:LKLPljm/ogCxgR4EMhQqiNyGOh3dr9/yiN0XUS9c5JUMtFU+3rp
 MDZX2d5+qv5DR2McnD01azKVrUB9Nhp2b6WyA0gdJLVQOO8ZIHwCCbZ5+p19gaht/fNH4jI
 NzatNZ75P+IeGQq4lUr7FGYeJZteslED6Zfj1mvfoD80Ax1MmdINq86PS6OmEYliamgGsYx
 jbI+65QkPDkBHdnaJIFYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GhbEGRrt5v0=:AkmqZ0IKn9sgMJCuXN4tYP
 ydUAsqO08KjDT5Ik6SSDGoTkATcmv0HBIK61EQtzzg6KlgbDW+DfH99tnq6bX2olagV42w08M
 bZBoDHSvxNA/SDWT5X50OwXfLZ5WZpnjgOfS4pt7aZA5D/Fi7dTBWPitwRwwLt53r1nwnmNRP
 nHQxNoUg7iHdDLCH0TvXPv3oUTWGwXIFkWrqtOmMhZV9weJG9uElcrslyviZUzb1GGOp1nblT
 GgoYWy95oPZ+7t/E0/nKoxv5FWdFNTDkmfPouwFjH09M8nraiS124i6yKZnH5aBFGyIcVekWo
 EWQqNDSmdGnz4Kx+OWfGtxB/APTeBpp3RUDtLZI1s/OheLUG4AnBppPMBAx1tTMYzFs6rJdpU
 +SiIqWurps7BG3DKxf7OS6/sK67GXSc+N77LDWTJARhOQGPZI/8a1OrB6sq5Hs5bkB9B2T3Os
 fJ4fF+laOBivbi6qpQc2+taSx6QdO586DEmp5UyjhTB9nNNXPZCORcnCdfBYTUnrdhRw7IUcK
 4EGlTgBnhZM4R/ZocDYZqR036gBkzIvWHytpu5lGYG8AgWvXnh98RTlwVJNvhPdNdIhAFkK5R
 HXYrXNkUqVPGl4AQLMF0QZZn450gPJcOOIXAni6/OqOMfID9zunOFKp/ynbzOHa0XjpxcCjpy
 J8R/acZ9oE0rylfgVPZ/Z67DcdwjEb3iClDtYM7wrej7f42yZ0G0iYNUFa5R/ddvVfqXL7YFk
 c2E2cSh2JkozbEGkJcKa6LTiDV5H3MRPBaTZhNzB+wgsEbxD9LoyFlBAI1Y5cmVAM79HRmTy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279300>

When a text file with mixed line endings is commited into the repo,
it is called "not normalized" (or NNO) in t0027.
The existing test case using repoMIX did not fully test all combination=
s:
(Especially when core.autocrlf =3D true)
=46iles with NL are not converted at commit, but at checkout, so a warn=
ing
NL->CRLF is given.
=46iles with CRLF are not converted at all (so no warning will be given=
),
unless they are marked as "text" or "auto".

Remove repoMIX introduced in commit 8eeab92f02, and replace it with
a combination of NNO tests.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0027-auto-crlf.sh | 191 ++++++++++++++++++++++++++++++++++++++++++-=
--------
 1 file changed, 157 insertions(+), 34 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 1a56e5e..b343651 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -55,6 +55,26 @@ create_gitattributes () {
 	esac
 }
 +create_NNO_files () {
+	lfname=3D$1
+	crlfname=3D$2
+	lfmixcrlf=3D$3
+	lfmixcr=3D$4
+	crlfnul=3D$5
+	for crlf in false true input
+	do
+		for attr in "" auto text -text lf crlf
+		do
+			pfx=3DNNO_${crlf}_attr_${attr} &&
+			cp $lfname    ${pfx}_LF.txt &&
+			cp $crlfname  ${pfx}_CRLF.txt &&
+			cp $lfmixcrlf ${pfx}_CRLF_mix_LF.txt &&
+			cp $lfmixcr   ${pfx}_LF_mix_CR.txt &&
+			cp $crlfnul   ${pfx}_CRLF_nul.txt
+		done
+	done
+}
+
 check_warning () {
 	case "$1" in
 	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
@@ -62,7 +82,7 @@ check_warning () {
 	'')	                                                 >"$2".expect ;;
 	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
-	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" >"$=
2".actual
+	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | u=
niq
>"$2".actual
 	test_cmp "$2".expect "$2".actual
 }
 @@ -71,19 +91,10 @@ commit_check_warn () {
 	attr=3D$2
 	lfname=3D$3
 	crlfname=3D$4
-	repoMIX=3D$5
-	lfmixcrlf=3D$6
-	lfmixcr=3D$7
-	crlfnul=3D$8
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
 	pfx=3Dcrlf_${crlf}_attr_${attr}
-	# Special handling for repoMIX: It should already be in the repo
-	# with CRLF
-	f=3DrepoMIX
-	fname=3D${pfx}_$f.txt
-	echo >.gitattributes &&
-	cp $f $fname &&
-	git -c core.autocrlf=3Dfalse add $fname 2>"${pfx}_$f.err" &&
-	git commit -m "repoMIX" &&
 	create_gitattributes "$attr" &&
 	for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
 	do
@@ -99,6 +110,45 @@ commit_check_warn () {
 	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 }
 +commit_chk_wrnNNO () {
+	crlf=3D$1
+	attr=3D$2
+	lfwarn=3D$3
+	crlfwarn=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
+	pfx=3DNNO_${crlf}_attr_${attr}
+	#Commit files on top of existing file
+	create_gitattributes "$attr" &&
+	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
+	do
+		fname=3D${pfx}_$f.txt &&
+		cp $f $fname &&
+		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
+		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${pf=
x}_$f.err" 2>&1
+	done
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF" '
+		check_warning "$lfwarn" ${pfx}_LF.err
+	'
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF"=
 '
+		check_warning "$crlfwarn" ${pfx}_CRLF.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
mix_LF" '
+		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF_mi=
x_cr" '
+		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
+	'
+
+	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRLF_=
nul" '
+		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
+	'
+}
+
 check_files_in_repo () {
 	crlf=3D$1
 	attr=3D$2
@@ -115,6 +165,31 @@ check_files_in_repo () {
 	compare_files $crlfnul ${pfx}CRLF_nul.txt
 }
 +check_in_repo_NNO () {
+	crlf=3D$1
+	attr=3D$2
+	lfname=3D$3
+	crlfname=3D$4
+	lfmixcrlf=3D$5
+	lfmixcr=3D$6
+	crlfnul=3D$7
+	pfx=3DNNO_${crlf}_attr_${attr}_
+	test_expect_success "compare_files $lfname ${pfx}LF.txt" '
+		compare_files $lfname ${pfx}LF.txt
+	'
+	test_expect_success "compare_files $crlfname ${pfx}CRLF.txt" '
+		compare_files $crlfname ${pfx}CRLF.txt
+	'
+	test_expect_success "compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt" =
'
+		compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt
+	'
+	test_expect_success "compare_files $lfmixcr ${pfx}LF_mix_CR.txt" '
+		compare_files $lfmixcr ${pfx}LF_mix_CR.txt
+	'
+	test_expect_success "compare_files $crlfnul ${pfx}CRLF_nul.txt" '
+		compare_files $crlfnul ${pfx}CRLF_nul.txt
+	'
+}
  checkout_files () {
 	eol=3D$1
@@ -169,7 +244,11 @@ test_expect_success 'setup master' '
 	printf "line1\nline2\rline3"     >LF_mix_CR &&
 	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
 	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
-	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul
+	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul &&
+	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF=
_mix_LF &&
+	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
+	git commit -m "mixed line endings" &&
+	test_tick
 '
  @@ -191,46 +270,72 @@ else
 	WAMIX=3DCRLF_LF
 fi
 -#                         attr   LF        CRLF      repoMIX   CRLFmi=
xLF
LFmixCR   CRLFNUL
+#                         attr   LF        CRLF      CRLFmixLF LFmixCR=
   CRLFNUL
 test_expect_success 'commit files empty attr' '
-	commit_check_warn false ""     ""        ""        ""        ""      =
  ""
   "" &&
-	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
   "" &&
-	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""
   ""
+	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
+	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
 '
  test_expect_success 'commit files attr=3Dauto' '
-	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  "$WAMIX"=
  ""
   "" &&
-	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
   "" &&
-	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""
   ""
+	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  ""      =
  "" &&
+	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
+	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""      =
  ""
 '
  test_expect_success 'commit files attr=3Dtext' '
-	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WAMIX"=
  "$WILC"
  "$WICL"   &&
-	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
"
"LF_CRLF" ""        &&
-	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" "CRLF_LF=
" ""
   "CRLF_LF"
+	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WILC" =
  "$WICL"
  &&
+	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
   &&
+	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""      =
  "CRLF_LF"
 '
  test_expect_success 'commit files attr=3D-text' '
-	commit_check_warn false "-text" ""       ""        ""        ""      =
  ""
   "" &&
-	commit_check_warn true  "-text" ""       ""        ""        ""      =
  ""
   "" &&
-	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""
   ""
+	commit_check_warn false "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn true  "-text" ""       ""        ""        ""      =
  "" &&
+	commit_check_warn input "-text" ""       ""        ""        ""      =
  ""
 '
  test_expect_success 'commit files attr=3Dlf' '
-	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""
   "CRLF_LF" &&
-	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""
   "CRLF_LF" &&
-	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_LF=
"  ""
   "CRLF_LF"
+	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""
"CRLF_LF" &&
+	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""
"CRLF_LF" &&
+	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""     =
  "CRLF_LF"
 '
  test_expect_success 'commit files attr=3Dcrlf' '
-	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
"
"LF_CRLF" "" &&
-	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
"
"LF_CRLF" "" &&
-	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
"
"LF_CRLF" ""
+	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" "" &&
+	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
 '
 +#                       attr   LF        CRLF      CRLFmixLF 	 LF_mix=
_CR   CRLFNUL
+commit_chk_wrnNNO false ""     ""        ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO true  ""     "LF_CRLF" ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO input ""     ""        ""        ""        	 ""     =
   	 ""
+
+
+commit_chk_wrnNNO false "auto" "$WILC"   "$WICL"   "$WAMIX"  	 ""     =
   	 ""
+commit_chk_wrnNNO true  "auto" "LF_CRLF" ""        "LF_CRLF" 	 ""     =
   	 ""
+commit_chk_wrnNNO input "auto" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   	 ""
+
+commit_chk_wrnNNO false "text" "$WILC"   "$WICL"   "$WAMIX"  	 "$WILC"=
   	 "$WICL"
+commit_chk_wrnNNO true  "text" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO input "text" ""        "CRLF_LF" "CRLF_LF" 	 ""     =
   =09
"CRLF_LF"
+
+commit_chk_wrnNNO false "-text" ""       ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO true  "-text" ""       ""        ""        	 ""     =
   	 ""
+commit_chk_wrnNNO input "-text" ""       ""        ""        	 ""     =
   	 ""
+
+commit_chk_wrnNNO false "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   =09
"CRLF_LF"
+commit_chk_wrnNNO true  "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   =09
"CRLF_LF"
+commit_chk_wrnNNO input "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""    =
   =09
"CRLF_LF"
+
+commit_chk_wrnNNO false "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO true  "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+commit_chk_wrnNNO input "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_CRL=
=46" 	 ""
+
 test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
-	git reset --hard
+	git -c core.autocrlf=3Dfalse reset --hard
 '
  test_expect_success 'commit empty gitattribues' '
@@ -257,6 +362,24 @@ test_expect_success 'commit -text' '
 	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRLF_=
nul
 '
 +#                       attr    LF        CRLF      CRLF_mix_LF  LF_m=
ix_CR
CRLFNUL
+check_in_repo_NNO false ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO true  ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO input ""      LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+
+check_in_repo_NNO false "auto"  LF        LF        LF           LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO true  "auto"  LF        LF        LF           LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO input "auto"  LF        LF        LF           LF_mi=
x_CR
CRLF_nul
+
+check_in_repo_NNO false "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+check_in_repo_NNO true  "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+check_in_repo_NNO input "text"  LF        LF        LF           LF_mi=
x_CR 	LF_nul
+
+check_in_repo_NNO false "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO true  "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+check_in_repo_NNO input "-text" LF        CRLF      CRLF_mix_LF  LF_mi=
x_CR
CRLF_nul
+
+
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
 # How to read the table below:
--=20
2.5.0
