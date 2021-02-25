Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5CC433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CB164F1A
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhBYTmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:42:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58613 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhBYTk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:40:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C46AD11BC76;
        Thu, 25 Feb 2021 14:39:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f7Rpwm5t3AsT
        yz5Cd5VrKnzFEiA=; b=pSCZj5EmIUSoeL1luRrfoAxSFJ+r/FfLCX5AZhOOYsnF
        mPcRq3eFEgCf0TXGUlMhGi9JW0a1s2I7NGpG1W1v8EnKUuXeLXAqnorYHcaSnpOI
        QvisiSd7yG3D7KQmamSL7pp7rg5jtBeueEhO10S+rzEE5kNFCLexI1S1pbt7t4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AxZ4TW
        vmleFSQrDBFyMHth8YfixTCxbx7SXf7DljN2cwhwsQPUJBtJZQiRUBs+NOEIYETD
        Iss18D1RQgbGq+e8W431fWQM/DRNlMlLpNsWAVAPqN6M2PxkNB3bXISWqu3oqKFA
        7rYgtawNKl8yG/dpVgarn89fTykaQFtEpDEys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB85F11BC75;
        Thu, 25 Feb 2021 14:39:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AA7A11BC74;
        Thu, 25 Feb 2021 14:39:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/12] Simple IPC Mechanism
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 11:39:39 -0800
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com> (Jeff
        Hostetler via GitGitGadget's message of "Wed, 17 Feb 2021 21:48:36
        +0000")
Message-ID: <xmqq8s7cuebo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33FD320A-77A1-11EB-986D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is V4 of my "Simple IPC" series. It addresses G=C3=A1bor's comment=
 WRT
> shutting down the server to make unit tests more predictable on CI serv=
ers.
> (https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)
>
> Jeff
>
> cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason avarab@gmail.com cc: Jeff Ho=
stetler
> git@jeffhostetler.com cc: Jeff King peff@peff.net cc: Chris Torek
> chris.torek@gmail.com

It seems that the discussions around the topic has mostly done
during the v2 review, and has quieted down since then.

Let's merge it down to 'next'?

