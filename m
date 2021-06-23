Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36657C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE416100B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWIPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 04:15:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40527C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:13:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c8so1725510pfp.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsZgOywFV0vGhWDOM79WuNQCSXay/KLuGM0NYkbAiQM=;
        b=As09LSMo/cU8XAa2AE3Fglo3oMZpiOOpebqkSBwgPvzlnzN+EVN0IvQr2j/5ULhSwd
         pPH32LuAm893xZJNsfzzqCHK//yctDgPgCz8mb3NoeFlwLlTmoEAuOAFHJu5eMs6wwMT
         TGMxZo7z0b5Ca+T4wZiZqDaxrFp5y27NyBo/+RczlPfQknXUC59tHHy6613Vd/gCFDeR
         kpIyYcKnTEUDZ8tZTa7eC8ZjcyiR2gE4gwGV9eDD4Ko61p2kkgIK0JC5b9ndZFoLknqn
         ho5I54pLLcRw1GFqrI58behIG2pc50Xnw5SG57XJEidYN281TY8VV3Tu5uHhxxyujcUP
         c/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsZgOywFV0vGhWDOM79WuNQCSXay/KLuGM0NYkbAiQM=;
        b=D4U6kYHg+lDm6YtN7Ws80Hzob6RLWQ4qNIz9H0NrVN5xXgGUa1wbr8Mdnw69uJLKPt
         VVWVnoN/6fWpbsf5UPUwVneliIbZtB/KkIhEe8CI3P49ytpydHd+L+jR2r4QLy0tawpx
         +ENPhoSC+JENuEPoPxno+3i56WzLIcREwiAX9D0POwEY3iKvl5J9xAThAXzRqOcWendr
         MvIk3BkOucDB/rHDLF2OFJQS0p9tsLZkNr7/+Cc7XmY78qLbyM0f4AU4LUMnesSkXOaM
         cJx+MmB0Fzy4TTdzzPtaaXcekp0DfqOup3G1yubYW2gQAfrBxBd1IfQFvvmI7TXTmCpw
         qyQQ==
X-Gm-Message-State: AOAM530DhRJNDHPH2UJvFavOa08ohY5NQHgEq5g9TWy25llCEvbidbh5
        uXTWX2NLxVmhJoEk7C07Vixb+0AFGgO1XA==
X-Google-Smtp-Source: ABdhPJwWS3jHfLQ57zboTEh+bAq6eR8CkRxLV+disAy2Blyqo8Ilm5MxKhRbjEO9JWAgBrMR7uA8HA==
X-Received: by 2002:a65:49c4:: with SMTP id t4mr2836942pgs.108.1624435984761;
        Wed, 23 Jun 2021 01:13:04 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-46.three.co.id. [116.206.12.46])
        by smtp.gmail.com with ESMTPSA id n23sm1678302pfo.196.2021.06.23.01.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 01:13:04 -0700 (PDT)
Subject: Why empty subject? (was Re: )
To:     Avishay Matayev <me@avishay.dev>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2c2cfbc6-c428-772e-6ccf-66261cf0e331@gmail.com>
Date:   Wed, 23 Jun 2021 15:12:45 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 23/06/21 05.40, Avishay Matayev wrote:
> P.S. I am a complete newbie in regards to mailing lists etiquette,
> pardon me if I've done anything incorrect
> P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
> changes to `pager.c`, sorry if that was wrong of me (You probably got
> this mail twice because of a misconfiguration, oops)

Why did you send the thread with empty subject?

-- 
An old man doll... just what I always wanted! - Clara
