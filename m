Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EDC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635FC64F07
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhCQRsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:48:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhCQRrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:47:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A08DA8455;
        Wed, 17 Mar 2021 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1fKbgrVhgO1FBo13UlLSsSQH9Mk=; b=XKDkxE
        qNOuCW88G6E0FRcYthPz15eNKs/SECKRDJ8ocVpJOA65tgPRht3Vi0X56Sw6eXfi
        VrGUf8B/olpLhX46crRPqLLDKDn/frFFwItFNW3Xroo80vupb04B+nyIZhrQIMwc
        n7lfa2b6coYpISXpz2n0DerlXL+O76J+1tdoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GB1NzRMJdSB7kfZ2xeVy7mxPogpJutkN
        e/6VmDeA9iYBNLy7jVk9e5IoJR1VZTQW5v11eupnbw1Gt0ZFEZgKnJkRdAmp1+VK
        jQguJ9rokme73BAnJvoChN1mR5DbwhD3fihgcKH4HuYpTb3oigt5Edvpt/FGiIJs
        7J8FY99kSgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32AA1A8454;
        Wed, 17 Mar 2021 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6553A8453;
        Wed, 17 Mar 2021 13:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Makefile: mark 'check-builtins' as a .PHONY target
References: <cover.1615856156.git.liu.denton@gmail.com>
        <c889973be754336005d0155ce670f16e322df9c3.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 10:47:42 -0700
In-Reply-To: <c889973be754336005d0155ce670f16e322df9c3.1615856156.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Mar 2021 17:56:20 -0700")
Message-ID: <xmqqlfaly8n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E06E09A4-8748-11EB-A53F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Then convention in Git's Makefile is to mark targets which do not
> actually generate any precious files (such as static checking targets).

s/Then/The/ has been pointed out, but I am not sure what "precious"
means here.  I do not think you are referring to the distinction
between ordinary targets and .PRECIOUS targets here, but the use of
the word makes readers wonder if some interaction with the .PRECIOUS
marking was taken into consideration.

> .PHONY enables the target to still run, even if a file is erroneously
> created with the same name as the target.

True.  Another convention is to "build" such a target with
double-colon rule.  The existing code already follows the
convention, so there is nothing the patch text needs to do, but if
we explain the change in the log message to make the code follow
conventions, we probably should mention it as well for completeness.


Thanks.

> Mark 'check-builtins' as a .PHONY target.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index dfb0f1000f..6dbecdb606 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3236,6 +3236,7 @@ check-docs::
>  
>  ### Make sure built-ins do not have dups and listed in git.c
>  #
> +.PHONY: check-builtins
>  check-builtins::
>  	./check-builtins.sh
