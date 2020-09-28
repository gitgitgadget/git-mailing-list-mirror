Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8DC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8232072E
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wKRZGDHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1UA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:00:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58550 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1UAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 16:00:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0D68EFBFA;
        Mon, 28 Sep 2020 16:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LmQ9e62HTvRj
        1PcpOxyWiTOnukU=; b=wKRZGDHIDOpiGCo5oXMSoahijtMOre+hHosv716vkxdA
        FjBatlB9CHwGxr1ikns6KdjinpH9sww0AYpb4QYBEtRG4v4iHP+Ne0VRGuMKZzmS
        iTkedqLyZcDyCMnTqBnOdQv353foO8aoRz5V35S7/qYfzuhFsQY8hXmH/JhQUEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=F3yN/H
        7pkeJQVY5UHsXP41gDBDQ/+QJJz10JvFCnV72VsdM4LMcvaJFDyoNmZmSFeAX4/b
        VvINNxnCAJsbByYHl57JA9rUHPcGMnC8Az/5hoybuqinrSqtpr1HJ0EbClEh1wp8
        zsj1vhJ6h3X4cz5j5SsoALQpGIIteGpkREbQQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8FAFEFBF9;
        Mon, 28 Sep 2020 16:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17D8BEFBF6;
        Mon, 28 Sep 2020 16:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
        <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
        <20200928174619.GB24813@szeder.dev>
Date:   Mon, 28 Sep 2020 13:00:48 -0700
In-Reply-To: <20200928174619.GB24813@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 28 Sep 2020 19:46:19 +0200")
Message-ID: <xmqqzh59llhr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E70D1A2-01C5-11EB-A5CF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> That build runs the test suite with a bunch of GIT_TEST_* knobs
> enabled,...

Ahh, OK, I knew there was one "funny" job but did not realize
linux-gcc was that one.  It is understandable why that particular
job behaves differently from others ;-)

Thanks.
