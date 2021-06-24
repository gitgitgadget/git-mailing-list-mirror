Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B08C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC2E613A9
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFXWCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhFXWC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 18:02:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64ADC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:00:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so8314834wrv.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+p30S1AQtNDulXB//gJECU7DAhi+X+nVsrBx4XxKurc=;
        b=D4h1EKSzTv81B4oIezwMXbd6zWIrfQx0kTlIJ3HX16BOzRL21Cond/1HvOQd4qxkWB
         nAxe6hmaP07Sd/8PEilrlii6v3Q/tSzcCUGP+SGuX0+Ewsh0vzA0DoIfIRo3kPHClckT
         XpGQL2CRvYgfEHu6FRLc6rZpFoNt/sULi53y6/MdigikamYtSF7UANB+uytjzg/tXVtI
         gAPMztsybEpeM1jSYYtKYLbOcMXY3yFdb/lPUtQy/6dGzH9jx6Lx8ydngrp2zLZ90RV6
         xgvfzo2hW3tB6zTVB6j5KMd/pp/e78xYeJHkUOFtzki7nTtxlbBYFuiPFdHUgCYTQNBL
         J7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+p30S1AQtNDulXB//gJECU7DAhi+X+nVsrBx4XxKurc=;
        b=P8OxkOT+krn8iy2mmcw7Kw0LMfKUk84fRcO0aZUrNE4FNo8BWGbhuwphARqORNHlp2
         qyAIrkc5/a+mJs8Tv+UmefSVIygudq30/nW1O4VT5akseqW4aCOxoXJQN5GWhHX2/Bmz
         WzMKEdbdV9mGVJE13ey+6S7zA4O3+Kg4L7aId7og2c7nzmsxAx7Cgbz5UL2eMZD3M2aS
         W2frgF/baVX4waAYdfJgOQoqvhJg1iZvdRl7PPGP/eRXjFZ2tPaWIuGn/4fKKDwYbjuY
         id7FUNNcvTtwpSZo6+v+mdVItxldODa/e6OlRmBl8gtoRE2aFTU4JuOsY4HCC57ed9zH
         nceA==
X-Gm-Message-State: AOAM5335QIn30jqn3Bpdnh3m2glZIfmiaa890znH4ZItrOzVjbFEB3XP
        PQ7NRNBUoozQuoX/faGt5YU=
X-Google-Smtp-Source: ABdhPJytevoT4o1h3fSMs3t10K8e9oiKM3aI/wdBoIK7DNddyjrN9mEoBF6ZRYt3BzR1jFHi+uhQag==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr7009482wre.17.1624572008323;
        Thu, 24 Jun 2021 15:00:08 -0700 (PDT)
Received: from [10.17.18.5] ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id s1sm10031056wmj.8.2021.06.24.15.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 15:00:07 -0700 (PDT)
Subject: Re: [PATCH v4 01/21] fsck tests: refactor one test to use a sub-repo
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
 <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
 <patch-01.21-2e37971c016-20210624T191755Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <d77583dc-5dd6-7992-bf48-456f14e36207@gmail.com>
Date:   Fri, 25 Jun 2021 00:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <patch-01.21-2e37971c016-20210624T191755Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/06/2021 21:23, Ævar Arnfjörð Bjarmason wrote:
> Refactor one of the fsck tests to use a throwaway repository. It's a
> pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
> teardown of a tests so we're not leaving corrupt content for the next
> test.
> 
> We should instead simply use something like this test_create_repo
> pattern. It's both less verbose, and makes things easier to debug as a
> failing test can have their state left behind under -d without
> damaging the state for other tests.
> 
> But let's punt on that general refactoring and just change this one
> test, I'm going to change it further in subsequent commits.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t1450-fsck.sh | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 5071ac63a5b..1563b35f88c 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -48,24 +48,22 @@ remove_object () {
>   	rm "$(sha1_file "$1")"
>   }
>   
> -test_expect_success 'object with bad sha1' '
> -	sha=$(echo blob | git hash-object -w --stdin) &&
> -	old=$(test_oid_to_path "$sha") &&
> -	new=$(dirname $old)/$(test_oid ff_2) &&
> -	sha="$(dirname $new)$(basename $new)" &&
> -	mv .git/objects/$old .git/objects/$new &&
> -	test_when_finished "remove_object $sha" &&
> -	git update-index --add --cacheinfo 100644 $sha foo &&
> -	test_when_finished "git read-tree -u --reset HEAD" &&
> -	tree=$(git write-tree) &&
> -	test_when_finished "remove_object $tree" &&
> -	cmt=$(echo bogus | git commit-tree $tree) &&
> -	test_when_finished "remove_object $cmt" &&
> -	git update-ref refs/heads/bogus $cmt &&
> -	test_when_finished "git update-ref -d refs/heads/bogus" &&
> -
> -	test_must_fail git fsck 2>out &&
> -	test_i18ngrep "$sha.*corrupt" out
> +test_expect_success 'object with hash mismatch' '
> +	test_create_repo hash-mismatch &&

This patch was originally sent to ML on 2021-03-28:
	https://lore.kernel.org/git/patch-2.6-3e547289408-20210328T025618Z-avarab@gmail.com/

since then, however, commit f0d4d398e2 (test-lib: split up and deprecate
test_create_repo(), 2021-05-10) has been merged ;-) so this line should
be:

	git init hash-mismatch &&


> +	(
> +		cd hash-mismatch &&
> +		oid=$(echo blob | git hash-object -w --stdin) &&
> +		old=$(test_oid_to_path "$oid") &&
> +		new=$(dirname $old)/$(test_oid ff_2) &&
> +		oid="$(dirname $new)$(basename $new)" &&
> +		mv .git/objects/$old .git/objects/$new &&
> +		git update-index --add --cacheinfo 100644 $oid foo &&
> +		tree=$(git write-tree) &&
> +		cmt=$(echo bogus | git commit-tree $tree) &&
> +		git update-ref refs/heads/bogus $cmt &&
> +		test_must_fail git fsck 2>out &&
> +		test_i18ngrep "$oid.*corrupt" out
> +	)
>   '
>   
>   test_expect_success 'branch pointing to non-commit' '
> 

