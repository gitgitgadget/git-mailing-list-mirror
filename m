Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBEC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D660FC3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhHDWUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHDWUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:20:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A2C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:19:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id c25so6038172ejb.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k8dEcdoZQOit61fBZbRtMnLCWaXYtTApLAWSoxmwSzE=;
        b=CzICJGc6Wrh58flQeKB3ew0k3bCpJazjRE4M52tQ36l65vP6NikGWr9rJIEmT4tp3F
         3pnZT+cB4kC/+aRVBRjoEMYIeRNQyVfU6J59yk6O/gUWNG/XSzfP6uD69VAU0qRMlfsP
         M28ggn9EJB1/u5GoEyqFE4HiW4/vXrpf71Q3GYpuNU0DrVkibNFqxD9rOkG0OhBOGS7c
         tTbDB6tYtVBf9/L6+LGEVfAZyzrAY3rEUu7hBFPvsfBLSW7QRbO0/7XtCdaBuZlr1L0E
         n0awaKDZByQkBakh7Xtilt30fQmxaNYg94mOGbdrKSCrjUAr+ilX7+nBJ9XnE4iqUM3D
         Yqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k8dEcdoZQOit61fBZbRtMnLCWaXYtTApLAWSoxmwSzE=;
        b=mPe+soTXp+rR6IiEsGDiC6itUBrQ8BDLl0qBnEmrDGcr/alO3h/JBk2iYOOnxqxYp4
         akAQA/G39XgLhEinHubirvEoz67EZNsgQxtwsNMjaE8V1tWDEVUYA8iEqzkYg2hJddp6
         sj4H5PhmHPSVjGpu/1tAl27JgFmfqN41jriqGDcC/pBsGKITDIFWIH6QjNFySwAhU4b7
         l+aCq3WbpVmJVFFMHQudNneFFPydREhlbEkWyJGITXjldnloV3ELXU4bzokqIsMy2aQ5
         Dymz8YkijWGoeVPTXAI7vKWsyF4VFZiYMVQcgtBIrGib5sVt/xrdvgtefH1FSvwDmK5A
         /3tA==
X-Gm-Message-State: AOAM530R5DXwqA2V+FzdPlX8gWG7xuzXrQMZtE2Kg8xnKi5Zp9c2y731
        EDBkgFp+avBE5MptqCd7f2s=
X-Google-Smtp-Source: ABdhPJx+PluYwZAhKzGq2Bkdcbgm4TZHVy5P33UPNf6pqDaolzU85DyC23zYDjxtn0NQrzdQxdMxBg==
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr1356313ejc.49.1628115598049;
        Wed, 04 Aug 2021 15:19:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bx11sm1043390ejb.107.2021.08.04.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:19:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Date:   Wed, 04 Aug 2021 22:06:15 +0200
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com> <xmqq8s1hozy8.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq8s1hozy8.fsf@gitster.g>
Message-ID: <87im0kn983.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> * ab/make-tags-cleanup (2021-07-22) 5 commits
>> ...
>>     As long as we have no user of a -q flag ever, what's the point of
>>     forever carrying the "rm foo*" when we know it's foo.out, just
>>     because a future Makefile change might add foo.blah?
>
> That is not a forward-looking thinking.  A cheap and easy way to
> future-proof was suggested by a reviewer.  Why ignore repeated
> suggestions?

Raising it repeatedly is an odd way to ignore it :)

But sure, all I was looking for was some reply to
https://lore.kernel.org/git/87k0lit57x.fsf@evledraar.gmail.com/; if you
want to keep it sure, I'll keep it. Will re-roll.


