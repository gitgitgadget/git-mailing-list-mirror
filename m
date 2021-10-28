Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A133C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1F610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJ1WlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:41:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59327 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1WlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:41:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91399F9ECB;
        Thu, 28 Oct 2021 18:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MIcF94vijNusapXX1MAI8jj1V9i4IQUhIkngKh
        w7BL8=; b=WKGBUZKVpnY2W2FL9z7GrRLybnIsGbAT1K/wvOrTQhXaOSFv/qpyRw
        ChfxfqPY+WZiuiJ8VZKu/cOXGVu/10PmSSRvF1hwUKofsuDuL5kyqXzyDbIDm15+
        CtKP1yjD53FooMJFTp5jatKWx29zY7VBn1Vq7cLVTEyIXXTeu7Eos=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86A1AF9ECA;
        Thu, 28 Oct 2021 18:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBBE8F9EBD;
        Thu, 28 Oct 2021 18:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, vtbassmatt@gmail.com
Subject: Re: [PATCH 1/3] test-lib: add prerequisite for 64-bit platforms
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <20211028205649.84036-1-carenas@gmail.com>
        <20211028205649.84036-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2110282344330.56@tvgsbejvaqbjf.bet>
        <CAPUEspj2B7M_-cbA2O3LickF7MeVYNtXjfJMBMeYkLag5K=Z3g@mail.gmail.com>
Date:   Thu, 28 Oct 2021 15:38:48 -0700
In-Reply-To: <CAPUEspj2B7M_-cbA2O3LickF7MeVYNtXjfJMBMeYkLag5K=Z3g@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 28 Oct 2021 15:09:13 -0700")
Message-ID: <xmqqee84pyfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D20D56DC-383F-11EC-A05B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> Since this is clearly copied from `LONG_IS_64BIT`, why the change from
>> `-le` to `-eq`? It is at least inconsistent to use anything different
>> here.
>
> My assumption is that the check for sizeof(size_t) we have is really
> about finding the bit width of the platform, and we currently support
> 2 of them (32-bit and 64-bit), which is why the name I chose was
> "IS_64BIT" and also why I was strict on it being exactly 8 bytes
> (considering all platforms git supports have bytes with 8 bits).
>
> It can go eitherway IMHO, and your point about being inconsistent
> (with my lack of explanation in the commit) suggests we should instead
> use your proposal, do you want me to resend or could adjust them in
> your tree?

Is LONG_IS_64BIT used to ensure that long is _at least_ 64 bit?  If
so, perhaps its name may need to be rethought.  On the other hand,
if it is meant to ensure that long is exactly 64 bit, then it should
use -eq to compare.

And from that point of view, SIZE_T_IS_64BIT and use of -eq look
consistent with each other, I would think.

Thanks.

