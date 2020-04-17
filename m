Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E86C2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B920771
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 01:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it+M9ZPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgDQBxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbgDQBxz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 21:53:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E536C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 18:53:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x10so785941oie.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 18:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZtXRiwS0Mk0pr8ivmEt/uNVeidBCrcji5EecQ0V4nU4=;
        b=it+M9ZPLQ6oXqana0IDLsuUuN0attQMMxYJXoFjH1w4WL2wrvTifnPbYumrzrhDkK/
         N+bAPOErJogE1fXE0ctxtI6fzhsmnT2A79dP317HkTaYTlWZO3bD7lch8B1prWuUutAw
         dctjXQIbQv/Z817VBtEgQCQGtFZhVSgNk8mzFivI/XsdjqquIlQ6qb5Bnzb4OcLl2rxH
         Doo9FlVvEkMy1pqOCSo8ZN1FnEAc7mWI5JYltwGDLsbUo2bhS1DIq4+b0CCxSXv/V7W+
         ueBKnVK2xTekTrYRHKRDaQdhYia/Y+h7CNAZqwL3Ta7KXXuXjmLFUWeq1Bq1+8g4iRbC
         4rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtXRiwS0Mk0pr8ivmEt/uNVeidBCrcji5EecQ0V4nU4=;
        b=l4RSiHp1gRrZh0kmfe9C5tN8h4eanBbowlReQ/Ub6+1RTT+wLzO2wrZGyj7YH4oJQT
         zpbXQa0YtV2qKKsmz7THW2fcUVh/vIyNbeW93zFbQI+fEsddc6VW1KmOSRznEE1QLidH
         12tF54xQeRrtNqaYiDNPb7InBFgLet2nmXfRlTBNy3S6PEn9qwYRk5lH7JCPTbDJDQfS
         NaKg7vjOE6D9BWtJdFBHtjtydEF7WD/5wqIpgobA5mX/YuvioHLmMYOamGhiMSpP4i8n
         SNIwK5CTtSuhG6sUam+Td3+8Q+fOVIszPWId79LYnJ5v8oZneAm/jPDHfogD8qH2eR23
         KHnw==
X-Gm-Message-State: AGi0PuaZTaP8O1arNBMVPdNwPeUHBZXuhuIk4vFPnmO8aFO/RXPXk9qc
        0zNMrsJPbA9zRg7T4m01TsU=
X-Google-Smtp-Source: APiQypKuLWkRAt9WN/Ix5tbHksiEs1oP367ieg8JL1y4a05tB7uFAApcL0zNCnwFASMMsefbnJ2pUQ==
X-Received: by 2002:aca:1709:: with SMTP id j9mr692494oii.59.1587088434326;
        Thu, 16 Apr 2020 18:53:54 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d84sm7603092oig.33.2020.04.16.18.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 18:53:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] log: add log.excludeDecoration config option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
 <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
 <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
 <xmqqo8rrz5gn.fsf@gitster.c.googlers.com>
 <xmqqftd3z4sa.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <481d4e05-c6f8-0554-e8f6-04562d316c4c@gmail.com>
Date:   Thu, 16 Apr 2020 21:53:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqftd3z4sa.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2020 2:03 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>  	if (include_patterns && include_patterns->nr) {
>>> -		int found = 0;
>>>  		for_each_string_list_item(item, include_patterns) {
>>>  			if (match_ref_pattern(refname, item)) {
>>> -				found = 1;
>>> -				break;
>>> +				return 1;
>>>  			}
>>
>> Micronit.  
>>
>> Let's mimick the early return in the loop above (for command line
>> excludes) and below (for configured excludes), each of which is just
>> a single "return" statement in a block without {braces} around.
> 
> ... heh, it seems that the nit is mine in the suggested alternative
> upthread.  Let me amend while queuing.

Shame on me for not noticing. Thanks for the close look!

-Stolee
