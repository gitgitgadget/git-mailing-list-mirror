Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302EC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FE461DC8
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhF2MxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhF2MxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:04 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344CC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:50:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g14so3409996qvo.7
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmzRVMTbiWHEiiqAWAZqJndc0wjizD7Ar/J2++Y944k=;
        b=CmsuXwqNoZlrUPN4J6uFaYFPThGaCOIHWkeUqk4auV19IlRaqf/0Ow0eF6TyTRQ0p+
         NGyf0AuLllGWINTMF+GendWufM7UL7Fl7BOs4YKPO+eyyfCSfjyWSvrmYy6gEYUYBTA+
         DuA57bVhRRCY0f5zo7RnDaSRD1wd+Cf0ooAX4njDGTpoXm573TwucJhBEmmT8G1KiXVm
         yFyEWexvS249ZH7yH4+D+9pRRq3udWq1btX5I2mTjv+mNtx9jeG9SLE2ufcJjCtNk0Gk
         Qn0h2DvDAWpXFMOaof9+YqFZoqS+arOH8lcHhSbjFfSPQ5LjOTC6GXW2SIgujvZYSsph
         jblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmzRVMTbiWHEiiqAWAZqJndc0wjizD7Ar/J2++Y944k=;
        b=WsT81Taf12azSjp3nzPQ7NQaFnGq2DR7cpuRw2/2DRwgf9U/q4c/DuK7XFDUY0YcSq
         SH3RxnXJQcPVgAXprTrt/JG5yJQeVhbmpKqrKtqO8xDJGwPq0VroLY6mjdraPZmolune
         UwtnEwEu2ONj8Lc9WgKhfz8iYfpePdhrwbg92Izi86K4dwWc+y5sOPDArKhfzgZkHOMR
         wxaUqMYIhh9g3na0ppSG/Nfp4gQ9UtZbJVykxottIlga9wvzA1ZT2isTSmR++rJDsC3M
         v56CRqMBn6j1qTDn3ENA2sqswqztPO2BfIi0U538fz1y2xXWDQSzxxsps+0zAxE7Yvu5
         BJLw==
X-Gm-Message-State: AOAM530aX3dleCwTLcyT9w5rdIks102DgqBCDyQtvFszxEpbJp6y1BUN
        55dkcKzsZUJrON0VXcm5MQs=
X-Google-Smtp-Source: ABdhPJweDMbSg+zu83DJqrZIYDYAmFWXKsMWNUBO+2qN7mpg/giC83z9oQN8n4H8AzlfBL23Qo5uPw==
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr30774753qvb.37.1624971035962;
        Tue, 29 Jun 2021 05:50:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a008:8d1a:199e:a08b? ([2600:1700:e72:80a0:a008:8d1a:199e:a08b])
        by smtp.gmail.com with ESMTPSA id 28sm7726798qkp.67.2021.06.29.05.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 05:50:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] t6423: test directory renames causing rename-to-self
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
 <d3572e8bc85e4c7a33094f5da71957c2e59fd7f4.1624727121.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c088028d-3045-70ce-19e9-f3ffc9c57c98@gmail.com>
Date:   Tue, 29 Jun 2021 08:50:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d3572e8bc85e4c7a33094f5da71957c2e59fd7f4.1624727121.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2021 1:05 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Directory rename detection can cause transitive renames, e.g. if the two
> different sides of history each do one half of:
>     A/file -> B/file
>     B/     -> C/
> then directory rename detection transitively renames to give us C/file.
> Since the default for merge.directoryRenames is conflict, this results
> in an error message saying it is unclear whether the file should be
> placed at B/file or C/file.
> 
> What if C/ is A/, though?

This case seems interesting, but somehow missing from the test cases
below. Each of those cases include renaming up or down the directory
hierarchy instead of doing a sideways rename.

> +# Testcase 12i, Directory rename causes rename-to-self
> +#   Commit O: source/{subdir/foo, bar, baz_1}
> +#   Commit A: source/{foo, bar, baz_1}
> +#   Commit B: source/{subdir/{foo, bar}, baz_2}
> +#   Expected: source/{foo, bar, baz_2}, with conflicts on
> +#                source/bar vs. source/subdir/bar

This test goes deeper.

> +# Testcase 12j, Directory rename to root causes rename-to-self
> +#   Commit O: {subdir/foo, bar, baz_1}
> +#   Commit A: {foo, bar, baz_1}
> +#   Commit B: {subdir/{foo, bar}, baz_2}
> +#   Expected: {foo, bar, baz_2}, with conflicts on bar vs. subdir/bar

This test goes higher.

Does the problematic case not hit when going out to the side, such
as "with conflicts on subdir/bar vs otherdir/bar"?

If so, then _maybe_ the commit message could indicate this is an
omission on purpose. If not, then maybe a third test should be
added?

Thanks,
-Stolee
