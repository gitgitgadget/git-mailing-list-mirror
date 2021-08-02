Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77137C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5523860F5A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhHBKdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhHBKdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 06:33:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B1C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 03:33:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n2so23747766eda.10
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GWSvkkUBWPh1SGaG52Jx34eG3uujZ/FCYG3jUIKngUM=;
        b=qTuL86L6wh9B8V0LujTv85UbTG3eadGsFUk33V9VBhPAYRbuM3dH1eIh+GU2OGGwhc
         aaYtobgJogQzEVs76wYbCVCBhcB8B7VXphFGxErsm2jzQcDg8rza6YDIJzXIh83ig0JF
         BOEhRjoGkbDfG5xH1eEQUxnI8DsGACBKK1KW41OCBIt9iasQ5sEndbuohzV+UMVZAZBs
         NPqbdqXawiTOWSv+rykvT6smw84zRCPYHcKVXnCPF7FTKCG02sYn/QDrHDWvfSi1iMgN
         /4TmX2aMLZBdVgMmq2ULMpStL+Ad6QMUAx5/T3oKAYfsIMCTXHNkxmGg3IHoXejrdrgC
         35KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GWSvkkUBWPh1SGaG52Jx34eG3uujZ/FCYG3jUIKngUM=;
        b=oOwyHtVWrYqD2A+IF/xuXOOcLrvCdI7KxX1JBSCfCkXcmGDCVa1aowxi25kDNIxCUl
         mrJ35sABv+ycJGmM7ZkBoRrst+ojEO7NZvtI3P8+OsnZhhwTPDMJyeippWtZRRZwnubw
         Bru9sBuNc05tH7gzMPI9xk8XaAfkcNy74DCI47wY958EChUByWKzIxgAcraeicrYNPs2
         rQ7k40Bv2j29KlWFqARhw9jCVbYMcyRy8aBpB65sYztFRAvJR9YqalQQ2sPbKHkZOmd8
         XvBr+f4fa9XmXSS/zWckNdIFqdk1Bv2y19drmxmF4CCdegEz1TaCCBoCpQWSp7fcYuoQ
         vxRQ==
X-Gm-Message-State: AOAM532QFvSrodfMNP0shNdH7UOVwV1dHjQV2B7vCINtFprrsD/zXMwt
        pms9gBEHsobxf0xtDOx6X3A=
X-Google-Smtp-Source: ABdhPJz9Xjg3Ov67Bite3jOJ6Z05rHaUUZ/E5D8gbgMtedZD9KqTGoFxW24IPu2HM2rNjXPsAYFtUA==
X-Received: by 2002:a05:6402:299:: with SMTP id l25mr18365372edv.283.1627900390403;
        Mon, 02 Aug 2021 03:33:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jj19sm4358122ejc.85.2021.08.02.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 03:33:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
Date:   Mon, 02 Aug 2021 12:32:11 +0200
References: <xmqqk0l4xuvo.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqk0l4xuvo.fsf@gitster.g>
Message-ID: <87im0op256.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 01 2021, Junio C Hamano wrote:

> * es/trace2-log-parent-process-name (2021-07-22) 2 commits
>  - tr2: log parent process name
>  - tr2: make process info collection platform-generic
>
>  trace2 logs learned to show parent process name to see in what
>  context Git was invoked.
>
>  Looking good.  Ready for 'next'?

I just replied with some issues/suggestions and a (to me at least)
working patch on top to make Linux log the N parents like Windows does,
as opposed to the Windows having N parents, and Linux just having the
immediate parent of this series.
