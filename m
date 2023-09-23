Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C2CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 08:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjIWIL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIWILz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 04:11:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83217180
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 01:11:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405524e6768so9360575e9.2
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695456707; x=1696061507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrlrCftivd4WdPXIJMRvcV8qIjuBLBxsc7iCJspcccQ=;
        b=BUsqVPUL2XkrqVHTgr52gSyjHnY8t1MbjEnbYnUWWf+Beq1eratsBfAT1PE6emWBGC
         IFYWBmcsE80fVX2AJ7MnQ3Zwxe0FbAA37KpB4fGQCOWKY1ISMeijLY9Q35DaKPGG2n2b
         S/IS8edPx4KVzKn4B6OwYCOZaoSNtlTyn8iUgjXW61XP1XFuYB35ruIRMdiEToXbPof6
         kPBFmTJNw7TIJ6xxOhXWFoXyo9j+jxOQHzdc+TNcUqoDLHBTxD5u9TPk7DqSLVHvFmog
         FikipPPm2+7qvFKodkZWxH+Ch1XRYNnt4kT9De1mx6K8M3EP+L8AO2ZSoyedsi68U7+b
         hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695456707; x=1696061507;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrlrCftivd4WdPXIJMRvcV8qIjuBLBxsc7iCJspcccQ=;
        b=Db/WwWMtC+01QB07nlgIOaRsASX8trHMaWYLoCub9JJJcRtKFQpWctFQEKEvPArCGb
         DxhtZWlfX6b/Dlbg4ppX3kFY0SbtQiMRINYKT9cg6zRTK7LutlJa+V8cEX5zOopDwTnN
         r+WTtkl+eqKLlwfhuBo9n9pQYiqqOb+6PmJb25We2xmwWmlKdmpKKeow/Uhi7aKtvkrC
         c7Z1QA6ACFpFEDMz/+WQrUsloKjVL0Bj0WsxP588CzHp2y6YUOoMtXmwzYjQ6HdkBhnb
         eofS63vayajAKbTzFstWdvJ0r6dBMXSJ7bJVRUmYz0Jq5BI/qZLnFrq39ap1YFywZ3H8
         zfDg==
X-Gm-Message-State: AOJu0YxcCp7JChh2VkKjZ/HFLH+m2HI3NmaiUUU5dh9KFS7qb/ioZxRR
        HMcnJOCpOrFITawDYOgMcNQ=
X-Google-Smtp-Source: AGHT+IEgLqCoWJ33dxhDq1MC84nEw9pMTQLHPjKhgWth+Wm1ygLlt6xa5oENk3yKtih6KzFA8n6cWw==
X-Received: by 2002:a5d:4e91:0:b0:31a:d6cb:7f9d with SMTP id e17-20020a5d4e91000000b0031ad6cb7f9dmr1734897wru.24.1695456706735;
        Sat, 23 Sep 2023 01:11:46 -0700 (PDT)
Received: from [192.168.2.52] (203.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.203])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b0031f82743e25sm6288483wrt.67.2023.09.23.01.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 01:11:46 -0700 (PDT)
Subject: Re: [PATCH v2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com>
 <20230923062415.GA1469941@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <f33cbdf5-9887-e9c4-504e-f7d96e630bc4@gmail.com>
Date:   Sat, 23 Sep 2023 10:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230923062415.GA1469941@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-sep-2023 02:24:15, Jeff King wrote:
> On Fri, Sep 22, 2023 at 10:38:06PM +0200, Rubén Justo wrote:
> 
> > [...]
> > Let's add the missing conditions in the if-elses chain to make it work
> > as expected.
> 
> Thanks, I think this explains the situation better than the original.
> 
> > +	elif test "$test_failure" = 0
> > +	then
> >  		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
> >  		invert_exit_code=t
> > +	else
> > +		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
> >  	fi
> 
> OK, so you did add in the "else" here. :)

Yes, easier to explain XD

I had last minute doubts about the missing "invert_exit_code=", but
decided not to include it.  This way, "--invert-exit-code" works as
expected with "failing" tests.

Maybe we can make "--invert-exit-code" work in the other cases as well.

But let's let the dust settle, before scratching that itch :)

> I am obviously fine with that,
> and the patch overall looks good to me.

Thank you for keeping an eye on this.

> 
> -Peff
