Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59DCC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 08:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiLFIcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiLFIbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 03:31:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AA1BE8E
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 00:31:34 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t17so4446490eju.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 00:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRAD6Clq+u168+BzIY//TrAsx+nA5LBSXuB7zUVmedk=;
        b=On5+BaJOgHfFD5WtCE9Bi6Uf4KXkl6BT5CWmaX7sbrDf7+X5uudmZKrLtFBXWeipNH
         l6b95y/l0BedjcuWUeJRhzVB2S2X8s7fxCsjymRvkV6Pbl+nYI+aSrCNaPhv4enr/cQE
         t/M9tHKtfZIRGbAQquASlB6p+vbF9gPWIkMLWkz0p+yJ6WPUA/R+QjK7ClD/uj1f8gJB
         ogv9TMjafKSF6l1ep1kd/2LfYJpBbHiKoivRdwIuu5ULWlIj6Zt7ga+1tAOUvAvM05rp
         AzBZbtE24IaeahJw61WEDxeD5mXW6uTKen60zh3KrKFzlZVy6/ubHvDC8G4sYiXIiZYP
         Up/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRAD6Clq+u168+BzIY//TrAsx+nA5LBSXuB7zUVmedk=;
        b=PG0LGg4Y7bD6oAYFCBI25D2Z1b7Se8jEihY/lUQbn4+xuEDgG3CYJ0nWVZQH3SyLbl
         4Ycn4qraptJKcN3iE3OtaozFz2xKoOL9G81LpPJPqx4m5AGt5n7/4IGSdplUrn8MCHI1
         d++Sw8SGNfrU+lbwgpB8PoYuWEIbuB5XhRajXd8WPl/KdS3QKjeRm95W7r49mIJHhxNT
         LS9A8GxpjtRA5LkXH3k/4lFaBoEtPfc5tCos9XvwkvvhqPZSvr0s/lZDfG/ShhPmHLmh
         6NluZ0SdE3wSRoSMis8nRwfEpdLYEHMjqPKqQRPsMZ5KB0FWPJv4ZZr2ym/B3s1cVY85
         7nFQ==
X-Gm-Message-State: ANoB5pnC5ntjBhwPys9SGefvQmfKRZPsCG2qqdAd+WQSO4xwqZhpFYe6
        +i+Csl1OzSxp+Lii3DyXdno=
X-Google-Smtp-Source: AA0mqf5FBLjjD9ilqx5jRiydRAUjeZeX+6brQBuuiQEprhgcGFf76xQgKxh6ki0dMGBtOKKJp/rE0g==
X-Received: by 2002:a17:906:3ad6:b0:7ae:40b7:7fbe with SMTP id z22-20020a1709063ad600b007ae40b77fbemr70013544ejd.371.1670315492258;
        Tue, 06 Dec 2022 00:31:32 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b007b790c18264sm7066115ejb.159.2022.12.06.00.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:31:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2TMR-003cYc-0a;
        Tue, 06 Dec 2022 09:31:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Paul Smith <psmith@gnu.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
Date:   Tue, 06 Dec 2022 09:13:08 +0100
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
        <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
        <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org>
        <xmqqpmd4ulnj.fsf@gitster.g>
        <1rq7o244-pos8-rp21-1q49-3210454n89nr@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <1rq7o244-pos8-rp21-1q49-3210454n89nr@tzk.qr>
Message-ID: <221206.86edtdc4rg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Thu, 1 Dec 2022, Junio C Hamano wrote:
>
>> Paul Smith <psmith@gnu.org> writes:
>>
>> > On Wed, 2022-11-30 at 09:23 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son wrote:
>> >> Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
>> >> changed in a backward-incompatible way, as its "NEWS" file notes:
>> >
>> > Hrm.  I did try to look through the other makefiles to find similar
>> > constructs and get them all, but apparently my grep fu was
>> > insufficient.  Bother.
>> >
>> > Thanks.
>>
>> Thanks, both.  Will queue.
>
> I noticed that this patch also touches Git GUI, a change which technically
> should have come in via https://github.com/prati0100/git-gui, not directly
> via git/git.
>=20
> I noticed that this patch also touches Git GUI, a change which technically
> should have come in via https://github.com/prati0100/git-gui, not directly
> via git/git.
>=20
> So let's make Pratyush [Cc:ed] aware of this change.
>=20
> We probably want to avoid applying Git GUI changes directly to git/git in
> the future. In the meantime, because I know that Pratyush is busy, I
> opened https://github.com/prati0100/git-gui/pull/83 with a (partial)
> backport of this patch.

Should it? I looked at https://github.com/prati0100/git-gui#contributing
before including git-gui in that change, which says:

	Even though the project is hosted at GitHub, the development
	does not happen over GitHub Issues and Pull Requests.  Instead,
	an email based workflow is used. The Git mailing list
	[git@vger.kernel.org](mailto:git@vger.kernel.org) is where the
	patches are discussed and reviewed.

As a bit of deja-vu when trying to find if that was outdated or not I
found that you seemed to have had pretty much this exact exchange
already with the git-gui maintainer at
https://lore.kernel.org/git/20190924122306.bcwe37wlahjimve7@yadavpratyush.c=
om/

Which seems to have been followed-up by
https://lore.kernel.org/git/pull.361.git.gitgitgadget@gmail.com/;
I.e. you sent a git-gui change to this ML.

Or do you mean that it should have been sent to this ML, Pratyush should
have pulled it, and Junio would have pulled upstream after that?
