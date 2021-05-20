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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46FCC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C67C60698
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbhETPXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbhETPXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:23:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C54C06138E
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:21:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y7so2349483eda.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lHr1CuIUs9ZAyrYm3HpPJaGnohQX5P78/4Gf/To/x3A=;
        b=uVq5xBtmNTQkAlyn61fH8rxHCcg794cZ00BZt+FsYPxUtA0UFUJ2NffMttdS2ebNPU
         OiZr037BZWJxO6DdUG+JZ1qZSULbiYE7jxAfheeFZESAhmVxdSt0O10BqBfzLTGTpyPi
         229PqirXANR6FOKDfZiMf1uIf3IDdLA8wBPBoIkvB1WiUCHzEgMffmcWXJN2p91sH+dS
         PZMIFJQKlr6Wm95X/jXACvnODi/Tx3wGX+yoLL4XBAOC7fuwungV6+411P6iNLDWwTOH
         LLiCYUQWafmvTCHmMkGpAW1QSNUBEwb/j/xJqE4NzoO/tcCGNTRboCqLu28uMv8Gmpor
         t7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lHr1CuIUs9ZAyrYm3HpPJaGnohQX5P78/4Gf/To/x3A=;
        b=GuMIlPd39e2CNzTvCLHQvAAZTikhEDTZwLkY661aDjwtWwBDud1nCUlW6m9WhqekJT
         Im64gfJzh374IyDNuGhaZmYenOJjhBskJZ6llqluCxtvSGVOdAZ93h6UJm0YKFvmtin2
         q9VFbE3myLSnMr7um97DwIBx97UULioRMGV7b7Vk00Fy1iNMbJarv1pEaDvxeP5PSCR1
         neyOSUn6yq6+E/OjGCzFY4TBGdY6qYKvzb1VQUlN+YMt/2a0u3Flm4CdNeaE3hQkTA8n
         pFf4yXcZhwEiVA7j3VhYgXyNcmEM623GP4GOYteLB3pqS0hcMku3o94yinbaOXC/mMkH
         BZfA==
X-Gm-Message-State: AOAM533DqN/uIeWZNd3dr75QKV8CwMI1dNsQgoI6YgepviYT8I2gvTIb
        YoEAvUfURHDR3Z0JBjhaBhWhfoIzU6DGvA==
X-Google-Smtp-Source: ABdhPJyO0TlUlxawGtvwwqdtT36GO0F5/UpuBBD7854Koj5zW5i6uWMRzsE2AwnE/vurV23K/89+Og==
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr5444997edt.76.1621524106840;
        Thu, 20 May 2021 08:21:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g23sm1373163ejb.15.2021.05.20.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:21:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 05/21] t1401-symbolic-ref: avoid direct filesystem
 access
Date:   Thu, 20 May 2021 17:20:08 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <248d9ffe79272c7a6efef64512d72ccb9a91349a.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <248d9ffe79272c7a6efef64512d72ccb9a91349a.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <871ra1qvli.fsf@evledraar.gmail.com>
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
>  t/t1401-symbolic-ref.sh | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index a4ebb0b65fec..315a62f78019 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -3,21 +3,20 @@
>  test_description='basic symbolic-ref tests'
>  . ./test-lib.sh
>  
> -# If the tests munging HEAD fail, they can break detection of
> -# the git repo, meaning that further tests will operate on
> -# the surrounding git repo instead of the trash directory.
> -reset_to_sane() {
> -	echo ref: refs/heads/foo >.git/HEAD
> -}
> -
> -test_expect_success 'symbolic-ref writes HEAD' '
> +test_expect_success 'setup' '
>  	git symbolic-ref HEAD refs/heads/foo &&
> -	echo ref: refs/heads/foo >expect &&
> -	test_cmp expect .git/HEAD
> +	test_commit file &&
> +	"$TAR" cf .git.tar .git/
>  '
>  
> -test_expect_success 'symbolic-ref reads HEAD' '
> -	echo refs/heads/foo >expect &&
> +reset_to_sane() {
> +	rm -rf .git &&
> +	"$TAR" xf .git.tar
> +}
> +
> +test_expect_success 'symbolic-ref read/write roundtrip' '
> +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
> +	echo refs/heads/read-write-roundtrip >expect &&
>  	git symbolic-ref HEAD >actual &&
>  	test_cmp expect actual
>  '
> @@ -25,12 +24,13 @@ test_expect_success 'symbolic-ref reads HEAD' '
>  test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
>  	test_must_fail git symbolic-ref HEAD foo
>  '
> +
>  reset_to_sane
>  
>  test_expect_success 'symbolic-ref refuses bare sha1' '
> -	echo content >file && git add file && git commit -m one &&
>  	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
>  '
> +
>  reset_to_sane
>  
>  test_expect_success 'HEAD cannot be removed' '
> @@ -42,16 +42,16 @@ reset_to_sane
>  test_expect_success 'symbolic-ref can be deleted' '
>  	git symbolic-ref NOTHEAD refs/heads/foo &&
>  	git symbolic-ref -d NOTHEAD &&
> -	test_path_is_file .git/refs/heads/foo &&
> -	test_path_is_missing .git/NOTHEAD
> +	git rev-parse refs/heads/foo &&
> +	test_must_fail git symbolic-ref NOTHEAD
>  '
>  reset_to_sane
>  
>  test_expect_success 'symbolic-ref can delete dangling symref' '
>  	git symbolic-ref NOTHEAD refs/heads/missing &&
>  	git symbolic-ref -d NOTHEAD &&
> -	test_path_is_missing .git/refs/heads/missing &&
> -	test_path_is_missing .git/NOTHEAD
> +	test_must_fail git rev-parse refs/heads/missing &&
> +	test_must_fail git symbolic-ref NOTHEAD
>  '
>  reset_to_sane

You do end up needing to refactor some rather nasty patterns in this
series, so this isn't on you initially...

But since we're encountering this "reset_to_sane" pattern, can't we just
as easily fix it up with something more obvious than replacing an echo
to a specific ref with a tarring up and untarring of the whole .git each
time?

I.e. something like:

   # setup the .git initially

Then:

   test_when_finished "rm -rf copy" &&
   git clone . copy &&
   # munge the repo and use "git -C copy" for the tests"

?
