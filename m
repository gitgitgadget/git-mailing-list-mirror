Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3112C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADDC61042
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhDLR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:58:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64947 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243648AbhDLR6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:58:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3971C12ED54;
        Mon, 12 Apr 2021 13:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BS+ICYlrv7uX
        uVD9Rv7o26WgTho=; b=tRbAyJXnm4kEFFMgltNZvx7/PMtHxw06r2T1gmueXQVf
        Z5EQW9W8z8TOfJwnosxkcNwLLkZv80zqS+TvHANK4HZEprrOsDwsDZKefVxjB8xW
        RlNXx4T7PKDaVNedbtEVR9ZeyYOKexj7AgdR1p1BruEkSvvQoJa/YtuBc7O886o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QKx9w4
        MGBtJeMsGDegPlB60EI+8QqWUmNRE2b5qZzqSk2Z5EfUckXSD2i6A72FUXCqlQDc
        9OFBrrd3PxiTyaA87zRLFihU9y/F27HWwpRZTcwNOtm7gJ89XxukLf5r6DXVgKt6
        6DtnYmhePeL4LuNkoiyhQS7UgPIZBMR0uSTsw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A5C12ED53;
        Mon, 12 Apr 2021 13:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AB7012ED52;
        Mon, 12 Apr 2021 13:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] C99 support: remove non-HAVE_VARIADIC_MACROS code
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
        <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
        <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 10:58:22 -0700
In-Reply-To: <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:02:18 +0200")
Message-ID: <xmqqeeffe669.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD170856-9BB8-11EB-8F7F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove code that depend on HAVE_VARIADIC_MACROS not being set. Since
> 765dc168882 (git-compat-util: always enable variadic macros,
> 2021-01-28) we've unconditionally defined it to be true, and that
> change went out with v2.31.0. This should have given packagers enough
> time to discover whether variadic macros were an issue.

It hasn't even been a month since we did v2.31.0.  Since it was not
even a maintenance release for security update, I have no reason to
expect packagers to be all that prompt to react.  And because we
gave them an escape hatch, they may have used it to update their
distro packages and haven't had a chance to tell us about it yet.

So, the above does not sound like a credible excuse to make our
future work necessary to react to "our toolchain is not ready yet"
complaints bigger.  At least not yet.

Please do not add patches that you know are unnecessary right now to
the pile of patches that needs to consume reviewer bandwidth.

Thanks.
