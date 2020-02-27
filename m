Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA3C34022
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3631F246A0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPuVyku6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgB0PHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:07:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56953 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbgB0PHC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:07:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94B37B3632;
        Thu, 27 Feb 2020 10:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Oqrpo5YJv54YKjPe2hLXb6weYA=; b=gPuVyk
        u6hECce2LQo7BHyXGytK3eGdd+QtoRwVWJy0SP7MBjKlDC3pCm1LL7wDl2hOeMjq
        d453lSkbyxSqWLGHYh3Zd4RCCZXdTpnbuvwMdQyk4T5Qaq+hTzEPbZ5kV7GZ8KCT
        Yju3VFE4TRX9RDI1f/vxA35vgoQ/K76jRJegU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vcGjFBswA475zyw+xFNAKteD2ho2wKSk
        Xkrz4obHauGeKbv94xeJGsRNBUHLrtQjGZzh2UwguFbQBvqtcFjBwZcZhBEGNPCf
        wviWJLv35mjwT+TCZIDQSgrUlewpO/C++VKxlwBliQWfBQv0UZcewPX1E8z27NSA
        wBTF9g/vaCw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D141B3631;
        Thu, 27 Feb 2020 10:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8237CB362F;
        Thu, 27 Feb 2020 10:06:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing tags
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-19-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
        <20200226022332.GB7911@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2002271423580.46@tvgsbejvaqbjf.bet>
Date:   Thu, 27 Feb 2020 07:06:56 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002271423580.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 27 Feb 2020 14:24:56 +0100 (CET)")
Message-ID: <xmqqh7zcgjcf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCCF1A6E-5972-11EA-9C8C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You're welcome, but credit for catching it should go to Azure Pipelines
> ;-)
>
> To be honest, I am rather happy how these CI builds help us catch things
> already when they are in `pu`. _Quite_ happy.

Oh, you do not have to be honest for that---you show that all the
time ;-)

And I am happy that I can throw a new topic to 'pu' and CI will
catch issues before I even look at it seriously to consider if it is
worth keeping it.

One sad thing about Azure Pipelines thing is that, as far as I
recall, we hear about breakages it discovered only from you and
nobody else, while we hear about breakages discovered by Travis by
at least multiple people, and that is *not* because the coverage is
wider or report is more accesible and easier to read there.  It's
that our CI at Travis forced awareness of its existence on us by
simply being the only one out there for a long time.

We are bound to add issues to the tip of 'pu' (e.g. 64-vs-32,
bytesex, or GNUisms) that are easy to discover by building on
different platforms and in different configurations every once in a
while.  We should advertise more to gain awareness so that other
people can also notice breakages Travis's limited coverage may have
missed even when you are on vacation.

If you want quantitative measure of success ;-) (sorry, I couldn't
resist as it has been Perf period around here), I want to see at
least two people outside Microsoft to notice and report breakages
first found by Azure Pipelines CI in the coming 6 months.  How can
we help make that happen?

Thanks.


