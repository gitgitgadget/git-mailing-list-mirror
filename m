From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0027: Add repoMIX and LF_nul
Date: Sat, 25 Apr 2015 09:41:20 -0700
Message-ID: <xmqqegn817pr.fsf@gitster.dls.corp.google.com>
References: <553B3871.6050904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 18:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym397-0006zm-5O
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 18:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbDYQlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 12:41:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750825AbbDYQlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 12:41:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 283FA497B4;
	Sat, 25 Apr 2015 12:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gIUoR/yQw9V/
	IdOAxtDOtd5kFJ8=; b=kHwu7B6oPk9QHKDT4yiZGvPTFLoii+4mV/rozFFXpMWe
	pX6Ib+eWs1DSOmdXKsudEVtecP5MG1KwfM7NkTaf/r0drmWm/upKLtgK1plezblU
	5T1X5cwzVzHX7ppY4rvr+wfTGNR+uJoJCKA4L4qK3sQTLNJEDMmq7BNYV8z2tko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rdBie1
	YxvHvhPhfw1qwJQ46ART0jX1AeTtHqc5YhL7oAVYndjb0JpCdhqrt+cj7aJLZ+cy
	qPkQspXV7OczfCTHGpsHZY1AFv/3112l1kDaB4Jgnw3Yw8mDtDEDL0mF+jLsWIaC
	KXy+0mFu+sn+fI7/uX/PllM2MAj02M7tjYV1E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2194D497B3;
	Sat, 25 Apr 2015 12:41:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86D7D497B2;
	Sat, 25 Apr 2015 12:41:21 -0400 (EDT)
In-Reply-To: <553B3871.6050904@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 25 Apr 2015 08:47:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E77AECD4-EB69-11E4-A59B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267792>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> "new safer autocrlf handling":
>   Check if eols in a file are converted at commit, when the file has
>   CR (or CLLF) in the repo (technically speaking in the index).

