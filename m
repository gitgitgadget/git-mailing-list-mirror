Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C45C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJSUPE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Oct 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJSUPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 16:15:02 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D825208A
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 13:14:58 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id y80so15474491iof.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 13:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpSs2Xi22QI1VdLQzKptS0nDxeatOKslZhrbhNn5z0s=;
        b=tP1Sp/y2/hsUvPMRXOKJyq/14NPmbUU8hBPevLunFhoG8O0ZSHHINKEwJSsnOhIQQR
         m6D64JTXD6lSYcTaHBGDhYSMjdQh2eyPSaxQrdY0Z91l2/pwB1s5ve5NxvNyfWg3/Dsk
         tnhU9osrbzVntlTLmBFy/XAGJO1H/fZnOj3p6v/USRNrQdhVBnGBxV66sWmdBkd78y1t
         UVxvzVmasEakDCGwF8Ba6Hgms/B8RVClB7r/oIsW1pja2bEkNpnqcgrQYyJz/vq2QxFV
         c5H4GnZY9MjVDO5wVhImEc7zl2QunF7cUje98+1tG57R+AizNczthemcsFgoQUMRl+5H
         svGQ==
X-Gm-Message-State: ACrzQf3rYiunHJtowoqABm7Yxm/MfSxr8YZB41Hgaz/LtUFUR1I4vaHK
        XBOH8Wwr9ePnpYoXgwDOMsVk8n4TKZ7PCho1oIiEGpSk5Sw=
X-Google-Smtp-Source: AMsMyM72Ko2ilTmBurvVlKi4LnCZyqBTZDgLeL0lE9hCulbINPryiDJb5DyfSzThP9jQi2XzQUH5ffJBhgUX/Y+T1hM=
X-Received: by 2002:a05:6602:154f:b0:6bc:f701:cb37 with SMTP id
 h15-20020a056602154f00b006bcf701cb37mr7338646iow.136.1666210497406; Wed, 19
 Oct 2022 13:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g> <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221019.86bkq8hake.gmgdl@evledraar.gmail.com> <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
 <221019.8635bjhbds.gmgdl@evledraar.gmail.com>
In-Reply-To: <221019.8635bjhbds.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Oct 2022 16:14:46 -0400
Message-ID: <CAPig+cSCb6tA+Ox=xK+LuC+Hf=JRRBr3=xx9cJ0yQaguHm+HSQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 3:16 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Oct 18 2022, Eric Sunshine wrote:
> > On Tue, Oct 18, 2022 at 9:22 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> In practice we've been catching SHA-implementation specific code early
> >> because the OSX implementation was different, but in this case it's
> >> OSX-only code, so it only supported the Apple Common Crypto backend.
> >
> > I don't know how germane it is to the current thread, but previous
> > discussions[1,2,3,4] favored dropping use of Apple's Common Crypto
> > altogether since it doesn't seem to buy us much (or anything) and is
> > incomplete; it doesn't support all of the OpenSSL API Git uses.
>
> Yeah, maybe. I'd be 100% OK with that happening, but I don't use OSX
> outside fo CI really, so I wanted to avoid scope creep to "non-SHA stuff
> we use OpenSSL/AppleCommonCrypto/whatever" for, in the cases where we
> can/do use OpenSSL/AppleCommonCrypto/whatever for SHA also.

Indeed, I was not suggesting that retirement of AppleCommonCrypto be
tackled by you or by the series you posted to fix the build failure;
doing so is well outside the scope of the immediate problem. I brought
up those old discussions only as reference and as a pointer that
whatever fix is eventually adopted for the immediate build problem
need not necessarily bend over backward for AppleCommonCrypto support
if a long-term goal is to drop AppleCommonCrypto (i.e. do as little as
necessary to keep AppleCommonCrypto in a working state, but don't go
overboard trying to give it first-class support since it will never be
a complete replacement for OpenSSL).

> But if you/someone can come up with a patch that confidently asserts
> that it's useless & drops it I'd be happy to either integrate it &
> submit it as part of this series if it makes things simpler, or
> alternatively re-roll on top of it.
>
> I'm just not confident in making that case myself, since I hardly use
> the platform, am not too familiar with the various concerns (aside from
> skimming the links above), and don't really have interest in pursuing
> that.

I was not suggesting holding up your series or integrating retirement
of AppleCommonCrypto with it; they are separate concerns.

> OTOH if you do want to make the case for dropping Apple Common Crypto
> that would also presumably be much easier after this series, once we're
> past justifying the hurdle of "wait, we're switching the thing we use
> for SHA-1 by default, which we build practically everything in git on?"

My "don't know how germane it is to the current thread" observation
was in response to the `fsmonitor` thread, before I ever saw the
series you posted for fixing the build failure, so it wasn't given as
any sort of feedback on your series, and wasn't asking you to
incorporate retirement of AppleCommonCrypto into your series. That
said, it does appear that dropping AppleCommonCrypto should become
easier after your changes land if someone opts to tackle the task.
