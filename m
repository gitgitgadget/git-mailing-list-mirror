From: tboegi@web.de
Subject: [PATCH v3 1/7] t0027: Add tests for get_stream_filter()
Date: Fri,  5 Feb 2016 17:13:20 +0100
Message-ID: <1454688800-20714-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRizf-0001rY-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbcBEQMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:19 -0500
Received: from mout.web.de ([212.227.17.12]:58263 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbcBEQMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:17 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LuLt5-1a0ssi3xbT-011jpk; Fri, 05 Feb 2016 17:12:16
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:VCBzFvzbrx5qVCflWQwEZTrzVcNaaMXGifJXja90+etLZxflsjV
 yoyLeA29weh6nTJnch94qf6M0y9O7T4+EVBXG2mNA1znekhEqZwOS54AT8JZMx0n3L+NY4+
 lbKzYh6RA8C5GCPQnDkKuicEjaV3cMkAq08NO/bXip24ugOKSxKu1LQDnDb4kxAX3wEVUqt
 emdlKzGxfpCJFRPWKZDsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MLvfhOCsKPk=:xpA3g9gX9m9eZN0o2RPOEK
 YjJpLPTmWDPTQqoqv3WWQJuJDKpoMB3MzNHWL156NsCNhojXPCx/nYv4xviPitTvuY4VER/Y8
 lx/lYG1nxLBfpxaufG3Pnj+sqQETsPl6H2k05/BpYgqZdq+U4VJl+AXRYeppmV0W0gqMYLRUL
 DpBr3V5kvYZR8PlLM4Cq63yZHSFCM8lQRg7X+1iZ9839/Ps409iWtokCekDqeE7yNBl6oR0WI
 xCwPMdCDnn2raFabREVoQKhJYUyQtZnF91eD09UyIq2q3LfQ8B7dU2uR/daAhsOS6FJw1izic
 5ciXneeG4PrA97MdAqwjYo3Ft+SpGpSi/9mjlKkmO/Tgqi9NHD/W4PARswIuOeWJViohtXgP9
 85Ww3F32AlfWn8HN4ZoEDunQ2Py99iPEOx7rKhB7PrIl94ZpFznKUl9NDypTVregFoBI4s6AY
 M/JaNE+BZhowpgXEHuuitH/PhayqV42SIGDAfpfv0jtMwB0jCofiLBbGsqV/v2ff+OdJ4m/Rc
 YG9QFsmEQ+RqIh7TUOTHRmDPdm1YTI+gIbx/Qtaac/5MY9K6D+Ge0mlypeDmY2AWl/g7I2iqo
 LHJp+z2ND1SviXKRq2UZSE+NDvpEFrGgeGjiS6zY8G05UqePOWJFmwu+A9ushLXfHQwLOy1Ns
 50rSWUkFo/8hGv0SWYKzvE2h9+X8WuE/QTw3Dbs1efU5EqfsHkUHp+sTN4hBImQk0TFYW86gX
 lCtbgj2toirRt7APYQ8JxjtJlLpsQQkFT+4VYPOakxhlytLaXHt7+nZs0q2L2kr/pi0aNiLg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285581>

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
Changes since v2:
1/7 t0027 uses ident instead of i (the empty "" is still there)
    better ident of case..esac (thanks for the patience)
    (And again the question, if there is an official init.el, please)
4/7 don't change the logic which stream filter to use   =20
7/7 had been broken (wrong bufferlen) , should be OK now


t/t0027-auto-crlf.sh | 281 ++++++++++++++++++++++++++------------------=
-------
 1 file changed, 146 insertions(+), 135 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 504e5a0..fc4c628 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -21,38 +21,32 @@ compare_ws_file () {
 	pfx=3D$1
 	exp=3D$2.expect
 	act=3D$pfx.actual.$3
-	tr '\015\000' QN <"$2" >"$exp" &&
-	tr '\015\000' QN <"$3" >"$act" &&
-	test_cmp $exp $act &&
-	rm $exp $act
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
+	test_cmp "$exp" "$act" &&
+	rm "$exp" "$act"
 }
=20
 create_gitattributes () {
-	attr=3D$1
-	case "$attr" in
-		auto)
-		echo "*.txt text=3Dauto" >.gitattributes
-		;;
-		text)
-		echo "*.txt text" >.gitattributes
-		;;
-		-text)
-		echo "*.txt -text" >.gitattributes
-		;;
-		crlf)
-		echo "*.txt eol=3Dcrlf" >.gitattributes
-		;;
-		lf)
-		echo "*.txt eol=3Dlf" >.gitattributes
-		;;
-		"")
-		echo >.gitattributes
-		;;
-		*)
-		echo >&2 invalid attribute: $attr
-		exit 1
-		;;
-	esac
+	{
+		while test "$#" !=3D 0
+		do
+			case "$1" in
+			auto)	 echo '*.txt text=3Dauto' ;;
+			ident) echo '*.txt ident' ;;
+			text)	 echo '*.txt text' ;;
+			-text) echo '*.txt -text' ;;
+			crlf)  echo '*.txt eol=3Dcrlf' ;;
+			lf)    echo '*.txt eol=3Dlf' ;;
+			"") ;;
+			*)
+				echo >&2 invalid attribute: "$1"
+				exit 1
+				;;
+			esac &&
+			shift
+		done
+	} >.gitattributes
 }
