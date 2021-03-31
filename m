Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94AFC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFDB61056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCaWhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:37:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56181 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCaWhU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:37:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4A0BA9457;
        Wed, 31 Mar 2021 18:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E0s0p6WxsuBszTntuKErVqg70CI=; b=l1nyzt
        NMM7iwr63iK/OD0w7OAfvouZBE0Eulv+CuEBgOGIhqrcnlMq4Js2dasJc0Ch4a3X
        rhH5bhp/uhDNs7WgDFVcaG3N/kKXJZ8CqCxBTTlxi4uGrrcoZt8JKuq8AJPO2Gm6
        KNtX5he4eAx88FuJA/EVxAYd6tCwvQfFX/PTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yw1OyiEVLo/VxRkK1M6+2JwNu4lvZiN0
        kNBWILayAG6nvTHQSm9/EYfDjMoYqKsPRBgDP0GBY5PuVGWbUSag5YOWYvrgKREw
        96bbZZGUtluQkZFDpzh9jjaZwW4gi7Ov6ghUEBLYz7kPQuUShHGxXGAoizYeCFs0
        syUATh08o5g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCE8FA9456;
        Wed, 31 Mar 2021 18:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AF40A9455;
        Wed, 31 Mar 2021 18:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     lilinchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        lilinchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v9] builtin/clone.c: add --reject-shallow option
References: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
        <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com>
        <xmqqim576spj.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2104010021510.54@tvgsbejvaqbjf.bet>
Date:   Wed, 31 Mar 2021 15:37:18 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104010021510.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 1 Apr 2021 00:24:32 +0200 (CEST)")
Message-ID: <xmqqim5754rl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6DA6258-9271-11EB-B942-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Does this "single variable is enough" really work?
>> ...
> That's my mistake, and you don't even need a second config to see the
> problem:
>
> 	[clone]
> 		rejectShallow = false
> 		rejectShallow = true

Yup, that is a much simpler example.

> Sorry for the trouble!

Don't feel bad---in an earlier round of review I made a similar
mistake to wonder if these two variables can be reduced into one
myself ;-).  As you said, this one is special in making two calls to
git_config() and need to be handled carefully.

Thanks.


