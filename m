Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F526128A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhFHNCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhFHNCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 09:02:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B3C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 06:00:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j184so20018337qkd.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ajJQhOURy0Gp/fGqEEXMr1wKlu0FARxGVLoRAGr34PY=;
        b=S+cYBDrDPJUCAVKwa2YY4SAQ4tOL1cFkov0pxhYRZJsLAKec383nNdhkA/CEP5iqQl
         YPOHfQIAbF260byAqXi4Y/djh1/1yVi1eog52XbE0moiAOW+O30wfPIVQlJ1Gozi8Cwf
         /Uc0P1GeM3oitpveXG/3gagl9CSxOPkx8Lv2SmcdH/nod2sbRdfdtjZKRTrpZY8LpMW1
         S7WqUO7kyg2Wsy1CKt/vSWtL5QcqJ0LXxJ3MZg+/3odF2Y74gWTit0vFMD9SUpiIwXoV
         z/q7z3wzFf1FIMHQqXfQ/y2hZjTgJlzJSUtZzbJ7ogiR2dUVFZ1qNIo1YMR9cMnbULXI
         5qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajJQhOURy0Gp/fGqEEXMr1wKlu0FARxGVLoRAGr34PY=;
        b=OOMkuvs+4FszeolTL56t1aOARhpyjFsAksqj1ioxocgLgsg/M+W+mOINo59L4ffqta
         Cmop8LQqRbz6eq7KYMR3Im4NCuYOMEviGMjlPMjo/lDL0BhGLB4u/vq/z5cKTvwBhUCj
         M2jTgxKIbq9RDmX9j9sMBzpSMr+qLrhQ0OUryoK58JnLeRj3LL4I+JBwyGKCgfkvMg8l
         73su/TYDVprWLUMvsnTiy/PTHDaCVXXEMo8w+B10p9d2iuUPbT7j+7G5OzLvqvVOyjS+
         BlkZ7sF7AY3+jfpiyckGjg1T276dX+qPko6ScYcAQZ1InP7D8Ntmt6seiCpI24nf6G+z
         kF4Q==
X-Gm-Message-State: AOAM532LR4NO08iVNwTiVnR8WJBvATaOk3tQwDVJ/I0Q4l8qjRdd+6jh
        uoG8PfH6wGQ4Y12s2paZBig=
X-Google-Smtp-Source: ABdhPJwkPEsTzzLrD9e6x9xCVmrwFUWr8XMkOSIzvWw560a3OPwCqbL8qOTI27gYfKqSthpDmT9tXQ==
X-Received: by 2002:a05:620a:787:: with SMTP id 7mr21389251qka.397.1623157251472;
        Tue, 08 Jun 2021 06:00:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:950a:2e04:f8f4:95ec? ([2600:1700:e72:80a0:950a:2e04:f8f4:95ec])
        by smtp.gmail.com with ESMTPSA id a14sm10556590qtj.57.2021.06.08.06.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:00:50 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <b2ce649a-00d0-8418-2a3f-9172ff69eccf@gmail.com> <xmqqmts1rwr4.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b13422ee-0cc8-d77d-cdfa-c8caaf0efdbb@gmail.com>
Date:   Tue, 8 Jun 2021 09:00:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqmts1rwr4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 9:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 6/7/2021 8:34 AM, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>> ...
>>> +			old_entry = make_transient_cache_entry(
>>> +					entry[0].mode, &entry[0].oid,
>>> +					old_path, /* stage */ 0);
>>
>> I didn't realize this before I started integrating with
>> v2.32.0 (which I should have done before submitting v5) that
>> make_transient_cache_entry() has changed its prototype to
>> include a memory pool parameter.
> 
> Sorry for the trouble---these are usually all known to me for topics
> I happened to have picked up in 'seen', since I try to make it a rule
> that 'seen' must be a descendant of 'master'.
> 
> How can I usefully communicate the conflicts I find out during the
> integration cycles to topic owners, I wonder.

This is my fault for stacking topics. I used a GitGitGadget PR
to target a custom merge of other topics in flight, so my
merges were testing against a static target. When those topics
were merged, I should have updated my PR to point to 'master' or
even 'next'.

Thanks,
-Stolee
