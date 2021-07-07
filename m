Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D4C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF37611C2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhGGRrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:47:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61757 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGRrP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 13:47:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE38D133DFA;
        Wed,  7 Jul 2021 13:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AwFGDA3fmhfN
        UWH9muaOFXJeC2KxUqwVWjsGguKscso=; b=FmIj24Vx/PSlkInAfTqI/xxTPTtj
        mg23cAPejSCdrZUefeZPG10Q4ZNjWQg1RxH/L5n0dpTawv301wWWZFFibgJKCDWw
        H7yVoR99Tqt8zQzggTs6/4Re4VhmN+bBT1YJ/hsHBt8Ub8WrRnL5TmqnWapD/18m
        ofUdltkd74RgnaA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6453133DF9;
        Wed,  7 Jul 2021 13:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4519B133DF7;
        Wed,  7 Jul 2021 13:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: reorganise duplicate commit prompt strings
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
        <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
        <20210707162308.2438170-2-hujialun@comp.nus.edu.sg>
        <YOXc+mT01vptY9Nx@danh.dev>
Date:   Wed, 07 Jul 2021 10:44:30 -0700
In-Reply-To: <YOXc+mT01vptY9Nx@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 7 Jul 2021 23:57:30 +0700")
Message-ID: <xmqqzguydnnl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC92DDDA-DF4A-11EB-AFB2-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> However, I think we shouldn't take this route, because splitting likes =
this
> will make a translation lego. I can't speak for Junio, but from my
> observation, it's preferred to have 3 variables for 3 full-text, and
> we will pick the suitable text in each if-leg.

Yes, that is what I meant in my earlier suggestion.  More like

    char *hint_cleanup_all =3D
	_("Please enter the ... , and an empty message aborts the commit.\n");
    char *hint_cleanup_space =3D
	_("Please enter the ... if you want to.\n"
          "An empty message aborts the commit.\n");

    if (allow_empty_message) {
            hint_cleanup_all =3D _("...");
            hint_cleanup_space =3D _("...");
    }

    ... the if/elseif cascade in which calls to status_printf() are made
    ... using these variables

Thanks.
