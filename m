Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE2C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC81961073
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhETP1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhETP1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:27:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE62C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:26:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i7so8110654ejc.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3/C73zkk+XvZilbSSNbiF3O7MoijZHQXJDrRyiqYgfs=;
        b=ekYUmc8x1F768X/xPMqIZf55meKEYVbNyoyNu0lHIlhh2hPzI5CUSoSmt2n4X/22ve
         dDdrHEI2pR74Hp7uXZKp0qavNhb0XFfv37rpNl5HHe+17OSM07saDjmzgoXIB1oxeFRO
         rcz2lqgezxzYiorCcE8082Kk4vUv/CmqhOnmznNKVufXbs9QF25PXUL0N6mE2NaT4Pyo
         MoOdwi2lSfCyY4kYCJKT56r8TPINK8qLLXsxc1rHJM7ZpEpQBr3iTnezCOVsLCEPEWwf
         xd6XmUg8taBoBVWZ1yH4phOMRTq26ioxU9nK7Mp540jF0JJN9tN3KfKAQj4JXiyLG2wg
         4eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3/C73zkk+XvZilbSSNbiF3O7MoijZHQXJDrRyiqYgfs=;
        b=JU6R2oLVPrziegiWBqN3Mpigc83Fwsgbq27Samrsd2hIEHxBKwXGoLqagkFv7+LPww
         lOOZYsTsW7H4/ioyQoNLaFSuHseczuFFnUhzgjwnGzoixbcg7kHDSE8IxR0nOqwPn1f4
         pOkpjE+VKNHWGH0SF1YjUhsrj3bil1ZWifDs5G8shfrAoW0Kbme0XByX0UHqAd5w4+Fz
         lAkQgJZ24n6dSsIQRByIxCh8gzpFKh0WhBcDGHxzfXUwW7YiCx2WFyKa4qLczMjUQNfs
         tVGpNz5NxMTFmq+vBA50CJUXaHRLbFJn3xtoZXvMhD67C2kJSqcIurlyMBMeuEfR5TDF
         jjLw==
X-Gm-Message-State: AOAM532gSN4hxjhwpv7nrX4maehWIntfyFwKvc2Ff1cso+LARJmKSKAU
        jiDp2ZHkc9KwD3cGMi1qN7mHKTTLY83lbg==
X-Google-Smtp-Source: ABdhPJyznmYOGU93D7KyqufHS4FqcUdbvWYhSAuFfE7QO37ADMl6612cL4pUcqlBJlmhHX5Dkm+p8g==
X-Received: by 2002:a17:906:5049:: with SMTP id e9mr5174610ejk.30.1621524381928;
        Thu, 20 May 2021 08:26:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g22sm1627841ejz.46.2021.05.20.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:26:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 08/21] t5000: reformat indentation to the latest fashion
Date:   Thu, 20 May 2021 17:24:11 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <e67b90847c4eb78fff786944c04413f8a02cffb4.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <e67b90847c4eb78fff786944c04413f8a02cffb4.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87v97dpgtf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t5000-tar-tree.sh | 104 ++++++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 51 deletions(-)
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 7204799a0b52..b6734cba7e65 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -111,25 +111,25 @@ test_expect_success 'setup' '
>  	EOF
>  '
>  
> -test_expect_success \
> -    'populate workdir' \
> -    'mkdir a &&
> -     echo simple textfile >a/a &&
> -     ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
> -     echo long filename >a/four$hundred &&
> -     mkdir a/bin &&
> -     test-tool genrandom "frotz" 500000 >a/bin/sh &&
> -     printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
> -     printf "A not substituted O" >a/substfile2 &&
> -     if test_have_prereq SYMLINKS; then
> -	ln -s a a/l1
> -     else
> -	printf %s a > a/l1
> -     fi &&
> -     (p=long_path_to_a_file && cd a &&
> -      for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
> -      echo text >file_with_long_path) &&
> -     (cd a && find .) | sort >a.lst'
> +test_expect_success 'populate workdir' '
> +	mkdir a &&
> +	echo simple textfile >a/a &&
> +	ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
> +	echo long filename >a/four$hundred &&
> +	mkdir a/bin &&
> +	test-tool genrandom "frotz" 500000 >a/bin/sh &&
> +	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
> +	printf "A not substituted O" >a/substfile2 &&
> +	if test_have_prereq SYMLINKS; then
> +		ln -s a a/l1
> +	else
> +		printf %s a >a/l1
> +	fi &&
> +	(p=long_path_to_a_file && cd a &&
> +		for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
> +		echo text >file_with_long_path) &&
> +	(cd a && find .) | sort >a.lst
> +'

