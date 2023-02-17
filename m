Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE3C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 17:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBQRjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 12:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQRjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 12:39:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D30E714B0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 09:39:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id bt14so891806pfb.13
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSqX/aqERK6fGSNO2Zg7MAbQDN6DGqLdPv6+E+aa9qE=;
        b=HD1HwTLm3klEMvlpLDxIaCTDIHUAUJrKG7ZI3QtFE0E4n0vlCN+zVrsFowpc0JpI7y
         FpTAOorOOnYTTUd/88I95leyVLb/jikIrIiXnRXEMqhBK8R7q4H83S2EhTLXVAsKNdB4
         HviEHjQjf7WUG5BxlIsU/RK9J1FF60iY3FlZw1tzKKsH0cz9whUDzBiCB5dS+I8SnYyw
         Qpj4yrRjnH/HZd4ah/K5vIX5SLr00dRTGt+h9apAor4sgYVmcW57oCe1J6OIHF9Lxmrx
         sEq09BC3sjtsnyO4yYZY7d5/Y6qZ3Ux02oij3ZxDCNp4CenExS6hGvuT7JoF/D7biUFD
         ghWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uSqX/aqERK6fGSNO2Zg7MAbQDN6DGqLdPv6+E+aa9qE=;
        b=XMfRgIkHCjnCkwy0KOvBS5cd3q7Rb3IgVli34kPucxjNSKvtwnFjSOBAHVRnEIoIru
         scIHCdKtosQCwUyXdVAW03QAOh/wCpOkMrXmDBCq++YcVWVazdaISvyl76LzDnhWcAbc
         iXDicE06JAYSJ5npXDGnHEUdKufKORmgNqI2yezgHmtFlA1Q1U1ZPDL6MjzXkn5B7oAK
         8UGl76v+W0KiNl4KBbeJ9aymwzKUvAgT2v38EG6LgMATcg+Vx4AGTgitxrVySnfB8jrI
         ssFb/VFW5WFafX1mFKHYLanjYIqitdJw6guVvQKIaeCL7mx78KjDPIgvR5K72UObAHul
         IDCg==
X-Gm-Message-State: AO0yUKVPQcEj4Z7w54gifXeO4kdXUXWwmd10N+GL0cvSh06RcM5UBGML
        ygoLvCNUa4nBVjZFzFY0JoU=
X-Google-Smtp-Source: AK7set83nUSJA7bowTRtMRnEdgE6KaSnbK81rJU0jsKa63dvNj6rZA8mRZwbAhYcvxDJIdxo/Hgtuw==
X-Received: by 2002:aa7:960d:0:b0:5a8:5d89:3ae6 with SMTP id q13-20020aa7960d000000b005a85d893ae6mr1544184pfg.20.1676655577392;
        Fri, 17 Feb 2023 09:39:37 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78dc3000000b0058ba2ebee1bsm3299887pfr.213.2023.02.17.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:39:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
Date:   Fri, 17 Feb 2023 09:39:35 -0800
In-Reply-To: <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        (Alex Henrie's message of "Thu, 16 Feb 2023 20:15:05 -0700")
Message-ID: <xmqqilg0mbs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> 1. Add a --no-rebase-merges option to `git rebase`.
>
> 2. Add a rebase.merges config option.
>
> 3. Add a warning to `git rebase` that appears if rebase.merges is
> unset and neither --rebase-merges nor --no-rebase-merges is given. The
> warning would advise the user that the default behavior of `git
> rebase` will change in a future release and suggest setting
> rebase.merges=no-rebase-cousins to get the new behavior now.
>
> 4. Change the `git pull` advice to recommend --rebase=merges and
> pull.rebase=merges.
>
> 5. Wait a couple of releases.

The above sounds like a standard "flip the default" dance executed
in the usual order.  I am not sure about the remainder but that is
not because I find anything wrong in it, but because I haven't
thought things through that far into the future ;-).
