Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB178C433FE
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 04:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiC3ET2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiC3ETX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 00:19:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B782A235853
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 21:17:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j15so38965476eje.9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 21:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJGaL6vH9zuBPTfqhXyxvv2ciYiGw0GX4+joBDVlevo=;
        b=VHOQBPXiV58cNd2hLPvZWbSc6J5F8JHFTsNBjUzu5TyhszBlIXCZXmHylN5hiljLpt
         rPmmINmFV/5ksEudysUkL+ZQ11Cr7GYUsRSZkgjwtf5EOzzgEzOeS4aYD58CXYU5IQ0x
         G32sSxi6VyjsX0Lqh38VSyOUoFXGhmv6QsYDuiRi/S5RD3wJKd7fQG4xunY5S0YyTZYp
         G8EFu/jxezZgAyB1qJL4kAbpD7v4wesDerZNYznXWm6xKd7iTkyfz9LdmjNczHTnoCXt
         Kc6rYSd9YpelrkJ953+mgwu6xpSsr6hO7ouyNC06YUWEMf/UES1qNvAGh1huFhJDpr79
         AMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJGaL6vH9zuBPTfqhXyxvv2ciYiGw0GX4+joBDVlevo=;
        b=FzV0TAWNL0rZvkEMzL1oTNAKvioL4srw4HzSCeHtnqFoMeU3RGPRPFbeAw30DYxheY
         t0INz1kn09e17VBGf++ckBVMPXVZPxyDRbHeQ/vIzu8VPyOqYnGGOfoLSq5JrtpY2cax
         +ypD9HoC0UmPAkkYi06LzUEIuOVuLJfWbTI/1tfW59CRPuQy0Ht9fnRj3CCeteI2eQKR
         00guh6KY4zwO/oHzw/5NoEFLW7gGMioQHGNXsl0azsN5IhlKFwTU7FEm2MrC0UNvVnpM
         l5cYmLVy3GXgTr/QaRl68Dn19x+Sda7Qt4Eh1+LVjiXbtRhQ66pQHVGJr27TEjfEvRqa
         aViA==
X-Gm-Message-State: AOAM532bnrDgWdzhRMN8HxmPwbEiNs7zYpuzDuwGPhbYOc+qn803w6WV
        SNXI23iqBcfdQjopkP0q5K81Y3jpdm5Yr6ELuInsHw==
X-Google-Smtp-Source: ABdhPJy9gdwfhhTRjRKedEsvlMe96LguVerWpqwz5eCWBlQqeqjFPjDjWo00hD4x81bqPikaBN3U+62c1XErQfa8LVc=
X-Received: by 2002:a17:906:7d52:b0:6df:a6c7:2c5 with SMTP id
 l18-20020a1709067d5200b006dfa6c702c5mr39086255ejp.540.1648613857222; Tue, 29
 Mar 2022 21:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
 <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com> <xmqqh77gyd0y.fsf@gitster.g>
In-Reply-To: <xmqqh77gyd0y.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 30 Mar 2022 06:17:23 +0200
Message-ID: <CAPMMpojsepWTf23Tm7uEGK54UabJUz43Yj1UfbpipVniPHScbA@mail.gmail.com>
Subject: Re: [PATCH v4] tracking branches: add advice to ambiguous refspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 5:49 PM Junio C Hamano <gitster@pobox.com> wrote:
[...]
>
> Sent a wrong version?
[...]

Yes indeed. My apologies once again. V5 coming as soon as the test run
completes.
