Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B895C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015D2610E6
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhHTJUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhHTJUT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 05:20:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AF2C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 02:19:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k24so8543069pgh.8
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ls7LXLh/2NrVq6FQ0AZrXnN8SmwsTXrLa/7CVGgrBOs=;
        b=BRQ+Flot4I8bQdLtaXypeClR0x9brBdIHgeK+iWI7E5zC/ga1F95qGdb4u6mQoDWDH
         9efKa7ABNHLnM7tZzSpV/Hs8CoBFWhoqHjrqNxPJz/Ow+Oa4Wl+shjJEM5CfRQdOlTiq
         SMItTsOZsq2aDqhUradEaQBoJcgNS1R4nFcjZhuUwnxlGDJlMmyrlQM3BVF1f7KRwFkt
         iFuVCo8KNaPd5qybm522+27nF8TW9taf71ir9eN9nVfnPkbKYaIMdckZ4PGJprAJyiN8
         tjsYOeprlvhZctUcK3fM8f7sjCAph2ewzg0B3M4TmfJlO/lv3yJlYsKnuEs7YhhjzllT
         U1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ls7LXLh/2NrVq6FQ0AZrXnN8SmwsTXrLa/7CVGgrBOs=;
        b=MzjpRDb465nUwno2rdz+GkiIasQqcmQByT/SWsizqASzjjK5z+dMHKu9tXudfMqJUk
         7xNTfMTC1w4DyIJ5yGtjItu1NaGmJT8lVEbIm2dI8B8NNlnkdyGxLcLpjrxXMSaPMoQh
         2ewO23BBUHXJh75b77IClRe5l+uTHkUPIEkD08CTyWFtHaPZJlPxBZ+0g7bG/g/fJ3/z
         V+kIL2E8m8sG/grjoYuojaQNkK9bG1C7Jxr/3m/MIdM/O4O1k6Jej2NaHdWn+kwRdcpH
         tAmb71UAIQmq5ZxLa7abZHdpwcfGWr7tOmez+eYljOHHLD94rLssfztbrsj6DAPGXL+P
         giuQ==
X-Gm-Message-State: AOAM533BgDBkoH2nVN8Y5GUu77oFWU5ncVhxA8DyDc9VLDWZ6Ms39ztm
        t9NIucaZzPet+1y/dN8xF1CQkWx2dvw=
X-Google-Smtp-Source: ABdhPJzGJFqOrlXpNbtSMExJ+EYbGTapW52rXRwHmZtX+g8Q6i+skBO3ROVngCwct9VhfCM4VumexQ==
X-Received: by 2002:a65:6205:: with SMTP id d5mr17978435pgv.326.1629451181656;
        Fri, 20 Aug 2021 02:19:41 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id g11sm6079873pfo.166.2021.08.20.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 02:19:41 -0700 (PDT)
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
To:     Jan Kratochvil <jan@jankratochvil.net>, git@vger.kernel.org
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
Date:   Fri, 20 Aug 2021 16:19:39 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/21 01.17, Jan Kratochvil wrote:
> reproducer:
> (set -ex;: rm -rf gitgit;mkdir gitgit;cd gitgit;git init;echo a >x;git add x;git commit -am.;git checkout -b b;echo b >x;git commit -am.;git checkout master;echo c >x;git commit -am.;git diff master^..b|grep -v ^index >b.diff;git apply -3 b.diff || cat b.diff)

I can reproduce your issue on latest Git (2.33.0).

It seems like you remove `index` line, which **may** contain blob hash 
information required for three-way merge with git apply -3.

But if you don't remove it when generating patch that way, you will get 
expected conflict when git applying.

-- 
An old man doll... just what I always wanted! - Clara
