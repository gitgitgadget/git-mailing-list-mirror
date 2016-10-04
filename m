Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2215C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbcJDT6R (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:58:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752109AbcJDT6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:58:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14EDD424DB;
        Tue,  4 Oct 2016 15:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=36JY40Z6EyhkYqG9L7+YR3b0GsM=; b=osWwzy
        GjWdwRocxmicOsNeDLc74nyguA+/xXuhpwVColZO3Rs1hD9YhJ4Tm7C1XPb3Ssc2
        TG7jnywVCI93NTDXX9vLloZAhBDMR7SNtu8vEGenJZfuGZXyg0+D0WQRZeP3vLhe
        OjZHvKJNbe40dTGXB7b/sT9UkDvpUtCdDpEwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mC3+gYFZ83yP5uM9VtS2uLZyuVX6HCOO
        kz/BSJ7V7VBtw5fFW98U7/i2d4FO2+ggoZdFG9FlmqpWW1XxffoM7Xzif6+yrXpQ
        QnUlFRwRJ/KmU9MljnWsb5BXB2BLT61HoNttZ8iKKxO2f7GJ96Ft7qUaTaiElL63
        zsv7cSZGRjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 039C2424DA;
        Tue,  4 Oct 2016 15:58:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72F7F424D9;
        Tue,  4 Oct 2016 15:58:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 10/14] pkt-line: add functions to read/write flush terminated packet streams
References: <20161004125947.67104-1-larsxschneider@gmail.com>
        <20161004125947.67104-11-larsxschneider@gmail.com>
        <xmqq8tu3ubzl.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 04 Oct 2016 12:58:12 -0700
In-Reply-To: <xmqq8tu3ubzl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 04 Oct 2016 12:53:50 -0700")
Message-ID: <xmqq1szvubsb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2AD9D3E-8A6C-11E6-B0C7-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I must be missing something.  Is the other side always supposed to
> give a flush packet or something?  Perhaps that is what is happening
> here.  If so, I am OK with that, even though it somehow sounds a bit
> wasteful.

Ah, scratch that.  What I was missing was that this channel is
designed to carry multiple interactions and delimiting with EOF
which by definition can happen only once cannot be a norm.
Expecting a flush to declare the current stream terminated is
perfectly fine.
