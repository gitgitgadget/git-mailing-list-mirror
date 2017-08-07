Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3083B2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdHGTs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:48:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50559 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751662AbdHGTs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:48:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DED519E841;
        Mon,  7 Aug 2017 15:48:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hyjphz9EgJd7iJDUYbxzjLUFrMc=; b=TX/1Fy
        loGKvViTSJBZD/PRlG6MBI5QeaN6YzzxzlfUtsvh0PKoMSXRSvUbU45lfmnmruWT
        f83cNhJIUfzppwlkTPCLfHGY2JsjpcDbn9KNvsTVEl0XWwGPdHoe0LGZOnznM9Xf
        cFWJkrg8vdCwuBkfTqDSNCFa4PfeHpof8bSH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nNrGQdAvSskALm8N0C3bAr2W7sdsUOAs
        pCm8/gF2Q/JKIAKo0yRRpr0FIe36IQFZyiVfdHnzAqVE4VxHanJ3j4X5kaqqyB08
        ERfRF0Tkf6vQ3FBTHjl+7KiVQPjJgS1f2KDHP9pEA9hPOn4RMTLRNlxGQ5IybpnN
        Cg3oZGYczeI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D62729E840;
        Mon,  7 Aug 2017 15:48:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 450529E83E;
        Mon,  7 Aug 2017 15:48:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
        <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
Date:   Mon, 07 Aug 2017 12:48:19 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708072136290.4271@virtualbox> (Johannes
        Schindelin's message of "Mon, 7 Aug 2017 21:39:12 +0200 (CEST)")
Message-ID: <xmqqshh3p3b0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D4AA3C4-7BA9-11E7-AB65-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The patch obviously makes the code better and self consistent in
>> that "struct delta_index" has src_size as ulong, and this function
>> takes trg_size as ulong, and it was plain wrong for the code to
>> assume that "i", which is uint, can receive it safely.
>> 
>> In the longer term we might want to move to size_t or even
>> uintmax_t, as the ulong on a platform may not be long enough in
>> order to express the largest file size the platform can have, but
>> this patch (1) is good even without such a change, and (2) gives a
>> good foundation to build on if we want such a change on top.
>> 
>> Thanks.  Will queue.
>
> This is sad. There is no "may not be long enough". We already know a
> platform where unsigned long is not long enough, don't we? Why leave this
> patch in this intermediate state?

This is a good foundation to build on, and I never said no further
update on top of this patch is desired.  Look for "(2)" in what you
quoted.
