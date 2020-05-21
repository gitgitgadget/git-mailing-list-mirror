Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C289C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AD520759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kAEzPWKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEUSBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:01:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52426 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEUSBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:01:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF06693AA;
        Thu, 21 May 2020 14:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oW8ip186h/zH
        04lKX6vh81uMOBU=; b=kAEzPWKUXo6gHOsUXzED06LBfvOd1yzu2e9kp+zjmN8H
        IEni7AG425wayJGeAABEBPnQB9NMumSITsLclAL9gOic1TPuJ+4wuY2BL7TIimos
        T81E3TD1pNTXwSNW8sJ6LQcpLayj9307NuddcQAAVJLKNgYVsJqpL1ZYEcAw13o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yWZfXk
        DqKuH8In1YHV4RhOMvqma9o6403qJldET4cJ2YAzOmtkXh8SvdgpAsqVWujoyalX
        lYDBPyikGs1QwEeOfUQbP+s3i8bqEEgq7FcFLNugzSmMcWfntNUHHcnyWRwk91Ra
        hSYBV/FGGJAHPp3r7urZNHwkfwJwT8SMPuTU4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6119693A9;
        Thu, 21 May 2020 14:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E091693A8;
        Thu, 21 May 2020 14:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] t1450: increase test coverage of in-tree d/f detection
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
        <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
        <xmqqpnbduiec.fsf@gitster.c.googlers.com>
        <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
        <xmqqh7wovoop.fsf@gitster.c.googlers.com>
        <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
        <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
        <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
        <106c58e1-9c74-46e3-c83a-88eee114d9d6@web.de>
        <20200521102053.GA578930@generichostname>
        <1f982a11-358c-195d-21f4-0299f5b60ff2@web.de>
Date:   Thu, 21 May 2020 11:01:17 -0700
In-Reply-To: <1f982a11-358c-195d-21f4-0299f5b60ff2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 21 May 2020 15:31:26 +0200")
Message-ID: <xmqqwo55rwuq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11FD78FE-9B8D-11EA-9398-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> +check_duplicate_names () {
>>> +	expect=3D$1 &&
>>> +	shift &&
>>> +	names=3D$@ &&
>>
>> It doesn't really make sense to use $@ here since we're not using the
>> argument list behaviour of $@; we're just expanding it normally. I wou=
ld
>> replace this with $* instead.
>
> The assignment to $names flattens the list, so $@ and $* behave the sam=
e
> here.
> ...
> At least I'd like to keep the $@ as kind of a reminder that we want to
> pass on arguments (full names), not words.

I personally prefer to use "$*" when we are not invoking the "list"
magic of "$@" and switch it to "$@" when it starts to matter, but I
can also understand your "reminder value" reasoning, so I am on the
fence.
