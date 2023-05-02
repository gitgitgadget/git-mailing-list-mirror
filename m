Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A649EC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjEBVuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBVuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:50:09 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CF10FE
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:50:06 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1928ec49077so798459fac.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683064206; x=1685656206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCeAcOgsXNSPp6+3kZuTmvL0NiBzXjEOc4fPuHTTJqg=;
        b=gd4P+9HGho4+Af7BXrLF85j5RuI2Q8Y2G2iZwH6JRaxjeC3sfaPi2rRetccXizqy8Q
         fruuqbqAlQIcPnJl5bnTHwgmpPiW8qGC4gtFOYvlhKm6PoX2oGzU5lgXo7975wTIWRm0
         NLkokORlQ3LQRA/3n1cMa3d89FTvpOByf2fJw1yCt+Uw2XGB1WKTfMVHF9B9D3OqcQpX
         x3l5kL3geRLkT5aPah6gcWajvmvPlinBCeTO8cUbL5jNd/EG0BwjyxgRLBWYpJSW4xhb
         4FnYLzaxGDwFtqeWcujqVsecHgCR/yZ5ayO6uHGPL3g/dqJmGjaYEDQKxiiY7Z8IXZuq
         H4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683064206; x=1685656206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCeAcOgsXNSPp6+3kZuTmvL0NiBzXjEOc4fPuHTTJqg=;
        b=IJVdaie82jdAuOeVHJnlwT2zzUjHDV4Tk6sELLA+vHsdVMS+/oQbGeSjhKtwcDYZ1j
         lxXhQhi2ONcrs2VH+31JJ2QHlCns8nr3zoHD3+WpD5TKl+J6Cw6bKqAHgP+5f0lA4n/P
         R2zf3x9nW2iJsSL35ckRAkueQCAdVfa2ylTno6VMDzKtrSsz21I/d86SzqcicWoO49kH
         xqNb7yk4rJRt57uQ7ffFNIHG8zJIS69MOi2+F6mEcfYydPxcbJqayIXQhmpzAoD1GAML
         9mam3VifPPFlfjE3mVe6e4spbD2pa0CCcpMG7yDO+2YFPwKBFybHIxwz/xv02TSXtoUQ
         aNXA==
X-Gm-Message-State: AC+VfDxPugg8tRS0b0IHz6k/JkxT4OYB6lbbIKm1AIaC5IK1v9LkNYw3
        2XshNMbn12weZ8TwDOLptxs=
X-Google-Smtp-Source: ACHHUZ47wbJGd1FUAackGx4CRBANESEE33twzQtSDU59uveTSSEO8GbkhYLVj5kpZ1sp7E+rMUdpDQ==
X-Received: by 2002:a05:6870:5ab4:b0:192:6a53:a378 with SMTP id dt52-20020a0568705ab400b001926a53a378mr3151157oab.1.1683064206115;
        Tue, 02 May 2023 14:50:06 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z6-20020a056870e14600b0018b182ce317sm12657505oaa.55.2023.05.02.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:50:05 -0700 (PDT)
Date:   Tue, 02 May 2023 15:50:04 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        gitster@pobox.com
Message-ID: <6451858c41a39_200ae294c3@chronos.notmuch>
In-Reply-To: <871qjy31iu.fsf@gmail.com>
References: <xmqqh6t57x0y.fsf@gitster.g>
 <20230425162631.13684-1-maxim.cournoyer@gmail.com>
 <20230425162631.13684-2-maxim.cournoyer@gmail.com>
 <CAPig+cQ+6m35cTXr20-BNyHRsQQq2nTNERCH8N9NMsUP8Ct7mA@mail.gmail.com>
 <87h6t3pyn1.fsf@gmail.com>
 <645158de9d0d0_1ba2d294a6@chronos.notmuch>
 <871qjy31iu.fsf@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: extract execute_cmd from
 recipients_cmd
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> =

> > Maxim Cournoyer wrote:
> >> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> =

> >> > On Tue, Apr 25, 2023 at 12:46=E2=80=AFPM Maxim Cournoyer
> >> > <maxim.cournoyer@gmail.com> wrote:
> >> >> diff --git a/git-send-email.perl b/git-send-email.perl
> >> >> @@ -2,6 +2,7 @@
> >> >>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
> >> >>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
> >> >> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
> >> >
> >> > Let's avoid this change, please. Many people have worked on this f=
ile
> >> > over the years -- often making changes far more substantial than t=
hose
> >> > made by this patch series -- who have not staked such a claim.
> >> =

> >> I don't mind to drop this hunk if it's unwelcome/not current practic=
e.
> >
> > In most open source projects the practice is that only the top one or=
 two
> > contributors are mentioned.
> =

> I see.  I got used adding copyright lines from contributing to GNU Guix=
,
> which retains everyone's minimally substantial changes copyright notice=
s
> (if they wish), but that's probably not too common, given even the GNU
> maintainer's manual says [0]:

I would say GNU practices are not what most OSS projects follow.

> >> it's still enough of a change to be protected by copyright though, b=
ut
> >> I don't mind too much.
> >
> > My understanding is that your work is protected by copyright laws
> > regardless of whether or not a copyright notice exists. Not that it
> > would matter much in practice though, because the cases where copyrig=
ht
> > matters in open source projects is very fringe.
> =

> You are right; written works are automatically protected by copyright.
> I think copyright ownership would matter in case the copyright holders
> want to intent legal action against an entity violating the license of
> the Git project (GPL v2).  Hopefully that'll never be necessary.

Yes, that is one instance, but it only matters if your wishes contradict =
those
of the other copyright holders, that is: they want to sue, and you don't,=
 or
you don't want to sue, and they do. As long as your wishes align the thos=
e of
the other developers in the Git community, it doesn't matter.

Cheers.

-- =

Felipe Contreras=
