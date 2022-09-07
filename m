Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FEC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIGTMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIGTMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:12:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333BDBB932
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:12:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 145so15595594pfw.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=hpcDL1xddshb5+DzRGvgfDB+gPInG3DP+kbdhDo5lHw=;
        b=h1jHhMmeyaX94VHrt81fDKC5caOiOejIYQNSvJ9J5HNrHjlrOjrLnxEgY8kpjP5eoM
         VJoKtbNHniAj2op3C74gKOgeOQ+xGZVGHS0EOURYXcjdT6NXJEqAjy+MeHaOG/+tbKT6
         hx3DBJlx0BqdBYDGYqjs28S17eKYtzKy+a4txKTgjrdWfrGKpxE+Y/WvTt1JRooQo48O
         c0ImavLxNHZTh1nVqkGsN1YTMdwM2aSahxsavy6+Vje/rtHIMedf9R6ZGuJ5raSuHhr8
         A4wyUtl+jtfL91cpVsBQCA7XBfPpHrJr01YbPCSxQGJRshHHu49N7jdJdWgcBCNiEBRx
         qjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hpcDL1xddshb5+DzRGvgfDB+gPInG3DP+kbdhDo5lHw=;
        b=XvH9wUPsqI14ffC0fApQEuoZkdW9akE8IUjValY0fKH4CfIy3st/aEdjbIHKrIwF51
         te96duuER0luy+OLogcxYYv6AL6w8fZcHH7FI12IPorUmPV9cdRTKoWy66uhQfYBKUhe
         KFRC4CrW09hJHphawQ1vPJDJuy9lVFSpozR12DBVXW+N5DkvXFT6FoFqMRpMU3GfiVLH
         4xfCYrHBZg87JhzDxbdEB1Qx/ZJCWUXPil09VNw5LeYRDEV+X424A9BDcBH1Oc3qXQzO
         jsp0YeXnP/gl8HXiMHVs3LmrA/3kZhqk4AOl1wnWYVo79u6jELiv5+RSMNHFbJFczRp6
         DaiQ==
X-Gm-Message-State: ACgBeo3lz37eaxfoaSkPhHXcn5IY4JqTZDMtuHZ3a4zPl+XhVIC2EtMK
        doX00bTUCD3emx49ZaHMUDk=
X-Google-Smtp-Source: AA6agR5/RcEJ0MgmRrnVp+awR3stV7kEpUaD7BXjZdPVUSVkK0AyRsGYtwUs0bdR3Fi0gOIsjHECdQ==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr5522365pfc.0.1662577942590;
        Wed, 07 Sep 2022 12:12:22 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016f975be2e7sm12749096plh.139.2022.09.07.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:12:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/5] parse-options: minor cleanups for handling subcommands
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
        <20220905185007.9042-1-szeder.dev@gmail.com>
Date:   Wed, 07 Sep 2022 12:12:21 -0700
In-Reply-To: <20220905185007.9042-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 5 Sep 2022 20:50:02 +0200")
Message-ID: <xmqq5yhzuhgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The changes really are minor: the first four patches shouldn't alter
> behavior in any way, and even the last one touches only two error
> messages.

All of them make sense.  I especially liked the simplification of
"defaults to list" one.  "git notes list list foo" might change
behaviour but probably in a better direction.

Will queue.

Thanks.
