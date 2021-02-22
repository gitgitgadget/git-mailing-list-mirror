Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA7C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D4D64E83
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhBVORp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 09:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhBVOQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 09:16:01 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F27C061786
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 06:15:17 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k13so1539248otn.13
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z3r6em4LXVmvBOAJN1MMXT2bqb43pghD4z0L80gGRPY=;
        b=CyVdFrWGTRvu2wN0pzmZN3Pbzgn7+S2ulAbPXdZdfKk1Hm1vRcBTTKWat3qJlzfTyj
         FE95QVZqrA670VQGNrmlWf/w6bT4fh986b/prRFi1hO+JwAFnFIBJn4IyIcSA+WTtLzg
         1eUo028l6v+FTZQXefo/vgueVjV3y5Ck81hFpOPvybnlvaD6nWq2tSSEbqqXpK+kR47t
         2K9xVdlsi9qeymyDRxz3e/IXct/jRD0qUeY61C8C1pF5rJ53HBODzGS13XzWpkYzsLMn
         AUWRt8lTkiOV8SjfwFyXIX3N6bBmURVsxEeOTmPN/GW+De5+xzvw6GotpuGdBD0zMdea
         WsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z3r6em4LXVmvBOAJN1MMXT2bqb43pghD4z0L80gGRPY=;
        b=Mii24Gpr3pg3sTfCQ1jMbnso9PAH/RYTwTGqy8zrru1iuREbJJSfPQewdrPPOlSgcV
         HnmnBJ7sqJINWG3q8QibsEsk6vesImKHP9dFInUAiFuJLPUi07MY3Y5LweTXQQe13Tk1
         O+tLPLnW3FOFLLlV06O8wVZLtfvRxQHtDEM5KFYDDwEwJKQg5Z2wAwV+e5JNLJPVTJWk
         +A2smxzPmnQ4s+a5RpF/cD8v7ayOb1LjDd2if0CkxrQZTQ/Uz+xBM8HKDp4Reu9gl8bb
         BCaxgO1n9ckGROyLmWVi201GD196NxMeXvQE8Df9/VCoGEMPqFFUNiyQJadPoYreTok7
         AHvQ==
X-Gm-Message-State: AOAM530g0a5U+EW89P+DphSYegWWSIY5mfQYXVqpqr7xmXKD6g5XPRI0
        lrW8GdYvdHBKpTopISo9m4Y=
X-Google-Smtp-Source: ABdhPJzMGviz2WVzUP8vhOxp4eVVbCScrWvU3kgdLl6xblMI7Z7HHEv1ZH3sCstyw3uzBO/ZbUtHPA==
X-Received: by 2002:a9d:7699:: with SMTP id j25mr16815111otl.202.1614003317152;
        Mon, 22 Feb 2021 06:15:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:65a9:a9d5:52a1:bf1e? ([2600:1700:e72:80a0:65a9:a9d5:52a1:bf1e])
        by smtp.gmail.com with UTF8SMTPSA id g10sm28449otj.15.2021.02.22.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 06:15:16 -0800 (PST)
Message-ID: <6ef5487b-905d-8f34-a53c-d1138f5528d9@gmail.com>
Date:   Mon, 22 Feb 2021 09:15:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH] commit-graph: avoid leaking topo_levels slab in
 write_commit_graph()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.881.git.1613765590412.gitgitgadget@gmail.com>
 <xmqqa6rz9zrx.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa6rz9zrx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/19/2021 10:36 PM, Junio C Hamano wrote:
> "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Andrzej Hunt <ajrhunt@google.com>
>>
>> write_commit_graph initialises topo_levels using init_topo_level_slab(),
>> next it calls compute_topological_levels() which can cause the slab to
>> grow, we therefore need to clear the slab again using
>> clear_topo_level_slab() when we're done.
>>
>> First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which
>> is currently only in master and not on maint.
> 
> Thanks.  
> 
> Forwarding to those who were involved in the said commit for
> insights.

>> index ed31843fa522..9529ec552139 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -2471,6 +2471,7 @@ int write_commit_graph(struct object_directory *odb,
>>  	free(ctx->graph_name);
>>  	free(ctx->commits.list);
>>  	oid_array_clear(&ctx->oids);
>> +	clear_topo_level_slab(&topo_levels);

This change looks like a sane change to me. It definitely fixes a leak.
The leak "wasn't hurting anybody" because write_commit_graph() is only
called at most once per process, and the process closes itself out
shortly after. Still, it's good to have good memory hygiene here.

Thanks,
-Stolee
