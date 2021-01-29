Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497EDC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EC864DFA
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhA2XNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:13:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52730 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhA2XNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:13:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFB5EA1D9C;
        Fri, 29 Jan 2021 18:12:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HOPO20YOMm8oPHhPWwQzO2CtPqc=; b=hs81uN
        b6aY4F3cL7e8KMKKsAgI+ACzxe7k+/DFbhwSRVAHAV71A8j7bAhNRXK4LjbFwblQ
        B622mDMViSd82IMtoKCcDHo5pas3aGej0TdxCXghAPgDxDBZJeLnkGBm1w1Xwjwc
        IdCwhd56xAD8DXeiKKFQ82QgzyNQfcq3UeyZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q1nWGiDUuzRjGuYQohqP6dvcSVIhxdSY
        IQS+QvTLQikckusA1U84qVafh1EYCckJRSMvJssp+GVM0GF33BLPoJZnWovd2izE
        LsCUnyyk52SzZBqfUcPTbvcsoK+a3UJNQ3rumI2/pDPdlK1v3TqZstQBHSlDcjwU
        jLW1PXQ7Qo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E67AEA1D9A;
        Fri, 29 Jan 2021 18:12:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7531FA1D99;
        Fri, 29 Jan 2021 18:12:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/10] p5303: measure time to repack with keep
References: <cover.1611098616.git.me@ttaylorr.com>
        <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
        <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
        <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
        <xmqqy2gbsclr.fsf@gitster.c.googlers.com>
        <YBSHv3TWleRxM1+/@coredump.intra.peff.net>
Date:   Fri, 29 Jan 2021 15:12:54 -0800
In-Reply-To: <YBSHv3TWleRxM1+/@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jan 2021 17:10:07 -0500")
Message-ID: <xmqq8s8bs5ft.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84E9F560-6287-11EB-B338-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 29, 2021 at 12:38:08PM -0800, Junio C Hamano wrote:
>
>> > Oops. Looks like I was the one who introduced that. Nobody seems to have
>> > complained, so I'm somewhat tempted to leave it. But it would not be too
>> > hard to replace with perl, I think.
>> 
>> Yeah, but would it be worth it?  I am actually OK to say that you
>> need GNU sed if you want to run perf.  We already rely on GNU time
>> to run perf tests, no?
>
> True. This one is a little worse because it's subtle, and somebody might
> copy it unknowingly into the regular test suite.
>
> I am happy to leave it, or for you to pick up the patch I sent earlier
> (which I did verify produces identical output).

Yeah, I would be very unhappy if somebody copied-and-pasted it, but
somehow I didn't think too many people moved code in that direction
;-)

Will apply the portability fix, then.

Thanks.
