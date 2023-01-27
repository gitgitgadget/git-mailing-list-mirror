Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4825DC38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 18:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjA0SqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjA0SqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 13:46:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E84757B7
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 10:46:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g23so5886484plq.12
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfjTg/2S4MPnRdCPV2T3oKS0YBU2hKv27vtZ8JLX21k=;
        b=CSwkplFIvTPTRBUyV/z0stChH/e6fyQ08mUXWnJs5Ss0cF8zA71y5ND/COIbOekoBR
         Z+gYshrFra7SbWEgLIe/jAS1RkRPCOMbTw1AeP55+XHUBnrKzxVrjL6res3cXgxd/f6W
         nyE1zjoQROT7BknK/ckU5KU/8WO56lihpnNv5jEG8d7BRFURxY7qRrWj+9EGDFCY/jCS
         2moXeOdY67AhfB4t92VLGiOiaAYQw8Q1eJVT+8xNrf8NXAlMlGzthKY1cVpsTvvk/V4x
         qhtkEN+ZYunH/crHWzqhQaxajsw8wATX8YDcqJ32d74f5dt6yV0b8RR4Qy5g+0V2X5Xi
         Ex3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OfjTg/2S4MPnRdCPV2T3oKS0YBU2hKv27vtZ8JLX21k=;
        b=Gc8ZaYiJE10IcBIhnCd9cMen1pVKpHZAvp1G65J1ShN1Pnq7oioA706LHlmLV8srrL
         uuziEu/bGIFYfzH6xuOAS9EWCkJ+awagBtr0ay0Rv0HyDb3pWJHhkq4m/KfAXo00xQ1L
         dTUuRcZJvLrY2okZMBYvmyAUNMoc/fZh4/PkIxUpw2Uh28pIp3kDHtlacn/H8OsYAZse
         EZva7K5Zkj/IH3x/rEVwILJbsKt6h73cVYIxkZE4J2/HEHvDUT9P5IsqIyw/1Kuq9rFb
         IfKqu79KTYTxgm+2pyHd4Vwtf7/1jT8ErnszGLRRfhtmu4LEmIBKz6v92KrZlRZBcas1
         FvOg==
X-Gm-Message-State: AO0yUKVZmZR9AfFys3SfcG6nBSFQFVE/a2ziYssRTRMjDqlYEUKxzZfo
        OtGIC8AZwKmi6gNAwh8N4HRK3FJM658=
X-Google-Smtp-Source: AK7set9e2fHW5WfRm/lwUB8U7R+fwPm2Q1Sdeyac/XOenDAwjgO2Um6eeWK5Go1dmDvmyfMN1CuKsA==
X-Received: by 2002:a17:902:dac8:b0:196:59a0:bffe with SMTP id q8-20020a170902dac800b0019659a0bffemr2572448plx.17.1674845166607;
        Fri, 27 Jan 2023 10:46:06 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709026b4500b0018b025d9a40sm3164587plt.256.2023.01.27.10.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:46:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
Date:   Fri, 27 Jan 2023 10:46:05 -0800
In-Reply-To: <xmqq1qnfancf.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        27 Jan 2023 09:39:28 -0800")
Message-ID: <xmqqtu0b95oy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> What am I missing?
>
> Note that I've seen and recently re-read the discussion that leads to
> https://lore.kernel.org/git/f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net/
>
> I suspect that this auto-probe is related to solving "the user
> thinks JIT is in use but because of failing JIT the user's pattern
> is getting horrible performance" somehow.  But I do not think a hard
> failure is a good approach to help users in such a situation.

I guess what I am saying is that the previous one that has been
queued on 'seen' may be better.  It should cover your original
"SELinux and other mechanisms can render JIT unusable because they
do not allow dynamic generation of code" use case.

Thanks.

