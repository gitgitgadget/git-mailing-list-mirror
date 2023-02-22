Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A8C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjBVXJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBVXJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:09:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971F55A5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:09:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x34so7387413pjj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHTceYu5Iiz11wUvE+gi5T7W8P5VM31sjjD76dt0y1k=;
        b=T1nbFOHYEXgk1c1s+D/AeVlDo2MOCFlayfadcoa8e3eMlfw+0dwuWl9s0n36dx6a9R
         DK8YcG8d59HBUTUI3U6S4k95re5QhgsO7U8PDQzYjz0X0m+PeJvbHcEdxI5aHgWauDTl
         E0ErOaJbjCNsSdDHjZe3oDOOClttKiDWcALSTgZZjrf+SYYOyUjx22FEXQfiHV7oYeOF
         0SJYHoYFhz/Fnjfs33wtNSnMLtHuDUG+unlBXG4epCWwLfwewQTR8ZC6I7QJiNIb7h3o
         OBVbVnUu4SXemwouOZVNakXvptMFnLN61GFGEpwTXxl//MK87n6ejPgfuwH4ZS9XROqP
         bGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHTceYu5Iiz11wUvE+gi5T7W8P5VM31sjjD76dt0y1k=;
        b=Qe/PY9tKd/SgjOfcLP+yE4qZgpgLYZb9TRJOyKQRahD5X2eV5Wd947y+2ny2N/WvRu
         nLzTmJ7VfHJ/vBOsCS37JhGS+9rBaFkMTLeoRcyuvTNiOsmijfVlnOo5uWWj5FII6ubd
         UuQVrcWwaBZ/+U/9a73f+pTatVgsoivijFG7ReMv0t8ttq5nsMLNTyfggaFs+G9kr/GW
         pRJ95R7qrecbns44RVtxYfUsV1IiCaoJabIJAgSi787ZngbmNRe9ZVQlV2A9Oz1XpbpH
         d3K+TIQj2HN0sRHftSKZiLcIebu8byL9ekWGwcOtZ1AN1WW7U94+Sk8E/w4Mg4QYwBQw
         wraA==
X-Gm-Message-State: AO0yUKWbV1Xw4gOTrSadQsjMEtP/FPge04xnabn8nIgyig3hEJTMWnI1
        NfLL82X0mmRddYecGdvsa6U=
X-Google-Smtp-Source: AK7set85HVUZRhN6h2SY7jsMDTK6rgFzEoPCI0hJ1I5Wjq/kUDltWLMJZkmfGES8zQIPdQ5NsIwbPA==
X-Received: by 2002:a17:902:d50b:b0:19a:97e0:60e8 with SMTP id b11-20020a170902d50b00b0019a97e060e8mr11853545plg.29.1677107384814;
        Wed, 22 Feb 2023 15:09:44 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902bd9800b001960706141fsm2105910pls.149.2023.02.22.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:09:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] restore: fault --staged --worktree with merge opts
References: <20230218163936.980-1-andy.koppe@gmail.com>
        <xmqqa616g8yv.fsf@gitster.g>
        <CAHWeT-Zy=iJZoVAWZHqnGGFb-KMbg1fk_mmdE2T=K4+xRHpG0A@mail.gmail.com>
Date:   Wed, 22 Feb 2023 15:09:44 -0800
In-Reply-To: <CAHWeT-Zy=iJZoVAWZHqnGGFb-KMbg1fk_mmdE2T=K4+xRHpG0A@mail.gmail.com>
        (Andy Koppe's message of "Tue, 21 Feb 2023 22:27:27 +0000")
Message-ID: <xmqq356xcn5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> On Tue, 21 Feb 2023 at 18:38, Junio C Hamano wrote:
>>         Side note 2: it is conceivable that --worktree --staged
>>         --ours may want to (1) resolve the conflicted path to stage
>>         #2 in the index and (2) check out the result in the working
>>         tree.
>
> Same with restore --worktree --staged --theirs and stage #3?

These two work pretty much symmetrical, so the same story should
apply there, I would think.

> Thank you very much for the thorough review. I'll prepare a new
> version of the patch.

Thanks.
