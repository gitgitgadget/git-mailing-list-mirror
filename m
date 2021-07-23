Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F11C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B660E8F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGWQf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:35:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhGWQf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:35:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF1F3155390;
        Fri, 23 Jul 2021 13:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iIFkRrM2xS7gm1m0Rneuhyp0q+Uhf63mcDqtPE
        FuQpU=; b=Z8GYlAfOIAZoETfGWKqNP1tJHWqFmPgK2VAEkCrJ2GbbKE5Tjgh4dn
        0giVSX8oje9LMAhEw02DILN+p5Q5GKCDGrc46iIqDQ8wePIux1k6akkmeB5EZmvk
        MzyIyKlLv7aO2uxtvz87plBb3wMd+yEaRQDN8AxQvE1LrSHxmqm0I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD12C15538F;
        Fri, 23 Jul 2021 13:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F92915538D;
        Fri, 23 Jul 2021 13:15:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 06/11] t1405: use 'git reflog exists' to check reflog
 existence
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <eb2c53d19cf90432ff4fd5af9ca6f4abc636cd7d.1626989327.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:15:57 -0700
In-Reply-To: <eb2c53d19cf90432ff4fd5af9ca6f4abc636cd7d.1626989327.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021
        21:28:42 +0000")
Message-ID: <xmqqy29xne7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6103FB6-EBD9-11EB-89C9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This fixes a test failure for reftable.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1405-main-ref-store.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index a237d9880ea..92b04873247 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -98,12 +98,12 @@ test_expect_success 'reflog_exists(HEAD)' '
>  
>  test_expect_success 'delete_reflog(HEAD)' '
>  	$RUN delete-reflog HEAD &&
> -	! test -f .git/logs/HEAD
> +	test_must_fail git reflog exists HEAD
>  '
>  
>  test_expect_success 'create-reflog(HEAD)' '
>  	$RUN create-reflog HEAD 1 &&
> -	test -f .git/logs/HEAD
> +	git reflog exists HEAD
>  '

Obviously more logical.  Thanks.
