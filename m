Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D861F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfKFJt4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:49:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53338 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKFJt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:49:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E4B8A3AC4;
        Wed,  6 Nov 2019 04:49:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q12LzioZrbdwJhFLaOInVEwbQOE=; b=dvXH1N
        g2Fntm/lfjuxk0ea9ykfnp11fACDzwL1MWPK5BnNgnngKbVINi6cwefNif++OA2n
        dS6lKMrQCQMHBDnmEh/yIAV3DnbtTx6WAfh//wzvWAp7DFFADtFArhQH4jgfMbk+
        LBDzY2CMacc8pnwq48cv1NBAc5Wr9Nvp9ffnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s57tMWSgNoQ3Oz+AXM7FnZ+cwH3xYtr8
        CW61+DsjWhZZwXMO8kWvWSuQ8d1ImP2wIMTC8jQLvQMNkgAhxJvyHY+4v4xaYmsM
        uuEcxA+RtXY/R7XC6kOft8f5YLGSpCq41nmLq+tXXb62bTYdq35aHMw71TTY0QIr
        toRkB1N+mIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65D7EA3AC3;
        Wed,  6 Nov 2019 04:49:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95D6CA3ABF;
        Wed,  6 Nov 2019 04:49:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com>
        <20191106041644.GE4307@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet>
Date:   Wed, 06 Nov 2019 18:49:50 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Nov 2019 10:14:37 +0100 (CET)")
Message-ID: <xmqqsgn1tjup.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7CC3228-007A-11EA-97C8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 5 Nov 2019, Jeff King wrote:
>
>> ... transforming it later into a curl_slist. I don't think that really buys
>> us much, though.
>
> Alas, it _does_ buy us a lot, as I *just* found out (can you imagine how
> glad I am not to have rushed out another Git for Windows release?).

Thanks both, and especially thanks Dscho for both for a fix and for
restraining yourself from the urge to pull trigger too soon ;-)

> I will change the patch to avoid using `slist` early and send another
> iteration.

Will look forward to seeing it.

Thanks.
