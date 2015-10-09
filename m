From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0027: Improve test for not-normalized files
Date: Fri, 09 Oct 2015 15:12:34 -0700
Message-ID: <xmqqk2qvofn1.fsf@gitster.mtv.corp.google.com>
References: <56172D62.9060408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:12:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkfu5-0001RL-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 00:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757421AbbJIWMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2015 18:12:37 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36402 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbbJIWMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 18:12:36 -0400
Received: by pablk4 with SMTP id lk4so97760014pab.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=95eCe+pGHiWZ6vT/SYguswLXM/0UDZoK8i6ptnNhSh4=;
        b=Ey1Amyy1eBanXCXQkl9U9V3V63kvUECEaHOSh7igPfmpAfrHvppXmHVwSZtxxC29cM
         nSlm0UF2uSPuvVo6s1qGObxSmhO/ZSEeiagqGpzTtLDaREIS1mhB2hYB7pAeKv4+9mo8
         9sgQaQez5lJbbuILkLCSZvjNVmtXGHd6CYPf5N9ju9V8CNJRNOKuD1TFQG2lVogwOviF
         aUtwXTZciNo4Axzd9pt8yz00Hwy5kX2CvtqcP/OFXLbwy+CdWbBNF+fXY7aYODqpRGPQ
         Oi2uHS6pax2Fq2LupYxunnxSqKzWpr5jr5b0MdgmXkbXI+3VkXs/KiNtstgTQc3fe79Q
         NVpg==
X-Received: by 10.66.142.202 with SMTP id ry10mr18394703pab.86.1444428755858;
        Fri, 09 Oct 2015 15:12:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1c62:e65b:3845:3a2b])
        by smtp.gmail.com with ESMTPSA id bw8sm4313812pab.47.2015.10.09.15.12.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 15:12:35 -0700 (PDT)
In-Reply-To: <56172D62.9060408@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 9 Oct 2015 04:58:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279318>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

This patch is seriously broken and I do not know how you managed to
do so.  Notice how "+create_NNO_files" is indented but no other
added lines in the same hunk, for example.

I tried to hand-munge, but gave up.

