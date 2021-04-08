Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8551C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E9261151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhDHNbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHNba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:31:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A33C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:31:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d10so1400313pgf.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O2JAUeY5GcWHxrHaIZAd/VeUAll1zpdqiRdWw3l0qYI=;
        b=gnP2BLWhAgEUqCx4ujY2gjtdQdslFmN33ml8Sw4PhjGhswSq3myc0Pr+OYvfa9ZfSA
         ehXekpuZWnic4VA+W7YQmcTBspZS9o4+ha7dk3QX/VGCijvTTdWg1hJcBslMmPYbJiX1
         yWq1AA2ta1h2vMmSb2htIwk9JA+hhQZh9BJU2FVoBONB02U8to1ZErXVh2pWH66rkfYy
         9l98ukL4qnhgdWHJpf3olmre4Jkw4O334ARN3lv/tR0O0sSE1/wK7E9z/Bxo7JHwLDf0
         q0r7FA3qbV/xQQ3OiBre1oSWgBk4t3eAMQusDnEzMyIw+ExTy1h7lMbZaYxmxEvmKQTA
         qpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O2JAUeY5GcWHxrHaIZAd/VeUAll1zpdqiRdWw3l0qYI=;
        b=NHHQa8FGJ0QybY9leirBXCWDqCmRB00p/238Lm5qA537ONFROIL+mcLpJVQ6y2W0Qo
         pNsnTgPF32+CV5dcckOzdIFo9i+vLigZ+KSwPagwNgpCP4hFZ78Jy587/ZmD42Jz2B1P
         fWONQ2gHY7k6i/OAv9PWStipnFwij/tjvzmpKpLWHySe2HvmUh2Ao7WXd6MgBVhB5ZzI
         0evD+sVEbkCIdnP6fEylXrDrZ6TyRw+W3kOB5ZMCP3X/Dqrx7/jgCBraYrPUCDrLmAbx
         d4wB4dfpOFF1gttQUFHWJXgUG/I4kbo9wtyT9VadwabWpAUTIo2D82XbvzYw2f/RmEWu
         KTAA==
X-Gm-Message-State: AOAM532zmsu03wcYa4+41o+Sf8nsmgmZsFhg9FeuxPKdnLwkGoA4TWMp
        4nsq1nyygvqThy4w5wAw/AapUE493GMO8Q==
X-Google-Smtp-Source: ABdhPJz3m1iaeyBc677RamZOyrwMmq7aSNmKcRKdteIStm41Wa4CJT+XwikaUK6BqZ9fJY9UvvWU5g==
X-Received: by 2002:a63:f54b:: with SMTP id e11mr7897612pgk.139.1617888678057;
        Thu, 08 Apr 2021 06:31:18 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id y12sm25160775pfq.118.2021.04.08.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 06:31:17 -0700 (PDT)
Subject: Re: There should have be git gc --repack-arguments
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
 <CAGyf7-GQ_1JV6X3Z0h4c3+Qy1eZ30RW-Mni=72p007md5NLKMg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7c53b1e6-5801-7e96-2939-18abbd8d1e53@gmail.com>
Date:   Thu, 8 Apr 2021 20:31:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-GQ_1JV6X3Z0h4c3+Qy1eZ30RW-Mni=72p007md5NLKMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04/21 02.38, Bryan Turner wrote:
> I can't speak to the feature request, but since there are
> configuration knobs already for both of those, that implies you can
> use git -c pack.windowMemory=... -c pack.packSizeLimit=... gc and
> those configuration settings will be propagated to the git repack
> process that git gc runs.

Oops, I overlooked that. Thanks for reminding me!

-- 
An old man doll... just what I always wanted! - Clara
