Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74766C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhKWBbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhKWBbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:31:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E5C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:28:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so40407644eds.10
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsMAAHqkJgudFs948LTCzOxDP9qQRROnSPtNmcFHkP4=;
        b=nmZK2DkK7Co+W0tgYtudhu47vUh2CQEf2WLlhglWA9Pi5zAxeU+Qf8K28UN5OM8lhH
         JCTucomzfRyNP/svr7h9DZQGRsH3j4KA+Klz/VF+J6D1i4iyyV44RqWDUf9yHJD+50HK
         IA+XPUBmNnVJqZkbiirdpagiISXOvR0w5FXxsIJEkrVesQEqcNxU1G+oiNS9IdIgpPUE
         RJuLgw2gTw9VFsI63XgxhwWIYni1Pif1w+daPel7hwz/H4Omoy/XGGHNgVmVaWjnMxzH
         9E4LWRsLSGD1rzwuihyAnTG232y9q37zp3ZRn8m4KyjL4lCrxZoGE7z8LaXJCZGvBaZo
         Y8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsMAAHqkJgudFs948LTCzOxDP9qQRROnSPtNmcFHkP4=;
        b=uTQJfuqck53P6Z/lrjSVhgxEGY/mJrhpf9ny63JkqOlAnTlYPI4Nf4Y/cex/L9gqoQ
         BrXgPISb6U7rUxpFLbQloiSJRtUST+zuJ2gXV3nRM2vj6NUkOBbG5Qc2WWrMTBmvNC7k
         mRqvSNlmgEcDGgZ9B6PK1w9XXFOL7QaV4F/xEhWn5dQCB8bqkbtDJdFmAJqditgYR3L9
         oGE3q04oW9o1lZPaj0sg84RkitIAAM70W+hvOOtX6KTMK8epKPbcUohXwn2RabkzhOhw
         Ackq+3pAXsQa7psOY3TmAyY5zEbZ2hTFBLMIWfaRwp08etoLE2kr27q9Ipv+oN2tVQEa
         WnbQ==
X-Gm-Message-State: AOAM531otzDmO2xKk+70IjJFWFHV7+IA69wUHSBorZYEx/CINrOB7U4t
        eMupR9grFMweLv9DJT+iWhKuY3U2RYd+ylLi8LWpFy+W
X-Google-Smtp-Source: ABdhPJxauepMz+dUINmjS3bMVSI1H3P1GJSIV2LlIuidwZ0Gr5rNvq3VUSNz0L3S5+MkSS8uJWUf581Dlr4tisQLc8A=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr2465238eji.434.1637630920557;
 Mon, 22 Nov 2021 17:28:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <69bcaf0aab28fec145742f7183b1d89b12eaf0f9.1637455620.git.gitgitgadget@gmail.com>
 <211121.86bl2d1jo3.gmgdl@evledraar.gmail.com>
In-Reply-To: <211121.86bl2d1jo3.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 17:28:29 -0800
Message-ID: <CABPp-BEJvJSj7oUFeZYbhNmMbqfT7a-L+iQfoob-nHcPcsfiqA@mail.gmail.com>
Subject: Re: [PATCH 6/8] clean: do not attempt to remove current working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 9:51 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:
>
> > +             int prefixlen =3D prefix ? strlen(prefix) : 0;
>
> nit: s/int/size_t/

Thanks; will fix.
