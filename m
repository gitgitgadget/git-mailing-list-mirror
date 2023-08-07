Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A98C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 22:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHGWtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 18:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHGWtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 18:49:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149BF3
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 15:49:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so42909895e9.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691448551; x=1692053351;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tHW4QbIXEgbBEcqOhSUF5noLqXctYJ/CWgh/CkmD1s=;
        b=E5XKM+gm5fxiH3TbxQ2xBXeGjHy7joj3cqeveFnetH4lmOxdT/H/wQlT3B5+/WjsXg
         sdSWzMxEiIevcfRa0ghShdnrbV3k5r4Yf7gIYEKNZINjizNfEqcWiBESQDK2z7BFFSe+
         /yXgZNI16yDBdzQjNTOlZA5wrkYDJqW/6OhgnOjd2E8PXQNnGVGQERybaSaE3LVYLQj2
         Vcta7vb+EjExqNubC1q+e6fcstE3mzQ+2upO8ZsAj9TjeltSq4YkpDDilvUb88jWZ9h/
         baMnHPdbI7h15UZBC0In0REHaDqK2BsjMk+xPI/EXaDb8FFz+7+DUGWUmKIdwpjNpfOR
         lgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691448551; x=1692053351;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tHW4QbIXEgbBEcqOhSUF5noLqXctYJ/CWgh/CkmD1s=;
        b=T+TnazTDI0KxkjCfV1GOc50NYGEbItu3/rqdbJ6mO/HAYETNwXhh3Ru6N/R6GGUz8Q
         1voEIZy6yypzlbQLW5JDZ4UGAp6RRqe1lIyEaxOkzx0Mk4noVbTBdWwGKiaupUUFqsic
         4S+uRqosqeC/JtSJyVQ3jTb/G5++4bMq7k75GEuLuoEuMLnt5f97SVj4jcYIRsCtPQ3d
         EBeWi751zGECqJ4wdsFOdV1BOi6MYHYSn3owGk2KdVlgC5Yzm43Pbij6SHRsIBksEBh8
         zEYDGttgbPH6IUZk9g5gCYNGxCbDuErZasUp92l8QsFbmhAsP6+Bm0fUR2scSi1Aw/ER
         V0aw==
X-Gm-Message-State: AOJu0Yw5SAAOBMzADgedLljnYH4J5LiOx8+m9sUiu07sva7ojq3ZzHnn
        Ea5RE4tld6OZ+PHBsqQT7io=
X-Google-Smtp-Source: AGHT+IHwJWBZpHvHn0pTPF+swHIOkcWp1Nzn4uLfPRSJ3hXz8kzXJ9vYy/t2+wI+GjSynex86MSDiQ==
X-Received: by 2002:a5d:61c4:0:b0:316:ee7f:f9bb with SMTP id q4-20020a5d61c4000000b00316ee7ff9bbmr6543570wrv.65.1691448551007;
        Mon, 07 Aug 2023 15:49:11 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm11821596wrq.20.2023.08.07.15.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 15:49:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] branch: error message checking out a branch in use
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
 <d217d15f-ddef-d9bf-07fa-464b4025ab3c@gmail.com>
 <ZNFjZD4ImMz2mnrT@nand.local>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <01c1418e-a879-b778-f6d4-b76bef3e33b7@gmail.com>
Date:   Tue, 8 Aug 2023 00:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ZNFjZD4ImMz2mnrT@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/23 23:34, Taylor Blau wrote:
> On Mon, Aug 07, 2023 at 10:42:40PM +0200, Rubén Justo wrote:
>> Let's update the error message we show when the user tries to check out
>> a branch which is being used in another worktree, following the
>> guideline reasoned in 4970bedef2 (branch: update the message to refuse
>> touching a branch in-use, 2023-07-21).
>>
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
>> ---
>>  branch.c                | 2 +-
>>  t/t2400-worktree-add.sh | 3 ++-
>>  t/t3400-rebase.sh       | 2 +-
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 3e4684f79f..98c199f7b7 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -838,7 +838,7 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
>>
>>  		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
>>  			skip_prefix(branch, "refs/heads/", &branch);
>> -			die(_("'%s' is already checked out at '%s'"),
>> +			die(_("'%s' already used by worktree at '%s'"),
> 
> I wonder if "'%s' is already used by ..." (with the additional "is"
> between the branch name and "already") would be clearer / more natural.

I have no problem with that change.  I think I was trying to keep the message
sort ... the tests does not need to be adjusted.

> 
> Thanks,
> Taylor
> 

Thanks for reading carefully.

