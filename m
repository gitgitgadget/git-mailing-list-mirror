Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DDA1F461
	for <e@80x24.org>; Thu, 16 May 2019 04:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfEPE2U (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 00:28:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59283 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPE2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 00:28:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70CBA147164;
        Thu, 16 May 2019 00:28:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bDpKe5xXyB0MrSROQcKOQmL8zEk=; b=BfFev5
        Wn5ZtbHdT32FXW5E2Gm53iwBpCH63CV4IyS85/TvXJXoSNAQdZ/NrUpfWE8xzvpE
        dR0FCINbOCdDe0NWM131w9R4rOHSWjvP/hI7bQY8aTuOgMKDAW77w13iZDVakEDu
        Z/S60RVSm2XyDCMQDJeyi2nw8MbJnT1cUvycg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ms1UgZQ6W8/LSD6zG0qjZOoiyXSUHCTn
        I7PDfQrOCPHo6QPS0VxnbiyC7jxQyW7DalqHTtPriYeSFvBMgSn1pgiCfmGBuNef
        7QCA6w6SzssCao9JE17HB2qfY3eG2DI/zkR3khUfl3NwL+Hllb9SurYhnNXvjP9x
        3JN+8+04xQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69841147163;
        Thu, 16 May 2019 00:28:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAD27147162;
        Thu, 16 May 2019 00:28:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
        <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
        <20190516034220.GE4596@sigill.intra.peff.net>
Date:   Thu, 16 May 2019 13:28:16 +0900
In-Reply-To: <20190516034220.GE4596@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 15 May 2019 23:42:20 -0400")
Message-ID: <xmqqtvdv3twf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 074BFDD2-7793-11E9-B722-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 16, 2019 at 11:24:25AM +0900, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> lacked the "const" for that reason, but apparently some compilers
>> >> complain about the parameter type mismatch.
>> >
>> > We could be more explicit, as we know exactly that it is MS Visual C 2017
>> > that is complaining.
>> 
>> We could be, but I do not see a point of shaming one particular
>> compiler vendor.
>
> I'd slightly disagree. If 10 years from now we decide that MSVC is not a
> supported compiler anymore, that information would be useful for
> somebody digging into the history to say "ah, we can probably use this
> pattern once more". I say probably because while it was the only
> complainer, once the pattern is removed we wouldn't know if anybody in
> the interim _would_ have complained. But it still seems like something
> that _could_ be useful to an archaeologist in the future.

OK.  I do not have problem with "... apparently some compilers
(e.g. MS Visual C 2017) complain about ...".

I just thought MS folks would mind that; if they do want to see the
name of their compiler in the description, I am fine, too.

Thanks.
