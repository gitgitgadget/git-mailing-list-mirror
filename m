Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F944C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 03:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhKWDjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 22:39:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54327 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhKWDjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 22:39:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FF0A1732A5;
        Mon, 22 Nov 2021 22:36:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VQDzfVvtXNB8
        mGWaObon1lk0Twkf8lnqJSWvhAbPCPo=; b=l86nl7J/EPvyReEJKBK/6Fr12ATF
        AkQD6xOmEi3GtjTE6cH5sRUe1WNiaQ7ylY4GRTQxQdlmuRoqBa3/x7++03KlJGV0
        KO0kjII+z2gkQMRqkMfXV9gLp1hygUKxQkVXC24B3X8HYoJZGXA5dUhhwtAIp88O
        DjaosUO76C4Opug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88E001732A4;
        Mon, 22 Nov 2021 22:36:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9395A1732A0;
        Mon, 22 Nov 2021 22:36:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
References: <cover.1637567328.git.dyroneteng@gmail.com>
        <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
        <xmqqczmsf2d2.fsf@gitster.g>
        <211123.86tug3wu8v.gmgdl@evledraar.gmail.com>
        <xmqqpmqrachl.fsf@gitster.g>
        <211123.868rxfwqdw.gmgdl@evledraar.gmail.com>
        <xmqqlf1fa8cj.fsf@gitster.g>
Date:   Mon, 22 Nov 2021 19:35:59 -0800
In-Reply-To: <xmqqlf1fa8cj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Nov 2021 18:55:56 -0800")
Message-ID: <xmqqh7c3a6hs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A448BCC-4C0E-11EC-8724-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> That is what I would call over-engineering that I would rather not
>>> to have in low level plumbing.
>>> ...
>> We've got --format for for-each-ref and family (also branch etc.), and
>> for the "log" family.
>
> But I didn't comment on them. ls-tree is a lot lower-level plumbing
> where --format does not belong in my mind.

There is a lot more practical reason why I'd prefer a less flexible
and good enough interface.

I can see, without coding it myself but from mere memory of how the
code looked like, how such a "we allow you to choose which field to
include, but you do not get to choose the order of fields or any
other string in the output" can be done with minimum disruption to
the existing code and without introducing a bug.  On the other hand,
I am fairly certain that anything more flexible than that will risk
new bugs involved in any large shuffling of the code, which I am
getting tired of.

So there.
