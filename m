Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6143C388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 11:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1FF2067B
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 11:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOSrPU+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKGLKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKGLKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 06:10:05 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B65C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 03:10:05 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so3137397pgb.10
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zypBo3A9UlbLuuQqiDiOYa25gWllqARliPCLrcc2ozE=;
        b=aOSrPU+L2gGeEu1olEaqoGJc0GqV1guYRiixmEr6qCodq3NdNl+FpujWjAiRHVSSK+
         ZyretDNg2PW7bJhOoyoMw3MyHm1YbRhz4UWUL490J/yioVlZ4BFfIsaqSKyPC1Cjel0x
         qTpbXzIAbUMikiESYB+Cn+93s6LLcrZ4dzFm1nZJqRgqVzkXx4AV5VUIZ1KlAv212r/D
         RDrJGnP1XIFwoIBApw2oKllEH9zR7f9DM7N6OaMKmfbT8Oj4xyXjew+7XUup/2pr22A0
         VJLdBVYA+s/0eLW/O469m3zQ5O5EphZVCO1ljWkK4ZtoZBtU78+zMpLeOIwoIntjoVPp
         qDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zypBo3A9UlbLuuQqiDiOYa25gWllqARliPCLrcc2ozE=;
        b=bHBJm/Y+IK0d7ScK9Yc3+ZSAy4PlarXDhJxPzgODuNBpfeozjZGn7X7zLXTCbPyBnq
         OtZEz5bT3h7bUvxNEC2GTHS91aq7QMuj7XNBEx6ZTQ42pB4Vt2COIkDPFTKhv0hUuZuY
         UwvIMkEMPz8cClt5iTUNhfCt8FDEU7Z56yrnkQjiQJziPltKhmn4cWn95+nOsIt+enxP
         AGnup81GgGBb4dfo6n2Jk/ApbVcUG3xPHDOkBsI1+PCdZyu0TQuUuhcEDA5R9UoMkwW9
         1FKcrnbGI791U2gNyizWNTfNlsE0XPnnUEGLaK7fQBIsPKFBj2EvTtom7u5zdNot2KCs
         OMQg==
X-Gm-Message-State: AOAM531hxAR0szkcIIpq/+R4r7w17VRG5zeO08hM11GyNi7Pyq/pse7m
        mYpBmyJBLzxLUIk+cDZ7dE0=
X-Google-Smtp-Source: ABdhPJzsMFI5NmguCmk7mkwwjEnSCSLoVK9xxihvBSKuegmsxvP216OUhApGjNg+HVTD87c5ZO6zBw==
X-Received: by 2002:a63:c54e:: with SMTP id g14mr5217848pgd.19.1604747405004;
        Sat, 07 Nov 2020 03:10:05 -0800 (PST)
Received: from localhost ([2402:800:63a8:b485:e36e:8de6:8e0a:7fe3])
        by smtp.gmail.com with ESMTPSA id w6sm4343109pgr.71.2020.11.07.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:10:04 -0800 (PST)
Date:   Sat, 7 Nov 2020 18:10:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with untracked
 files as "-dirty"
Message-ID: <20201107111002.GA21309@danh.dev>
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201026175742.33356-1-sangunb09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026175742.33356-1-sangunb09@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta,

On 2020-10-26 23:27:42+0530, Sangeeta Jain <sangunb09@gmail.com> wrote:
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..9104d1946d 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -765,6 +765,11 @@ test_expect_success 'setup different kinds of dirty submodules' '
>  	cat >expected <<-\EOF &&
>  	dirty-both-ways
>  	dirty-head
> +	EOF
> +	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
> +	cat >expected <<-\EOF &&
> +	dirty-both-ways
> +	dirty-head

This will throw-away above change to "expected", I think this is not
what you expected to write!

