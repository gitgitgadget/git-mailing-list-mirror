Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D77C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968EB60FED
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ2V4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:56:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60349 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJ2V4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:56:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C50A15E9B2;
        Fri, 29 Oct 2021 17:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3k43fjsCNYiD
        N3QxJzGsZzG3bIa4QoI0jHmiTRNilMM=; b=QbIDmKv0x8bgJGcMtpuAQ3CDnReS
        i+quNTwx9cl17HL6New7GhdT48Cnj6sknA/qQUHxl2Be5qa5doVB6xZQjRPnq1ZS
        Ys99g9ikfZZA8D5TQzChPKmZ6AddMVfHAk+K/KVePf9GtWfGsOiYo7HZbj14uibP
        hbkHJty2DEzF9hI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14FD515E9B1;
        Fri, 29 Oct 2021 17:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1CF0715E9B0;
        Fri, 29 Oct 2021 17:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
References: <20211029212705.31721-1-carenas@gmail.com>
Date:   Fri, 29 Oct 2021 14:53:30 -0700
In-Reply-To: <20211029212705.31721-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 29 Oct 2021 14:27:05 -0700")
Message-ID: <xmqqo877ijl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A880027E-3902-11EC-AB1B-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Platforms that are using the git compatibility layer for unsetenv
> use void as a return value for unsetenv(), so any function that checks
> for a return value will fail to build.

It sounds like barking up a wrong tree.  unsetenv() is supposed to
signal success with 0 and failure with -1, and the compat/
implementation is broken, not the caller that tries to be nice and
check the error return from the system function it calls.

Not that adding the unused wrapper, and leaving it unused, was a
wise decision in hindsight, though.
