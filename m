Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667DC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDPMuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDPMuH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 08:50:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187AD40E4F
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:47:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so19579157ejb.4
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WKE8pZomuiE/SxUSGAm3plkyaJ7vv64ZjA5aRGow4J4=;
        b=fmv5z3kbSX0HwVi7kDYNibwAEJ+5OrD7TGlDOiqLeUewhfwiLqy/gMuusg+Cr7yksc
         YtLCiIYg32GWutJSTH0mqx3bfZpin0LjitgrKdiiIitHtGRk5RFN+U9+5jEQvVhsSH5i
         XVkKykLSGOTZeuhs/RBJ4N6fQX7/Xg26NmsuTFS/3NkiGgt+RFXf7CWHfzD2Rw9tw1pX
         yp2r6kqHPuIssk1WaGauZw89VAisZcQm6PvlgHcr9EqaAfWEDdXXBw5AX+B2EdrIQtGJ
         nERtX5nIxSyym7XYNzBNojHKAGlzvY57WIRJ+6GaiW3HHVLOHUKPbCfZJstzAs/rHw+t
         u6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WKE8pZomuiE/SxUSGAm3plkyaJ7vv64ZjA5aRGow4J4=;
        b=5uvWCEPjj6321ErwgqL3QabVFlujkJ4DLHOEwNEbhGHPNk22kvybNAtozHBG6S7g3l
         T+Vsbz91c5ewxOf3LHPFeSyA2+Pl6NYQhF5SICk9+pqQABslse4omNij9gq7rvqsRHNY
         vel1OQ286bcfuHheeue7wkRlNR/Mnco9Kp4LI6IcrcHagBj8qzHAnCplxMJm2dTUYHsZ
         CzLqhyofOCzW3voEKjmuESh1iea1S57P+SsO9H25q25Pv1RdDcpq9ur/NgG1+LV+UIvB
         Q5sz3qFGViwDHxOcfwVDvOQLLgkAGElYJdURGPsadN+lKpXBZrhXO0MURRbeKcDKxLKm
         I8NA==
X-Gm-Message-State: AOAM530ks9FNMLKeg/1oEUJ3ZQWfiBkESRhvQ4tqF0+0uma9/fzGIkLc
        G1VLOHmNVoHN+l8SSzKla/g=
X-Google-Smtp-Source: ABdhPJxSCWjBrpob/3jxZh6WjsvGq5lR0wT/bsg4600tA+bGuU2jQWaJUiuyfQMXG6XSdP/fRkOFgA==
X-Received: by 2002:a17:907:3e8b:b0:6e8:c7b7:a3c3 with SMTP id hs11-20020a1709073e8b00b006e8c7b7a3c3mr2715989ejc.337.1650113253089;
        Sat, 16 Apr 2022 05:47:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y26-20020a1709063a9a00b006e0c272e263sm2662197ejd.71.2022.04.16.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 05:47:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfhpr-006FS9-Vf;
        Sat, 16 Apr 2022 14:47:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
Date:   Sat, 16 Apr 2022 14:33:09 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-2-carenas@gmail.com>
 <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
 <CAPUEspgYU_797VSsdLWVqLXjSYsKfJhUb7M=jdouF01kHcKQyA@mail.gmail.com>
 <220416.86tuatalmf.gmgdl@evledraar.gmail.com> <xmqqo8117er2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo8117er2.fsf@gitster.g>
