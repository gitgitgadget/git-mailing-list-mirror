Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6851F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbcJKQzs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:55:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50366 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752263AbcJKQzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:55:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99BA843260;
        Tue, 11 Oct 2016 12:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0mHBiZDdp73whLNhAqJBEyTy6nc=; b=YBRlCM
        g+mdxXvOxWyPQ4tQjn5cC4verOUPswOmep5pgQp3SLEhT+mglEOFgmbRsOaxp6RX
        T39Y6VcPcJS2NCCHWLZGtjcA3oznHKGsLBQKU/wgbM4ivr91xFVH0xjeObElRV0X
        WvA+OdK+uLQugr+M1ULArkzmGcVWbZdg3faSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HFmxnoFm+ptRx+iVmrjTNQLOcqEZ0Gyt
        1auuACH2PqSu+zZHsZBdRZgpDSqtFii0PrEIHUF1XEtqfcBjQT+d+Pince+HDogu
        4xWz5iWxEWEV56BbmsgcXVpkajG6Td7XfMs285kCI2KkB0RGeqSEiYLXLK3C8K7h
        HIQ8A87vtSg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 900F14325F;
        Tue, 11 Oct 2016 12:54:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5FD14325C;
        Tue, 11 Oct 2016 12:54:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script parsing
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610111212090.35196@virtualbox>
Date:   Tue, 11 Oct 2016 09:54:33 -0700
In-Reply-To: <alpine.DEB.2.20.1610111212090.35196@virtualbox> (Johannes
        Schindelin's message of "Tue, 11 Oct 2016 12:20:38 +0200 (CEST)")
Message-ID: <xmqqzimaaks6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63613D8A-8FD3-11E6-AA1B-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I am personally fine with this line; two things come to mind:
>> 
>>  - This would work just fine as-is with Linus's change to turn
>>    DEFAULT_ABBREV to -1.
>> 
>>  - It appears that it is more fashionable to use
>>    strbuf_add_unique_abbrev() these days.
>
> Right, I actually looked at this place when I tried to decide where I
> could use that function. Somehow I thought I'd not break up the flow here.
>
> But since you asked so nicely,...

When I say "I am fine", I am not asking you to change anything.

Some of the places that have been updated recently to use
strbuf_add_unique_abbrev() in other topics did improve the
readability of the code, but I do not think it would universally
be true.
