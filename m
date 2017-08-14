Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DD620899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdHNT6y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:58:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50502 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751575AbdHNT6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:58:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3200D94757;
        Mon, 14 Aug 2017 15:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=01B0dQV3xiuxhYyaKAnxdtLSggE=; b=Sx4VaI
        hSYxlN4O2qpFU2qalBizdDS0fzLmkpqNMFxXYikR1Ba6y/krvil0+HTOD+sHVvCS
        Y6gb2WXlB5l6haB8P58t2dsLKKRKEAVoxkJkk5laF0Fg5BuvA/wBu5l5vdTF034m
        NFzZG5wZP9HJS3gkznLPm+3royqO9cTBbX8XI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UKCqGFxXHqtO8eGt8m0iRPGLNc+kR+mu
        ZovLC50kH/kyO9eCKFPA2KJ53MxDMJHULa5jTYxviQJLNnAGdRand9byPkEoHsnY
        wVMitYAxKhEIx3n/B3MGKCfLFd5mglZLcyAXdsbMIL9BGVyZxxNC2G9yaAgaI8WR
        s/smf7HiFZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BCF94756;
        Mon, 14 Aug 2017 15:58:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AAD594753;
        Mon, 14 Aug 2017 15:58:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
        <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
        <20170813183026.GC31079@mail.zuhause>
        <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
        <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
        <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
        <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
Date:   Mon, 14 Aug 2017 12:58:51 -0700
In-Reply-To: <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 14 Aug 2017 20:31:50 +0100")
Message-ID: <xmqq378tvs3o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF1811E2-812A-11E7-8E74-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> In a previous comment, I said that (on 32-bit Linux) it was likely
> that an object of > 4GB could not be handled correctly anyway. (more
> likely > 2GB). This was based on the code from (quite some) years ago.
> In particular, before you added the "streaming API". So, maybe a 32-bit
> arch _should_ be able to handle objects as large as the LFS API allows.
> (Ignoring, for the moment, that I think anybody who puts files of that
> size into an SCM probably gets what they deserve. :-P ).
>
> The two patches I commented on, however, changed the type of some
> variables from off_t to size_t. In general, the patches did not
> seem to make anything worse, but these type changes could potentially
> do harm. Hence my comment. (I still haven't tried the patches on my
> 32-bit Linux system. I only boot it up about once a week, and I would
> rather wait until the patches are in the 'pu' branch before testing).

We are in perfect agreement.

I didn't mean to say that it is OK to replace off_t with size_t
without a good reason, especially when the current code (at least
the part I looked at anyway, like the OFS_DELTA part) seems to use
off_t correctly, and your review comments are very much appreciated,
so is the effort started by Martin to take us in the direction of
using types more appropriate than "ulong".
