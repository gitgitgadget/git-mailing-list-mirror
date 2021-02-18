Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9204C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A7364EE1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBRU24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:28:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58591 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBRU2l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:28:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C60912B601;
        Thu, 18 Feb 2021 15:27:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Kymsd31XsoYx
        APnjJB33fGFTOZ0=; b=DyqCiPCLxXLdNSh+lkOKgR5HyLUK9AebkQAWgJSH2k48
        LINDcSrmYI2//1MgoN+rs35fhWJ2gvS59C3s5ZWxUoZ2PSwutOnl7PHsdXYmZLvV
        enx2XQOXko/s1SNOwz9fXVjACMMlKjb6959hRTNQIvoIBtOsUONr1/HAd5A1yN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Jq5ZzK
        WRZCUWWdNoZ7rQf8s/gulPv/P7y9oRf/ADaGJ0ouDiKstI5Txcm+rFkphTk94gXq
        Se1jiGoRpxNVFRHGE+rV9vYgPgQt9iaF9bnCV+8V8mzFSvDMVtDLccwpqjWjE2+3
        RbXWDPmOpMOH16aJKOA5QDlphMfqHNFvY0oAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53BC612B600;
        Thu, 18 Feb 2021 15:27:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95E8D12B5FF;
        Thu, 18 Feb 2021 15:27:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
        <20210217194246.25342-1-avarab@gmail.com> <xmqqo8gijtl7.fsf@gitster.g>
        <87zh028ctp.fsf@evledraar.gmail.com> <xmqqtuq9faw5.fsf@gitster.g>
        <YC7GupBLb4IoDLj6@coredump.intra.peff.net>
Date:   Thu, 18 Feb 2021 12:27:48 -0800
In-Reply-To: <YC7GupBLb4IoDLj6@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 18 Feb 2021 14:57:46 -0500")
Message-ID: <xmqqtuq9dsu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C56A8E92-7227-11EB-94CB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 18, 2021 at 11:12:26AM -0800, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> >> Let's get this reviewed now, but with expectation that it will be
>> >> rebased after the dust settles.
>> >
>> > Makes sense. Pending a review of this would you be interested in que=
uing
>> > a v2 of this that doesn't conflict with in-flight topics?
>>=20
>> Not really.  I am not sure your recent patches are getting
>> sufficient review bandwidth they deserve.
>
> FWIW, I just read through v2 (without having looked at all at v1 yet!),
> and they all seemed like quite reasonable cleanups. I left a few small
> comments that might be worth a quick re-roll, but I would also be OK
> with the patches being picked up as-is.

That's good to hear.  I shouldn't even have bothered to answer the
question, if the v2 were to have sent to the list without waiting
for my reply ;-)
