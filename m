Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606331FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbcHZRKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:10:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57305 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751139AbcHZRKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:10:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4727372A5;
        Fri, 26 Aug 2016 13:10:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4oxv1hEJ1ak/CG6iJRFFYgpPOo=; b=qTw3Yc
        e6b1fDF6D7DxPHczK/5FyM9+wTGBxXVZLX+v7oMDyeptMkmYeqSDnd6et31IraJ4
        RezHqyEKrRhaP2G+smoS5Oy887EINwtRF1RAGkQuT2P5Rt/ooo8G6uo53uZEbSK6
        Sstn+cnt9lGRs3sCj+wJ4fAn9Fa56qzPIGt1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g73kj1VnAyD0bnvK+pKKrcWGcLa1pe2n
        ZHBlAUdT4CWcpIxhW7/aMMD1D9kFykgWRkgD91Kgil4aMICVRQZdOyBnFldFp8jt
        bWjOQRGCW5/VDwSETrMtuYHUFQ55YTfxkfCq/j9iiSmzarVUykur62PZylyJpldW
        vj2IOUfJbCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB865372A4;
        Fri, 26 Aug 2016 13:10:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CC703729F;
        Fri, 26 Aug 2016 13:10:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 03/13] pkt-line: add packet_write_fmt_gently()
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-4-larsxschneider@gmail.com>
        <xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com>
        <6A26AA14-E393-492C-ADE0-3206DF78AFF6@gmail.com>
Date:   Fri, 26 Aug 2016 10:10:50 -0700
In-Reply-To: <6A26AA14-E393-492C-ADE0-3206DF78AFF6@gmail.com> (Lars
        Schneider's message of "Fri, 26 Aug 2016 11:17:34 +0200")
Message-ID: <xmqqinunihgl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AEF985A-6BB0-11E6-BC56-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I agree with your criticism of the code duplication. 
>
> However, I thought it would be OK, as Peff already 
> tried to refactor it...
> http://public-inbox.org/git/20160810150139.lpxyrqkr53s5f4sx@sigill.intra.peff.net/
>
> ... and I got the impression you agreed with Peff:
> http://public-inbox.org/git/xmqqvaz84g9y.fsf@gitster.mtv.corp.google.com/

The former does not exactly show how ugly it was, but I do not have
to see it.  It is talking about eliminating the need for memcpy()
and duplicated header generation code, which the suggestion you are
responding to didn't even attempt.  If Peff said he tried an even
more aggressive refactoring and it ended up too ugly to live, I
believe him and agree with his assessment.

> I will try to refactor it according to your suggestion above. 
> Would "packet_write_fmt_1()" be an acceptable name or should 
> I come up with something more expressive?

The latter is preferrable, but we do not mind too strongly about
the name of file-scope static helper that will never be called
directly by anybody other than the two more public entry points the
helper was designed to serve.
