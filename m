Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CD5207E8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIE9Xb2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgERQep (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:34:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52595 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERQep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:34:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3030A620E0;
        Mon, 18 May 2020 12:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sAL8/eL5Iidqu5qMlsX5ncxt0oQ=; b=iIE9Xb
        2SpBvq1aJ7favCXISoyK+JWGayw3wct8RQ7ZhgkkaVZZeffxn0JgFNaz3twzjt6F
        ISWXd259Sh9qg7JefaYbjDo8rWPWgTzWGn6OgSSIbXw6M9qB+BtSoVsya6Q3uoeh
        IwiQtsQ+Cehld+icyyOjumf5lgRQ2gfpKDtnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYVXZB0Azpw4UNNggt+oSIhZkaY7ibPf
        pxfZhoRBs0abvBfETC8N6wZtPmsoGdBbg6anZ+Q7EqqUcQO6yP927SsrNaA5gnjC
        nXqyESMocfHaUaHUsulKyGHQrubDZ/HvISnObpxU3SLNXVhkBZmJjbg+5DUbJrPS
        DJI1ibD8xh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A15620DF;
        Mon, 18 May 2020 12:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3DA4620DC;
        Mon, 18 May 2020 12:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Force Charlie <charlieio@outlook.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] remote-curl: ensure last packet is a flush
References: <cover.1589393036.git.liu.denton@gmail.com>
        <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
        <20200515210245.GA3278654@generichostname>
        <20200515214102.GE115445@coredump.intra.peff.net>
Date:   Mon, 18 May 2020 09:34:42 -0700
In-Reply-To: <20200515214102.GE115445@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 15 May 2020 17:41:02 -0400")
Message-ID: <xmqqeerh5hi5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79F11A02-9925-11EA-9461-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 15, 2020 at 05:02:45PM -0400, Denton Liu wrote:
>
>> On Wed, May 13, 2020 at 02:04:58PM -0400, Denton Liu wrote:
>> > This is not a complete solution to the problem, however. It is possible
>> > that a flush packet could be sent in the middle of a message and the
>> > connection could die immediately after. Then, remote-curl would not
>> > error out and fetch-pack would still be in the middle of a transaction
>> > and they would enter deadlock. A complete solution would involve
>> > reframing the stateless-connect protocol, possibly by introducing
>> > another control packet ("0002"?) as a stateless request separator
>> > packet which is always sent at the end of post_rpc().
>> > ...
> I do kind of like the idea of a stateless separator packet, if I
> understand your meaning correctly. I'll wait to see what the patches
> look like. :)

I vaguely recall talking with somebody (perhaps it was Shawn Pearce)
about my long-time complaint on the on-the-wire protocol, in that
the protocol sometimes uses flush to merely mean "I've finished
speaking one section of my speech" and sometimes "I've done talking
for now and it's your turn to speak to me" (the receiving end needs
to know which one a particular flush means without knowing the
context in which it is issued---which makes it impossible to write a
protocol agnostic proxy.  

If the above proposal means that we'll have an explicit way to say
"Not just I am done with one section of my speech, but it is your
turn to speak and I am going to listen", that would be wonderful.

