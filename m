Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C051F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 06:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLG5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 01:57:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56416 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLG5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 01:57:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 684F590396;
        Tue, 12 Nov 2019 01:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A8NCrCyvkd6IOaqo8fIhz8cXU38=; b=f3KPoY
        QczZB2RjiL2fliz23jj5gmW8Wer874rLdpzUxoynaLuJ7T3RRem7ThFFYV0qjpsk
        e8K2M7pDWqSLR6kmGeNJZfUeIG2ywNtjfGMZRKFzxqY5wMNJOG4EXSjwHgR1nTVg
        JHPuYifGFI4jhrQB1pDW30nZYM56/Knr2WfxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KTH2WN7RK9wDJUCffEPr0bGgWr1PA4TS
        Rs/dTX8MYlNZD8OvvcnkrDRKYV60hT/tObnEMY/7Q2cUEb+NfjF9LKPUAqSx8xqA
        OistpNT9d7+zJrylQX+P81uHIsWusca4GhxCNOTD60JzJq4ZwXYJQfqbvt2eqMc/
        IpYA2EWDVXc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51BC890395;
        Tue, 12 Nov 2019 01:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FC1590393;
        Tue, 12 Nov 2019 01:57:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        James Coglan <jcoglan@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4215: don't put git commands upstream of pipe
References: <20191018152121.GE29845@szeder.dev>
        <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
Date:   Tue, 12 Nov 2019 15:57:08 +0900
In-Reply-To: <8e950ddfba3fa0f6d0551a153228548da6af6117.1573520653.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 11 Nov 2019 17:08:29 -0800")
Message-ID: <xmqqzhh1eg57.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5F32582-0519-11EA-9E51-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> A little late to the party but since this cleanup hasn't been done yet,
> let's do it now. We can apply this patch to the tip of
> 'jc/log-graph-simplify'.
> ...
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&

Obviously good but I wonder if

	show_graph () {
		git log --graph --pretty=tformat:%s >actual.raw &&
		sed "s/ *$//" actual.raw &&
		rm actual.raw
	}

would help to make it even more readable without too much repetition.

Will queue; thanks.

>  	test_cmp expect actual
>  '
>  
> @@ -68,7 +69,8 @@ test_expect_success 'log --graph with left-skewed merge' '
>  	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
>  	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
>  
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -99,7 +101,8 @@ test_expect_success 'log --graph with nested left-skewed merge' '
>  	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
>  	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
>  
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -139,7 +142,8 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
>  	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
>  	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
>  
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -175,7 +179,8 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
>  	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
>  	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
>  
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -210,7 +215,8 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
>  	git merge --no-ff 4_p -m 4_G &&
>  	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
>  
> -	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --date-order --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -250,7 +256,8 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
>  	git checkout 5_r &&
>  	git merge --no-ff 5_s -m 5_H &&
>  
> -	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
> +	git log --graph --pretty=tformat:%s >actual.raw &&
> +	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
>  '
