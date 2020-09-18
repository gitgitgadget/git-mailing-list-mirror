Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D4DC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2CC2074B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bVodHiF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIRQhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:37:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60605 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQhg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:37:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76087F7328;
        Fri, 18 Sep 2020 12:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n2EKz/FL/8Hyp/h97yMm290sDko=; b=bVodHi
        F+hKSHh6Sw+xMdsH2nmqq7kglFWTRYTP3zGN3ZS/E2BtYdq50wuKPtgd4aqtBnD1
        szt+DVGVToDR3TEe16TJe5UJ4KvK1fhbFr76+NvL1rxR/AO5vXY/cklydGKUx2mB
        F8qsGTXniNMlWv56VSn2q1Emo/ARDtj448Szc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n+genorpifHF5ekRUYQkvoHt/l49Z2nP
        rKSyybsAvGoBCpo4uD2sBjiwvoPvGLWDimjq0r+EX/rx6xYQoO7oExcPoy3A0l1D
        j9C0FivLih+Xd7jm6/Ea9THUHduG7XTrvE3twBz/3kuR65RpT2hp39glZvwau/cf
        Ecg4eEPyB94=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D8D3F7326;
        Fri, 18 Sep 2020 12:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B67D4F7325;
        Fri, 18 Sep 2020 12:37:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
        <xmqqk0wtv204.fsf@gitster.c.googlers.com>
        <20200917140254.GA28281@pflmari>
        <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
        <20200918071647.GA17896@pflmari>
Date:   Fri, 18 Sep 2020 09:37:30 -0700
In-Reply-To: <20200918071647.GA17896@pflmari> (Alex Riesen's message of "Fri,
        18 Sep 2020 09:16:47 +0200")
Message-ID: <xmqq363fnir9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F865C8E-F9CD-11EA-84E1-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

>     git fetch --ipversions=ipv6,ipv8
>
> Given multiple times, the last option wins, as usual:

Just a clarification on "the last option wins".

You do not mean "I said v6 earlier but no, I want v8", with the
above.  What you mean is that

>
>     $ cat my-fetch
>     #!/bin/sh
>     git fetch --ipversions=ipv4 "$@"
>
>     $ ./my-fetch --ipversions=all

the argument given to 'my-fetch' overrides what is hardcoded in
'my-fetch', i.e. "I said v4, but I take it back; I want to accept
any".

I find the above sensible.

> BTW, transport.c already converts transport->family to bit-flags in
> connect_setup.

Yes, that is why I suggested the "list of acceptable choices"
approach as a direction to go in the future, primarily to limit the
scope of this current work.  I do not mind it if you want to bite
the whole piece right now, though.

By the way, I have a mild preference to call the option after the
phrase "protocol-family", without "IP", so that we won't be limited
to Internet protocols.  IOW, --ipversions is a bad name for the new
commnad line option in my mind.

As I said elsewhere, I also think TRANSPORT_FAMILY_ALL is a
misnomer.  When it is specified, we don't use all the available ones
at the same time.  What it says is that we accept use of any
protocol families that are supported.  It is OK to use ALL in the
CPP macro as it is merely an internal implementation detail, but if
we are going to expose it to end users as one of the choices, I'd
prefer to use 'any', and not 'all', as the value for the new command
line option.

Thanks.
