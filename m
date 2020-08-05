Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C0C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD1206DA
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzCEbIm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHEQUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:20:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64141 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHEQS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4D6BDD60D;
        Wed,  5 Aug 2020 12:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FfwEkqDze27Hsq5E7yFQ1X8iG9I=; b=nzCEbI
        m3quzgeaeTjfvl0fdsSSgIVrTqOVfsxA90InmmsPfEsDDUcYb9AmuWbmjkqwC62p
        jxM+lhQsLj0T/L3R61BFe1OrLwJFIlIn+Xj8viqvgccmDrFPs3uhfTZZbU/t4Moq
        3+7O3ZJIaQ7k/0RDrP4ZM248zIszIBXf3MSKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DbONHlkMKevuVM0Su8wtwD6aj+Jg35k/
        FoS9/7gOOBRkC4V662P3xafxUlYuhkrUXkurE0TMrmhLoRbdhEdWNwi4RA9oHjtM
        TxaAbqtHfceT/5PUZNoMLiW+OCe/1y4AOyZHIrFL3YaDLPSDQIBUKGbo4hzaGEHG
        6LavOadJPPo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3DEFDD60C;
        Wed,  5 Aug 2020 12:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E83E8DD60B;
        Wed,  5 Aug 2020 12:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87k0ydp0hc.fsf@osv.gnss.ru>
Date:   Wed, 05 Aug 2020 09:05:35 -0700
In-Reply-To: <87k0ydp0hc.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        05 Aug 2020 18:37:51 +0300")
Message-ID: <xmqqeeoloz74.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 800AC624-D735-11EA-ADBC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
> In this case your original test:
>
> git log --no-diff-merges -p --first-parent [--diff-merges=1: implied] master
>
> would fail, as implied --diff-merges=1 then wins.

IMHO, I think this is an absolutely wrong thing to do.  At least to
me (and I suspect it would be to many users), what "--first-parent
implies 'when showing a diff, compare only with the first parent'"
means is that it should do so unless told to do otherwise.

    git log --no-diff-merges -p --first-parent

explicitly tells the command that the user does not want to see
patches for merge commits.  I do not see any reason why
"--first-parent", which merely *implies* a specific diff generation
preference for merges, countermand it.  IOW the implication is
conditional.

It is like saying

    git log --first-parent

should show patches because it *implies* comparing only with the
first parent, but you can see why it is wrong.  It is because that
implication is conditional---it kicks in only when the command is
told to compare with any parent (i.e. "-p").  

I.e. the implication is "compare only with the first parent if told
to compare, and if not told what to compare with explicitly".
