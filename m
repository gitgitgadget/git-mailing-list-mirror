Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632CE205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 20:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbdAKUz3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 15:55:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53206 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752294AbdAKUyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 15:54:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB0B35F709;
        Wed, 11 Jan 2017 15:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OvsbodRGrCW/WtKDWEBAcFebHiA=; b=Cd16Cr
        vun4VZ0hmSgY/PI7MnR8IeZVArxHGCZX9Ebwc1G0bJsQkTg1txpfJDHVlMHYyRXz
        dYWDHmoRj9QBdU7pM561MAMcgubRcN+OSFwyojLp9MwqwZODXhZifJsT3Cur2xlz
        2TrEnchaCBZDJl2ODKYuMRnPRaiaP81gXMYcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=omm8AL1eD5H4ZklsubLjJfXOXZTZbkk6
        M64eQr6K1ZMcsRIccUaxIGwg3FtfBNXwhfU3nhjQH1EKQI2/D+S0uIRKYmqpyGHr
        wtwBtaNQalqhY6A+b79XXoH54MoOm5QHgLyrlf2eACJyixvjahaTVNobUQRiTOdr
        LzTVY9Ntb6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80C4E5F707;
        Wed, 11 Jan 2017 15:54:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6846C5F706;
        Wed, 11 Jan 2017 15:54:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Richard Hansen <hansenr@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-2-hansenr@google.com>
        <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
        <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
        <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
        <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
        <9daa70e4-82b0-a82a-67b9-e893546638a7@google.com>
        <xmqqtw96pno0.fsf@gitster.mtv.corp.google.com>
        <20170111144158.ef6kle3vw3ejgmut@sigill.intra.peff.net>
Date:   Wed, 11 Jan 2017 12:53:59 -0800
In-Reply-To: <20170111144158.ef6kle3vw3ejgmut@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 11 Jan 2017 09:41:59 -0500")
Message-ID: <xmqqbmvdnwrc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E206DA-D840-11E6-98D3-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 10, 2017 at 02:15:11PM -0800, Junio C Hamano wrote:
>
>> Richard Hansen <hansenr@google.com> writes:
>> ...
>> > I think so.  (For bare repositories anyway; non-bare should be
>> > relative to GIT_WORK_TREE.)  Perhaps git_config_pathname() itself
>> > should convert relative paths to absolute so that every pathname
>> > setting automatically works without changing any calling code.
>> 
>> Yes, that was what I was alluding to.  We might have to wait until
>> major version boundary to do so, but I think that it is the sensible
>> way forward in the longer term to convert relative to absolute in
>> git_config_pathname().
>
> Yeah, I'd agree.
>
> I'm undecided on whether it would need to happen at a major version
> bump. ...
>
> So I dunno. I do hate to break even corner cases, but I'm having trouble
> imagining the scenario where somebody is actually using the current
> behavior in a useful way.

Thanks for a detailed analysis (I probably should have spelt them
out when I said "we might have to" to save you the trouble).

