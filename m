Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B26C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAIOCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjAIOB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 09:01:29 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A51CB3C
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 06:00:17 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j15so2384366qtv.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 06:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LckbT8pQnhL4sWis2E5JWRSrAIHvN2mDZt1UOQ/L59g=;
        b=qXwT1Hbf+oIfFVS93lNCtqIeewP29xdV5HwujvVIGWrISK6NnpuZt0/xTetrZmIRL7
         wh88oXlyqqNIsx3DMEjN57yRnl6+ftJtuXpjbMQX7ae6CVv1mbPAckcylmqknRUQB1ur
         djRDrBInyLLs3DnRi9RqG3ATiW/6wyF8zcGQ92LK/PsR9zU4Qmt8jdcj1wdsUGEWRxIp
         bMvR4K8Mw2vZv91vxh9XE6YLxmdaOa/ZZ1g9yStzf61nimK6q2bwADW+h7UQxyD8J4Yu
         UpUv6XWtL3aXEEcVZVEVTuyFKQOl9uDBihLj8ZANvcdYofMyd4kmgsp5M4ETt6zRij3k
         Kcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LckbT8pQnhL4sWis2E5JWRSrAIHvN2mDZt1UOQ/L59g=;
        b=p8Nc8rl81AigwAd1gFW3Ejzc9to3oiEhBqy/DjIwjxHMTVa2PiYCbFuO2h9GAdOgMf
         0J7+UK+N0+KxPGroXXMYFxpRBfne2lVc4jR+wEvYsZqYoe+BPVGKyfy3WZKo0+m68OnH
         L69zGG7VdZQ87yRxhs4s4flktZWdocO7O32Xk6zQp9glJA5Db91rgTR57wFAx/Q/OQCL
         lpWVV1lYIc+3ecRQR6r+r2GlyYjBJ0qcWYSTzpnlULbBT7zj0P4CXiO/X2+TFNC6cp58
         dNxCgpJpFhVsSGL8VzpCqpenaSlBvfOtAWneaWVJEkjlnQAupCoJLoA6AsvTW8Rh9PCZ
         1h0w==
X-Gm-Message-State: AFqh2kpWovyteudCZsOQMjVAQ6nAjj3DTXFuWNizEnsBGC5F+G2Cda8U
        64RF5zEPSgJKAGrVE7TYv1/WbxZPaHU/SQ==
X-Google-Smtp-Source: AMrXdXu3YFD16choMvFb9/yvGfmk0gt1eIeKQPCDtR6QvjH3pMdBY2d98ZVSW+jl/UjQCAyfumQ09Q==
X-Received: by 2002:a05:622a:591b:b0:3ab:6a9a:aa8b with SMTP id ga27-20020a05622a591b00b003ab6a9aaa8bmr96874224qtb.60.1673272813349;
        Mon, 09 Jan 2023 06:00:13 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a24c700b006fc2e2198easm5455879qkn.95.2023.01.09.06.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:00:12 -0800 (PST)
Subject: Re: [PATCH 4/5] revisions.txt: be explicit about commands writing
 'ORIG_HEAD'
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
 <302b789a4869c2aa8a0de2f71a2725c6c567685f.1673120359.git.gitgitgadget@gmail.com>
 <xmqqcz7p22x5.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <530a9dc9-dc16-fe26-954c-27daabf9e9bd@gmail.com>
Date:   Mon, 9 Jan 2023 09:00:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqcz7p22x5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-01-07 à 21:08, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -way, to record the position of the `HEAD` before their operation, so that
>> +way (`git am`, `git merge`, `git rebase`, `git reset`),
> 
> Let's not commit that these four will forever stay to be the
> commands that uses ORIG_HEAD.  Perhaps "(e.g. `git am`, ...)"?
> 
>> +to record the position of the `HEAD` before their operation, so that
> 

I think I prefer being explicit in the documentation. It's easier for a user
wanting to learn which commands write that pseudo-ref to have them all listed
at the same place. If other commands learn to write it, we can update the list 
here.

That said, I can live with that patch being tweaked in the next iteration if people
feel strongly about an explicit list.

Philippe.
