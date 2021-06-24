Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D3C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E04613E8
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFXI0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhFXI0I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 04:26:08 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF74C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 01:23:49 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i12so5223876ila.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fRhR+KVcZVBHcSVRoQDeiPQZ3Aa05yhqFwNwgAtnKG0=;
        b=r44GzXwVilPsQp6q2O+H8S6lv2RTu+vEvwSS0nbW+j0kppdb/anah5eXo+xVuhXRab
         IH/G7KDWmCVIskvoGzQeqQXMQBj9uMPU6BODi15aN+mA6cI0SeuUqz1bdiyKuHz5tl3Y
         NuEfeCsYJDeGz1LkbB9ftgppAM11H6NWbQDctNaydnW6x8ny+EQZUonkpRKazVPu6LeR
         3WSgr7hepe7Hz9/jfSIrpVRdk3DaPueFtKywXhdqP6+t4d8vTb1Sk7ltj/UVyWkF3yCG
         ZDl7y+TCTteLDMvhYJ2vkxw/zodL+5C3ilGuRm7dbElFWo1BxOjk9hQb/SAAjPAKmffC
         7Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fRhR+KVcZVBHcSVRoQDeiPQZ3Aa05yhqFwNwgAtnKG0=;
        b=GO0fZOAtIpNMmjbPwbx5cHZFTck5ciIEr3g2MQCWcmHxiOOAadK1dxFsfGolTtFbgb
         8ST6kSE6bwi9yU0ElEKblihD2BnqDKUjZ+rOzskDN1QAK+1YGwB9MRWAhj9QHZM4yU/6
         cmREZ6aMs8O3X/0EZ0GORTNlhmYoKITHpj6GwCKkMYqiogNhrQyRAGjhGt8RdlehYFZ8
         zUyv8vbbn/H+A+MkTxEYBG8d5bVvOEWH/p9LdMXbS/Os4WLFoSt0afYRNDfgf3i04QCM
         sfLLUCvtfuXdpPPEOi4jvLutXq8LUaHwV3oQj/Wm1sc/UezUSxqf5u5lwKgMGMGQEcfl
         Re2Q==
X-Gm-Message-State: AOAM5325qJqQcHEogGZInj63NQiJrEH6ZhkdI7Gi/lTGPEpDu3WE3D4H
        8YJEnxTvW+KTxwzlruJhtKQqTKK1uPOqC5XsJ/Q=
X-Google-Smtp-Source: ABdhPJxeo5AVZxk3V2b6izjcKuwZlDrE1t2eyrapLdxQFMvaBtYUFXfvnLoJRJjGKstw3N8ZtzVdqxK/ob0fk80GgSE=
X-Received: by 2002:a92:5401:: with SMTP id i1mr2711778ilb.17.1624523028834;
 Thu, 24 Jun 2021 01:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
 <pull.980.v4.git.1624332054.gitgitgadget@gmail.com> <ab497d66c1167981181173f19cfe7d8857c348a3.1624332054.git.gitgitgadget@gmail.com>
 <7c43f6d4-7940-de5e-f424-a2ea50739b66@gmail.com>
In-Reply-To: <7c43f6d4-7940-de5e-f424-a2ea50739b66@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 24 Jun 2021 16:23:36 +0800
Message-ID: <CAOLTT8QhT85dAwxUTag=ktf9XVfZunfhSgswJLGeyszSxx7Q=g@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] [GSOC] ref-filter: add %(raw) atom
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8812:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 22/06/21 10.20, ZheNing Hu via GitGitGadget wrote:
> > Beyond, `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
> > `--tcl`, `--perl` because if our binary raw data is passed to a
> > variable in the host language, the host language may not support
> > arbitrary binary data in the variables of its string type.
>
> Better say:
>
> "Note that `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
> `--tcl`, and `--perl` because if the binary raw data is passed to a
> variable in such languages, these may not support arbitrary binary data
> in their string variable type."
>

Thanks, Bagas Sanjaya, I will change all of them.


> --
> An old man doll... just what I always wanted! - Clara

--
ZheNing Hu
