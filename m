Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BBDC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F04A64EE1
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBTDbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:31:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60830 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTDbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:31:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F5EE11629B;
        Fri, 19 Feb 2021 22:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qcO08g3XVLva
        kQndPyU7VPARqkM=; b=k9I/L/DBSk3x2DmBEdk9VPCQOzA2h57ScFsiD51mjrWy
        ciB6GSoC++U0KjvJ3dA9VjXxZA11sz6vbr5i2/NdTaY0NGEQCZ+8xyTLkPYoCQ13
        UsD9H6yZyqXL7xudv1YM+RKyyHTd2+z9d5xk8sk0egXyPghIRzhMEIHBsz4BDfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P1lTz/
        jWCUuD+UfqfkNkVq2lpP1xP+PgGUDoS7HVDcnpT67Yx44T4g/sTT8A1J/r7CRrdx
        BeAaVfpxNF2pFz5I1B2s5rZNeqrLiLcrqL8i4LqQqVDBmdlXYBh0BmIwKXmlchbm
        +9dLLEHgPf6qlkPF/Q6we6dpeOZmITvFK1BBI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07A0811629A;
        Fri, 19 Feb 2021 22:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E425116299;
        Fri, 19 Feb 2021 22:31:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <xmqqzh01ar2s.fsf@gitster.g>
        <20210219004612.1181920-1-jonathantanmy@google.com>
Date:   Fri, 19 Feb 2021 19:31:04 -0800
In-Reply-To: <20210219004612.1181920-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 18 Feb 2021 16:46:12 -0800")
Message-ID: <xmqqmtvza007.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10D929C4-732C-11EB-922E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This seems to have been stalled but I think it would be a better
>> approach to use a custom callback for error reporting, suggested by
>> =C3=86var, which would be where his fsck API clean-up topic would lead
>> to.
>>=20
>> If it is not ultra-urgent, perhaps you can retract the ones that are
>> queued right now, work with =C3=86var to finish the error-callback wor=
k
>> and rebuild this topic on top of it?  Thanks.
>
> OK - that works. My original idea was to rewrite it using an
> error-callback but using starts_with() instead of the ID that =C3=86var=
's
> work will provide, but seeing that at least one other contributor (Peff=
)
> seems OK with the patches, rebasing mine on top of his works too. I'll
> also take a look at his patches.

Thanks, either way would work for me, but if the suggested route
forces you review =C3=86var's code and work together, that would be a
good bonus point ;-)

