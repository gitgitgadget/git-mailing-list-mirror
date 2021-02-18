Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DFC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87C964DA8
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBRUjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:39:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52231 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhBRUiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:38:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9B5910945F;
        Thu, 18 Feb 2021 15:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ntLn59D+kP0mPugb35rBPR7lyiQ=; b=qBttTt
        o+MRfDD+nxqJbSnP4BxMRCjajVC4z34XiAbMr4HdlYQHSecbkusm9g6rIbi7GaXW
        pr5uHWZ7/47vny/oQrMvgep1skHiMMXIQbXLVcjP7MgNxAZqAZMw13/f+hF8yZHJ
        PjbS7wxOJeUyYJhzHBiqvlPFKJXPAC5SYRMjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Of0FPt90n8tSELPfLO9YZZQNlv+h4/OH
        v59kvASGGyyr8vSkatrV+HJAni2Gj31XPl88NoAUV7sraFNJ8hVnvulwBF/1qc73
        BNMpYpWig5Tu50VJD43OLQ/1NPK9luDTSasdM/iW2PkK1fVnIviOQuFUruRakOni
        v7/4TipkMfs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A24FD10945E;
        Thu, 18 Feb 2021 15:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4E9110945C;
        Thu, 18 Feb 2021 15:37:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-2-charvi077@gmail.com>
        <xmqq35xulbj0.fsf@gitster.g>
        <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
        <xmqqpn0xfal8.fsf@gitster.g>
Date:   Thu, 18 Feb 2021 12:37:19 -0800
In-Reply-To: <xmqqpn0xfal8.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        18 Feb 2021 11:18:59 -0800")
Message-ID: <xmqqpn0xdse8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 195A9E10-7229-11EB-A390-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> ...Thanks, for pointing this out. Also, in the above method for
>> alnum I think we can initialize an array of alnum[] instead of
>> alphas[]. Or otherwise I was thinking to instead check:
>>            if (!isalnum(*c) && *c == ':')
>
> Sure a loop is fine, or alnum[] is fine, or just alpha[] is OK, I
> would think.  Do you foresee you'd need --fixup=chomp124:<commit>?
> I somehow doubt it.

Having said that, we may regret if we did not include some
punctuation to allow for a multi-word keyword.  IOW, "alpha plus
dash" might be a reasonable minimum.

But what keyword --fixup=<keyword>:<commit> can take is entirely
under our control, so it is not all that unreasonable if we just
forced our developers some discipline to pick a single-word keyword
for any of their future enhancements.  It's not like we are opening
up extensibility to the end-users, who may complain that the way
they can spell their new <keyword> is too limited.  So if we already
have alpha[] and/or a helper function that does strspn(alpha) that
we can reuse elsewhere, I do not think it is worth to try supporting
punctuation.

Thanks.
