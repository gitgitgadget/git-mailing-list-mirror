Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB58C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B264E79
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBPWYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:24:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58714 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhBPWYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:24:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62D879E881;
        Tue, 16 Feb 2021 17:23:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eZnOpxCT3PAO
        QSv6iVSnB1088d0=; b=s9mVDvLBkRtQTxOwlcXbuoVbxet49Dfdmir//zRsdLQU
        HeLbNykFhWubxivcnUCzBXOA/TT9WVgNB6TSUy6g5pL1zXEvZ2HB5/EJ2cjR8W6Y
        ytTLTI8Z/H0YCx/pdZs76qJLFFcianlhjhGYb20GrRPWGK7Wg+3GfGpa/+Shxaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WcrMdR
        nFMxLvl99jDU3Z3XR/OtJQlUsDT1hXmv5OJQ9/yEaq+Xr3oGXJ+9DMQUoTCm2RJY
        iRjiJ3nFY/URcJ+TYJc03Vp8ftF8cj0lC1aQhudth7YyhclZjnK3UYxbSgLaghoN
        L3pZH+3kr7MWz+EGb/0anQm+Zy6mADOY1w0PE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53A559E880;
        Tue, 16 Feb 2021 17:23:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 928619E87C;
        Tue, 16 Feb 2021 17:23:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 00/22] pickaxe: test and refactoring for follow-up
 changes
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-1-avarab@gmail.com>
Date:   Tue, 16 Feb 2021 14:23:30 -0800
In-Reply-To: <20210216115801.4773-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:39 +0100")
Message-ID: <xmqq8s7nps7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 99BDF91A-70A5-11EB-985A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a smaller v2 of the series to remove the kwset backend and
> make pickaxe use PCRE v2[1].
>
> That's not being done here yet. These are mostly small
> refactoring/test fixes. The most significant work is a new xdiff
> interface at the end of the series.
>
> It's based on next where some preparatory work already landed[2].

Do you really mean <20210204210556.25242-1-avarab@gmail.com>?

  grep/pcre2: drop needless assignment + assert() on opt->pcre2
  grep/pcre2: drop needless assignment to NULL
  grep/pcre2: correct reference to grep_init() in comment
  grep/pcre2: prepare to add debugging to pcre2_malloc()
  grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
  grep/pcre2: use compile-time PCREv2 version test
  grep/pcre2: use pcre2_maketables_free() function
  grep/pcre2: actually make pcre2 use custom allocator
  grep/pcre2: move back to thread-only PCREv2 structures
  grep/pcre2: move definitions of pcre2_{malloc,free}

I do not think we have that many patches whose title begin with
grep/pcre2 in 'next'.

In any case, I'd rather not to see things done directly on 'next';
targetting a selected few topics merged on top of 'master' would
not be bad, though.

Thanks.

