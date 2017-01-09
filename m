Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FE91FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754768AbdAIT0b (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:26:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51351 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750980AbdAIT0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:26:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C375E3AB;
        Mon,  9 Jan 2017 14:26:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VWumWg8knXjLB5EDkRx1iuAqnY0=; b=dgIMln
        ip5H43AsHjz88BEMhw7FyKFi96DU9vGLB6v8RB1FU4WI4STP3oEv1T8vkZFty5BK
        H1sjHW/XBJS1q1Mr2Vb1nYNGXLbsqdG7nUp3stNp1/vd7DxhgUBgPuLaJqdyO4V4
        Du3J9+8Cqz6MnXiptiby9T/hyYX9Oca3IndjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UsPBIEffy0syL2AVXan1O7yEH8d1wVrx
        4gpTMxoBRRKRSKtSIGWwilj0VpBVeIRhcSci1bbOPBNWKg1xS3AAC/M/Ehu6exT4
        rjsCxMkl182+WZ6odMAcRzAeE2786sraDZFO4gGmHizXKiofhWnefccD2Pxokof2
        GedfOxIG3c4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EE515E3A9;
        Mon,  9 Jan 2017 14:26:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE86D5E3A8;
        Mon,  9 Jan 2017 14:26:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v5 0/5] road to reentrant real_path
References: <20170103190923.11882-1-bmwill@google.com>
        <20170104220124.145808-1-bmwill@google.com>
        <xmqqpojy1c49.fsf@gitster.mtv.corp.google.com>
        <20170109180418.GB62878@google.com>
        <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
        <20170109182433.GC62878@google.com>
Date:   Mon, 09 Jan 2017 11:26:27 -0800
In-Reply-To: <20170109182433.GC62878@google.com> (Brandon Williams's message
        of "Mon, 9 Jan 2017 10:24:33 -0800")
Message-ID: <xmqqr34ct4po.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84E83FFC-D6A1-11E6-8AA4-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 01/09, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> >> How does this relate to the 5-patch real_path: series that has been
>> >> on 'next' since last year?
>> >
>> > The only difference should be in the first patch of the series which
>> > handles the #define a bit differently due to the discussion that
>> > happened last week.
>> >
>> > Here is the interdiff between v5 and 'origin/bw/realpath-wo-chdir':
>> 
>> Then can you make that an incremental patch (or two) with its own
>> log message instead?  It (or they) would look and smell like a
>> bugfix patch that follows up a change that has already landed.  As
>> you know, we won't eject and replace patches that are already in
>> 'next' during a development cycle.
>> 
>> Thanks.
>
> Yes I'll get right on that.

Thanks.  Will queue.
