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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B68FC433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196E064F26
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQIrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCQIrP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 04:47:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027AC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:47:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bm21so1271731ejb.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=m03pjouGBgwc5LnDysD4P5YuRDaznhcpeCZbh4JZuHA=;
        b=mFGG6FfEtNzi4XsPOd7RuDC2PwuQ6FMhqEe7M5stfulFllsGrQb9KuZZMK83DDG8st
         28u0fJuRHiK4GTHV00pObS+RsTkxB2vXChw+mUWWAdvri+NJzHHLObsWx4EP4h1fuDn+
         7W+uKHWgFFm7qIezDdMnOy5mFGFfKqsjllrHzFZhfpYEynB7QFoKredPeDWUAe4Ev6L6
         kJLbdqtxOpghUbE/bt5s7RzpjE4iAKf/xg2KuX/fJg/ldQXy+LNgLTexwqB1TyneUwIK
         IcG7mJqwevjzMp1wtnJp3WLI5b7W788/vpUk78h1G0MTvf5woQsWqAlPDAmevOJRbQQF
         PgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=m03pjouGBgwc5LnDysD4P5YuRDaznhcpeCZbh4JZuHA=;
        b=S2Qi4r2T9qkzgCeP13RJjLhTUqG9N/QLGG3FWwzusvy8GC0leQu4DPjqM0BKRRw9rq
         88H6BABiz7DlL5GTf9UqG8lN8FtJn5IbYT9xuly/zCXkwOaAb2k92JmPa9yRuOP/9Dm7
         QhHmU0tSo1p5H2aI9e35NqkAAquSgr4E6ITYmfqNyn/240b7n+ciwYysyefelbcf4asd
         bHtITfPuqGBJIQ8C9qtKvvVVIJ+5rXiBqV25jmU+TWpo0He9tSv+X+t6wvoPwSZltQEY
         lSEvY2hTJjDG0sG5Yargrd8P1QacpXU0L/Ry8qAq8O42gn/WrN5CSEnjCiKOSBrSenzK
         QchA==
X-Gm-Message-State: AOAM532fn+7d996ZWroE6zxjFkSzVOtPNSo7vcu2S98v7tAN9Yb/LP+P
        /H24f328DEeVANcBKVMfVwlAPn2LCX2XMw==
X-Google-Smtp-Source: ABdhPJxGLZ9jSlB7Bqs4hxgP6wn1uueKEkkMwS6Xfk1mMb9NVUowi4/6v6Bu7iIgweQ26VdRddKsSg==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr34674816ejb.48.1615970833353;
        Wed, 17 Mar 2021 01:47:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf4sm6232490edb.19.2021.03.17.01.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:47:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 03/20] t1092: clean up script quoting
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <d3cfd34b84184bef42fe0892790d80091c9ca01b.1615912983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d3cfd34b84184bef42fe0892790d80091c9ca01b.1615912983.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 09:47:12 +0100
Message-ID: <87r1kedv5b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> This test was introduced in 19a0acc83e4 (t1092: test interesting
> sparse-checkout scenarios, 2021-01-23), but these issues with quoting
> were not noticed until starting this follow-up series. The old mechanism
> would drop quoting such as in

the "but these issues" follows a partial sentence where we haven't
introduces "what issues?".

Perhaps leading with some summary about $@ v.s. $*:

    Fix a bug in the sparse checkout tests of "$@" being conflated with
    "$*". The bug was introduced in 19a0acc83e4 ([...]), but had no
    effect until now because XYZ ...


>    test_all_match git commit -m "touch README.md"
>
> The above happened to work because README.md is a file in the
> repository, so 'git commit -m touch REAMDE.md' would succeed by
> accident.
>
> Other cases included quoting for no good reason, so clean that up now.

Maybe just my taste, per your comment on another series of mine we might
not have the same sense of splitting up commits, but...

I think in this case it's clearer to have these be two commits. We have
3 hunks fixing the bug, and 6 on an unrelated cleanup. It's a lot easier
for eyeballing a fix to be able to glance just at the 3, especially with
something like $@ v.s. $*.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8cd3e5a8d227..3725d3997e70 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -96,20 +96,20 @@ init_repos () {
>  run_on_sparse () {
>  	(
>  		cd sparse-checkout &&
> -		$* >../sparse-checkout-out 2>../sparse-checkout-err
> +		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
>  	)
>  }
>  
>  run_on_all () {
>  	(
>  		cd full-checkout &&
> -		$* >../full-checkout-out 2>../full-checkout-err
> +		"$@" >../full-checkout-out 2>../full-checkout-err
>  	) &&
> -	run_on_sparse $*
> +	run_on_sparse "$@"
>  }
>  
>  test_all_match () {
> -	run_on_all $* &&
> +	run_on_all "$@" &&
>  	test_cmp full-checkout-out sparse-checkout-out &&
>  	test_cmp full-checkout-err sparse-checkout-err
>  }
> @@ -119,7 +119,7 @@ test_expect_success 'status with options' '
>  	test_all_match git status --porcelain=v2 &&
>  	test_all_match git status --porcelain=v2 -z -u &&
>  	test_all_match git status --porcelain=v2 -uno &&
> -	run_on_all "touch README.md" &&
> +	run_on_all touch README.md &&
>  	test_all_match git status --porcelain=v2 &&
>  	test_all_match git status --porcelain=v2 -z -u &&
>  	test_all_match git status --porcelain=v2 -uno &&
> @@ -135,7 +135,7 @@ test_expect_success 'add, commit, checkout' '
>  	write_script edit-contents <<-\EOF &&
>  	echo text >>$1
>  	EOF
> -	run_on_all "../edit-contents README.md" &&
> +	run_on_all ../edit-contents README.md &&
>  
>  	test_all_match git add README.md &&
>  	test_all_match git status --porcelain=v2 &&
> @@ -144,7 +144,7 @@ test_expect_success 'add, commit, checkout' '
>  	test_all_match git checkout HEAD~1 &&
>  	test_all_match git checkout - &&
>  
> -	run_on_all "../edit-contents README.md" &&
> +	run_on_all ../edit-contents README.md &&
>  
>  	test_all_match git add -A &&
>  	test_all_match git status --porcelain=v2 &&
> @@ -153,7 +153,7 @@ test_expect_success 'add, commit, checkout' '
>  	test_all_match git checkout HEAD~1 &&
>  	test_all_match git checkout - &&
>  
> -	run_on_all "../edit-contents deep/newfile" &&
> +	run_on_all ../edit-contents deep/newfile &&
>  
>  	test_all_match git status --porcelain=v2 -uno &&
>  	test_all_match git status --porcelain=v2 &&
> @@ -186,7 +186,7 @@ test_expect_success 'diff --staged' '
>  	write_script edit-contents <<-\EOF &&
>  	echo text >>README.md
>  	EOF
> -	run_on_all "../edit-contents" &&
> +	run_on_all ../edit-contents &&
>  
>  	test_all_match git diff &&
>  	test_all_match git diff --staged &&
> @@ -280,7 +280,7 @@ test_expect_success 'clean' '
>  	echo bogus >>.gitignore &&
>  	run_on_all cp ../.gitignore . &&
>  	test_all_match git add .gitignore &&
> -	test_all_match git commit -m ignore-bogus-files &&
> +	test_all_match git commit -m "ignore bogus files" &&
>  
>  	run_on_sparse mkdir folder1 &&
>  	run_on_all touch folder1/bogus &&

