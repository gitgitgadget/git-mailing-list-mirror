Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D8C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A311C2068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EJuYkUqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKUFnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:43:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63426 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKUFnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 00:43:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EB2D2EBFB;
        Thu, 21 Nov 2019 00:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jtrSk4U2+QVM
        YW14dyoIML6ofgA=; b=EJuYkUqvUpbTaZ36Giykp8QvFTweKrwAjW0paRAW2/ku
        XyHgg4iC4WHdJhVsvsoLvTCb2GK/JaUxkXZe54wIe6cpqZ6ZVSGAf2WVRl0ANF3m
        sooDLnVNLB56UyYImCcdXj9O/yYy0JQl7ItRy4c2gRrOthT6LK4MigrMgV7cPOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=du3wyr
        pVE86abqRNXWQveTRUBNo1qKIGtq8CcOCGa3Np67J/IAw7/+DsKx+X1OhCMtUfle
        Ps4bSTc40ae76tSMr0QfssjrBUBy27dLx0+Uyv0JzNE2R2lGcsj/N4IFiveBZDzP
        YH0XNGRKDz0NXVObkKA3He4oeTNBjXzOL9snQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46B302EBFA;
        Thu, 21 Nov 2019 00:43:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 943862EBF8;
        Thu, 21 Nov 2019 00:43:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] builtin/config: warn if "value_regex" doesn't canonicalize as boolean
References: <cover.1573670565.git.martin.agren@gmail.com>
        <0f48ab4fc344b3cc226d0a45d13530022208ff3e.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 14:43:34 +0900
In-Reply-To: <0f48ab4fc344b3cc226d0a45d13530022208ff3e.1573670565.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 Nov 2019 19:55:06
 +0100")
Message-ID: <xmqqpnhl943d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC370A1E-0C21-11EA-BE79-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> With `--type=3Dbool`, we try to canonicalize the "value_regex". If it
> doesn't canonicalize, we continue and handle the "value_regex" as an
> ordinary regex. This is deliberate -- we do not want to cause existing
> scripts to fail.
>
> This does mean that users might be at risk of missing out on config
> values depending on which representation they use in their config file:
>
> 	$ git config foo.bar on
> 	$ git config foo.baz true
> 	$ git config --type=3Dbool --get-regex "foo\.*" tru
> 	foo.baz true
> 	$ # oops! missing foo.bar
>
> Let's start warning when the "value_regex" doesn't look like a boolean.
> Document our intention of eventually requiring the canonicalization to
> pass.

While I actually think this warning is counter-productive, if we
were to do so, value-regex given for a bool-or-int type should also
be warned if it does not name a boolean value and is not an integer.

With the way you laid out the "use enum to tell what kind of token
value_regex argument has" pattern, I think support for "--type=3Dint"=20
to normalize human-readable numbers would also fall out naturally,
which is nice.
