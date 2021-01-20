Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32CC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 02:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B421E2250E
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 02:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbhATCXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 21:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbhATCV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 21:21:56 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F384C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 18:21:12 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i30so9028739ota.6
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 18:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3IaZuNKWVE4De+3zXHTP68TzkIbZOHsDpXEqFwLfUs=;
        b=Ra5Noif5PTR9rJs5W/2PjH/mM+m203wUhAWkTCC96woaP9nWMzURpqjmj6k9ToabBB
         DC5BHaXs5FakKDefJ8gZeFhx7qNKKblFl+8WzbrMIDEqHe7yAJ+yxJWBit5HPZyXl9jP
         TDeBAWR6ZE+pAW9VBx/ugXErMTVAykbu/LE5SKY37uAGcfECMEw5hZTLYjyffP6+N+Mj
         RFDT8DPypUOO72Ie0/AB6eDkMe9SaantszNjg8qP7K2WCYur02rCNK3TxNRSvbiu9Ia/
         7HhCQs4V2gN8SzOF7EL7uUCsK6EAGomlL8wgZEoes6NY/rjhXWgkLCF2xejWw/2UXz7m
         yiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3IaZuNKWVE4De+3zXHTP68TzkIbZOHsDpXEqFwLfUs=;
        b=CjtJ4xq1iElTPyAkc17zPT9BukG2m2qot8wpJ4Ljyp5+C5ydKqhMkQlYK8ClnjR6IR
         SOmdQ3LSDkxlbBbsF7TR0w9YV6RAXMP20hRImmW4MLt4FkhsDbM0ZDbBxemi7TgNb7+y
         +lq2PP+/jAQ8J6QO5794JtffPOl8e+HTJ4tOHhfUN0efyD16oRVz8eTTgi+SoKuEs+/F
         p115wuPaAPbNdmS0sFmNZvrQA/hV13kBrTUe0tNB3I6p3/c/Rd9E0jngrshFCDp6KwIQ
         x4BnYThWiY2/WndLgGzu76txB6qDw68Uni5MXakGKsJ4lmUcXMspp4k1gbsC7d11oLJA
         Qp4Q==
X-Gm-Message-State: AOAM530Af1pKBSVjYw0OXJQbDA6XZUKQ2CUmLoxAzfv7dZjXHrbMNdoy
        JpV9sOhu7mXx4nt4BKYf+n1R7xmxYx0=
X-Google-Smtp-Source: ABdhPJw7XiNjICcfAS0sYH6LSyyhT28IOct9xPHDdLwSeSLqjXRCv0QZNziY/Gl7ZYim98iWzVvcWQ==
X-Received: by 2002:a9d:aca:: with SMTP id 68mr5571481otq.272.1611109268849;
        Tue, 19 Jan 2021 18:21:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id 2sm128934otg.6.2021.01.19.18.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 18:21:07 -0800 (PST)
Subject: Re: DEVEL: Help with feature implementation
To:     Antonio Russo <aerusso@aerusso.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
 <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
 <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
 <xmqq7do9iuqj.fsf@gitster.c.googlers.com>
 <9fc9d752-06f4-e75d-1549-f257fd34e0c3@aerusso.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ac68007e-ca66-0229-fa8f-4ceb7d6d8f23@gmail.com>
Date:   Tue, 19 Jan 2021 21:21:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <9fc9d752-06f4-e75d-1549-f257fd34e0c3@aerusso.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2021 9:52 AM, Antonio Russo wrote:
> On 1/18/21 6:24 PM, Junio C Hamano wrote:
>> Antonio Russo <aerusso@aerusso.net> writes:
>>
>>> As a side note, would this list be willing to look at patches that remove
>>> the need to use revs->limited?  Adding new features would be much easier if
>>> we could restrict git to use streaming algorithms for these simplifications.
>>
>> Do you mean you will write new implementations of operations like
>> "--simplify-merges", "--ancestory-path" and all its friends without
>> the need for the "limited" bit?
> 
> Yes.
> 
>> Willing to look at?  I do not know about others, but sure, it would
>> make be extremely excited.
>>
>> You may be able to rewrite some other operations that implicitly
>> require the limited bit into an incremental implementation, but I am
>> skeptical that you can do "simplify-merges" in a streaming fashion
>> in such a way that we'd dig a bit but not all the way down before
>> making decisions on which commits should be included in the output
>> and how their parenthood relationship should appear etc.  I and
>> Linus tried independently and we did not get that far in our
>> attempts (note: there wasn't commit-graph back then).
> 
> Yeah, it's a big task (but, it'd be useful work, rather than doing
> another rewrite of my feature to make it work when revs->limited).
> Each of the flags (simplify-merges, ancestry-path, etc.) is its own
> little sub-project.
> 
> I haven't thought about any one flag specifically, but the fact that
> two complete code paths exist right now just seem like a nightmare.
> I'm not necessarily interested in making the implementations faster,
> but rather getting rid of the duplicated code path.

It's definitely a long shot to remove the limited flag altogether,
but a good start would be to remove sort_in_topological_order().
All of its logic is already re-implemented in the streaming version
(see every use of "struct topo_walk_info" in revision.c). The
streaming is designed to be faster in the presence of a commit-graph
file, but it should still work correctly without one. Since all
commits with have "generation number infinity," each phase of the
walk will do the same as the limit_list() and walk all reachable
commits before returning the first result.

The only thing to ask is: what is the overhead of the streaming
version over sort_in_topological_order()? Is there one? You'd need
to do performance tests without a commit-graph file.

This has long been on my own TODO list, but I haven't been able to
prioritize it over other things. I'd be happy to review the change.
It also would be a good way to familiarize yourself with the code
and how we already do some streaming things, even when "extra"
information is needed to accomplish that.

Thanks,
-Stolee
