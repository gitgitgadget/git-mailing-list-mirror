Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E6C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6532225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mip8XLxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKBSvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:51:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50127 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgKBSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:51:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 287D31005F9;
        Mon,  2 Nov 2020 13:51:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NtNhDXck1/AErEozA6BzrUqV1dE=; b=Mip8XL
        xkB6OuvvY3DFqjzgVR1GBIUZyZm8LKmscvjIemoiTwO2+FDYYOhGMEqUgBdUcbv/
        VwaxuD9dofA7OS7VnuQH54xKhy/oVqeBB6a/DH/s6F/mjuKT4ckFMvdi3nDRUzFH
        rytROk0DNdWpbrn1maTFMwwWFrYMgw6NbxcME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rrHmXBpT1E0odfPFKqFi4whWWl1Y3dqa
        6S24b3GYpk6cV4Dgxh5XiDFsyxsVO2B6jir9insw9uEmA6onF9I7u1rk4UmEfkQk
        nIoBkEEjqkq/ZUZArTChP/fofGnbl5PuHRVMTkQTw8QkQy/tqwArcFH2VqQ7FjWf
        ReglISvmylI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20D771005F7;
        Mon,  2 Nov 2020 13:51:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DD411005F6;
        Mon,  2 Nov 2020 13:51:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: jc/sequencer-stopped-sha-simplify, was Re: What's cooking in
 git.git (Oct 2020, #04; Tue, 27)
References: <xmqqsg9rvc9z.fsf@gitster.c.googlers.com>
        <20201102184634.3280859-1-jonathantanmy@google.com>
Date:   Mon, 02 Nov 2020 10:51:44 -0800
In-Reply-To: <20201102184634.3280859-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 2 Nov 2020 10:46:34 -0800")
Message-ID: <xmqqo8kfvbgf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 750D12A2-1D3C-11EB-9549-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I do not mind taking the approach as a prudent and careful thing,
>> but I want the question answered regardless, as I know Jonathan is
>> in a good position to tell if this is just a theoretical issue than
>> I am, and depending on the answer, we may rethink the approach of
>> trying to be overly careful.
>
> From what I see, this is just a theoretical issue for now. (I spotted it
> while looking at the code, not because of a bug report.)

If there is no actual damage, then probably the earlier "let's be
extra careful" Dscho mentioned may equally have been us being
unnecessarily cautious.  Assuming that you didn't apply this patch
to the internal version you ship to your developers---if you did,
then we truly gained no data from this exchange because the original
tightening had no chance to even cause the damage.

In any case, let's merge the loosening patch down to 'maint'.

Thanks for being careful.
.
