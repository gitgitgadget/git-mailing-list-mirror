Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A491920281
	for <e@80x24.org>; Wed, 20 Sep 2017 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdITHkm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 03:40:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33053 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbdITHkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 03:40:41 -0400
Received: by mail-io0-f194.google.com with SMTP id j26so697580iod.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=irdkj8ohFNFQAcFaPdxD9PHlk1DhL2St0WQR3HI4yE0=;
        b=MQjHBzitvwvidrA5XtBBfdWyvyjKDYhjN85k4+aVlBWARucUvGKEoWLMYKCo6LW/l5
         H2JE9Rw64YgTAE1uR3E7HOZo2+Di1bzzgeYwMUdBNfLZJYRgBWcjsPm7UAHOmlSgVEaO
         pLT3hGl/DleW0RtJ+kkEjOxkGJVV6xWYBXSyRdj65D8ZsggLp8U2a6N53Y31FLt+6MMp
         KlgIFgRhuZiSGMjO9nAwiuLNHp0cd6QV4MwgfVhU9IynZlPEqEf+ru7ysg6w/KLCBZR9
         F6Oop9EHm6eTdLjOuWrutmtd81NdUucAeClyYIskKanoEW3x7za8ZLZRN1yDyVT/dwP5
         0F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=irdkj8ohFNFQAcFaPdxD9PHlk1DhL2St0WQR3HI4yE0=;
        b=QiK+7jW51hhrQBeDBKh0ALNmh/lH7qzxqaYm971nanFGf5pTrbiuJQHJ2xWUJ+VJu8
         zQ/7lAZlrIethoYSnx1KI2QPJ2TRYN/U18eUB4D/pGViMOubQlFU0ll23TXJA31jqpxi
         i3IRgtg88ZgHZr5wNDXVyg371s5Rs5VQTX+y//HjVp2AsOLiPEpC/zNWWp6bxrMayQYo
         ApmwaHZNK6ON9DqSp1vo2ci678NWQ0YCRUPO7dqUX4DH4ikBVkjE81yky/5r3WfUrb+/
         aKeWGFPi9hBZlf7XCTbycjBbxF8ZTxNolfrPG486DdMHsmuWNajjtdwBLZnYFXXBrQgk
         ySnw==
X-Gm-Message-State: AHPjjUgQ6HXMWQv5COtPIV+9A9j/DW/HSL89/un3F1jpELRFy74PInDv
        XEZ/0v+mURC0LFyiuYkbuzrMVcGF
X-Google-Smtp-Source: AOwi7QB8Z4ovcaCVOA1PmPiowRZxAZDcJMBLLRkIATCkyolRfatHMc70jJ2cmkbxhMkO3ZDz/wewYQ==
X-Received: by 10.107.135.90 with SMTP id j87mr5503699iod.159.1505893240779;
        Wed, 20 Sep 2017 00:40:40 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id s81sm624093ioe.55.2017.09.20.00.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 00:40:40 -0700 (PDT)
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior
 for empty list
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <20170920023008.GB126984@aiede.mtv.corp.google.com>
 <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
 <20170920052705.GC126984@aiede.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <b53ab56f-80e6-588f-fefb-53d7fe22edbd@gmail.com>
Date:   Wed, 20 Sep 2017 13:10:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170920052705.GC126984@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 September 2017 10:57 AM, Jonathan Nieder wrote:
> Guard the loop with a NULL check to make the intent crystal clear to
> even the most pedantic compiler.  A suitably clever compiler could let
> the NULL check only run in the first iteration,

Noted this just now. So, the overhead doesn't occur when the compilers
are clever enough. And as I said in my previous email to this thread, at
least 'gcc' and 'clang' seem to be clever enough.
> ... but regardless, this
> overhead is likely to be dwarfed by the work to be done on each item.

:-) That's of course seems to be true.

