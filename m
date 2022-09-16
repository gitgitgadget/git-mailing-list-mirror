Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0519ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 13:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiIPNBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiIPNBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 09:01:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539CA3D74
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:01:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so2239795lfu.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Wc/6lKOW2i61/TMh25ze4w4NEODR3HDGUcmTsYmmUsY=;
        b=MoVjorFdL8BgbODTDTThdrAEL9JqK0cSpVuOeTMrFw4ZtRcNKeRcA0MV+V2SrrNNz8
         JslwJ3eTrf4fGqKbLQgaJ501vUZHnp9LV1aGeVtKLZm+66kBlwa+VoWLslRV193Hy77n
         gCU2X0maRvAWFY/yYQUwBQ9h4XeW3Fv8cZX5qaL32K7wbsTmBPs/5ux3J3odrTK2eUt+
         m1cfxGPMQxtXVAlvhRTMTzTSUVbfGRJXWZgGUOWFaI05LVkX4cieYjWBNtBkChek5W9z
         kLPqljU5J82gRi2cUavZ0VmIXg6n0B120LiTd+p5uEWCWMi9/Mn+sCTP2Tg4benCc/1i
         xduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Wc/6lKOW2i61/TMh25ze4w4NEODR3HDGUcmTsYmmUsY=;
        b=gqel0X2NdDv3WyLiJgTPMvL+T4h2NEaPj1i36Jc3WX+egAko+RSdiKJIXtO0nPc7aD
         hYa6S6vKJRtuQO7RWFsFrrzp/32YCnvwEa9SAAl/cj+fD4BVbgh9vT29zABp0sUEbjXL
         d7Rq79kgKRG2BJKXoi/W7DwWNmCY4I+zHC9eLuAp4K6TlzFoYLdpzayKbVWWsZw+SgDA
         ocay3i27qRmJXxsEUL4m+QFjw920igOugqe4Wp2Dra6v+0sI3mii8+avtmzps/KxvTLG
         Rl8d1rvAVvImGB50JUppyGuSOsNZDYfdcSJhoYbGP7Fcr8/D7endFPAVwN6fKgI7WGZm
         u5/w==
X-Gm-Message-State: ACrzQf1yzrmfaj+cQOuPMfFRptuGt1pzk2tAOgPAF+R3d3/mhvja/Ywu
        wruGouHj83driiSSb990y37GNP28FPk=
X-Google-Smtp-Source: AMsMyM7XTZfhbJc4vbySjbEbTrGOxoiVegavq7F8d+0WYzNlM/by8EX2Sptg4i1/CZHWg6nbWrIOVA==
X-Received: by 2002:a05:6512:4024:b0:497:4db:6ad0 with SMTP id br36-20020a056512402400b0049704db6ad0mr1707102lfb.637.1663333269537;
        Fri, 16 Sep 2022 06:01:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e7303000000b0026bca725cd0sm3657549ljc.39.2022.09.16.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:01:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff-merges: cleanup func_by_opt()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-2-sorganov@gmail.com>
        <xmqqfsgsmq4j.fsf@gitster.g>
Date:   Fri, 16 Sep 2022 16:01:07 +0300
In-Reply-To: <xmqqfsgsmq4j.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Sep 2022 11:47:24 -0700")
Message-ID: <87wna3jwx8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Get rid of unneeded "else" statements in func_by_opt().
>
> While it is true that loss of "else" will not change what the code
> means, this change feels subjective and I'd say it falls into "once
> committed, it is not worth the patch noise to go in and change"
> category, not a "clean-up we should do".

I agree the "else" vs "no else" is subjective, but the problem in fact
is that the first "if", unlike the rest of them, already had no "else",
making the code inconsistent. So the fix should either be adding one
"else" to the first "if", or remove all of the "else". I chose the
latter, to end up with less noisy code.

>
> I haven't looked at diff-merges.c for quite a while, but I did.  I
> notice that the code is barely commented on what each helper
> function is supposed to do, etc., and very hard to follow.  The file
> needs cleaning up in that area a lot more, I would say.

I believe each helper function does exactly what its name suggests, so
no comments are needed. I hate to add comments that actually just say
the same as function name, so I'd rathe consider to rename some
functions instead should somebody point out to problematic ones.

That said, it seems Elijah Newren had not much trouble adding his
--remerge-diff capability to the diff-merges code, so the code must be
not that hard to follow even in its current state.

Thanks,
-- Sergey Organov.
