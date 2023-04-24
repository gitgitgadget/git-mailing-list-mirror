Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85420C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjDXNwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDXNwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 09:52:31 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299846596
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:52:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-18785f07525so1522328fac.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682344334; x=1684936334;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrYcLQxoRXgPoPTxjY8G/zt8q3uSydsdumGQrriKEuw=;
        b=AvnoAufqUD2ugZstmm0LrEk2DAAoysCG3qKFQHTTC7asdoxOVXGMs4JrWXf3BJOR3m
         aYjvm1POEggfdrhXxlcKq/i0k+FU/3BRrPx5FBYI2x5cUEbaUWxGyCxzyh03tgp+HAfG
         Yw/k/q2wkB29bTJ9CkuAdsYHoZH/M9K/xOFAuLdGkLewKwm/jecW2hgt6m0g0f2XjiwI
         z72vyq6Dj7qGjLDl/iQWdhe31sTTzX3USeIW7PNmJf9W/F2ACKHsWYSFW3KsRWSEWJLb
         d/idrzEzi1Rb1EfhrlPhS0CHIkdkMvalPr38qvZ7i1lP1C1CxT7D4+yifvpfZY3jO+YH
         039g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344334; x=1684936334;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jrYcLQxoRXgPoPTxjY8G/zt8q3uSydsdumGQrriKEuw=;
        b=L71zDrPmC7sW7fbEiCUbaToZcequ+AS4n5B9KSkPXdAhXnfEIFpVQSI0V5DtRCo0WP
         5YgESdcKjTorlLT8R9Dbvsyr4jB5wHdX6mKx9T4uZPMj9TyyoRCnozJ/1sn2hGcZKuhW
         96vrwKIKVddrlzh/r1qBenk2OX/FJqQl9bjBans7vc/BTXIqG8FXYl56MpihV57U54Ou
         eStXZB7AO2yHZt5IA5wZpznGWf+nJu+ltSSg5xBPpm5Pnr/W7go4rHrhAZGIZyw3tPDO
         518Nz2GbyclRnXhzUBwxsLeKwxFJ9HVVslNZhWmc/P3qcL3d8idcJwUUp0p613RVMxNf
         uYfA==
X-Gm-Message-State: AAQBX9f30PYaNaiX5NT+9ImdH7jQziopDhkyJ034ajoJhyfumSHfNvXq
        7hlsGunfnt9zYi8Cz1ZsXK8=
X-Google-Smtp-Source: AKy350a690bD7hHPxiJudvRHEejp9Xch1Tfg+YMAU2OjSbDjtTFLMNSxw4Mv6OOpiwfwqnZH0ltStA==
X-Received: by 2002:a05:6870:658b:b0:18e:7e69:a6d4 with SMTP id fp11-20020a056870658b00b0018e7e69a6d4mr4037266oab.43.1682344334244;
        Mon, 24 Apr 2023 06:52:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w22-20020a056870a2d600b00172428894e0sm4473045oak.28.2023.04.24.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:52:13 -0700 (PDT)
Date:   Mon, 24 Apr 2023 07:52:12 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Koichi Murase <myoga.murase@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>,
        Koichi Murase <myoga.murase@gmail.com>
Message-ID: <6446898cd2dc3_aba294be@chronos.notmuch>
In-Reply-To: <20230420223800.1698197-1-myoga.murase@gmail.com>
References: <CAFLRLk9aLXx-j=W++qqiu5-Z0TpqdnyfR35+QA5aMZM=YRZvGQ@mail.gmail.com>
 <20230420223800.1698197-1-myoga.murase@gmail.com>
Subject: Re: [PATCH] completion: suppress unwanted unescaping of `read`
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Koichi Murase wrote:
> From: Edwin Kofler <edwin@kofler.dev>
> 
> The function `__git_eread`, which reads the first line from the file,
> calls the `read` builtin without passing the flag option `-r`.  When
> the `read` builtin is called without the flag `-r`, it processes the
> backslash escaping in the text that it reads.  For this reason, it is
> generally considered the best practice to always use the `read`
> builtin with flag `-r` unless one intensionally processes the
> backslash escaping.  For the present case in git-prompt.sh, in fact,
> all the occurrences of the calls of `__git_eread` intend to read the
> literal content of the first lines.

This is my undrstanding.

I agree using `-r` is a good practice.

> To make it read the first line literally, pass the flag `-r` to the
> `read` builtin in the function `__git_eread`.
> 
> Signed-off-by: Edwin Kofler <edwin@kofler.dev>
> Signed-off-by: Koichi Murase <myoga.murase@gmail.com>

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
