Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8B81F463
	for <e@80x24.org>; Tue, 24 Sep 2019 07:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409240AbfIXHWE (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 03:22:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390221AbfIXHWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 03:22:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so798520wmi.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OQYCNeFqGeyBjG6N1iYXpU6+zpWYiduFOlqDa7fR7uU=;
        b=fEeDC8E/wvarn8VRQf0NDaKTrEXFGh2vRmJJPk3fS2ypl+bmx/j1ZnF8LwoPHhsHFt
         0c7xAUD/B7oVSiwy87wE5QtXDZA4U8nQMPoXfrH3Xgx0tdsETaLxpUdYq75U7yqeToBo
         jSIpyqCyUuVhdU4i65eQQRYTF3xjsm2OPaaRaFqpuLFgdiJM2VZ67ZuvXYGEzU/ON96t
         xHJ1LDfUxuoe1TdIxFQqRFqdxOihEhS1CO2RPNvpnDOcnqJ4UJcRv8Vr810gw4IDuOUl
         L4THy43UfIq1Hi/9qgphnRDv7a17iTGG57ZhWlalSeUT7jIo5t79nyRF3ugM0u09c83p
         v8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OQYCNeFqGeyBjG6N1iYXpU6+zpWYiduFOlqDa7fR7uU=;
        b=FmUtFm8wi9RSB3VR9q9ipLrft7XiDNduNtFYhLRd4qWrRKyFgqvWyD+5jS9mZopnUJ
         AHp+bTIPPoEKcRkbII0pjwn1oH60vzAuoTLigNlNzVbzYC6cp1zCtBbhyox41SMXERbx
         QqzYXwGVREvRSuZxPSpnet5izNImFvMgR2erCDxLPyri494rn8awzmgDYgPcSCRKIY3f
         5zty7l5bMbyg9dwfmf1ZFYo8K1zCMkFQoVFC0axRkbi3nf8NmlsZ96sQ0ZNFOpqhsnto
         cN78zeGviqqwWISRnrcHt7pvJQApGVD57CbdT9uoa0HwfBxpY4p23pwaNGndVQoc57Xv
         hfDA==
X-Gm-Message-State: APjAAAUXKH0ywo7ULdzcjlirK2CS4XEitnydTVgrTCAf2MpDU5en8hYD
        8IysbTe/L1ezFT9lxaXhVGVoLv1Ve4E=
X-Google-Smtp-Source: APXvYqwMhCJxzc4pEZrfs2BKNujwHiF8Ldmsf+a5IRB/A0hSS/ZJEzmmUbUgiRrOC1rVg4azIyQLlQ==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr1405876wmi.103.1569309721963;
        Tue, 24 Sep 2019 00:22:01 -0700 (PDT)
Received: from szeder.dev (x4dbd468e.dyn.telefonica.de. [77.189.70.142])
        by smtp.gmail.com with ESMTPSA id s19sm2468801wrb.14.2019.09.24.00.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 00:22:01 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:21:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
Message-ID: <20190924072159.GD2637@szeder.dev>
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
 <20190922195312.GC10866@szeder.dev>
 <8e7617ef-85d0-df3f-4418-5a2502b8e726@kdbg.org>
 <20190923083723.GD10866@szeder.dev>
 <fe58f33f-a3ae-4981-5bb7-d1659f3ab189@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe58f33f-a3ae-4981-5bb7-d1659f3ab189@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 09:16:26PM +0200, Johannes Sixt wrote:
> Am 23.09.19 um 10:37 schrieb SZEDER Gábor:
> > On Sun, Sep 22, 2019 at 11:01:26PM +0200, Johannes Sixt wrote:
> >> Huh? For signed cutoff and positive CUTOFF_DATE_SLOP,
> >> cutoff - CUTOFF_DATE_SLOP < cutoff is ALWAYS true. Signed interger
> >> underflow is undefined behavior and signed integer arithmetic does not
> >> wrap around!
> >>
> >> IOW, the new condition makes only sense today, because cutoff is an
> >> unsigned type, but breaks down should we switch to a signed type.
> > 
> > Yeah, that's what I meant with worrying about signed underflow in the
> > commit message.  As long as the cutoff is at least a day later than
> > the minimum value of our future signed 'timestamp_t', the condition
> > does the right thing.  And considering that oldest time a signed 64
> > bit timestamp can represent far exceeds the age of the universe, and
> > the oldest value of even a signed 32 bit timestamp is almost half the
> > age of the Earth, I wasn't too worried.
> 
> Note that commits and timestamps can be forged easily. I'm not worried
> that Git does not work "correctly" with forged timestamps (as long as it
> is not exploitable); but when it is simple to make foolproof, we should
> do it.
> 
> BTW, 32-bit timestamps cover just ~135 years (not half the age of
> Earth).

Gah, forgot the division with seconds/year when calculating the range
of the 32bit timestamp.

> That's too little for people who want to store historic
> documents in a Git repository.

Indeed, but 'timestamp_t' is defined as 'uintmax_t', and we have the
Makefile knob 'NO_UINTMAX_T', in which case 'uintmax_t' is defined as
'uint32_t'...

