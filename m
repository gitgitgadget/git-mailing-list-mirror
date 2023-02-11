Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36AC05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 01:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBKBd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 20:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 20:33:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486B7D3EB
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:33:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so7406451pjb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxiwYaZdA2ulSnMtFpY6/u9l1VfFI722xQFGFHVNer8=;
        b=hON9kWItGAMjNHh2RC7op2iE1Lj+5QIIpOId9FWJzWf6OgaOeuLszX1lFJlaWaYUwr
         yjyJMrO/lkNl7vNS4CJdgzLJbffuzRazzAdvL+zsUYUBgVNy3zLXiJTB3H6DkKEspJbs
         zNVnl7dlbfeG+H8+4+lX/U1/rAh52LWQXHzR33dOhhxMjRvI9z5YSy8U96FlMmN8z0gV
         A1f+NOZLzB+6y1jVAtEaIYqEukj0kGqS7Qb1EzV/o2FwcTFYygTO5YskTYlCh1DhJl3X
         C/gb3Kra83OQQfvkyrioM5QgtWLvUC/pOKSePAk3M48rkxub8Qsq7Z5NkIH4YohqZwZU
         /Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxiwYaZdA2ulSnMtFpY6/u9l1VfFI722xQFGFHVNer8=;
        b=y0x4aaXjYjan8tTv04YUemrXy0C+lTEp+woBettqBcMdGl1fjwQVmy9ZO+FR0ApuAG
         ENMbPX75kfS5ow8QZbgy51e1hqvRXXMJdGPl+BGGbT3mlxgYUEjxxEjFsRrbC6cHNutm
         lpmvdMNgfrHkexhDmm+5TEYMSwxQi9mmvqAmCu86unfTkoI41WrRaBeM+ZajauxoOsh6
         D6JR8HIlPRm6CK0vILrYUo2Zz0bhYOh8y76Hu4ULps774xYunKfYumGbSIb0g0XqiEOk
         xf91VuOoa4W+YLkA6/PQAH7PAes0iCWih7PFl1JsqG2k4aQSwhANXcvUrKCfEj1wRf5t
         7c2w==
X-Gm-Message-State: AO0yUKUNVDjVWmv6j1TFEUhJZthdNQd2wUPCUjSDHTCpm6SugCncAUVQ
        JfA+TPUBZFUxjkXu5jENh3A=
X-Google-Smtp-Source: AK7set9x2LaKm81sUud6YbQv3tQt/hKzZuvbV2Fli+7N04BXwiVP8hVobP1QwX6QuMlG64UM/trKnw==
X-Received: by 2002:a17:902:ec90:b0:198:dae9:5f58 with SMTP id x16-20020a170902ec9000b00198dae95f58mr11301710plg.14.1676079233887;
        Fri, 10 Feb 2023 17:33:53 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b00186b69157ecsm127847pld.202.2023.02.10.17.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 17:33:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jade Lovelace <lists@jade.fyi>
Cc:     git@vger.kernel.org
Subject: Re: BUG: git config --global --get ITEM ignores
 ~/.config/git/config when ~/.gitconfig is present
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
Date:   Fri, 10 Feb 2023 17:33:53 -0800
In-Reply-To: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
        (Jade Lovelace's message of "Fri, 10 Feb 2023 16:39:17 -0800")
Message-ID: <xmqqsffdf0ji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jade Lovelace <lists@jade.fyi> writes:

> Then:
>
>  » git config --global --get user.name
>  » git config --show-scope --show-origin --get user.name
> global  file:/home/jade/.config/git/config      Jade Lovelace

With "--get" replaced with "--get-all", what do you see?

