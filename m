Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA550C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXM0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXM0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:26:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4386DC31C
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:26:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d1so2221054wrs.12
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2qCbiBIQkK7wc2hKiM437U0JltbbIfJwdnUrfQG16Q=;
        b=I/N3GJOxUpOZb9W4NMYsubEP6vdH30+cfmDENLueQY6fXpftd9rjHt+r3dCzRH0BKb
         a1JkdwAWAff1CWa+2ujvMo0SxCj4Os8fXoe5SUrz5fU2bkhFt7KZRsWLX1CVXYGCIqhB
         kbKSQ0KgCQ4rOB5Ewm58oKq27Me9pG/WuYa+JSYqGkeWGLGAYVKtXP8xMlArr2q3cVyc
         eHwCktvM8eGxaJeq5IrfXaIEm7lirz2RJXf5DJB80drSKQhg2uICRf2bt24t0CNCRrwX
         iHrnP0AWxlCzvQZB0mC1MJbx/SO34lBVUbKsn1U9RBWS4EYiWOIe8fmsSQjrQgz30idx
         o6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2qCbiBIQkK7wc2hKiM437U0JltbbIfJwdnUrfQG16Q=;
        b=lZdN+kvDMQU99Sc6n/D2UzGQupYpLGJDl13PN9CoQrnjYGxPFJuBaAWo8l/R90xWpG
         iAa7bMTCrDvmEKDNLLNP8xBUUyuRwXFzrzXq6Yza1ZzeDRG2mgzWg2KZqCPf4JEJQIx3
         FyP9b3XGfyO9kuWaTq2+/wqxuJyrpL+sMgjLVcwLDzf7RlQqwnSjZaBRjg8jUhEh0FW3
         SO0j7rQJPsKIkfLncv4b15ruRH3j0UMbemMT/T87OIYSPk6AgzcZ8Tdl+YYjZ608E9yj
         By8MqC31oE5S9NRhgl514z7OQmxaC3yd7BmkFbqChJlyKDV3a3JiA75ndDb3Wk455wHf
         geQg==
X-Gm-Message-State: ANoB5plebBbuU2FGXUY67/eKNp/IeZ/poYNF2pJtLvNkkiXDNn1fzOdZ
        RIRTSd8oFrI+8Y0WPfQ3vIM=
X-Google-Smtp-Source: AA0mqf55iEPKMTM8rYkkBMvXmXuTTWn8Bn6Qbv943LOeswkMWLsn7QMVO86K/FxLztti9AurSm3DMA==
X-Received: by 2002:a05:6000:16c6:b0:236:6e66:3447 with SMTP id h6-20020a05600016c600b002366e663447mr20124174wrf.24.1669292808048;
        Thu, 24 Nov 2022 04:26:48 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id b10-20020adfee8a000000b00241dec4ad16sm1192350wro.96.2022.11.24.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:26:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyBHQ-00093z-24;
        Thu, 24 Nov 2022 13:24:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] ci: install python on ubuntu
Date:   Thu, 24 Nov 2022 13:23:05 +0100
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-4-worldhello.net@gmail.com>
 <221124.86edtspq74.gmgdl@evledraar.gmail.com>
 <CANYiYbEHXwXTpRiha+0SoO_7_6LrJ7iE5c-fc-uzp21+aXKgBQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CANYiYbEHXwXTpRiha+0SoO_7_6LrJ7iE5c-fc-uzp21+aXKgBQ@mail.gmail.com>
Message-ID: <221124.86a64gpmkb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> On Thu, Nov 24, 2022 at 7:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Thu, Nov 24 2022, Jiang Xin wrote:
>>
>> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> >
>> > Python is missing from the default ubuntu-22.04 runner image, which
>> > prevent git-p4 from working. To install python on ubuntu, we need to
>> > provide correct package name:
>> >
>> >  * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
>> >    "python" package, and "/usr/bin/python3" is provided by the "python=
3"
>> >    package.
>> >
>> >  * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
>> >    the "python2" package which has a different name from bionic, and
>> >    "/usr/bin/python3" is provided by "python3".
>> >
>> > Since the "ubuntu-latest" runner image has a higher version, so its sa=
fe
>> > to use "python2" or "python3" package name.
>> >
>> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> > ---
>> >  ci/install-dependencies.sh | 2 +-
>> >  ci/lib.sh                  | 2 ++
>> >  2 files changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> > index 291e49bdde..e28d93a154 100755
>> > --- a/ci/install-dependencies.sh
>> > +++ b/ci/install-dependencies.sh
>> > @@ -15,7 +15,7 @@ case "$runs_on_os" in
>> >  ubuntu)
>> >       sudo apt-get -q update
>> >       sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>> > -             $UBUNTU_COMMON_PKGS $CC_PACKAGE
>> > +             $UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
>> >       mkdir --parents "$P4_PATH"
>> >       pushd "$P4_PATH"
>> >               wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
>> > diff --git a/ci/lib.sh b/ci/lib.sh
>> > index a618d66b81..ebe702e0ea 100755
>> > --- a/ci/lib.sh
>> > +++ b/ci/lib.sh
>> > @@ -235,8 +235,10 @@ ubuntu)
>> >       if [ "$jobname" =3D linux-gcc ]
>> >       then
>> >               MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python3"
>> > +             PYTHON_PACKAGE=3Dpython3
>> >       else
>> >               MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/python2"
>> > +             PYTHON_PACKAGE=3Dpython2
>> >       fi
>>
>> Let's not copy/paste and repeat ourselves here for no reason. Part of
>> this is pre-existing, but if you just re-arrange these variable decls
>> you can do this instead:
>>
>>         PYTHON_PACKAGE=3Dpython2
>>         if test "$jobname" =3D linux-gcc
>>         then
>>                 PYTHON_PACKAGE=3Dpython3
>>         fi
>>         MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/${PYTHON_PACKAGE}"
>
> That was exactly my first edition, but I thought it was weird to write
> as "/usr/bin/${PYTHON_PACKAGE}". But if use two variables like
> PYTHON_BINARY and PYTHON_PACKAGE, looks even more silly. So I choose
> current solution.

I don't mind if you go for your inital version, it's not much
duplication, but why does it look silly? I don't think we need to worry
that the <package-name> on Ubuntu (and Debian) won't have a 1=3D1 mapping
to the /usr/bin/<package-name>. So defining the path in terms of the
package name seems like an obvious thing to do.
