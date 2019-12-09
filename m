Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA687C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6131A206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wLtZDSId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLITF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:05:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50778 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLITF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:05:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CEC7A912F;
        Mon,  9 Dec 2019 14:05:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XQBsMgjwVdYT70O3H+Lartz0kCo=; b=wLtZDS
        IdJ+pMizoOg8yzO+53sFtjCZUkbVu70MfRr17ZwAOXztGLy8tZ6JDhF7NuJrYmrT
        3cu+hicuo6p5+XFhm70pvFgcTadlt/u0TOVJIBU1X49ei5HChzklP3XX+T0F6vGj
        QBi0EOofl9+tJvr54mV72ymfDDZ8KiEUDWgOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZJaOd33PAjAzV+anAXkSt4/9aAYZT45x
        gu2ytjTrJc6ChAYbwge68bdmQbm5b5y90oGvjd4Ken3z6X7mhV20OofDiNKuJzHc
        X8m9BdSbl7lKn2Yn0Gh1DCuCx8z3DwRZNLPXx1YjPMINKpqnJirpudYgdnYnU9nV
        diU/wPCR1/I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71B2AA912E;
        Mon,  9 Dec 2019 14:05:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7DEBCA912C;
        Mon,  9 Dec 2019 14:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
        <20191115180319.113991-1-jonathantanmy@google.com>
        <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
        <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com>
        <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
        <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
        <20191209061853.GA38588@coredump.intra.peff.net>
Date:   Mon, 09 Dec 2019 11:05:21 -0800
In-Reply-To: <20191209061853.GA38588@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Dec 2019 01:18:53 -0500")
Message-ID: <xmqqtv69uxou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA324438-1AB6-11EA-A2AB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One tricky thing here is that I leave messages or subthreads that I
> intend to act on in my incoming Git mbox. And of course as time goes on,
> those get pushed further back in the pile. But when new messages arrive,
> mutt attaches them to the old threads, and I sometimes don't see them
> (until I go back and sift through the pile).

This is why I still let a tab in my browser to be squat by GMail
that shows only the traffic sent to this mailing list, as it is very
good at surfacing a thread with new activity even though it is bad
at everything else, including threading.

For real work, picking messages up and responding to them, I read
and handle the list traffic via NNTP interface to public-inbox (and
lore.k.o these days), but keeping GMail purely as a notification
channel has its uses ;-).