s/CLLF/CRLF/?  (no need to resend for this; I'll locally amend)

>   Add a test-file repoMIX with mixed line-endings.
>   When converting LF->CRLF or CRLF->LF: check the warnings
>
> checkout_files():
>   Checking out CRLF_nul and checking for eol coversion does not
>   make much sense (CRLF will stay CRLF).

Hmph, would it still make sense to make sure that CRLF will stay CRLF
so that future changes to break this expectation can be caught?  Not
that such a breakage is likely...

>   Use the file LF_nul instead: It is handled a binary in "auto" modes=
,
>   and when declared as text the LF may be replaced with CRLF, dependi=
ng
>   on the configuration

Makes sense.  Thanks.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since V1:
> Use TAB for indentation at on place (Thanks Eric)
>  t/t0027-auto-crlf.sh | 157 ++++++++++++++++++++++++++++-------------=
----------
>  1 file changed, 85 insertions(+), 72 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 810934b..1a56e5e 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -71,12 +71,21 @@ commit_check_warn () {
>  	attr=3D$2
>  	lfname=3D$3
>  	crlfname=3D$4
> -	lfmixcrlf=3D$5
> -	lfmixcr=3D$6
> -	crlfnul=3D$7
> -	create_gitattributes "$attr" &&
> +	repoMIX=3D$5
> +	lfmixcrlf=3D$6
> +	lfmixcr=3D$7
> +	crlfnul=3D$8
>  	pfx=3Dcrlf_${crlf}_attr_${attr}
> -	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
> +	# Special handling for repoMIX: It should already be in the repo
> +	# with CRLF
> +	f=3DrepoMIX
> +	fname=3D${pfx}_$f.txt
> +	echo >.gitattributes &&
> +	cp $f $fname &&
> +	git -c core.autocrlf=3Dfalse add $fname 2>"${pfx}_$f.err" &&
> +	git commit -m "repoMIX" &&
> +	create_gitattributes "$attr" &&
> +	for f in LF CRLF repoMIX LF_mix_CR CRLF_mix_LF LF_nul CRLF_nul
>  	do
>  		fname=3D${pfx}_$f.txt &&
>  		cp $f $fname &&
> @@ -120,7 +129,7 @@ checkout_files () {
>  	git config core.autocrlf $crlf &&
>  	pfx=3Deol_${eol}_crlf_${crlf}_attr_${attr}_ &&
>  	src=3Dcrlf_false_attr__ &&
> -	for f in LF CRLF LF_mix_CR CRLF_mix_LF CRLF_nul
> +	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
>  	do
>  		rm $src$f.txt &&
>  		if test -z "$eol"; then
> @@ -142,8 +151,8 @@ checkout_files () {
>  	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf=
 gitattributes=3D$attr file=3DLF_mix_CR" "
>  		compare_ws_file $pfx $lfmixcr   ${src}LF_mix_CR.txt
>  	"
> -	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf=
 gitattributes=3D$attr file=3DCRLF_nul" "
> -		compare_ws_file $pfx $crlfnul   ${src}CRLF_nul.txt
> +	test_expect_success "checkout core.eol=3D$eol core.autocrlf=3D$crlf=
 gitattributes=3D$attr file=3DLF_nul" "
> +		compare_ws_file $pfx $crlfnul   ${src}LF_nul.txt
>  	"
>  }
> =20
> @@ -155,6 +164,7 @@ test_expect_success 'setup master' '
>  	git commit -m "add .gitattributes" "" &&
>  	printf "line1\nline2\nline3"     >LF &&
>  	printf "line1\r\nline2\r\nline3" >CRLF &&
> +	printf "line1\r\nline2\nline3"   >repoMIX &&
>  	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
>  	printf "line1\nline2\rline3"     >LF_mix_CR &&
>  	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
> @@ -181,40 +191,41 @@ else
>  	WAMIX=3DCRLF_LF
>  fi
> =20
> +#                         attr   LF        CRLF      repoMIX   CRLFm=
ixLF LFmixCR   CRLFNUL
>  test_expect_success 'commit files empty attr' '
> -	commit_check_warn false ""     ""        ""        ""        ""    =
    "" &&
> -	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
> -	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
> +	commit_check_warn false ""     ""        ""        ""        ""    =
    ""        "" &&
> +	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""        "" &&
> +	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""        ""
>  '
> =20
>  test_expect_success 'commit files attr=3Dauto' '
> -	commit_check_warn false "auto" "$WILC"  "$WICL"    "$WAMIX"  ""    =
    "" &&
> -	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
> -	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
> +	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  "$WAMI=
X"  ""        "" &&
> +	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""        "" &&
> +	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""        ""
>  '
> =20
>  test_expect_success 'commit files attr=3Dtext' '
> -	commit_check_warn false "text" "$WILC"  "$WICL"    "$WAMIX"  "$WILC=
"  "$WICL" &&
> -	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""        &&
> -	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF"
> +	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WAMI=
X"  "$WILC"   "$WICL"   &&
> +	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "LF_CRLF" ""        &&
> +	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""        "CRLF_LF"
>  '
> =20
>  test_expect_success 'commit files attr=3D-text' '
> -	commit_check_warn false "-text" ""       ""        ""        ""    =
    "" &&
> -	commit_check_warn true  "-text" ""       ""        ""        ""    =
    "" &&
> -	commit_check_warn input "-text" ""       ""        ""        ""    =
    ""
> +	commit_check_warn false "-text" ""       ""        ""        ""    =
    ""        "" &&
> +	commit_check_warn true  "-text" ""       ""        ""        ""    =
    ""        "" &&
> +	commit_check_warn input "-text" ""       ""        ""        ""    =
    ""        ""
>  '
> =20
>  test_expect_success 'commit files attr=3Dlf' '
> -	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
> -	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF" &&
> -	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF"
> +	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""       "CRLF_LF" &&
> +	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""       "CRLF_LF" &&
> +	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""       "CRLF_LF"
>  '
> =20
>  test_expect_success 'commit files attr=3Dcrlf' '
> -	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
> -	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
> -	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
> +	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "LF_CRLF" "" &&
> +	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "LF_CRLF" "" &&
> +	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "LF_CRLF" ""
>  '
> =20
>  test_expect_success 'create files cleanup' '
> @@ -268,79 +279,81 @@ test_expect_success 'commit -text' '
>  #                    eol     acrlf
>  #                                            -----------------------=
-----------------------
>  #                                            What we want to have in=
 the working tree:
> -if test_have_prereq MINGW
> +if test_have_prereq NATIVE_CRLF
>  then
>  MIX_CRLF_LF=3DCRLF
>  MIX_LF_CR=3DCRLF_mix_CR
>  NL=3DCRLF
> +LFNUL=3DCRLF_nul
>  else
>  MIX_CRLF_LF=3DCRLF_mix_LF
>  MIX_LF_CR=3DLF_mix_CR
>  NL=3DLF
> +LFNUL=3DLF_nul
>  fi
>  export CRLF_MIX_LF_CR MIX NL
> =20
> -checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +checkout_files    lf      false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      input  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      false "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    LF_nul
> +checkout_files    lf      input "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      false "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
>  checkout_files    lf      true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> -checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +checkout_files    lf      input "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      input "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    lf      input "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
>  checkout_files    lf      false "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    lf      true  "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    lf      input "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> =20
> -checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> +checkout_files    crlf    false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    false "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    LF_nul
>  checkout_files    crlf    false "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    crlf    true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> -checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +checkout_files    crlf    false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    crlf    true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
>  checkout_files    crlf    false "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    crlf    true  "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> =20
> -checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $=
MIX_LF_CR   CRLF_nul
> +checkout_files    ""      false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      input  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      false "auto"    $NL   CRLF  $MIX_CRLF_LF L=
=46_mix_CR    LF_nul
> +checkout_files    ""      true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    LF_nul
> +checkout_files    ""      input "auto"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      false "text"    $NL   CRLF  $MIX_CRLF_LF $=
MIX_LF_CR   $LFNUL
>  checkout_files    ""      true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> -checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +checkout_files    ""      input "text"    LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      input "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    ""      input "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
>  checkout_files    ""      false "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    ""      true  "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    ""      input "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> =20
> -checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $=
MIX_LF_CR   CRLF_nul
> +checkout_files    native  false  ""       LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    native  true   ""       CRLF  CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    native  false "auto"    $NL   CRLF  $MIX_CRLF_LF L=
=46_mix_CR    LF_nul
> +checkout_files    native  true  "auto"    CRLF  CRLF  CRLF         L=
=46_mix_CR    LF_nul
> +checkout_files    native  false "text"    $NL   CRLF  $MIX_CRLF_LF $=
MIX_LF_CR   $LFNUL
>  checkout_files    native  true  "text"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
> -checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> -checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    CRLF_nul
> +checkout_files    native  false "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    native  true  "-text"   LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    native  false "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
> +checkout_files    native  true  "lf"      LF    CRLF  CRLF_mix_LF  L=
=46_mix_CR    LF_nul
>  checkout_files    native  false "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
>  checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         C=
RLF_mix_CR  CRLF_nul
