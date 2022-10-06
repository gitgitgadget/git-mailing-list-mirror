Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8BC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJFVuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJFVuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:50:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FFC89ACD
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:50:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so3051934pjk.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upX22+ZXIUCaS14WWoPqDSdG6S59df2gb/Hlknl52fM=;
        b=CHkYlWEZ0yvcvKiscbG1Z50Qbg/3UE+NXJVn3TlvmeB3iPQDD7v7IqSMBzmQqdARqe
         bLCC7st4qgmF983bRcSDAsNmq1teH9pFc1aYYnZJVMvF9QSLCkGnTcsHdYsJk0f9lTzI
         feYV0RkdawT9Fwd9gEvGT3USEsUrRH2ZvBEqv9pBfzGWKXx1bf3UsndMe4qgDRqRS3cI
         f9h7uhZVkxMDAPELkuBzEtGIlOtVegA0iFokNgmQ5N8v5nXVTyR+wj/lRMechPAQ3BXh
         vyKaCDiPZZnOJMBTz5DmZacTJ1gNVza9sCwmzcmm9rq3BAOyfMUWLFyZEyqLvFZc/yrv
         Y8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upX22+ZXIUCaS14WWoPqDSdG6S59df2gb/Hlknl52fM=;
        b=XtkzYSl9U3MOVQaQDrMWPX8RrG6ReJv42wgvOb4/hgfPphVvlreBmh4Vdo2ErkFbkW
         pN/0uBKP1XW9ZyNQO7CeCk8OJ6QGPZqlEKoJTctP8BFj/J9z5EldvoI4kcdrdM1ArpoB
         nZ9R0uPd78uR1iLB8ouDPU7Y9e0KJtdG9gPOHaeFXb8W6tzw4/joKuUvS1xM5ytpPHXv
         BztDjmEhPhpeX8Lz4jHgl4wr643OTv3J27pmX0e6P6epYaKn0NQEVtKjlxaGr1g+80ER
         pS5cyjjCreodxSbUlbzkYZRAAn+j0TKtHucLvcUVWjKz0BDl70C6hx6VRIEmR1ocQEi+
         IdXQ==
X-Gm-Message-State: ACrzQf1fBCQhY48SH/LuqizVwMg+fm30mfJ6g90Y1gtenMjoIkHaPXe2
        s2k/q2oX3LkymhJ0I1Mu7jA=
X-Google-Smtp-Source: AMsMyM7w93Qb6JaCf8ve+NSS8MG3p5OwjLe40EoRaaTV11ydHDLM5AvPKRhNCIYE4BbympV9mSkcNg==
X-Received: by 2002:a17:90b:1e0f:b0:203:2308:2ae6 with SMTP id pg15-20020a17090b1e0f00b0020323082ae6mr1749941pjb.187.1665093002711;
        Thu, 06 Oct 2022 14:50:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b00172f4835f53sm83002plh.192.2022.10.06.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 14:50:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
        <xmqq7d1eqhbf.fsf@gitster.g>
        <221006.86ilkwr6wy.gmgdl@evledraar.gmail.com>
Date:   Thu, 06 Oct 2022 14:50:01 -0700
In-Reply-To: <221006.86ilkwr6wy.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 06 Oct 2022 23:05:12 +0200")
Message-ID: <xmqqr0zkipva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> If we were to allow arbitrarily long thread_name[], which may not be
>> a bad thing to do (e.g. we do not have to worry about truncation
>> making two names ambiguous, for example), then the flex array is the
>> right direction to go in, though.
>
> We don't even need that, AFAICT. ...
> ...
> And we are taking e.g. "preload_thread" and turning it into strings like
> these, and saving it into "struct tr2tls_thread_ctx".
>
> 	"preload_thread", // main thread
> 	"th01:preload_thread", // 1st thread
> 	"th02:preload_thread" // 2nd thread
> 	[...]
>
> So, we don't need to strdup() and store that "preload_thread" anywhere.
> It's already a constant string we have hardcoded in the program. We just
> need to save a pointer to it.

That sounds even simpler.
