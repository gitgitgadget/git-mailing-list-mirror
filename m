Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EEC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73B3205CA
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QstalCrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKJNbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 08:31:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B4C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:31:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 199so2161314qkg.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 05:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PFwJDqR02NDF/MHciTdFe5IdUoACax+pLWWGpgV5jP4=;
        b=QstalCrcPMf7Ul8nSb2JgoCwxsDvno0G/nDBSDk35U1dF5fZegHGSh7H0sAZ7Sxzyn
         xBdPxuyupUylxR3hNB15yLrF3Su1a3KEg/60Rz5YqaqoFqUICcmJ5QP7yNfMrxGcj7WN
         9e0eV2boMXMQ0EzneqZvaLF+Vu638s9sxOsnPzFnvTBaf+GbHZKpu6xNfT5fEtDu6xx/
         RkGa2AXFJtqfxAJneY2TSxa4kWhtMx+zKdIocgXLyR5bnSeZMNM+PkQGF2jU6zpjnO3l
         wspB8+u9lVbrixQI6MobKhwGjLrRojGLET/ePnF39hWnZzQo/ZhGntAcx39TEiBD+1jU
         5TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFwJDqR02NDF/MHciTdFe5IdUoACax+pLWWGpgV5jP4=;
        b=a+CcmkXp3tVsJtI98sLPbOJOQnIKfkQFfQYBDgJIZFe3npbILeImVmelbnrW5NkCKg
         DkQsOmyXjXsL1oeJEOfbrDoFaS+WyBV/cJ/c6V1d/Sy1UWCu1jX/tDz0y2a4+TuBP3r5
         s4c+ijGZhMcMajVGfdzySLnoxltxpnQCPd+Ghs7dDpzg884D7uIoybd6Mb3BPnVxdQtr
         zm5N3OlrvKLnUNLXaNy+VDkhffT59qetcV4CJjgoP9rxhMKR4ua9b6M+KvzEc+XaMjDz
         eNm0FKQGUGUdKjNOr8wnBC1LHKCmlPgBtXtRcKFTK49v3bQwtMf7EExMBW0mp7kkSS82
         nJmg==
X-Gm-Message-State: AOAM53167AFOyJAw8jEyOYpTItQpyz4PMFvivpLEkBQfLS1ITWkDref9
        8FsiRLXU3tYne5dPPElv5CJyuX+lx6TRwA==
X-Google-Smtp-Source: ABdhPJyHRp+w4WssydEBdStqHBncYTy88ep9CQWNd7ouD1StowogIW7Pg9/Bwxn5/05LltyPrJ7d5g==
X-Received: by 2002:a37:aa93:: with SMTP id t141mr18730562qke.400.1605015096820;
        Tue, 10 Nov 2020 05:31:36 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:682e:9bea:2ed3:2846? ([2600:1700:e72:80a0:682e:9bea:2ed3:2846])
        by smtp.gmail.com with UTF8SMTPSA id r55sm8056464qte.8.2020.11.10.05.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 05:31:35 -0800 (PST)
Subject: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov 2020,
 #02; Mon, 9))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
Date:   Tue, 10 Nov 2020 08:31:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/2020 6:42 PM, Junio C Hamano wrote:
> * ds/maintenance-part-3 (2020-10-16) 8 commits
>  - maintenance: add troubleshooting guide to docs
>  - maintenance: use 'incremental' strategy by default
>  - maintenance: create maintenance.strategy config
>  - maintenance: add start/stop subcommands
>  - maintenance: add [un]register subcommands
>  - for-each-repo: run subcommands on configured repos
>  - maintenance: add --schedule option and config
>  - maintenance: optionally skip --auto process
>  (this branch is used by ds/maintenance-part-4.)
> 
>  Parts of "git maintenance" to ease writing crontab entries (and
>  other scheduling system configuration) for it.
> 
>  Will merge to 'next'?

This hasn't changed for a while, and part-4 is also sitting
after some initial feedback. I'd love for others to test
these background maintenance activities in their home forks.
I certainly have on all three platforms.

Perhaps part-3 could merge to 'next' soonish? I know we
discussed only merging part-3 and part-4 to 'master' at the
same time, but it would be good to have part-3 start cooking
in 'next' sooner than later, right?

Thanks,
-Stolee
