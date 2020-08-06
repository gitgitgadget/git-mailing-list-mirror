Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC143C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CBF20786
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=3v1n0.net header.i=@3v1n0.net header.b="NPVobwhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgHFRDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbgHFRB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006AC061A1E
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 05:13:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f24so29558779ejx.6
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=3v1n0.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3aNmwnszpPZknUedyDn6T2Bcas+O3oRxyJtcWAbOf1s=;
        b=NPVobwhL/LqUDK9W5pI/5zUeJo8gFLwvL9AqZiuGA9+ITp7973NhFxwNKnjJG2pvi1
         RTSrAyJNhLmhexdX6cafGGWrc8iYtex+ZSeGQsdC8mwWRaSCXCSz2rVg3nbpXrXdoqMt
         lukpxIIXMcXCyomqCIBAJqahwzT2OOy06G9hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3aNmwnszpPZknUedyDn6T2Bcas+O3oRxyJtcWAbOf1s=;
        b=fA4JMZB7t8SbcwnDehv6wbFPnyGbbo3f1QiezBlTAbHVEeuE90OCmUCVPUA6Cy4cS/
         ZxZ+ZzQypXCOMMJci3LXX2fl1f0CYvLma47NbMEPVnCA21rFj+WyvbzEcuLbz+w7qNT1
         eCGFCksmfPYSlXOROJDtHSQVmtQ4eYJJEMhqN8cyxM3cu3WDLSMdFNozfTncWuXnjYRs
         meXRrOIyq8LRz+LRR8Wsa++ZaZh4pS80JkLHfwfcVrIbPDOfgxAuLzloOcK6X1cHdqOY
         PxzOvamrY4pMPkFstpW4ruta76JMnxazOVVjuqtn7LI5fylqLlor/+t8gA73/VD+cNoe
         RNZA==
X-Gm-Message-State: AOAM532ezsLMMzX7V93FR4wkAezY2niqekUuXvgKXrposYo7pMaPkcEg
        5kxPK4+C8Z0tHmzqt7j9lm/y/fspV10=
X-Google-Smtp-Source: ABdhPJzVynvy8jrDl+B6FGA2IJoFcCaoYsvT3FTAuMaz2RVVGgpMV2a+3ITZS2Vc8tZMupQdQTlyOQ==
X-Received: by 2002:a17:906:1cd4:: with SMTP id i20mr3944213ejh.480.1596715997255;
        Thu, 06 Aug 2020 05:13:17 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id w12sm3382129edj.47.2020.08.06.05.13.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:13:16 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id m22so6944093eje.10
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 05:13:16 -0700 (PDT)
X-Received: by 2002:a17:906:1f08:: with SMTP id w8mr4192475ejj.535.1596715995861;
 Thu, 06 Aug 2020 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <66a026ae678341fe7e93a89e22f76e24282cebaa.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cR_04fL85nH1tJnbWYbwk3Bn5fRqzr2JReB2xXu9iUGAQ@mail.gmail.com>
In-Reply-To: <CAPig+cR_04fL85nH1tJnbWYbwk3Bn5fRqzr2JReB2xXu9iUGAQ@mail.gmail.com>
From:   =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Date:   Thu, 6 Aug 2020 14:12:49 +0200
X-Gmail-Original-Message-ID: <CAALaSckL5sKynGDRoqN7vd6cuXAvGwaDSyB4tVGXxZWGkNG_gw@mail.gmail.com>
Message-ID: <CAALaSckL5sKynGDRoqN7vd6cuXAvGwaDSyB4tVGXxZWGkNG_gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Il giorno mer 5 ago 2020 alle ore 22:58 Eric Sunshine
<sunshine@sunshineco.com> ha scritto:
>
> On Wed, Aug 5, 2020 at 3:51 PM Marco Trevisan (Trevi=C3=B1o) via
> GitGitGadget <gitgitgadget@gmail.com> wrote:
> > To list merge tool candidates we used to use a private GNOME env
> > variable (GNOME_DESKTOP_SESSION_ID) that has been deprecated for long t=
ime ago
> > and removed as part of GNOME 3.30.0 release [1].
> >
> > So, git should instead check the XDG_CURRENT_DESKTOP env variable, that
> > is supported by all the desktop environments.
> >
> > Since the variable is actually a colon-separated list of names that the=
 current
> > desktop is known as, we need to go through all the values to ensure
> > we're using GNOME.
> >
> > Signed-off-by: Marco Trevisan (Trevi=C3=B1o) <mail@3v1n0.net>
> > ---
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > @@ -266,6 +266,19 @@ run_merge_cmd () {
> > +is_desktop () {
> > +       IFS=3D':'
>
> We usually want to restore the value of IFS after we're done with it.
> For instance:
>
>     OLDIFS=3D$IFS
>     IFS=3D:
>
> and then restore it before returning:
>
>     IFS=3D$OLDIFS

Yeah, that's true and always a good practice, but it was never
happening in this file, so I followed the style.

> > +       for desktop in ${XDG_CURRENT_DESKTOP}
> > +       do
> > +               if test "$desktop" =3D "$1"
> > +               then
> > +                       return 0
> > +               fi
> > +       done
> > +
> > +       return 1
> > +}
>
> Rather than looping and mucking with IFS, even easier would be:
>
> is_desktop () {
>     case ":$XDG_CURRENT_DESKTOP:" in
>     *:$1:*) return 0 ;;
>     *) return 1 ;;
>     esac
> }
>
> But perhaps that's too magical for people?

Ok, fair enough, this is fine as well.

> > @@ -275,7 +288,7 @@ list_merge_tool_candidates () {
> > -               if test -n "$GNOME_DESKTOP_SESSION_ID"
> > +               if is_desktop "GNOME"
>
> Why do we need to retire the $GNOME_DESKTOP_SESSION_ID check here,
> thus penalizing people who might still be on an old version of GNOME?
> It doesn't seem like it would be a maintenance burden to continue
> checking it while also taking advantage of $XDG_CURRENT_DESKTOP:
>
>     if test -n "$GNOME_DESKTOP_SESSION_ID" || is_desktop GNOME

Ok, keeping this as well, it's even true that most people won't be in
gnome 2 these days, but not a problem to keep it around.

--=20
Trevi=C3=B1o's World - Life and Linux
http://www.3v1n0.net
