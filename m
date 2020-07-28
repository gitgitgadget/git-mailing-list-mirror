Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44AC433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7911207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L7p1dT3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgG1WoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:44:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53052 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:44:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B647831D7;
        Tue, 28 Jul 2020 18:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i+5piSdxVWGm
        ZqErr6SgcWJweu0=; b=L7p1dT3uMenpE53+im3MOp2utFd5JzngZdsQI8fazF2f
        RIVHgfdS1pFAgOmJPZ7m0AEpyLA53blSz7VxpXpKf2ZlI/nIJ+spDHbbvgrcu1Sy
        V84TvenqIH2oozmWXG1u32dnayfBT8KhwUiuQDUqS4nkGUacc1ws0bF8XN9orck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dSEGMK
        7riTDxIriucDpWzTpyBxM/IU+0lFo8qQ1aW0irNM4U52zQ1ulVo2a4gr6KZUOAnh
        xIwToc49h/7FwxInvRrQKEDzLtT5fWhSeLuqBEQikqIMITyBruWIEoQ62wND35cu
        MSDQXHunt1dOINz7TSC2ZyGU5Y7Zy6ryPjbdI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 327A3831D6;
        Tue, 28 Jul 2020 18:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7557D831D5;
        Tue, 28 Jul 2020 18:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: avoid using oid_to_hex() with parse_object_or_die()
References: <551da4ae-c75a-0f2b-7786-2fee32939b2b@web.de>
        <CAHd-oW68nGch8b3tfas4AUUgA8so-ihwazAf8-W-xQNPi31=Mw@mail.gmail.com>
Date:   Tue, 28 Jul 2020 15:44:03 -0700
In-Reply-To: <CAHd-oW68nGch8b3tfas4AUUgA8so-ihwazAf8-W-xQNPi31=Mw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 28 Jul 2020 19:35:50
        -0300")
Message-ID: <xmqq1rkvclak.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6BCBAA8-D123-11EA-86DD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Tue, Jul 28, 2020 at 6:40 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> parse_object_or_die() is passed an object ID and a name to show if the
>> object cannot be parsed.  If the name is NULL then it shows the
>> hexadecimal object ID.  Use that feature instead of preparing and
>> passing the hexadecimal representation to the function proactively.
>> That's shorter and a bit more efficient.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> Good catch. And this seems to be the only place where we use
> `parse_object_or_die(oid, oid_to_hex(oid))`.
>
> Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>

Yup, makes sense.  Thanks, both.
