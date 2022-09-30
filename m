Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7FC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiI3W74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiI3W7x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:59:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615A18B3F
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:59:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so8887056wrb.13
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=pBJxlqjJ6oskoUSeYSsj970BDXTrE+l0QXQCmzHbF/k=;
        b=FuPoMFj+fc6RVjN02teCfJFLRNgEDN74k115fYvKyQDvh2VfemmGzHAU5TispLSbBO
         v29j0DAngmf28t08W0+vKxnCHNY70OmInKpJNnLDV4dBSTjtBwiADVgBAq3WyniDcEh7
         VcqQSQoCYvEt4AuyGDkMsjQ5yX+r/NS/WQpQn45+BvvDBvGR8G4+T8+bKJAGtb4Ot7qd
         kvhB/PoMFBoJzLSOdV2KHPIxVc5AJXjbJ7uY6AzxWd0HxwG50ZuQGvL35AoPfi7JMB5o
         u5pCPfgkWCZkWR+fXC5r5Rj+Z+/ML9LVKGU28Ok/F0Yk/WfnMxSequA1KWON9YD6JEb4
         qSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pBJxlqjJ6oskoUSeYSsj970BDXTrE+l0QXQCmzHbF/k=;
        b=M1DuvQpZwRpg4zmOzC76D4tRnHSYhv7n/NnDYJSkrWb/Dw1R/dTvp/xLpRPGK7rSHb
         cu3DO5UPR0i5H0v2cf3IrRaIvvx3NBhd/9xZ7vWu6NXfiizOFtSX3kxQ+G52AD1a9VEh
         pA+J4feX2VEdemOkcNY3Mdo/2pmhs5pFNEZzIl00uBAywUXl6reSVEEABbG9f8JAHxaW
         WFZTN+mEqCcYlx2t2dgsVmBMQF53d2nhN1b4kwGgsF7VFlXsmaHOsvyghtQUXZRGO6P5
         d+leaOzCl+Yqz4UBrgHY7EZ8qmwhNBOLhWYtNbua2I7DSuoaA49uDQPvHoc30Ugp2d61
         OWzQ==
X-Gm-Message-State: ACrzQf1l+lLeKHTqvyPt69CGAkFMZeC744aSrGi4SQTFAPVgnPl+kLJh
        w2uK7vDubi07+CrQKrOxV8b8CYq9Oz0=
X-Google-Smtp-Source: AMsMyM4EhIAhJCErDvWO5RSH7GLmquXikxTqA6Es5ck7Xf+dDR1xcZKdSZZXT37IDxH+Ch9MQraQkw==
X-Received: by 2002:a05:6000:10cc:b0:22e:39a:efe4 with SMTP id b12-20020a05600010cc00b0022e039aefe4mr2644608wrx.256.1664578789717;
        Fri, 30 Sep 2022 15:59:49 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id o6-20020adfe806000000b00228c375d81bsm3318745wrm.2.2022.09.30.15.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 15:59:49 -0700 (PDT)
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqczbftina.fsf@gitster.g>
 <ba8a503b-76e2-5de9-1082-3b4c6ecd0cc3@gmail.com> <xmqq7d1lom12.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <0c875ba3-f2cd-7fe1-3192-7759e5cebdb7@gmail.com>
Date:   Sat, 1 Oct 2022 00:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq7d1lom12.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/9/22 0:26, Junio C Hamano wrote:

>> And.. the message does not make it clear the situation: if there is
>> a previous description, will clear; if not, will keep.
> 
> If there is a previous description, then we use the behaviour we
> have had for ages (i.e. will remove).  If there is not a previous
> description, then we use the new behaviour (i.e. not attempt to
> remove and hence we do not show an error).  Either way, the end
> result is "the user indicated they do not want description by giving
> us an empty edit result.  After the command exits, the branch has no
> description".  

I was not clear, sorry.  I was referring just to the concurrent-editors
circumstance.

I find your last paragraph in the message might suggest that in case of 
concurrent editions, the last one won't overwrite if exits with an 
empty description.  But it will if the branch had a previous branch
description when that last execution started.  You might want the reader
to assume that the example follows the initial description "on a branch
without branch description", in that case everything is fine.

That was what I was trying to review.  The usage and why the error is
avoided is well explained.  And better in your v3, imo.

Thank you.

Un saludo.
