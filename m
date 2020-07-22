Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA676C433E3
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAA52071A
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhtCiOIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbgGVVUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:20:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A7C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:20:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d17so4077864ljl.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+1ztGL9MfIgJU130RZfLt/NuOyBULzZGPDth4hlIS/E=;
        b=rhtCiOIT1pXT0/VpWhHzg+xYOQvmdStVlEyvCW7mYzjMO9g5ItWcaxADjnq1C8JX7A
         3YhBXACXZBEAB9MvJBaYf+rDzYe7e1FKC3kGtzexOuj/bN4j+IVQflkCju3X1aLnhCOh
         36NURj2IKXxH+F5UkYNelkrHMq41ZmGZruwa///yUEkuYt/EgsEDXrg+gbgEcGuQ03Kz
         z0x6uIm1z9RFjfmqLuAhd0D5Tp5XECFFuohpNj2SwT1pBgqhnqv05a7vUNNWxR7CvK/a
         sN6IUEXYgDHM9JktqVLnKrvo/VtZZe6TEgiHt9KAuhgb3VxzKm7i9vx7cocq/CnG4UGe
         Udkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+1ztGL9MfIgJU130RZfLt/NuOyBULzZGPDth4hlIS/E=;
        b=ZkpEK81iGeb1E4BxWV2HVK08f8EHkOxYDRc7Vvc/6pFGZEMSR09UfTPgrgjLFSMkE+
         QH1Bcz5z1ie8HI+RRq06JkaFqwsXeIaR4nvjXy+fSmj0HBMOxgm8YCy9Zgf7ZInfyggG
         IsDdr/+ZfkWqNQjyrDSAVm45o4kTcN9Q4+Mr5COSNUFjh97tulsmBX7zgoRIODXJhhXT
         adzkKvVwxb8QaWUU/cCX5SACJMX91pBroOXcxaeWHClADlflk6xPrk/eBYjBb+nsnm3f
         IMigBPr229IW514tHH8QeqyXy5YJl64weR+i+rYPZ4DI4if5/R7uH4mVA8t6FQujG5eC
         TxEQ==
X-Gm-Message-State: AOAM532IXGdc4berqJXCMpVLO2L4Sd8ZBKzx96A3wHQUp0nIkBnYI/IC
        5DknCcXNj9HnUcBbOPvAR6XEvaRu
X-Google-Smtp-Source: ABdhPJzqplb1ZYuFSpJV/++vw6BiTzfERwRK5/N29MPbafLhNF8QZo0PEvE7CLPlCIQoGuboTSVPvw==
X-Received: by 2002:a2e:8890:: with SMTP id k16mr447101lji.113.1595452847284;
        Wed, 22 Jul 2020 14:20:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v10sm797745lfo.11.2020.07.22.14.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:20:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
Date:   Thu, 23 Jul 2020 00:20:46 +0300
In-Reply-To: <xmqqwo2v45hq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 22 Jul 2020 14:14:25 -0700")
Message-ID: <87tuxzl00h.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Am 22.07.20 um 01:29 schrieb B. Stebler:
>>>> I have been looking for a tool to display merge conflicts, that instead
>>>> of showing the two versions of the conflicting section, would show the
>>>> diff for that section in both conflicting commits.
>>>
>>> Perhaps you want to configure `merge.conflictStyle=diff3`?
>>
>> Is there 'git merge' command-line option for that? I failed to find one.
>
> There isn't, unless you count
>
>     $ git -c merge.conflictstyle=diff3 merge side-branch
>
> as a "command line option" (which may technically is).

Yeah, I thought of maybe making an alias for that, so apparently I do
count it as command line option, thanks!

-- Sergey
