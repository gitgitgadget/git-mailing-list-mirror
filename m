Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F4C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbhKXOz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbhKXOzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:55:21 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1BC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 06:52:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r26so5823080oiw.5
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xX3aV3ipzzCAqIK0AEdPOD9ybxuKNx6ZkiN2e5pgkU8=;
        b=obs4QE/fGI+iaqRY46hovesmnInbIQDzlisfGFHTWwa/Ge9FWoKd64hElK2Vnl4nl0
         78fhMmbzzvleIYXk1ar3lKDL/37XaH0UdUBjaP3HkHB4kne00wAbJp/PRuSbfloi0Jmu
         D+e4O/QWuLKevBHJ4i9/5/124oGVK4UvWz/tInDKd9g9ZZSUUh2REl9HSJSXpd+wxRXI
         ib20JoO5/mjsXGCNA+rNVBvTlOVt1c66evqOjFrdWzfTs17IWmSX+2yEIX4wPewvxrbY
         dFpNVCvoqv4vXJRpteRuhjgfdpmOGxxUW4LwFaBBqVIhjGmkaWy+GbNpMUs9VfXwzjg2
         A6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xX3aV3ipzzCAqIK0AEdPOD9ybxuKNx6ZkiN2e5pgkU8=;
        b=5fo3+3u2W5Q7+k+utQKATIDuJnAhfTTzqVwa7WJ9arY4+WUMHPDUo6YQp7IWH7R3nu
         KrmRuPq5jdPo47OSB1D480lNMbDKUbmV7KxWwthzj3CJzODjIBfYYNMCjJxE3IUKV3DC
         dEVuTNZ/uXkedaOLGhltK/+lR9BFCxv0mhea6yrwYufIQA+4jzCbNecrFn6r5UhtaKGE
         XE3d/KBcAAt8tuZ2liHc4XbOh/Dh8OZykbjOS7IoTLdiBk3pTKId3tGfZYVKsFbX0Dzt
         W4E+BQq0qBJmAvVn9qkXMccG11zeFhlt+ykOSCOPSSWeT7k6Piywef4eyM+j7I4V3h6q
         il6g==
X-Gm-Message-State: AOAM532X62Lz6oZPmralg2TEZ5LRoW2iIJusfypB5yhDsi64wgVVxBhT
        xzBThoL/774jBeICibRf7tP4tEiDHdE=
X-Google-Smtp-Source: ABdhPJxyxmcdT6+14jF3PjhQZUpsJfrFwUnTF5VsKHvTHjEMFjPyVEVbbEfeRsbdRAMBHtZTpDV3YQ==
X-Received: by 2002:aca:783:: with SMTP id 125mr6815281oih.29.1637765531333;
        Wed, 24 Nov 2021 06:52:11 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id c41sm3227otu.7.2021.11.24.06.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 06:52:10 -0800 (PST)
Message-ID: <c8e86ac1-a391-8957-9301-8a9004d46191@gmail.com>
Date:   Wed, 24 Nov 2021 06:52:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 4/4] blame: enable and test the sparse index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <7acf5118bf5602fbafca2d42c4f363b5adbcbd54.1637620958.git.gitgitgadget@gmail.com>
 <xmqqr1b65sz1.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqr1b65sz1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/23/21 3:53 PM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 641523ff9af..247b9eaf88f 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -902,6 +902,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>   	long anchor;
>>   	const int hexsz = the_hash_algo->hexsz;
>>   
>> +	if (startup_info->have_repository) {
> 
> The command is marked with RUN_SETUP bit in git.c::commands[] list,
> so I would think we wouldn't even get called if we are not in a
> repository here.
> 
> Under what condition can startup_info->have_repository be false at
> this point in the control flow?  If there is such a case, it would
> mean that startup_info->have_repository bit can be false even if we
> are in a repository.  That sounds like a bug in some code (I do not
> know where offhand) that is supposed to prepare the startup_info
> before cmd_X() functions are called.
> 
As with checkout and pack-objects, this was added to protect against
the new BUG() in prepare_repo_settings being triggered with the help
command (which was surfaced with failures in t0012-help.sh). As with
those builtins, I will be removing the conditional and moving
prepare_repo_settings after parse_options in v5.
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index 5cf94627383..9ac76a049b8 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -114,6 +114,8 @@ test_perf_on_all git reset
>>   test_perf_on_all git reset --hard
>>   test_perf_on_all git reset -- does-not-exist
>>   test_perf_on_all git diff
>> -test_perf_on_all git diff --cached
>> +test_perf_on_all git diff --staged
> 
> That's a funny revert of what the previous step did; I thought this
> step was about "blame" and not "diff".
> 
>> +test_perf_on_all git blame $SPARSE_CONE/a
>> +test_perf_on_all git blame $SPARSE_CONE/f3/a
>>   
>>   test_done
>> -# TODO: blame currently does not support blaming files outside of the
>> -# sparse definition. It complains that the file doesn't exist locally.
>> -test_expect_failure 'blame with pathspec outside sparse definition' '
>> +# NEEDSWORK: This test documents the current behavior, but this could
>> +# change in the future if we decide to support blaming files outside
>> +# the sparse definition.
> 
> OK.  From the description it is clear that we do not support it
> right now, which is OK by me.
> 
Elijah made the point that blaming files outside the directory isn't
supported in full checkouts either. So I've updated the comment and
commit description a bit for v5.

Lessley
