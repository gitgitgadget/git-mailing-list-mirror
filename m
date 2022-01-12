Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C655EC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbiALGbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiALGbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 01:31:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE06C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 22:31:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g11so4636815lfu.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRSoUm6BgQyAOxFGAc/0YB+JKKdyWYYDxs9Qx2uTaRs=;
        b=KAvwVXHpVL3Hx/yAP4uWJJOEa0d6ge2K0HvQ62KGAlA4+oDnp7r9meMJDaTrb61O/V
         FrkhVRiJ1nNINTFAOKy+CZIoqyaR21a7zuOcrbHmQyOc7Zdc0LEXn1XWnmm8rUUx/WRm
         BnjGGiEVtfNEgqAt4G9z3A0Xeq1jE2P6Y3zK+ABbT08vzrloDuvX4fKhqEle+g4P6rKU
         YmPDt323xik67Gi8nwBUMsrFYyaukHZHbMgZf1W7RjoYmFnJwfYOnP1jOravT2Ebdv1d
         c1LtW9sYQV5okLLG169UrBI/n0pYuMoNETwLVG/wqCG3o4NHfarc3+q90jAJygbTredj
         UoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRSoUm6BgQyAOxFGAc/0YB+JKKdyWYYDxs9Qx2uTaRs=;
        b=15SfA1HPQXQL/lm/O5AgsqXJn459Xo9Ssrof4Prq7DA3TifgcHxe3bSwNQVWHrnmsH
         P53gkWQrg38GCHfaOfqPP25W/0KWiMpuymWTy6fJqstmhP47zOVOXEB9p3bWiqqYU9yB
         UJqJc4Y4yoE3INUaMDHymR83FlvgBVDg9E9XKiOEyE23e0nyYmx1suePtXbXKgsy4BJw
         FByPs9OSXMroVSaTTG/2+60K3XxhcjQJNSJg6yRjdKRfiRutOtRNntI0yDNjpNB10j2t
         cCDTGbJbNYH/6P8G8f4n/B37EnWdpOLX6APP42gf+E5wusoOmdIkvCSr8lGKWWUbc3Kv
         VfxQ==
X-Gm-Message-State: AOAM533orEDvOEH5WMiWoB90CAPSNrCfYKlJY5RCeXQZZF46rYjBBr+9
        1yU6MAoXZ77XlXmnLhtDxgZF8fzMSXpivimz5Io=
X-Google-Smtp-Source: ABdhPJwV8wTUBvgGcXZY5Ee+PknW100xoqnlbPk77sPB3Gmxjzw2nNtkc33x8erNQf15jIzUlXRGZZLhkBZndA3ooXE=
X-Received: by 2002:ac2:58c2:: with SMTP id u2mr6180414lfo.66.1641969104777;
 Tue, 11 Jan 2022 22:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-9-andersk@mit.edu>
 <CANYiYbHBjM-1oezX_1Z+te+wvQpdj=rwggHHCLPepos_Njwqvw@mail.gmail.com>
In-Reply-To: <CANYiYbHBjM-1oezX_1Z+te+wvQpdj=rwggHHCLPepos_Njwqvw@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 12 Jan 2022 14:31:33 +0800
Message-ID: <CANYiYbGdUE_NQFTA31EnEr57E00umfJQoUPMc=OZ3snO+GWZ=w@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] branch: protect branches checked out in all worktrees
To:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 23, 2021 at 8:58 AM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> On Thu, Dec 2, 2021 at 6:16 AM Anders Kaseorg <andersk@mit.edu> wrote:
> > +       if (wt && !wt->is_bare)
> > +               die(_("cannot force update the branch '%s'"
> > +                     "checked out at '%s'"),
>
> There is no space between "'%s'" and "checkout". Found this from [1],
> sorry for reporting this is a bit late.
>
> [1] https://github.com/git-l10n/git-po/blob/pot/master/2021-12-22.diff#L315

This issue was still there in git v2.35.0-rc0. Peter Krefting and Emir
SARI also reported this issue in pull requests:

 * https://github.com/git-l10n/git-po/pull/599
 * https://github.com/git-l10n/git-po/pull/600

I see Bagas has sent a patch for this:

 * https://lore.kernel.org/git/20220111123627.58625-1-bagasdotme@gmail.com/

--
Jiang Xin
