Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB92C4363D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A10D22244
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RTThQWfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409951AbgJTVdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:33:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54596 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409948AbgJTVde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:33:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C05FBFAE9E;
        Tue, 20 Oct 2020 17:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eic5C87DvtJt3xUnnPGvHMEXCXs=; b=RTThQW
        fNMMRx3wXu/M7G1ZLwsBjEnXu2Y+yPVeaCzXg+AS3RPohVEtxwoIn9r4vDKTb+RT
        7ZU9eAl1I/PLGenSBMLxYIRN0/gZKl6GtkDm2ZQxshJdNKrT/j8Dqqd3cUvj27+2
        FRQUwJlKakqyOaimP0sxRVJ3T1MbLc+cPxT/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lHSpb4CsuLQd6iLBD6hyzVANmfNpYKmI
        P2HoKxuGGkKmMjwtAbOCfwvg1psSBbmn7tosMQcUCVV6c7l/QPNGXxobrv7+9Iof
        WEbyM0it9F4SJGy0tyiHeHD+OaSkwSLXeFqQ9ympXs7ILaQ3ELNQ1/BE7dJ6tOFR
        /1kmi03IRJs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9B3BFAE9D;
        Tue, 20 Oct 2020 17:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12BCAFAE9C;
        Tue, 20 Oct 2020 17:33:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] sideband: avoid reporting incomplete sideband
 messages
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603136143.git.gitgitgadget@gmail.com>
        <xmqqwnzkab85.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010202246240.56@tvgsbejvaqbjf.bet>
Date:   Tue, 20 Oct 2020 14:33:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010202246240.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 20 Oct 2020 22:48:09 +0200 (CEST)")
Message-ID: <xmqqft68a8gn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5887C7C-131B-11EB-B204-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Nicely explained.  Do we want to also give credit to Peff for the
>> single-liner fix here, perhaps with a suggested/helped-by trailer?
>
> Sure.
>
> I had not added that because I had actually come up with the fix
> independently in my analysis before I read Peff's reply thoroughly.

Ah, of course, e-mails cross all the time so these things happen.
Thanks, both.
