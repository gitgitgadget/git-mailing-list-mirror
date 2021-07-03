Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88973C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614F8616EC
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhGCS7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCS71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 14:59:27 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27711C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 11:56:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so13760634otk.7
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=J0qo2Cf8uvGPSkHXZPzuBWVLAAhtEv/7CvObB+gXduM=;
        b=VoMZNCLhyX1wZfJ8oDusgdoY2m227jIF9nu3G4t3yVaiwQj0qoYQtAJGt62djeDABw
         GWsHvtvCotirAkx2//NKt32ODpXvi1imMhG8nB3LgsDzfvA+6qoxgZUApe5i78PvdjCd
         HnC+/jSKO0jYsFfvpCoYDcrYVA/uowAO6LdMJJIziw9VVVfVbKeYXlfbNJoSkjYUJRB7
         EECHdP3kDVaIIKv5CGun1k6LilVZJuIV2V0HtNG9NqDLH+uQU6ktpjU985bwalUoEq76
         j+HLIIqkkqUbbuzn5Mb7jnF2iMc/FpLY3nGCVHW0XkHiSAbXcDWTlHiFbuvpyFwxd5W+
         v9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=J0qo2Cf8uvGPSkHXZPzuBWVLAAhtEv/7CvObB+gXduM=;
        b=YaI9lcH5g52lSHRHxhWeAyfSx+Cr+T6v2D0VF0pi8Ove8zbw1TS0n1MF1T/Z18Aq+7
         IO45pPFM9vDhRaMX7TrrEFoeQcMu9rOWFFyZs9FlfM8MWwjOLMo9tzPzNk6FNRev1lQH
         IIw2oSwq5zPGGljl8HDzjub1cl+XyZk7AAtPCthSXNFLgrXinGEMTges74pAC569Iu3A
         Bxp+P6lSiWGXujr8Yein3IXe4rA0E3JeJtg/70XOH/16aDnWEDuVcJX2aMWwIWSVgN/U
         seQgeLxW79kAj0GuI1Xx1zZo4uBJHJ5pB3yEYXs55PIOkCMJUAO0JC/V8lhKeCA0aaMT
         vUbA==
X-Gm-Message-State: AOAM530ba2JYDQfRQvM3Guix/Uo33zq71vGVMoLLXrRXOEJjBBrq+Z4J
        A5QRfxWIVkQbz2KH3OJl3Uw=
X-Google-Smtp-Source: ABdhPJyd4WKVgTqgE5UnAv8VKPv7ttrPzwC1a0JFpMo9VOSWZnh/1DAdtSZrbbxVOZ5zRNYxrUenfg==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr4610828oto.227.1625338612591;
        Sat, 03 Jul 2021 11:56:52 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x30sm1461827ote.44.2021.07.03.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 11:56:52 -0700 (PDT)
Date:   Sat, 03 Jul 2021 13:56:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>
Message-ID: <60e0b2f2f198d_2f72081c@natae.notmuch>
In-Reply-To: <87mtr38tvd.fsf@evledraar.gmail.com>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
 <60dfb7d11cac3_3dd220811@natae.notmuch>
 <87mtr38tvd.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, Jul 02 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)=

> >> we've been eagerly re-building the documentation whenever the output=

> >> of "git version" (via the GIT-VERSION file) changed. This was never
> >> the intention, and was a regression on what we intended in
> >> 7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation=
,
> >> 2007-03-25).
> >> =

> >> So let's add an ASCIIDOC_MANVERSION variable that we exclude from
> >> ASCIIDOC_COMMON. The change in 9a71722b4df was only intending to cat=
ch
> >> cases where we e.g. switched between asciidoc and asciidoctor, not t=
o
> >> undo the logic in 7b8a74f39cb and force a re-build every time our HE=
AD
> >> changed in the repository.
> >
> > Once again, why do we care that the version is 2.32.0.98.gcfb60a24d6 =
and
> > not 2.32.0.97.g949e814b27?
> >
> > Not just in the documentation, but everywhere.
> =

> It's useful e.g. on my Debian system to see that the "next" Debian
> packaged is 2.31.0.291.g576ba9dcdaf in docs & "git version", arguably
> less so for documentation.

Obviously packagers would use real versions I meant this only for
developers (e.g. DEVELOPER=3D1).

And BTW, where is that Debian package coming from? I thought
distributions didn't package git pre-releases.

> > Maybe we can add a GIT_RELEASE variable that unlike GIT_VERSION it
> > doesn't contain the precise commit. For example GIT_RELEASE =3D 2.33-=
dev.
> =

> I just added this to my pre-make script:
> =

> 	grep -q ^/version .git/info/exclude || echo /version >>.git/info/exclu=
de
> 	echo $(grep -o -P '(?<=3D^DEF_VER=3Dv).*' GIT-VERSION-GEN)-dev >versio=
n
> =

> It makes use of GIT-VERSION-GEN picking up a tarball "version" file.

This would also do the trick (you need DEVELOPER on the environment
though).

--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,9 +6,10 @@ DEF_VER=3Dv2.32.0
 LF=3D'
 '
 =

-# First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
-if test -f version
+if test -n "$DEVELOPER"
+then
+       VN=3D"$DEF_VER"-dev
+elif test -f version
 then
        VN=3D$(cat version) || VN=3D"$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&


-- =

Felipe Contreras=