Since we're refactoring this anyway, let's:

 * split up ten=... hundred=... into two lines
 * put "; then" on its own line, if ...\nthen\n...
 * split up that sub-shell into (\np=...&& ..., i.e. our usual style, some with the one-line for-loop

>  test_expect_success \
>      'add ignored file' \
> @@ -147,18 +147,18 @@ test_expect_success 'setup export-subst' '
>  		>a/substfile1
>  '
>  
> -test_expect_success \
> -    'create bare clone' \
> -    'git clone --bare . bare.git &&
> -     cp .git/info/attributes bare.git/info/attributes'
> +test_expect_success 'create bare clone' '
> +	git clone --bare . bare.git &&
> +	cp .git/info/attributes bare.git/info/attributes
> +'
>  
> -test_expect_success \
> -    'remove ignored file' \
> -    'rm a/ignored'
> +test_expect_success 'remove ignored file' '
> +	rm a/ignored
> +'
>  
> -test_expect_success \
> -    'git archive' \
> -    'git archive HEAD >b.tar'
> +test_expect_success 'git archive' '
> +	git archive HEAD >b.tar
> +'
>  
>  check_tar b
>  
> @@ -194,26 +194,28 @@ check_added with_untracked2 untracked one/untracked
>  check_added with_untracked2 untracked two/untracked
>  
>  test_expect_success 'git archive on large files' '
> -    test_config core.bigfilethreshold 1 &&
> -    git archive HEAD >b3.tar &&
> -    test_cmp_bin b.tar b3.tar
> +	test_config core.bigfilethreshold 1 &&
> +	git archive HEAD >b3.tar &&
> +	test_cmp_bin b.tar b3.tar
>  '
>  
> -test_expect_success \
> -    'git archive in a bare repo' \
> -    '(cd bare.git && git archive HEAD) >b3.tar'
> +test_expect_success 'git archive in a bare repo' '
> +	(cd bare.git && git archive HEAD) >b3.tar
> +'

Ditto subshell etc. on one line, can't this be git -C bare.git archive
HEAD >b3.tar?

>  
> -test_expect_success \
> -    'git archive vs. the same in a bare repo' \
> -    'test_cmp_bin b.tar b3.tar'
> +test_expect_success 'git archive vs. the same in a bare repo' '
> +	test_cmp_bin b.tar b3.tar
> +'
>  
> -test_expect_success 'git archive with --output' \
> -    'git archive --output=b4.tar HEAD &&
> -    test_cmp_bin b.tar b4.tar'
> +test_expect_success 'git archive with --output' '
> +	git archive --output=b4.tar HEAD &&
> +	test_cmp_bin b.tar b4.tar
> +'
>  
> -test_expect_success 'git archive --remote' \
> -    'git archive --remote=. HEAD >b5.tar &&
> -    test_cmp_bin b.tar b5.tar'
> +test_expect_success 'git archive --remote' '
> +	git archive --remote=. HEAD >b5.tar &&
> +	test_cmp_bin b.tar b5.tar
> +'
>  
>  test_expect_success 'git archive --remote with configured remote' '
>  	git config remote.foo.url . &&
> @@ -224,13 +226,13 @@ test_expect_success 'git archive --remote with configured remote' '
>  	test_cmp_bin b.tar b5-nick.tar
>  '
>  
> -test_expect_success \
> -    'validate file modification time' \
> -    'mkdir extract &&
> -     "$TAR" xf b.tar -C extract a/a &&
> -     test-tool chmtime --get extract/a/a >b.mtime &&
> -     echo "1117231200" >expected.mtime &&
> -     test_cmp expected.mtime b.mtime'
> +test_expect_success 'validate file modification time' '
> +	mkdir extract &&
> +	"$TAR" xf b.tar -C extract a/a &&
> +	test-tool chmtime --get extract/a/a >b.mtime &&
> +	echo "1117231200" >expected.mtime &&
> +	test_cmp expected.mtime b.mtime
> +'
>  
>  test_expect_success \
>      'git get-tar-commit-id' \