>  +commit_chk_wrnNNO () {

Squashing warn into wrn or (check into chk) does not make it any
easier to read or type.

> +	crlf=3D$1
> +	attr=3D$2
> +	lfwarn=3D$3
> +	crlfwarn=3D$4
> +	lfmixcrlf=3D$5
> +	lfmixcr=3D$6
> +	crlfnul=3D$7
> +	pfx=3DNNO_${crlf}_attr_${attr}
> +	#Commit files on top of existing file
> +	create_gitattributes "$attr" &&
> +	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
> +	do
> +		fname=3D${pfx}_$f.txt &&
> +		cp $f $fname &&
> +		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
> +		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${=
pfx}_$f.err" 2>&1
> +	done
> +
> +	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF"=
 '
> +		check_warning "$lfwarn" ${pfx}_LF.err
> +	'
> +	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRL=
=46" '
> +		check_warning "$crlfwarn" ${pfx}_CRLF.err
> +	'
> +
> +	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRL=
=46_mix_LF" '
> +		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
> +	'
> +
> +	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr LF_=
mix_cr" '
> +		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
> +	'
> +
> +	test_expect_success "commit NNO files crlf=3D$crlf attr=3D$attr CRL=
=46_nul" '
> +		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
> +	'
> +}
> +
>  check_files_in_repo () {
>  	crlf=3D$1
>  	attr=3D$2
> @@ -115,6 +165,31 @@ check_files_in_repo () {
>  	compare_files $crlfnul ${pfx}CRLF_nul.txt
>  }
>  +check_in_repo_NNO () {
> +	crlf=3D$1
> +	attr=3D$2
> +	lfname=3D$3
> +	crlfname=3D$4
> +	lfmixcrlf=3D$5
> +	lfmixcr=3D$6
> +	crlfnul=3D$7
> +	pfx=3DNNO_${crlf}_attr_${attr}_
> +	test_expect_success "compare_files $lfname ${pfx}LF.txt" '
> +		compare_files $lfname ${pfx}LF.txt
> +	'
> +	test_expect_success "compare_files $crlfname ${pfx}CRLF.txt" '
> +		compare_files $crlfname ${pfx}CRLF.txt
> +	'
> +	test_expect_success "compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt=
" '
> +		compare_files $lfmixcrlf ${pfx}CRLF_mix_LF.txt
> +	'
> +	test_expect_success "compare_files $lfmixcr ${pfx}LF_mix_CR.txt" '
> +		compare_files $lfmixcr ${pfx}LF_mix_CR.txt
> +	'
> +	test_expect_success "compare_files $crlfnul ${pfx}CRLF_nul.txt" '
> +		compare_files $crlfnul ${pfx}CRLF_nul.txt
> +	'
> +}
>   checkout_files () {
>  	eol=3D$1
> @@ -169,7 +244,11 @@ test_expect_success 'setup master' '
>  	printf "line1\nline2\rline3"     >LF_mix_CR &&
>  	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
>  	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
> -	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul
> +	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul &&
> +	create_NNO_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CR=
LF_mix_LF &&
> +	git -c core.autocrlf=3Dfalse add NNO_*.txt &&
> +	git commit -m "mixed line endings" &&
> +	test_tick
>  '
>   @@ -191,46 +270,72 @@ else
>  	WAMIX=3DCRLF_LF
>  fi
>  -#                         attr   LF        CRLF      repoMIX   CRLF=
mixLF
> LFmixCR   CRLFNUL
> +#                         attr   LF        CRLF      CRLFmixLF LFmix=
CR   CRLFNUL
>  test_expect_success 'commit files empty attr' '
> -	commit_check_warn false ""     ""        ""        ""        ""    =
    ""
>    "" &&
> -	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
>    "" &&
> -	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""
>    ""
> +	commit_check_warn false ""     ""        ""        ""        ""    =
    "" &&
> +	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
> +	commit_check_warn input ""     ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
>  '
>   test_expect_success 'commit files attr=3Dauto' '
> -	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  "$WAMI=
X"  ""
>    "" &&
> -	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
>    "" &&
> -	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""
>    ""
> +	commit_check_warn false "auto" "$WILC"   "$WICL"   "$WAMIX"  ""    =
    "" &&
> +	commit_check_warn true  "auto" "LF_CRLF" ""        "LF_CRLF" ""    =
    "" &&
> +	commit_check_warn input "auto" ""        "CRLF_LF" "CRLF_LF" ""    =
    ""
>  '
>   test_expect_success 'commit files attr=3Dtext' '
> -	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WAMI=
X"  "$WILC"
>   "$WICL"   &&
> -	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF"
> "LF_CRLF" ""        &&
> -	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" "CRLF_=
LF" ""
>    "CRLF_LF"
> +	commit_check_warn false "text" "$WILC"   "$WICL"   "$WAMIX"  "$WILC=
"   "$WICL"
>   &&
> +	commit_check_warn true  "text" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
>    &&
> +	commit_check_warn input "text" ""        "CRLF_LF" "CRLF_LF" ""    =
    "CRLF_LF"
>  '
>   test_expect_success 'commit files attr=3D-text' '
> -	commit_check_warn false "-text" ""       ""        ""        ""    =
    ""
>    "" &&
> -	commit_check_warn true  "-text" ""       ""        ""        ""    =
    ""
>    "" &&
> -	commit_check_warn input "-text" ""       ""        ""        ""    =
    ""
>    ""
> +	commit_check_warn false "-text" ""       ""        ""        ""    =
    "" &&
> +	commit_check_warn true  "-text" ""       ""        ""        ""    =
    "" &&
> +	commit_check_warn input "-text" ""       ""        ""        ""    =
    ""
>  '
>   test_expect_success 'commit files attr=3Dlf' '
> -	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""
>    "CRLF_LF" &&
> -	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""
>    "CRLF_LF" &&
> -	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF" "CRLF_=
LF"  ""
>    "CRLF_LF"
> +	commit_check_warn false "lf"    ""       "CRLF_LF" "CRLF_LF"  ""
> "CRLF_LF" &&
> +	commit_check_warn true  "lf"    ""       "CRLF_LF" "CRLF_LF"  ""
> "CRLF_LF" &&
> +	commit_check_warn input "lf"    ""       "CRLF_LF" "CRLF_LF"  ""   =
    "CRLF_LF"
>  '
>   test_expect_success 'commit files attr=3Dcrlf' '
> -	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF"
> "LF_CRLF" "" &&
> -	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF"
> "LF_CRLF" "" &&
> -	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF"
> "LF_CRLF" ""
> +	commit_check_warn false "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
> +	commit_check_warn true  "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" "" &&
> +	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CR=
LF" ""
>  '
>  +#                       attr   LF        CRLF      CRLFmixLF 	 LF_m=
ix_CR   CRLFNUL
> +commit_chk_wrnNNO false ""     ""        ""        ""        	 ""   =
     	 ""
> +commit_chk_wrnNNO true  ""     "LF_CRLF" ""        ""        	 ""   =
     	 ""
> +commit_chk_wrnNNO input ""     ""        ""        ""        	 ""   =
     	 ""
> +
> +
> +commit_chk_wrnNNO false "auto" "$WILC"   "$WICL"   "$WAMIX"  	 ""   =
     	 ""
> +commit_chk_wrnNNO true  "auto" "LF_CRLF" ""        "LF_CRLF" 	 ""   =
     	 ""
> +commit_chk_wrnNNO input "auto" ""        "CRLF_LF" "CRLF_LF" 	 ""   =
     	 ""
> +
> +commit_chk_wrnNNO false "text" "$WILC"   "$WICL"   "$WAMIX"  	 "$WIL=
C"   	 "$WICL"
> +commit_chk_wrnNNO true  "text" "LF_CRLF" ""        "LF_CRLF" 	 "LF_C=
RLF" 	 ""
> +commit_chk_wrnNNO input "text" ""        "CRLF_LF" "CRLF_LF" 	 ""   =
     =09
> "CRLF_LF"
> +
> +commit_chk_wrnNNO false "-text" ""       ""        ""        	 ""   =
     	 ""
> +commit_chk_wrnNNO true  "-text" ""       ""        ""        	 ""   =
     	 ""
> +commit_chk_wrnNNO input "-text" ""       ""        ""        	 ""   =
     	 ""
> +
> +commit_chk_wrnNNO false "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""  =
     =09
> "CRLF_LF"
> +commit_chk_wrnNNO true  "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""  =
     =09
> "CRLF_LF"
> +commit_chk_wrnNNO input "lf"    ""       "CRLF_LF" "CRLF_LF" 	  ""  =
     =09
> "CRLF_LF"
> +
> +commit_chk_wrnNNO false "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_C=
RLF" 	 ""
> +commit_chk_wrnNNO true  "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_C=
RLF" 	 ""
> +commit_chk_wrnNNO input "crlf" "LF_CRLF" ""        "LF_CRLF" 	 "LF_C=
RLF" 	 ""
> +
>  test_expect_success 'create files cleanup' '
>  	rm -f *.txt &&
> -	git reset --hard
> +	git -c core.autocrlf=3Dfalse reset --hard
>  '
>   test_expect_success 'commit empty gitattribues' '
> @@ -257,6 +362,24 @@ test_expect_success 'commit -text' '
>  	check_files_in_repo input "-text" LF CRLF CRLF_mix_LF LF_mix_CR CRL=
=46_nul
>  '
>  +#                       attr    LF        CRLF      CRLF_mix_LF  LF=
_mix_CR
> CRLFNUL
> +check_in_repo_NNO false ""      LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO true  ""      LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO input ""      LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +
> +check_in_repo_NNO false "auto"  LF        LF        LF           LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO true  "auto"  LF        LF        LF           LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO input "auto"  LF        LF        LF           LF_=
mix_CR
> CRLF_nul
> +
> +check_in_repo_NNO false "text"  LF        LF        LF           LF_=
mix_CR 	LF_nul
> +check_in_repo_NNO true  "text"  LF        LF        LF           LF_=
mix_CR 	LF_nul
> +check_in_repo_NNO input "text"  LF        LF        LF           LF_=
mix_CR 	LF_nul
> +
> +check_in_repo_NNO false "-text" LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO true  "-text" LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +check_in_repo_NNO input "-text" LF        CRLF      CRLF_mix_LF  LF_=
mix_CR
> CRLF_nul
> +
> +
>  ####################################################################=
############
>  # Check how files in the repo are changed when they are checked out
>  # How to read the table below:
