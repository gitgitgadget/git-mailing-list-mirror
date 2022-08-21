Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A4C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 16:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHUQMU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 21 Aug 2022 12:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHUQMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 12:12:20 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ACF1A051
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 09:12:19 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-324ec5a9e97so234901157b3.7
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 09:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Oz6VzFJHJPRSban1yd/X+65Ol90f3rjg6aYZptpOEPE=;
        b=3rbiZZbAQdlzPOguRf5teRNBkRJ8JI4QNSRaIJTi4g2uDBT4INVPuiIe6vy2FufVx2
         HTqevF3ETf5WXZMOY+YH/zJq0pdLewMLompBQK7kwEUR4g+CkzKyBZ8gt1OtO/TBitQy
         9ikrECqKRBEumFCV7BHfFjADgiDQUdpflucLs2v9blycgdm3wBmKqr/iiHMOiThkXep3
         vqCY1pL2A3yjvYjMu0sf2JyVB7Dm7E9R9Q3SXCXITEtD1X57t5BKH5lh0JHa/SVn9Tc0
         LrSFF9pnEGmF/wzz58BLvdPGWoUz3wkWHcjU+im4OVrsEZ34k/V4aZB2oEgMRzdRFuwA
         k0bQ==
X-Gm-Message-State: ACgBeo2HP5MXP49/tpWNAsBdG/vZVYuutzrHSMQ02uTrypyK+pWz+sEB
        xmiQhMK6WGb2uYUyd7tGP9zoQuYJ0Z78PfFf6zI=
X-Google-Smtp-Source: AA6agR72JZRObEIoT/ZzUALV/jWvDOWrwj+5EyizJOWS8zrbgBZKWpC+lfRkiSEBcj7pWiA1NW727KQRTCi3zZ/dhMY=
X-Received: by 2002:a0d:c807:0:b0:336:cac2:59eb with SMTP id
 k7-20020a0dc807000000b00336cac259ebmr15743686ywd.70.1661098337537; Sun, 21
 Aug 2022 09:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-17.32-fa2417c7a17-20220821T130231Z-avarab@gmail.com>
In-Reply-To: <patch-v3-17.32-fa2417c7a17-20220821T130231Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Aug 2022 12:12:05 -0400
Message-ID: <CAPig+cTB_ei+VKfOtHRAkhCRgzqT=aPkq91DUtfXmjkRtg6FDw@mail.gmail.com>
Subject: Re: [PATCH v3 17/32] submodule--helper: don't redundantly check "else
 if (res)"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2022 at 10:00 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The "res" variable must be true at this point in update_submodule(),
> as just a few lines above this we've unconditionally:
>
>         if (!res)
>                 return 0;
>
> So we don't need to guard the "return 1" with an "else if (res)", we
> an return unconditionally at this point. See b3c5f5cb048 (submodule:

s/an/can/

> move core cmd_update() logic to C, 2022-03-15) for the initial
> introduction of this code, this check of "res" has always been
> redundant.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
