Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63256C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4133B20829
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="K0ySjL6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHNIeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 04:34:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB27C061383
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 01:34:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so4417406lfi.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CIPyz0cvh+aOb6zo9kTrzYRuJXEEoIGhpOq4/N27ziQ=;
        b=K0ySjL6g2GK5UfsMaeUIAyG51jxqUamdEBZdgp+/kRfUGAPVWZ/xfCd/sZCA8qihUF
         T18VKj1gA+sAq8dvQ3yIzCNKTPsg5vCC/sGfvPW2iYKrYcOdFMh8cL+5fsz5QuRuHTKq
         YiVJ4swrAWbrk1tDbUw2XPp4WyWF1eiAPtZdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CIPyz0cvh+aOb6zo9kTrzYRuJXEEoIGhpOq4/N27ziQ=;
        b=gay/4B8d+RA0nWbUH9WNHrx+iVeoh63FcxVjYd8L3IeyTiu9/j8wFpMgjcKR9GqQJM
         KqBMEMTHQFPGExgNdDbooh2e+ri7YUacDttTqjDZU86239V+I+/wbmCgUKahFyQvtVeM
         rTRhG00XiHOvlJyAHugP9r8LBJ2wmBgvpIGD8AbDskLSWSf3TdGOT+4NHTc1pkwYkr2Z
         tnZhWHXjiFs4B8PXBGjzST9qFscn1ktN1f1peAbvFuts6Bf7PjIHF6Z6MSRwUqFUGMX7
         2j/3BUjrGvr4XjBVRThbr7mGbbh2VQ3qsr5wg4Qe8eR3B04fGZcVtWLOCpE3zz/hhJjn
         j6gQ==
X-Gm-Message-State: AOAM5303itvVE32J5gtAkBH+JWRoHEl7Igsu8I0xNFRAZAhG3T9OoGOl
        7Y484E6UCMINYew9v0QSxHkp9OB3W5+n74r/
X-Google-Smtp-Source: ABdhPJyCcvRCNyvOugSWtqKeBB7AtNABnCNweeM+mYbKAWq4NBsjECDxyUa2a6ShVk8/xk+UcraiDw==
X-Received: by 2002:a19:8c4b:: with SMTP id i11mr750397lfj.32.1597394047841;
        Fri, 14 Aug 2020 01:34:07 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q189sm1612951ljq.68.2020.08.14.01.34.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 01:34:06 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y2so73222ljc.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 01:34:06 -0700 (PDT)
X-Received: by 2002:a2e:810c:: with SMTP id d12mr807915ljg.34.1597394045966;
 Fri, 14 Aug 2020 01:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
 <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com> <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
From:   Alexander Ost <ost@ieee.org>
Date:   Fri, 14 Aug 2020 10:33:55 +0200
X-Gmail-Original-Message-ID: <CAGNCYk2Mc83wsX1FRQZe9kCDFAN1OM6F8_pJ29CWWCoQ0Hf_Qg@mail.gmail.com>
Message-ID: <CAGNCYk2Mc83wsX1FRQZe9kCDFAN1OM6F8_pJ29CWWCoQ0Hf_Qg@mail.gmail.com>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I'll check it out.

Created a git-gui bug report (#41,
https://github.com/prati0100/git-gui/issues/41).

On Thu, Aug 13, 2020 at 11:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Aug 12, 2020 at 4:16 AM Alexander Ost <ost@ieee.org> wrote:
> >> Despite installing with `make NO_INSTALL_HARDLINKS=3D1 install', the
> >> installation process tries to create hard links, and the installation
> >> fails (a quick workaround is `sed -i git-gui/Makefile -e "s/ln /ln -s
> >> /g"').
> >>
> >> make NO_INSTALL_HARDLINKS=3D1 install
> >> ln: failed to create hard link
> >> =E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-cit=
ool=E2=80=99 =3D>
> >> =E2=80=98/filesystem_without_hardlink_support/libexec/git-core/git-gui=
=E2=80=99:
> >> Operation not permitted
> >
> > Indeed, it appears that the git-gui Makefile does not respect
> > NO_INSTALL_HARDLINKS. The git-gui project is maintained and developed
> > outside of the Git project (even though it gets bundled with Git), so
> > it has its own issue tracker. It would probably be best to re-submit
> > this bug report there:
> >
> > https://github.com/prati0100/git-gui/issues
>
> Thanks.  Perhaps something along this line (which is totally
> untested), as the top-level Makefile already exports
> NO_INSTALL_HARDLINKS to submakes?
>
>
>
>  Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f10caedaa7..1cdbf8e504 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -44,6 +44,11 @@ endif
>  ifndef INSTALL
>         INSTALL =3D install
>  endif
> +ifdef NO_INSTALL_HARDLINKS
> +       LN =3D cp
> +else
> +       LN =3D ln
> +endif
>
>  RM_RF     ?=3D rm -rf
>  RMDIR     ?=3D rmdir
> @@ -57,7 +62,7 @@ INSTALL_X1 =3D
>  INSTALL_A0 =3D find # space is required here
>  INSTALL_A1 =3D | cpio -pud
>  INSTALL_L0 =3D rm -f # space is required here
> -INSTALL_L1 =3D && ln # space is required here
> +INSTALL_L1 =3D && $(LN) # space is required here
>  INSTALL_L2 =3D
>  INSTALL_L3 =3D
>
> @@ -87,7 +92,7 @@ ifndef V
>         INSTALL_L0 =3D dst=3D
>         INSTALL_L1 =3D && src=3D
>         INSTALL_L2 =3D && dst=3D
> -       INSTALL_L3 =3D && echo '   ' 'LINK       ' `basename "$$dst"` '->=
' `basename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
> +       INSTALL_L3 =3D && echo '   ' 'LINK       ' `basename "$$dst"` '->=
' `basename "$$src"` && rm -f "$$dst" && $(LN) "$$src" "$$dst"
>
>         CLEAN_DST =3D echo ' ' UNINSTALL
>         REMOVE_D0 =3D dir=3D



--=20
--=20
Dr. Alexander Ost            | email: ost@ieee.org
Performance Consulting       | fon:   +49 (0)241 51859-230
Jahnstr. 11 / D-52066 Aachen | mobil: +49 (0)178 5431550