>  	dirty-otherwise
>  	EOF
>  	test_cmp expected actual &&
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index d7145ccca4..894a11b224 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -93,6 +93,14 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
>  	) &&
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
> +	expect_from_to >expect.body $subtip $subprev &&
> +	test_cmp expect.body actual.body
> +'
> +
> +test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
> +	test_config diff.ignoreSubmodules none &&
> +	git diff HEAD >actual &&
> +	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subtip $subprev-dirty &&
>  	test_cmp expect.body actual.body
>  '
> @@ -168,13 +176,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  		git clean -qfdx &&
>  		>cruft
>  	) &&
> -	git diff HEAD >actual &&
> +	git diff --ignore-submodules=none HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual.body &&
>  	git diff --ignore-submodules=all HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
> -	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	git diff HEAD >actual3 &&
>  	test_must_be_empty actual3 &&
>  	git diff --ignore-submodules=dirty HEAD >actual4 &&
>  	test_must_be_empty actual4
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f852136585..bb368b685d 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
>  
>  test_expect_success 'submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&

Nit:

I suspect that we're in favour of writing all optional argument before
all committish here.

IOW, I think we're better move HEAD after --ignore-submodules=none

>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	EOF
> @@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	test_must_be_empty actual
>  '
>  
> @@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>  
>  test_expect_success 'submodule contains untracked and modified content' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>  
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	EOF
> @@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
>  
>  test_expect_success 'modified submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 $head6..$head8:
> @@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>  
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head6..$head8:
>  	  > change
> @@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>  
>  test_expect_success 'modified submodule contains untracked and modified content' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>  
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	Submodule sm1 $head6..$head8:
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index fc8229c726..dc7b242697 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
>  
>  test_expect_success 'submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	EOF
> @@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	test_must_be_empty actual
>  '
>  
> @@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>  
>  test_expect_success 'submodule contains untracked and modified content' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>  # NOT OK
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
>  
>  test_expect_success 'modified submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 $head7..$head8:
> @@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>  
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head7..$head8:
>  	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>  
>  test_expect_success 'modified submodule contains untracked and modified content' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>  
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	Submodule sm1 $head7..$head8:
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 537787e598..78cd86be3a 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -503,6 +503,31 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
>  		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
>  		EOF
>  
> +		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'untracked changes in added submodule (A. S...) (untracked ignored)' '
> +	(	cd super_repo &&
> +		## create untracked file in the submodule.
> +		(	cd sub1 &&
> +			echo "xxxx" >file_in_sub
> +		) &&

Another nit: I think we can avoid subshell by:
	
	echo "xxxx" >sub1/file_in_sub

In general, I think other usages of subshell in this patch could be
replaced by above syntax for echo and "git -C subdir" for git.

> +
> +		HMOD=$(git hash-object -t blob -- .gitmodules) &&
> +		HSUP=$(git rev-parse HEAD) &&
> +		HSUB=$HSUP &&
> +
> +		cat >expect <<-EOF &&
> +		# branch.oid $HSUP
> +		# branch.head master
> +		# branch.upstream origin/master
> +		# branch.ab +0 -0
> +		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> +		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		EOF
> +
>  		git status --porcelain=v2 --branch --untracked-files=all >actual &&
>  		test_cmp expect actual
>  	)
> @@ -582,6 +607,33 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
>  		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
>  		EOF
>  
> +		git status --porcelain=v2 --branch --untracked-files=all --ignore-submodules=none >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'staged and untracked changes in added submodule (AM S.M.) (untracked ignored)' '
> +	(	cd super_repo &&
> +		(	cd sub1 &&
> +			## stage new changes in tracked file.
> +			git add file_in_sub &&
> +			## create new untracked file.
> +			echo "yyyy" >>another_file_in_sub
> +		) &&
> +
> +		HMOD=$(git hash-object -t blob -- .gitmodules) &&
> +		HSUP=$(git rev-parse HEAD) &&
> +		HSUB=$HSUP &&
> +
> +		cat >expect <<-EOF &&
> +		# branch.oid $HSUP
> +		# branch.head master
> +		# branch.upstream origin/master
> +		# branch.ab +0 -0
> +		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> +		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		EOF
> +
>  		git status --porcelain=v2 --branch --untracked-files=all >actual &&
>  		test_cmp expect actual
>  	)
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index 3fcb44767f..72da00a962 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -94,36 +94,60 @@ test_expect_success 'status with added file in submodule (short)' '
>  test_expect_success 'status with untracked file in submodule' '
>  	(cd sub && git reset --hard) &&
>  	echo "content" >sub/new-file &&
> -	git status >output &&
> +	git status --ignore-submodules=none >output &&
>  	test_i18ngrep "modified:   sub (untracked content)" output
>  '
>  
> +test_expect_success 'status with untracked file in submodule (untracked ignored)' '
> +	(cd sub && git reset --hard) &&
> +	echo "content" >sub/new-file &&
> +	git status >output &&
> +	test_i18ngrep "^nothing to commit" output
> +'
> +
>  test_expect_success 'status -uno with untracked file in submodule' '
>  	git status -uno >output &&
>  	test_i18ngrep "^nothing to commit" output
>  '
>  
>  test_expect_success 'status with untracked file in submodule (porcelain)' '
> -	git status --porcelain >output &&
> +	git status --porcelain --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 M sub
>  	EOF
>  '
>  
> +test_expect_success 'status with untracked file in submodule (porcelain) (untracked ignored)' '
> +	git status --porcelain >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'status with untracked file in submodule (short)' '
> -	git status --short >output &&
> +	git status --short --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 ? sub
>  	EOF
>  '
>  
> +test_expect_success 'status with untracked file in submodule (short) (untracked ignored)' '
> +	git status --short >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'status with added and untracked file in submodule' '
>  	(cd sub && git reset --hard && echo >foo && git add foo) &&
>  	echo "content" >sub/new-file &&
> -	git status >output &&
> +	git status --ignore-submodules=none >output &&
>  	test_i18ngrep "modified:   sub (modified content, untracked content)" output
>  '
>  
> +test_expect_success 'status with added and untracked file in submodule (untracked ignored)' '
> +	(cd sub && git reset --hard && echo >foo && git add foo) &&
> +	echo "content" >sub/new-file &&
> +	git status >output &&
> +	test_i18ngrep "modified:   sub (modified content)" output
> +'
> +
>  test_expect_success 'status with added and untracked file in submodule (porcelain)' '
>  	(cd sub && git reset --hard && echo >foo && git add foo) &&
>  	echo "content" >sub/new-file &&
> @@ -168,10 +192,17 @@ test_expect_success 'status with added file in modified submodule (porcelain)' '
>  test_expect_success 'status with untracked file in modified submodule' '
>  	(cd sub && git reset --hard) &&
>  	echo "content" >sub/new-file &&
> -	git status >output &&
> +	git status --ignore-submodules=none >output &&
>  	test_i18ngrep "modified:   sub (new commits, untracked content)" output
>  '
>  
> +test_expect_success 'status with untracked file in modified submodule (untracked ignored)' '
> +	(cd sub && git reset --hard) &&
> +	echo "content" >sub/new-file &&
> +	git status >output &&
> +	test_i18ngrep "modified:   sub (new commits)" output
> +'
> +
>  test_expect_success 'status with untracked file in modified submodule (porcelain)' '
>  	git status --porcelain >output &&
>  	diff output - <<-\EOF
> @@ -182,10 +213,17 @@ test_expect_success 'status with untracked file in modified submodule (porcelain
>  test_expect_success 'status with added and untracked file in modified submodule' '
>  	(cd sub && git reset --hard && echo >foo && git add foo) &&
>  	echo "content" >sub/new-file &&
> -	git status >output &&
> +	git status --ignore-submodules=none >output &&
>  	test_i18ngrep "modified:   sub (new commits, modified content, untracked content)" output
>  '
>  
> +test_expect_success 'status with added and untracked file in modified submodule (untracked ignored)' '
> +	(cd sub && git reset --hard && echo >foo && git add foo) &&
> +	echo "content" >sub/new-file &&
> +	git status >output &&
> +	test_i18ngrep "modified:   sub (new commits, modified content)" output
> +'
> +
>  test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
>  	(cd sub && git reset --hard && echo >foo && git add foo) &&
>  	echo "content" >sub/new-file &&
> @@ -349,7 +387,7 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
>  '
>  
>  test_expect_success 'status with untracked file in nested submodule (porcelain)' '
> -	git -C super status --porcelain >output &&
> +	git -C super status --porcelain --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 M sub1
>  	 M sub2
> @@ -357,8 +395,13 @@ test_expect_success 'status with untracked file in nested submodule (porcelain)'
>  	EOF
>  '
>  
> +test_expect_success 'status with untracked file in nested submodule (porcelain) (untracked ignored)' '
> +	git -C super status --porcelain >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
> -	git -C super status --porcelain=2 >output &&
> +	git -C super status --porcelain=2 --ignore-submodules=none >output &&
>  	sanitize_output output &&
>  	diff output - <<-\EOF
>  	1 .M S..U 160000 160000 160000 HASH HASH sub1
> @@ -367,8 +410,13 @@ test_expect_success 'status with untracked file in nested submodule (porcelain=2
>  	EOF
>  '
>  
> +test_expect_success 'status with untracked file in nested submodule (porcelain=2) (untracked ignored)' '
> +	git -C super status --porcelain=2 >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'status with untracked file in nested submodule (short)' '
> -	git -C super status --short >output &&
> +	git -C super status --short --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 ? sub1
>  	 ? sub2
> @@ -376,13 +424,18 @@ test_expect_success 'status with untracked file in nested submodule (short)' '
>  	EOF
>  '
>  
> +test_expect_success 'status with untracked file in nested submodule (short) (untracked ignored)' '
> +	git -C super status --short >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'setup superproject with modified file in nested submodule' '
>  	git -C super/sub1/sub2 add file &&
>  	git -C super/sub2 add file
>  '
>  
>  test_expect_success 'status with added file in nested submodule (porcelain)' '
> -	git -C super status --porcelain >output &&
> +	git -C super status --porcelain --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 M sub1
>  	 M sub2
> @@ -390,8 +443,16 @@ test_expect_success 'status with added file in nested submodule (porcelain)' '
>  	EOF
>  '
>  
> +test_expect_success 'status with added file in nested submodule (porcelain) (untracked ignored)' '
> +	git -C super status --porcelain >output &&
> +	diff output - <<-\EOF
> +	 M sub1
> +	 M sub2
> +	EOF
> +'
> +
>  test_expect_success 'status with added file in nested submodule (porcelain=2)' '
> -	git -C super status --porcelain=2 >output &&
> +	git -C super status --porcelain=2 --ignore-submodules=none >output &&
>  	sanitize_output output &&
>  	diff output - <<-\EOF
>  	1 .M S.M. 160000 160000 160000 HASH HASH sub1
> @@ -400,8 +461,17 @@ test_expect_success 'status with added file in nested submodule (porcelain=2)' '
>  	EOF
>  '
>  
> +test_expect_success 'status with added file in nested submodule (porcelain=2) (untracked ignored)' '
> +	git -C super status --porcelain=2 >output &&
> +	sanitize_output output &&
> +	diff output - <<-\EOF
> +	1 .M S.M. 160000 160000 160000 HASH HASH sub1
> +	1 .M S.M. 160000 160000 160000 HASH HASH sub2
> +	EOF
> +'
> +
>  test_expect_success 'status with added file in nested submodule (short)' '
> -	git -C super status --short >output &&
> +	git -C super status --short --ignore-submodules=none >output &&
>  	diff output - <<-\EOF
>  	 m sub1
>  	 m sub2
> @@ -409,4 +479,12 @@ test_expect_success 'status with added file in nested submodule (short)' '
>  	EOF
>  '
>  
> +test_expect_success 'status with added file in nested submodule (short) (untracked ignored)' '
> +	git -C super status --short >output &&
> +	diff output - <<-\EOF
> +	 m sub1
> +	 m sub2
> +	EOF
> +'
> +
>  test_done
> -- 
> 2.21.1 (Apple Git-122.3)
> 

-- 
Danh
