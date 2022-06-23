Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA1C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 01:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiFWBMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFWBMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 21:12:30 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D042EF5
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 18:12:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so14356491otg.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Z6SFaRDA9gPrYj6sX5klXUDT8mO+M0G44NhHC/tDy4=;
        b=cCU5z4GEV0VSg1tj1ny2bHTNp2LE57KqQYYKV3KkACZqQadxjW9NSIxzOchTaJ8n2t
         XaeypawHPf2wEYd4yFeiriQ7wm+P8Ypp+sPoch2//bajkj+hOBMAwEMYVm32MjkLTco1
         OxrBKNpgdK1spEROxMcECfrj9fDh6c6xxbIH8xHYckVdY0N02b0bbNVGfVUfwH3xvKSy
         aiPJNNRNeEkj5VBKP5Yq/3ScN824O12+hAnMr6MlFtveS0gyupjpUpBNdd+mWtITk9p/
         BvLR/9+MURKx0hCkGxWmrkclDHdVO0CNWjt9oF8J92Gg1LWBY1WyJoFeGSG5S8+4RD/J
         TqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Z6SFaRDA9gPrYj6sX5klXUDT8mO+M0G44NhHC/tDy4=;
        b=vLD5nXUril3s4kbJcaiaDq57e0ILNLXmapa3TH2tKsd7nB8kvM+iglLXSr7NBJYoq3
         /CpLJSpSJJvJkR6hdUHvCA8dmj09ut1eNyiHAPS2tO1ZX7j8KoaOgMq7t1x0PGXRpJKe
         XvlX98ieU2rTQeQ1GjqWKXdEEV1w7y0RUSyEErOVJ10k69jYIYJfdfRDcBwcTR4ylm03
         kksJ+BDWFeo3PBrgbTpOYVUvaxR8EvOqTpA3WjOrSEZh6VISThDqYgq5+3xGPQ303TWK
         GtFbPOw7R08DkFoc3BksxhuqMXf/y0mQeFEAacSAt8D4kBjw46lI4NzRas/k1fydSCvs
         dR5Q==
X-Gm-Message-State: AJIora9MhmeAlKWXLwtQI57MfnLIv32aSC4wlNPFTNZM3ryGm88QYn7X
        T4DFiwud5VfHWDFyyR/Fvw5yGVEbfMPAYp5MpMQ=
X-Google-Smtp-Source: AGRyM1uRYEpZxS9TyhqBDSTFvNIhFnGRmIkNtjtDBvaVAdaHKduQeiVZ7EgUAr2EqHAC9mf6ZA17NHybljMfHTgxvKo=
X-Received: by 2002:a05:6830:200e:b0:60c:2cbb:2fb5 with SMTP id
 e14-20020a056830200e00b0060c2cbb2fb5mr2705398otp.377.1655946748579; Wed, 22
 Jun 2022 18:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220614112858.16576-1-worldhello.net@gmail.com>
 <CAPv0VGvKFEbVzZEdn+eb-4Bb9KfQWCa=pM3iC_Dyu-6AKGCcug@mail.gmail.com>
 <CANYiYbGWoMpCOA43k=5a_kio2thf91BV69nfSySwhHZbbMOSkg@mail.gmail.com> <7df7a2fe-386d-c996-b783-8c95fb78b0ea@softwolves.pp.se>
In-Reply-To: <7df7a2fe-386d-c996-b783-8c95fb78b0ea@softwolves.pp.se>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 23 Jun 2022 09:12:16 +0800
Message-ID: <CANYiYbFnQLy3vsSiqYCxAb+Qqh5eUwKC7pdBQCa3d+EdbLy66Q@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.37.0 round #1
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     =?UTF-8?B?VHLCpW4gTmfDt2MgUXXDom4=?= <vnwildman@gmail.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 10:26 PM Peter Krefting <peter@softwolves.pp.se> wrote:
>
> On Sun, 19 Jun 2022, Jiang Xin wrote:
>
> > You forgot to remove file-location comments in "po/vi.po".  If you
> > send me pull request on GitHub, a CI workflow will be triggered to
> > execute the command below,
>
> Is that why the sv.po pull request is also standing still?

You may already notice the error report from the CI pipeline in the
PR[1], you should:

 1. remove file-location comments from "po/sv.po".
 2. update your translation based on the master branch of
     "git/git" or "git-l10n/git-po" repository.

After you fix all the above errors , and there are no more l10n
updates upstream, like 2.37.0-rc2 is released, I'll merge your PR.

[1]: https://github.com/git-l10n/git-po/pull/640

--
Jiang Xin