Message-ID: <220416.86czhh9ov0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Apr 15 2022, Carlo Arenas wrote:
>>
>>>> > +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
>>>> > +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
>>>> > +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
>>>> > +endif
>>>>
>>>> What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 for
>>>> dir.(o|s|sp)?" was that you can set this per-file:
>>>
>>> of course, but that change goes in the Makefile and therefore affects
>>> ...
>> I mean it can go in config.mak.dev, it doesn't need to be in the
>> Makefile itself.
>> ...
>>>>         dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-=
overread
>>>
>>> I know at least one developer that will then rightfully complain that
>>> the git build doesn't work in AIX with xl after this.
>>
>> Yes, it would break if it were in the Makfile, but not if it's in
>> config.mak.dev.
>
> I do not think you can blame Carlo for poor reading/comprehension in
> this case---I too (mis)read what you wrote, and didn't realize that
> you were suggesting to add the "for these target, EXTRA_CPPFLAGS
> additionally gets this value" inside the ifneq/endif Carlo added to
> hold the DEVELOPER_CFLAGS thing.

Indeed, I don't think I would have understood myself, I didn't mean to
imply any fault (except my own for not elaborating). Just claifying that
we can use that trick.

I.e. my own config.mak has had this (or a form thereof) for a while:

	http.sp http.s http.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Ddangling-pointer=3D
	dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-overread=20

> For now, let's stick to the simpler form, though.

Sure, works for me.

Note though that one important difference between this solution and the
patch I had for http.c is that the patch will fix things for all builds,
whereas a config.mak.dev change (whether it's Carlos's global addition,
or my per-file) can only do so for cases where DEVELOPER=3D1.

Although in practice that's probably fine, anyone turning on -Werror is
likely to do so through DEVELOPER=3D1, and fore those that don't it's
"just a warning".

So yeah, it's probably better to do that for now.

But FWIW I did write up and test the below monstrosity as a replacement
just now, it's guaranteed to work with/without DEVELOPER, and squashes
only that specific warning, and only on GCC:
=09
	diff --git a/dir.c b/dir.c
	index f2b0f242101..e7a5acb126f 100644
	--- a/dir.c
	+++ b/dir.c
	@@ -3089,6 +3089,13 @@ char *git_url_basename(const char *repo, int is_bun=
dle, int is_bare)
	 	 * result in a dir '2222' being guessed due to backwards
	 	 * compatibility.
	 	 */
	+#ifdef __clang__
	+#elif defined(__GNUC__)
	+#if __GNUC__ >=3D 12
	+#pragma GCC diagnostic push
	+#pragma GCC diagnostic ignored "-Wstringop-overread"
	+#endif
	+#endif
	 	if (memchr(start, '/', end - start) =3D=3D NULL
	 	    && memchr(start, ':', end - start) !=3D NULL) {
	 		ptr =3D end;
	@@ -3097,6 +3104,12 @@ char *git_url_basename(const char *repo, int is_bun=
dle, int is_bare)
	 		if (start < ptr && ptr[-1] =3D=3D ':')
	 			end =3D ptr - 1;
	 	}
	+#ifdef __clang__
	+#elif defined(__GNUC__)
	+#if __GNUC__ >=3D 12
	+#pragma GCC diagnostic pop
	+#endif
	+#endif
=09=20
	 	/*
	 	 * Find last component. To remain backwards compatible we
	diff --git a/http.c b/http.c
	index 229da4d1488..e63d4ab9527 100644
	--- a/http.c
	+++ b/http.c
	@@ -1329,7 +1329,21 @@ void run_active_slot(struct active_request_slot *sl=
ot)
	 	struct timeval select_timeout;
	 	int finished =3D 0;
=09=20
	+#ifdef __clang__
	+#elif defined(__GNUC__)
	+#if __GNUC__ >=3D 12
	+#pragma GCC diagnostic push
	+#pragma GCC diagnostic ignored "-Wdangling-pointer=3D"
	+#endif
	+#endif
	 	slot->finished =3D &finished;
	+#ifdef __clang__
	+#elif defined(__GNUC__)
	+#if __GNUC__ >=3D 12
	+#pragma GCC diagnostic pop
	+#endif
	+#endif
	+
	 	while (!finished) {
	 		step_active_slots();
=09=20
But yeah, between us not having -Werror by default and DEVELOPER
handling it it's probably not worth it just to be able to selectively
suppress the warnings involved.
