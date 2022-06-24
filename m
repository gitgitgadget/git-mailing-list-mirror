Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B1C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiFXIEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiFXIE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECD26DB08
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:04:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cv13so2032878pjb.4
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y+MTd6elMXddTYiCaS2xBO/yqR2acHOCqONaSEQj0PA=;
        b=EOq6ZCbJ0OCawmsN+/jNeK9uFZpZ9P7RFhZR3B1sZ3tFJfcZaol0ajzGRAg9buVWHN
         tA+eH5bWurzQocEAD3SRBbm09jmIWrIyrQ53vcK7k2hSMq5tQwWGueMTIED/HFTKxwCP
         CKuKhM1R1hrmPhXVU5/RxWUPfSZa2sj6JVOubf616GF4+ezekTUy1dTe0P61gnHbwW5o
         fuKIUWOCkCdXd4/ulXjSUKxQGLVaGOWgnmCSnCmqj+RYHR5TvtNFO+4XRA2ODq7g4UQH
         /v3oQYJ1bPINduPGYL1G6Cr+INsiCsAepVc1snbLj0YD+JdhzjqAjLZUwI6QnhjXQQc9
         No9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y+MTd6elMXddTYiCaS2xBO/yqR2acHOCqONaSEQj0PA=;
        b=QPt4GThwzVhxgr6gP423OEgzTWCnReUGeBBUlaa4Lh5/LT+zmqNhiSSPmVTSQ3j15h
         N2AHG2QeZa/tSW36ZgBpDmjYJx8mLW4aDXzlCt+biabLfRI1H0sUg17PtS0WQoKEENDy
         g+JiIcIGn61BagOFZ4IWI1AQYtliBT94EWmTSKv4aSBFwokwe5zorkiP+iK594CA9TT9
         Ma4rXPpmAc+AF35X/c/+CcPceAG+lwUoBmOuHwuEz9D5xpJ9EYaj9TAFyzrHJf2X4Bex
         jDnHC4Tv09tiq2SA9AYY8Zy+dtYkYiyTBpqLDN6repovmRFFKxqCwtjVGNQF808CAp8I
         mJPA==
X-Gm-Message-State: AJIora+nJ4F7apV47lfFTiJFZFq8bXfvXlwVvq06XgcdDCAhJp7KcJSw
        QQQposrb5+KxWDvJ2LHoVqk=
X-Google-Smtp-Source: AGRyM1v6u6H6WCUkjYvpMnfDkh9CJ3AAXyOTl98tJHCYLxxcMAOykWrHN+Y7B7WTnM5znYqFcRSU/w==
X-Received: by 2002:a17:902:c3c1:b0:16a:14bd:8b19 with SMTP id j1-20020a170902c3c100b0016a14bd8b19mr29939414plj.152.1656057866835;
        Fri, 24 Jun 2022 01:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090a481400b001e882d2eb02sm1097220pjh.23.2022.06.24.01.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 01:04:26 -0700 (PDT)
Message-ID: <f9e32b31-8b4a-2d07-4074-be10347764fa@gmail.com>
Date:   Fri, 24 Jun 2022 16:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/7] mv: update sparsity after moving from out-of-cone
 to in-cone
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-3-shaoxuan.yuan02@gmail.com>
 <3e84bdc5-31e7-a7aa-8404-228424810f35@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <3e84bdc5-31e7-a7aa-8404-228424810f35@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/23/2022 11:08 PM, Derrick Stolee wrote:
 > On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
 >> Originally, "git mv" a sparse file from out-of-cone to
 >> in-cone does not update the moved file's sparsity (remove its
 >> SKIP_WORKTREE bit). And the corresponding cache entry is, unexpectedly,
 >> not checked out in the working tree.
 >>
 >> Update the behavior so that:
 >> 1. Moving from out-of-cone to in-cone removes the SKIP_WORKTREE bit from
 >>    corresponding cache entry.
 >> 2. The moved cache entry is checked out in the working tree to reflect
 >>    the updated sparsity.
 >
 > Since this is a behavior change, can we test it? It would be good
 > to verify that the new path exists in the worktree after 'git mv'
 > succeeds.

I don't think we can effectively test this based on the change per se.
This change is preparing a correct behavior for the next few
commits, so I'll say it's tested along with the next few commits
(i.e. move "sparse" file/directory ones)?

Thanks & Regards,
Shaoxuan

