Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330841F461
	for <e@80x24.org>; Thu, 16 May 2019 02:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEPCYc (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 22:24:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50442 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEPCYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 22:24:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B89571B64;
        Wed, 15 May 2019 22:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ATye6zn3X+db63hN9f2OoVw73V0=; b=GUa+0p
        lIGii+V6CgPLumRHh5mRHV2dwk+X5LhiQ4450vdBypyzU+c3jcFh/OWwPP05zXYC
        ywhOyGifFlqf1PxrFvKDj6F2zd2oXdsb2VSxewYAfXSCbXhZuMUXwPTkt+jn/9z/
        Rm+SBKpfuvhuTkHcBq4M/1OZFiPPaT6gC7Hbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xUB1BRHZEdlVfMztImFph76EQb9pE1CZ
        hQP3kZHXsyHqZKfdCtm8PZ4p6TRVQWngWaebya9GGphQ1v+7ih9zU8N3Dxj01gSU
        TWS18fiERWky9esHkbCh4uVEL9yHoqRl/iuplKKE2XfYcpzjktXYFLwYTpp4YBJT
        tQ/Og0Zmud0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63E4871B63;
        Wed, 15 May 2019 22:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9526471B5E;
        Wed, 15 May 2019 22:24:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
References: <pull.192.git.gitgitgadget@gmail.com>
        <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
        <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
        <20190514144305.GA28530@sigill.intra.peff.net>
        <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905151234370.44@tvgsbejvaqbjf.bet>
Date:   Thu, 16 May 2019 11:24:25 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905151234370.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 15 May 2019 12:39:04 +0200 (DST)")
Message-ID: <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA93D2D2-7781-11E9-B6C2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> lacked the "const" for that reason, but apparently some compilers
>> complain about the parameter type mismatch.
>
> We could be more explicit, as we know exactly that it is MS Visual C 2017
> that is complaining.

We could be, but I do not see a point of shaming one particular
compiler vendor.

>> Let's squelch it by removing the "const" that is pointless for a
>> small function like this, which would not help optimizing compilers
>
> It is not pointless because of the size of the function, but because `int`
> is already a type that is always passed by value, never by reference.

You are looking only at the prototype side (i.e. declaration in
*.h).  Yes it is pointless for the callers.  For the callee, the
story is different and pass-by-value does not even get in the
picture.

The mention of pointless-ness I made was about the implementation
side (i.e. definition in *.c).  For a sufficiently large and complex
function implementation, being able to say upfront that this
incoming parameter is never modified would help following the logic
in the implementation, so "const int param" in the parameter list of
a definition is *not* pointless in general.  But apparently some
compilers are not happy abot "const int param" in implementation
that is paired with "int param" in prototype, we are dropping a
const that could be useful, with an excuse that for this particular
function that is small and trivial, we can live without.

