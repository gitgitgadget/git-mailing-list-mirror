Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C624C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5A5600D4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD1HYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:24:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62151 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhD1HYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:24:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37FC0129034;
        Wed, 28 Apr 2021 03:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RL1/rEoStzq/
        ITulpTFryxQmH+enkiTBBeApmjzJf5E=; b=DCESjYfFDfQsZ58z8QFLKoYoh8Nh
        oduIgPY3MKco4atirQYL7g485sLET/3pRGXc3sF0i5KzfS6l9PGbRIPy7/C/1lSx
        ZG/TgCiF1crmB8blzYovyTy1kh3g3KgH+yf7TeF8DlZgPxLP3P6S6WxLwKss9mKJ
        HYfMJ5HWXHF3FWY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 226C8129033;
        Wed, 28 Apr 2021 03:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A969129032;
        Wed, 28 Apr 2021 03:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Moussu <moussu.robin@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request: `git restore $commit $file` =?utf-8?Q?shouldn?=
 =?utf-8?Q?=E2=80=99t?= override
 uncommited changes
References: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
Date:   Wed, 28 Apr 2021 16:23:53 +0900
In-Reply-To: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
        (Robin Moussu's message of "Tue, 27 Apr 2021 17:37:59 +0000")
Message-ID: <xmqqbl9yc1o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0B030BE-A7F2-11EB-B1F8-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Moussu <moussu.robin@pm.me> writes:

> That=E2=80=99s the first time I=E2=80=99m interacting with the git comm=
unity,
> I=E2=80=99m not very familiar with the process. I hope I=E2=80=99m at t=
he right
> place for a feature request.
>
> Currently, I don=E2=80=99t think that it=E2=80=99s possible to get an e=
rror when
> copying the content of a file from another revision into your
> working tree if said file has uncommitted changes.

Yes, "git restore <from-where> <pathspec>" is like "I made a mess in
the paths <pathspec> in the working tree and I want to start from a
known state, so please take the contents for these paths from
<from-where> and overwrite the garbage I have in the working tree".

It would be a grave regression to stop overwriting by default, as it
misses the entire point of the command.

The same applies to "git checkout <from-where> -- <pathspec>".

