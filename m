Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDFC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352393AbiEFRyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444274AbiEFRyI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:54:08 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95A188
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:50:19 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id q2so7892064vsr.5
        for <git@vger.kernel.org>; Fri, 06 May 2022 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZQ+d7SkE03R8WrMUOViRyvKg1ZMg62vkigpAE284rsU=;
        b=lKb02xo/MgrY0VZIoT3kbcm7hgA5igZCZr4teFw7wzpdAs/iResWc4fdvcv2ZM1Kta
         c2cFTYa4Ugw8e8ozuA4+zczHl0QzmBXScE7hAZSwtcTT/CzjfCPARnJgqgFWuzj9qTFQ
         k7k4zK61rBFLdKPCH2XIcpa/qNLb9o/R08bZDu3A5EwEBWs/PTcf+3ZIcZjOG2s3iELq
         KR6x67F4R8oPG420YAwfQmfu3dOVeAxmP58qZebvAl7pdZCj9XzJe7l0MGDRJKHM1BLN
         To2ND+joeHu4ywq9UFDkJ9wueUWwfmlyrXIRbqztpsLvOB1+uRihTKhHayQeq/uDWISf
         cYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZQ+d7SkE03R8WrMUOViRyvKg1ZMg62vkigpAE284rsU=;
        b=j/lIQVPfjm8LqnvHgERjtl0w7EpyOJ7FXej/Wa2F4VL0kokzmNMIqgpmCePEzSMM2I
         ySN7NCenD+eNZVYw0LCQ5o6Xr4zSqIE6qeKHn+uMUQq5LnLd22WDuPXCL4BK1pZgErF+
         jJA2VGai7WS9/RPzj7VIPmhcHlEwPssYW5SyUhL+hJ0vnvsVJij1pC6AH0i7irT7veAa
         tBcV+M/4hGZR/YB//sOBjxVN5b5fYiAtqKzhRKFZjpy3EtWHUC6ixJwECyUg39WLOykb
         QW2A45KEElpcrWDUMjpVz2RdvJNpLHdAbOQzkOS/1JYjc69ngyW2KejRmPkmerJcGBn6
         20rA==
X-Gm-Message-State: AOAM531BM4L+je/gNMf9s2Z8tf7chnePmvUff6JVGoy410cUPh5JmckO
        MN4WWUMXQnZeXSaaEVNvKzP5TEclHqiUjbyFZCc=
X-Google-Smtp-Source: ABdhPJxa2/a/ayTy+ICSWKHaOvcLb+U+5KTh/AZmxETeJFTkFvfVcwkMMoTL7JxO5szcFQMhirPRM2WtSkOqxk3CXEw=
X-Received: by 2002:a67:c78d:0:b0:32d:1e85:9337 with SMTP id
 t13-20020a67c78d000000b0032d1e859337mr1364175vsk.76.1651859418162; Fri, 06
 May 2022 10:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
 <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com> <xmqq7d79gjre.fsf@gitster.g>
In-Reply-To: <xmqq7d79gjre.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 10:50:04 -0700
Message-ID: <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 28/04/2022 17:55, Junio C Hamano wrote:
> >> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> >>
> >>> +test_description=3D'verify safe.directory checks while running as ro=
ot'
> >>> +
> >>> +. ./test-lib.sh
> >>> +
> >>> +if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]; then
> >> Style.
> >>      if test "$IKNOWWHATIAMDOING" !=3D "YES"
> >>      then
> >
> > Also naming - we normally prefix test environment variables with
> > GIT_TEST_. IKNOWWHATIAMDOING does not tell us what we are allowing by
> > setting the variable. Something like GIT_TEST_ALLOW_SUDO would tell us
> > what we're letting ourselves in for by setting it.
>
> If this weren't "let's reuse the same mechanism as already used in
> 1509", I would have had the same reaction.  Renaming would be better
> done outside the topic, I would think.

Since I am renaming it anyway as part of this topic with RFC v4, would
it be a good idea to require both?

I see the "IKNOWHATIAMDOING" not as a normal GIT_TEST flag, but as a
"here be dragons!" warning, and I later found that I either
misremembered it being enabled in the CI, or it was dropped with one
of those refactors we do often there.

My RFC v4 includes a new nice looking GIT_TEST variable as suggested
by Phillip which I am also enabling in the CI to hopefully make it
even more clear that this is only meant to run there, but sadly that
also means that this patch will likely have a conflict when merged
upwards.

Alternatively I could not enable the CI in this series that is aimed
at maint or at least do it in an independent patch so it could be
dropped where it is not strictly needed?

Carlo
