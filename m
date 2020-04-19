Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42ECC2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9056420753
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 05:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rTuWLg/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDSFch (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:32:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61708 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFch (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 01:32:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BB06C9824;
        Sun, 19 Apr 2020 01:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U8OwhiDF7O5X
        YR1/SsUjRMtgmiM=; b=rTuWLg/sJMSKE+EU3CICckG9z1qigIUar7ZYHf5XFMc4
        4UW36Txjp34wJJWnreMqzJHmn582j9GE3TR05oTIBb7exBjAsw7IgLdSgpHvaDTs
        XXrQM/wTGxUpZspjz2YLdlV0ZyIddmCLgjLwzS3KTjBuYRTaOIDK5JPUhUmuajo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KZjDUl
        stfIe+i+gkBQtjTIqMBghrvGm6dJgyAPKeX9Clr0KonK3bw3YD7D95bqb4bu3f3w
        S8Ma7y9QblfWeSM3dYbAFE7dhW60G15PS7lF6C8m6N+yeDpOCgNcmyiAs8SEpx54
        Zo31Fa2o5hcAYiR0KNli/qrmnBjbMN25AHvzs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15936C9823;
        Sun, 19 Apr 2020 01:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E8A5C9822;
        Sun, 19 Apr 2020 01:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
References: <20200418035449.9450-1-congdanhqx@gmail.com>
        <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
        <xmqqk12ctmm1.fsf@gitster.c.googlers.com>
        <20200419024805.GC9169@danh.dev>
        <CAN0heSoj9fwpx5WbME+Oew-7NLfBfQCfAKissix+wnFk0UW5uw@mail.gmail.com>
Date:   Sat, 18 Apr 2020 22:32:30 -0700
In-Reply-To: <CAN0heSoj9fwpx5WbME+Oew-7NLfBfQCfAKissix+wnFk0UW5uw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 19 Apr 2020 06:34:10
 +0200")
Message-ID: <xmqq8sist501.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AD3A436-81FF-11EA-89AA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> My knee-jerk reaction to Junio's question was along the same line:
> surely if we could have a NUL in there, the current `strlen()` would us=
e
> it as an excuse to silently truncate the string, either before
> processing or afterwards. Thanks for looking into that more.

Exactly.

The change introduces a behaviour change, and we should describe it
in the log message to help future developers know that we did this
change, knowingly that we are changing the behaviour, and believing
that the new behaviour is a better one.

Thanks.
