Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB76C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4252067C
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W2FlnxEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFSIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:08:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55578 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFSIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 13:08:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40364B1A0D;
        Fri,  6 Mar 2020 13:08:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0j76/WxqA4pvUIv1JxH8wIIry5g=; b=W2Flnx
        Eq5iXbo8q8Fit+//KpjIN2ooAlprWuCH/vNCdeIaO4U+v2QFAOk+gpkWROqKrG5X
        aX/H3fuG+0B9PM6ctbHhWarde+ivU4HcgCBRz37MiWdw1t/CXjr4azdkZdxOkAY6
        IwNy8fNmqWkZduJH97VwvfH2Lbk4GkDB7fyyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QtshZq5wD2jv3rRjCurfFKs3xTHQI460
        a+0MCbY/ESoQdizCDhl3Mm6J9ozNWdb/m4dpHsSNo+YOuv6OOQ5zHfj15+vgpCnu
        v3PtV7fQ8zrOOW8WBhmHcfV96mSscAEr0SF3PA4ihH0lI3JPY5NNWOqtINKOzWp+
        fV1CbHDPZAw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 394CDB1A0B;
        Fri,  6 Mar 2020 13:08:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66F5AB1A09;
        Fri,  6 Mar 2020 13:08:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
Date:   Fri, 06 Mar 2020 10:08:41 -0800
In-Reply-To: <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 5 Mar 2020 18:34:39 -0500")
Message-ID: <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83EF094E-5FD5-11EA-BE3D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Having this command be a stand-alone exe rather than a builtin allows
> it to have a different linkage.  For example, you could include the
> libcurl and other libraries that are only linked into the transports.
> And then report version numbers for them if you wanted.

I actually do not think that is a good rationale.  Unless your
version of "git bugreport" links into the same binary as the
"transports", it still is possible that the version of cURL (for
example) "git bugreport" can learn internally from may not have
anything to do with the version of the library used by the
transports.  

Of course, making "bugreport" a built-in, i.e. the same binary as
the non-transport part of Git, is not a solution for that issue,
either.  As Dscho suggested and recent rounds of "git bugreport"
implements, teaching the transport binaries an option to report
relevant pieces of information regarding the libraries they use, and
making "git bugreport" ask them, is a very good solution for that.

What makes it possible by making "git bugreport" stand-alone is for
it to link with libraries that the remainder of Git, including the
transports that link with libcurl, has no business linking with (a
library to obtain system details for diagnostic purposes, for
example).  Early versions of "git bugreport" may not link with
anything special, but making sure it starts and stays standalone
leaves it easier to do so _without_ having to worry about splitting
the code that started as a built-in out to make it independent later.


