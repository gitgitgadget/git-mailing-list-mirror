Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A5C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53164613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhGNWa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:30:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhGNWa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:30:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D16D268A;
        Wed, 14 Jul 2021 18:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FIdI9RaSlTLJU1gWH4TWGxRQaJmGTeHryXSCuK
        K1QEI=; b=HWSCWWEc9dClS7x/AxktPEAbWcV6Xl3O3+2YJER4ospTTkFvKkgyfe
        8DOw9JDuMSRzpnOBU7Dih5q09lxYIuFB1ada1TmtF2iuYYM9OmmSmdCe1IQbiodv
        Hh9YcV3MpMFGxECvcJkTTq1yiA9f5ZveBd1frMWBtSm9LIDs7FKhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AA2FD2689;
        Wed, 14 Jul 2021 18:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEC07D2688;
        Wed, 14 Jul 2021 18:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
        <xmqqbl7525w7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>
        <xmqq35sgzy0d.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet>
        <xmqqa6movcly.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2107142350570.59@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Jul 2021 15:27:34 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2107142350570.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 15 Jul 2021 00:03:52 +0200 (CEST)")
Message-ID: <xmqqsg0gttt5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFD317A0-E4F2-11EB-9E1C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It wasn't quite obvious why we justify spending 370 minutes one more
>> time only to rerun 30-second job, though.
>
> True.
>
> And this is not a new problem. Every time anything happens in those
> `osx-gcc` or `osx-clang` jobs (e.g. that transient problem with the broken
> pipes in t5516 [*1*], that's a fun one), a full re-run is necessary, or
> else the commit and/or PR will remain marked as broken.
>
> In other words, while it is totally appropriate for me to explain this to
> you in this here thread because it came up as a tangent, it would be
> inappropriate to stick that explanation into this patch's commit message.
> We do not make a habit of adding tangents that came up during patch
> reviews into commit messages, and I do not intend to start such a habit
> here, either.

I do not agree; a brief mention "even though piling more and more on
the primary workflow would make it even less convenient to re-run,
it is already so bad that another one would not hurt too much more"
would be a clue good enough to motivate others to do something about
it if they feel like it.

