Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FEA20756
	for <e@80x24.org>; Sat,  7 Jan 2017 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbdAGWFS (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 17:05:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58810 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932794AbdAGWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 17:05:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75AB95B323;
        Sat,  7 Jan 2017 17:05:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=voTxsh2ga9qYGW8vkPS4W26/M2Q=; b=SBzhBl
        5U5ZPnl7bNahBtiqIju6Te768RB58MaPW7x+YZlqEsOi7z5ZwyGCce0U0GOFjcZa
        JRDohmQ01McB/0wWc0/LDO5phHei5ZtqGRmSWvO4aNQ9a/IjRSf2r5WYkTohRlEF
        QfCW50n9CzMGYRmJorPflsDsND3EGgJilh678=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mO7k5JJY9IptxrNHatEH2hTO70jf46rv
        u0atDmg08DMIujxFCRhCCLLdHxMc5RTbymWRxIrHBf2fmPnsxDlpCkWPK0fHoL0G
        ApT+kmyIYeuaITul7B9HE2uIl0/YInbzQE1ZiL3dJy3kX/ORm2n5ZHw0jqjaqLBX
        V9KaCVPumh8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 666645B322;
        Sat,  7 Jan 2017 17:05:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9C175B321;
        Sat,  7 Jan 2017 17:05:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] giteveryday: unbreak rendering with AsciiDoctor
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <c3b21bbec96408c4d6698129fd336c24c9e2f0f0.1483373021.git.johannes.schindelin@gmx.de>
        <20170104081544.5htofa3zpgkvty7x@sigill.intra.peff.net>
Date:   Sat, 07 Jan 2017 14:05:14 -0800
In-Reply-To: <20170104081544.5htofa3zpgkvty7x@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Jan 2017 03:15:44 -0500")
Message-ID: <xmqq7f6634rp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E906DE8-D525-11E6-A288-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 02, 2017 at 05:04:05PM +0100, Johannes Schindelin wrote:
>
>> The "giteveryday" document has a callout list that contains a code
>> block. This is not a problem for AsciiDoc, but AsciiDoctor sadly was
>> explicitly designed *not* to render this correctly [*1*]. The symptom is
>> an unhelpful
>> 
>> 	line 322: callout list item index: expected 1 got 12
>> 	line 325: no callouts refer to list item 1
>> 	line 325: callout list item index: expected 2 got 13
>> 	line 327: no callouts refer to list item 2
>> 
>> In Git for Windows, we rely on the speed improvement of AsciiDoctor (on
>> this developer's machine, `make -j15 html` takes roughly 30 seconds with
>> AsciiDoctor, 70 seconds with AsciiDoc), therefore we need a way to
>> render this correctly.
>> 
>> The easiest way out is to simplify the callout list, as suggested by
>> AsciiDoctor's author, even while one may very well disagree with him
>> that a code block hath no place in a callout list.
>
> This looks like a good re-write to avoid the issue while maintaining the
> meaning and flow of the original.

OK.  Ack.

Thanks.
