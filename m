Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA57C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9881164F1B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 00:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCSAOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 20:14:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58053 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhCSAOD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 20:14:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE53511023C;
        Thu, 18 Mar 2021 20:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zkf5+Kvk5q+FUJySDGKSAP5JDoE=; b=HlP7d7
        qzfEifr34eXaWtgvDpLSI5obF2YalWD4CbMAbY3z7ajOkMpqzPIsAxPWUjqag9yi
        5v8fhsT4RDEAIHh6hX0BWAwRZMf9k4Z7i5WcHSRMNfyeTT4wNehk7LwlOoc4M+KE
        Gp7mDYL4xLDshydPclnXYu32Xc4QFQP7kjVJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=teCXY4nOoa9MqYYF6GjBO+/2h0azdWyt
        jnV3RDKEAq1XR7tWxSVwgCm2x/Vjw0Z5FEYPD0a7JA0bFjgpKyqB+jRqv8We1zau
        RkBc6Hbaicwittq/9FqYi4tTlDDU8gtThQC0OmAZdFq88Q7obXaBqRbIrYn39P73
        nezHpd28ucs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E817D11023B;
        Thu, 18 Mar 2021 20:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4115D110235;
        Thu, 18 Mar 2021 20:14:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: avoid traversal of objects referenced by
 uninteresting tag
References: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
Date:   Thu, 18 Mar 2021 17:13:58 -0700
In-Reply-To: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 17 Mar 2021 16:11:14 +0100")
Message-ID: <xmqqk0q4ov95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 011FA39C-8848-11EB-BC6F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While most benchmarks are probably in the range of noise, the newly
> added 5310.8 benchmark shows a performance improvement of 25600%.

which sounds impressive, but ...

> +test_perf 'rev-list with negation (objects)' '
> +	git rev-list --not --all --use-bitmap-index --objects >/dev/null
> +'

... is this an interesting use case to begin with, without any
positive end?

> +
>  test_perf 'rev-list count with blob:none' '
>  	git rev-list --use-bitmap-index --count --objects --all \
>  		--filter=blob:none >/dev/null
