Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEFC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686FA61151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhDHXwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:52:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65002 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhDHXwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:52:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06E20B4F64;
        Thu,  8 Apr 2021 19:51:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BoTN+/z8dD3n
        SZFxDkScdeW8V/o=; b=vELtdAbKYA/oVB9C3ll0HGk4f+tlIjY8rAYdBTvjQa32
        J2HcWCLyULGvB4jmi+xP25R16ftt06IfqpWbKaTtj1nhWYdP7jMaOpKvXdkQeyGV
        jxAouRn9fJXAdCquXQBxgqIfnaOpuamzn+U/evpMTtRzKSZGDM2mbw/4kvGFqvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tILCk/
        vPUuPZdQtWWejMke63Y87FRhI+GTmZOyrBXR1mM6ieVG+TvPwOWkQWlSW6baDrm/
        Ad1mBOOZLXKmEK2X0MX7fr4bbNiQ6CtbaZHpEjz9LpmJNBpED9m1w53pr9VfSYJy
        rjZxqxF7gTs/7+ObNxwYf4zqwMjQ0LKbucX+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC28B4F62;
        Thu,  8 Apr 2021 19:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39BDAB4F61;
        Thu,  8 Apr 2021 19:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
        <xmqqa6q8tymu.fsf@gitster.g> <875z0wicmp.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 16:51:52 -0700
In-Reply-To: <875z0wicmp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 01:23:58 +0200")
Message-ID: <xmqqtuogpc6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64D5120E-98C5-11EB-B296-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'd prefer to just make these "enum", which means we'll have the aid of
> the compiler in checking all the callsites, as in the patch-on-top
> (which I can squash appropriately, need to update the doc comments
> though) at the end of this E-Mail.

I think enum is oversold by some people (not me).  C Compilers won't
do much when you use them interchangeably with int, simply because
they are designed to be used that way, no?

If existing code used 0 as false and 1 as true, and it learns an
"auto" value with a new definition,

    #define TRISTATE_AUTO 2

without TRISTATE_{TRUE,FALSE} defined to 0 and 1, that would be a
good place to stop.  I'd be quite happy with that.

