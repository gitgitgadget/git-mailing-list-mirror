Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE4DC43217
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiDPCIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDPCGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D436E04
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:03:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c10so12412139wrb.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QCgoSgnRVeo1mUvgAXteeYz2GEU69SdbVdygus/ZaLg=;
        b=GwdRQ2+gJ9c2xmkV6n1OmBXMfvjMB72ApPfY7tNmkbXd4b7FJtIEY+AMa14H0p85Vs
         lzPy2P5AO1KbvYEAH/eC9DhT3EOZW2pz1avJWVM0z1orogLdVrddRAJuDf5Lick9cUMW
         1B2k5mYGVOGwTtzh2tWp0+Hs+zLyK6ZBu5+mL6nR+dQcBSaYwKHEQWFy0NADKr4lcC0m
         KrGf/+1+uRFjdxUnPYTVIORqRd1ZygxdrgXeWvIq+iHt3XNdfS+i460GgIYbc/n0FZv3
         oQO1j/mrsj2t7F4H+km9z0ktc/+H0f9NOBNXBRkoqNOFLI7ABjP8IIrdckhgT+5gi5HG
         SFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QCgoSgnRVeo1mUvgAXteeYz2GEU69SdbVdygus/ZaLg=;
        b=Vzrdi+vauh3ye/WLsVbczIRnRXcCM71NVklgC0wlciEBNk1G6W2j8MWiduTKdqtifE
         8jOk9hC0QAwztlhEWpdYvzmW+kVNnzUDWVMsvjSy9xAvm57AR9sFG9IFvy6vBlIZ9qrK
         0yEUi75FA2SOjWHXSextVemL7goA/7RREsxteWtuobKLLZwdLki/PIk1fUutZMdTTpXF
         C8A5B1x0FB1rpy3K3lsROhxAyWOMCFZEiYj4kPn7cS0dD3/zL01nbUMXMZ522Lc116ln
         iwKRdK//kAJx7bTFJyYeYHYE8C9bvrAg8s6MPHLG4M6O2z60Yd+8vFlDRsf/z+cwQxkK
         oFXg==
X-Gm-Message-State: AOAM530LZw6x5mHNQ9KTHaAlkzQ/Y8MboGcWLb5WT6ymMXDo/QEmanxU
        +KgvcJVGTyEERbHTNJpznh0C0mvuuRKXxw==
X-Google-Smtp-Source: ABdhPJw77Tnt9zEf9vVgkaC2VcypP767FDHlDEbfpzivfFESYkeiGydKzYqyx0vBwPglxH7fv2eBeg==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr1655957edz.164.1650070793507;
        Fri, 15 Apr 2022 17:59:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906199700b006e874c0f5eesm2127337ejd.198.2022.04.15.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:59:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfWn2-005x6g-Hk;
        Sat, 16 Apr 2022 02:59:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood@talktalk.net
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
Date:   Sat, 16 Apr 2022 02:55:18 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-2-carenas@gmail.com>
 <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
 <CAPUEspgYU_797VSsdLWVqLXjSYsKfJhUb7M=jdouF01kHcKQyA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPUEspgYU_797VSsdLWVqLXjSYsKfJhUb7M=jdouF01kHcKQyA@mail.gmail.com>
Message-ID: <220416.86tuatalmf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Carlo Arenas wrote:

> On Fri, Apr 15, 2022 at 4:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Fri, Apr 15 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> > diff --git a/config.mak.dev b/config.mak.dev
>> > index 3deb076d5e3..335efd46203 100644
>> > --- a/config.mak.dev
>> > +++ b/config.mak.dev
>> > @@ -65,4 +65,9 @@ DEVELOPER_CFLAGS +=3D -Wno-uninitialized
>> >  endif
>> >  endif
>> >
>> > +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
>> > +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
>> > +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
>> > +endif
>>
>> What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 for
>> dir.(o|s|sp)?" was that you can set this per-file:
>
> of course, but that change goes in the Makefile and therefore affects
> ALL builds, this one only affects DEVELOPER=3D1 and is therefore more
> narrow.
>
> that is what I meant with "has been punted" in my commit message.

I mean it can go in config.mak.dev, it doesn't need to be in the
Makefile itself.

The make doesn't have any notion of "file scope" or similar, the
behavior is just a union of the variables, rules etc. that you source.

So just as we append to DEVELOPER_CFLAGS and the Makefile uses it we can
say "only append this to this file's flags", which since it's in
config.mak.dev is guarded by DEVELOPER.

>>         dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-ov=
erread
>
> I know at least one developer that will then rightfully complain that
> the git build doesn't work in AIX with xl after this.

Yes, it would break if it were in the Makfile, but not if it's in
config.mak.dev.

There it'll be guarded by the "only for gcc12" clause, so we don't need
to worry about breaking any other compiler.
