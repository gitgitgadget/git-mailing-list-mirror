Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC6C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 19:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ2Tcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ2Tcq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 15:32:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3826550
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:32:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q142so1023519iod.5
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IukVWkzUYKq405CSdVMW2rRCPNQDwV7kfEwB8Uawsr0=;
        b=zXvaMJeyyjckukV593e1PrSoSp74xExQEZsuQku3spqyJ/GmqdksDSjO0Zf8zL292R
         1VVruJ3A02y6yWg8AErVGb44upYeK86zKQS2uab3X3470/gLvpmKbNeoUYlp0HlgnZF9
         w8/LsGhia2BD8HaUws+jUBgiSk1i+Dtw+7h1xlVLDjhOYUD1iDCvRyJr7cag/aAwaqRp
         BwhbRWFug6JvitXqFrKhjemntd/YuL4oJzPhVibAxkuFz2ACIewUJrZ+aP3PLS0naQFC
         qMc/AoGHfw2XC4FUPvKUWKayMyQYAosvblPh7sFxazKklllVh00vlllyNTmAye69MdIh
         mRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IukVWkzUYKq405CSdVMW2rRCPNQDwV7kfEwB8Uawsr0=;
        b=d7eRr8epQOKOv1LWHTUG2D5ca8E2KzumcV5M7FDUtkCwCJOVugUdJsFMu0TEjs2nd7
         Gfg4XDe+yFdx5t+yJN76ugV4h3qeXTstNpP9xnNIbA3020sNQKICEi4AYRT2Sx5raswe
         fKxxJrSQq24kESGtIxsXLdu/wIPI+21MGWeq6yHYtV8WxNci1GlFMO0NMDZN2ZAhi1L4
         eZyy0y7DfvmT4CTrUnF0HzeAIiAupFVoksv51rBpB+0mFP0zZxaPUB+qnURcp9drrJOt
         loDNsFIvqGCKrTjRmPb3m3O+qlAgZuv3KJzWFQ+uN0D9Hc1vP0DJLUDucjCLQvWvHk7D
         5VSQ==
X-Gm-Message-State: ACrzQf2/1ltXuOqyxbmTHplsNbCzCpEDpsUs4tdjblUnMj+0T86La34U
        RVD6EqTXB4YHRuyW1mvHNkWcmA==
X-Google-Smtp-Source: AMsMyM4dHJZQF7bjhmixq8SnugR6sZHXyaAdmURKsfU5+JopGid8EtMI6LNr86mf+LsW+w4vvsePkw==
X-Received: by 2002:a05:6638:130e:b0:365:c3df:edef with SMTP id r14-20020a056638130e00b00365c3dfedefmr2858768jad.205.1667071964352;
        Sat, 29 Oct 2022 12:32:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r17-20020a056638045100b003743cc92b27sm882060jap.157.2022.10.29.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 12:32:43 -0700 (PDT)
Date:   Sat, 29 Oct 2022 15:32:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Message-ID: <Y11/2hyApN5NLruq@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 06:30:36PM +0200, René Scharfe wrote:
> Replace the convenience functions run_command_v_opt() et. al. and use
> struct child_process and run_command() directly instead, for an overall
> code reduction and a simpler and more flexible API that allows creating
> argument lists without magic numbers and reduced risk of memory leaks.
>
> This is a broken-out and polished version of the original scratch at
> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/

Thanks, this round is looking pretty good to me. It sounds like there
were a couple of small comments for which a reroll would be appreciated.

Assuming that that all looks good, I can queue the rerolled version.
Thanks.

Thanks,
Taylor
