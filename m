Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC35E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 16:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdHHQy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 12:54:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752092AbdHHQyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 12:54:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D999A686;
        Tue,  8 Aug 2017 12:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ObOgnhTdNWNmnRM2uK8ybeHKIzI=; b=NEI9+8
        bM7MP93mJi+D7UeGepL3cUhrVLcNaXymjKASG2r8MJpCYf8Xb0d22+77MXhgBBgd
        jGzOlleZkgJhvZ06KUiGW7/QhNneza/qKh4PVs7WJ4IIs6kYD06INQWeezdSSMoc
        StgTsafyqoskAOAyp/9bJeYw4khFufyaWwoIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sj/X4NvdKsQGkoz4Ew15Z19U1SLEhcH/
        t8j7tDr7RSXYczSPBOpTN0xVnOTqHyvtiQ+cw63n0wCKtzV7QRO/Mlu0p1FkzTOZ
        eN+WKED901i/CiEGyhdQ2HFbw5Lj5hUkh9ce8cYqKB974w/n44U0qUzQZH1W5/eQ
        wgaQ3y+gG+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CFE79A684;
        Tue,  8 Aug 2017 12:54:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 926DE9A683;
        Tue,  8 Aug 2017 12:54:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
        <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
        <87bmnvktee.fsf@linux-m68k.org>
        <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
        <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
        <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
        <xmqqzibcqhy9.fsf@gitster.mtv.corp.google.com>
        <20170808072510.leb525df4hmbwcvo@sigill.intra.peff.net>
Date:   Tue, 08 Aug 2017 09:54:53 -0700
In-Reply-To: <20170808072510.leb525df4hmbwcvo@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 8 Aug 2017 03:25:10 -0400")
Message-ID: <xmqqk22ec84i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D6F83D2-7C5A-11E7-AB08-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we're not quite ready to switch to curl based on comments in the
> nearby thread. But just for reference, since I started looking into
> this...
>
> The defines in the Makefile turn on USE_CURL_FOR_IMAP_SEND want curl
> 7.34.0. That's only from 2013, which is probably recent enough that it
> may cause a problem (I had originally thought it was a few years older,
> but I forgot the curl version hex encoding; 072200 is 7.34.0).
>
> For comparison, nothing older than curl 7.19.4 will work for building
> Git since v2.12.0, as we added some unconditional uses of CURLPROTO_*
> there. Nobody seems to have noticed or complained. I pointed this out a
> few months ago[1] and suggested we clean up some of the more antiquated
> #if blocks in http.c that don't even build. There was some complaint
> that we should keep even these ancient versions working, but the
> compile error is still in "master".
>
> So it's not clear to me that anybody cares about going that far back
> (which is mid-2009), but I'd guess that 2013 might cause some problems.
>
> [1] https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
>     if you're curious (you were offline for a while at that time, I
>     think).

Thanks for digging.  It would not help the issue on this thread at
all.  While I agree with your conclusion in the quoted thread:

    I think it might be nice to declare a "too old" version, though,
    just so we can stop adding _new_ ifdefs. Maybe 7.11.1 is that
    version now, and in another few years we can bump to 7.16.0. :)

it appears that we silently declared it to 7.19.4 and found out that
nobody complained, without us having to wait for a few years?

