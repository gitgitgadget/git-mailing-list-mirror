Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E801F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936478AbcIHVgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:36:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935667AbcIHVgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:36:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5083E3BFFC;
        Thu,  8 Sep 2016 17:36:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2zlAOSeUJeb89/15M7Y8a6amVp0=; b=kA/ESz
        ChJKzG65pYTp9sTqO47HqrLE5J88u7k+ANgACZvUoWN8H6TWcpvONnrfBGEVWcIX
        A7+TpcZG5X8HKE3lHRVNyVJcfTyVa2Bl1mhWUf33HopA2D0SS1ytOoUcMTq7DnSO
        sIBOyu+zLtT0zrHToSVVxwIOuiT4APHr5YhWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pw9vr0YlcO1Gnws+Gr939Q0/x/gkdaXN
        IWYavSHIiWXjYDxSV13vLseHzCkWXQ+3gDzXEBvVipaSDh/S0PCX35+sS5U7c1lG
        jxH7TPuVHljbvW6Bp2YbyvFGgopdCf9+AbotXQJN+uTCyhIvapPe8K8/IAGWbw3j
        v3FVrLRIbjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4996D3BFFB;
        Thu,  8 Sep 2016 17:36:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C82A33BFFA;
        Thu,  8 Sep 2016 17:36:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
        <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
        <alpine.DEB.2.20.1609061827290.129229@virtualbox>
        <alpine.DEB.2.20.1609061839370.129229@virtualbox>
        <alpine.DEB.2.20.1609061843120.129229@virtualbox>
        <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
        <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
        <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
        <20160908200305.okeeh35xmrvcveyg@sigill.intra.peff.net>
Date:   Thu, 08 Sep 2016 14:36:49 -0700
In-Reply-To: <20160908200305.okeeh35xmrvcveyg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 8 Sep 2016 16:03:05 -0400")
Message-ID: <xmqqzinidqfi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AE9D6F2-760C-11E6-ADD2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Even though this patch is fixing only one of the two issues, I am
>> tempted to say that we should queue it for now, as it does so
>> without breaking a bigger gain made by the original, i.e. we learn
>> the status of verification in a way the authors of GPG wants us to,
>> while somebody figuires out what the best way is to show the prompt
>> to the console on Windows.
>
> That's OK by me, but I don't know if we can put off the "best way to
> show the prompt" fix. It seems like a pretty serious regression for
> people on Windows.

Yes, I am not saying that it is OK to keep Windows users broken.

As I understand what Dscho said correctly, his users are covered by
a reversion of the "read the GPG status correctly" patch, i.e. with
a different trade-off between the correctness of GPG status vs
usability of the prompt, he will ship with Git for Windows, and that
stop-gap measure will last only until developers who can do Windows
(which excludes you, me, and Michael it seems) comes up with a
solution that satisfies both.

I consider that an approach that is perfectly fine.