=20
 create_NNO_files () {
@@ -208,28 +202,30 @@ check_in_repo_NNO () {
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
+	test_expect_success "ls-files --eol attr=3D$attr $ident $aeol core.au=
tocrlf=3D$crlf core.eol=3D$ceol" '
 		test_when_finished "rm expect actual" &&
 		sort <<-EOF >expect &&
 		i/crlf w/$(stats_ascii $crlfname) crlf_false_attr__CRLF.txt
@@ -244,19 +240,19 @@ checkout_files () {
 		sort >actual &&
 		test_cmp expect actual
 	'
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF" "
+	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF" "
 		compare_ws_file $pfx $lfname    crlf_false_attr__LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF" "
+	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DCRLF" "
 		compare_ws_file $pfx $crlfname  crlf_false_attr__CRLF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DCRLF_mix_LF" "
+	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DCRLF_mix_LF" "
 		compare_ws_file $pfx $lfmixcrlf crlf_false_attr__CRLF_mix_LF.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_mix_CR" "
+	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF_mix_CR" "
 		compare_ws_file $pfx $lfmixcr   crlf_false_attr__LF_mix_CR.txt
 	"
-	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf g=
itattributes=3D$attr file=3DLF_nul" "
+	test_expect_success "checkout $ident $attr $aeol core.autocrlf=3D$crl=
f core.eol=3D$ceol file=3DLF_nul" "
 		compare_ws_file $pfx $crlfnul   crlf_false_attr__LF_nul.txt
 	"
 }
@@ -301,14 +297,13 @@ test_expect_success 'setup master' '
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
@@ -449,23 +444,18 @@ check_in_repo_NNO input "-text" LF        CRLF   =
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
@@ -480,69 +470,90 @@ LFNUL=3DLF_nul
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
+checkout_files ""      "" 	 ""    false  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    false  crlf     LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    false  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    false  native   LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    input  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    input  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    true   ""       CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    true   crlf     CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    true   lf       CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      "" 	 ""    true   native   CRLF  CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    false  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    false  crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    false  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    false  native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    input  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    input  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    true   ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    true   crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    true   lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files ""      ident ""    true   native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    false  ""       $NL   CRLF  $MIX_CRL=
=46_LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    false  crlf     CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    false  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    false  native   $NL   CRLF  $MIX_CRL=
=46_LF LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    input  ""       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    input  lf       LF    CRLF  CRLF_mix=
_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    true   ""       CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    true   crlf     CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    true   lf       CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
+checkout_files "auto"  "" 	 ""    true   native   CRLF  CRLF  CRLF    =
     LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    false  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    false  crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    false  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    false  native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    input  ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    input  lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    true   ""       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    true   crlf     LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    true   lf       LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+checkout_files "auto"  ident ""    true   native   LF    CRLF  CRLF_mi=
x_LF  LF_mix_CR    LF_nul
+
+for id in "" ident;
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
