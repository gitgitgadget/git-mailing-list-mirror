Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D030C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6946108B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhJOJuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhJOJuj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:50:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC5C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:48:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so25322107wrd.13
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IEBtJRB9U8JfRlxPnLLLxVLh+zXWUxhJtVKNxG5eCVo=;
        b=GZJ4DaLySqv1jLrfyZZo7X2kvD2ygvZRvkD47SqhTtffOZU6qmK+BEmVKQ9yOhB9aQ
         Vjjq0iW7tVR3Cxft1tDO0oUCgp1rgwtieLj7zqPsRytXz+GfzNw+AtWGTdRQHvJvadyj
         3+lSt03x8Yxb7JM1ZM/ahVbS5JnL3r6v50W0QlhPYMPXu7Uf1CRKMYACtJlQhoyW3Np8
         QNdowjU6hL48alg4a9mJUwazodSSw3BRs+P2/JnigrGt0pJDSoZ7t4WkGMPzYO3SYktg
         oEL5iwre8PsCYXCh8jXekPanrQJrN3qEI1Wx2Afy8CxUVJKaNTtcNES6wB+BB/mr3HHo
         eDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IEBtJRB9U8JfRlxPnLLLxVLh+zXWUxhJtVKNxG5eCVo=;
        b=byNsw1G1/V08Qx88KyQ3JhCLCSMsWMh+y0zFrE5+vYseQSq2sf2boUabZO2qn6/GPG
         Z93TH3/wLIGd4TgTyAeVFN66LEYMxjQcfjV6FQ3wcfZ8jYhlcBZsv0q5x0fgjkGv7pwt
         Y/0x9MuEAwFzCZAcJL5v7Z3XOflpJ5Pb2Xn7Wdfr2yhS2BVVulh97RHj3C6+EzW9Nsrd
         ly6T6dhnbs1ZAlAd075zV6Rgmr/x7aeUWJwhyNs0ov/aSOcAPvj5uc6ERyKwlUTUIFD9
         BHBqf8Ww6GQC/6Fsx4LiE0j37Hqiv5LVTOQzf6j99WlMftIY9Qc6RiWF+1xaDBLhOHpb
         6TVA==
X-Gm-Message-State: AOAM531wAd4GafSXE9QJZXV+lDQsS1E5TBVP7XB0RcrC3+8pbubcpPqW
        +1zdhZiG9SsJMHvnvodUpQyeIFL7tjJ5Dg==
X-Google-Smtp-Source: ABdhPJw7bIqDOwboKuLrp0OPj6evOaeg3RHkpxGgmo/W0frmjqPDYhBIV98xnUKwEPmW6/+h7ZHWFA==
X-Received: by 2002:adf:b302:: with SMTP id j2mr13245618wrd.285.1634291311395;
        Fri, 15 Oct 2021 02:48:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c3sm3257793wrw.66.2021.10.15.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:48:30 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbJpG-0001mL-Er;
        Fri, 15 Oct 2021 11:48:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #04; Thu, 14)
Date:   Fri, 15 Oct 2021 11:48:04 +0200
References: <xmqqwnmf9lnv.fsf@gitster.g> <YWjfY3/62q6qNhFo@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YWjfY3/62q6qNhFo@nand.local>
Message-ID: <87pms6ehzl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Taylor Blau wrote:

> On Thu, Oct 14, 2021 at 05:28:04PM -0700, Junio C Hamano wrote:
>> * tb/repack-write-midx (2021-10-07) 10 commits
>
> This reminded me to check on the status of
>
>     https://lore.kernel.org/git/42a8d2ef-3a67-ca2c-4334-b79975d45da7@gmail.com/
>
> which hasn't been picked up yet. Stolee took a look and didn't have any
> problems, and I think this is an important one to pick up before you cut
> -rc0, since AFAICT `git multi-pack-index {expire,repack}` are broken on
> platforms that do not allow move-into-place when the destination is
> memory mapped.

I've looked all of those changes over and they look good to me to be
picked up & graduated.
