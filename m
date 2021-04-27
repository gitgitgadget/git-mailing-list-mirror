Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0363C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF91613BD
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 12:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhD0Mnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0Mnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 08:43:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982EC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 05:42:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t17so31275838qkg.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29TX3svBoeSa6RNNna1ZZ2YBQWtXVSsv/yeOvLqtTZE=;
        b=X8fMEx+IdRxa4mryMyH0Qz/k4U4EYfJWViWlVpo5TO9BfYWQeejE3OHhLnoXimYVeS
         DhQB3XWQcUs1P0Lzg4+HyJQsY7FIxUluBzoKE/QfFP9jYwX7D1YM1g9r3eNqblEOg+X/
         5jXBmwkpmPKmpw/UTmbijbDcMpuubHoykkR0Dia+HJq9AJkM5f2llcXFDeBGKg1IzS/O
         i6VUcA+lR96Y9jYd5c6P16ME87Z4y1ba5N6MQtDW6lE9eNXh6tbKjga5yiMngQK1CpNL
         xJOmF4+BhhIHjJf444B3Fa5DMob+m1JNh8w6E3jW/4tOfrZ0hETZ9UUviiKHmLU9uxdZ
         gV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29TX3svBoeSa6RNNna1ZZ2YBQWtXVSsv/yeOvLqtTZE=;
        b=FkzeOj3BFyIOD0jIlNXtPdV9yMXbF/PNgY/L0Nhq5Sjns5eJEUHInThGGemO1iLfg3
         en/ahrodwYH3hr+rxGGUwMMnoGmpaa5NpHaU5QgeGNPoYbU3kH68yTWtyAgPNbjzCnr+
         0KoqnrruugF7552ya7ig9wPeLSPNTJZ1yQxjIKJB7wHoCjDdudFpAvLFlxgTNLCubPab
         dq37lbceyA2dlOGJq74CBO9VTZco9vQEpX1FclWRl0uNDsMb7bQfaeCSUALAP855CrKu
         2D6jS80p77eOkkC9V52nMwLi4iBhD1Fsv0STTL/qzYXiFNm77UUrdZHetg/xG6YNQcw/
         braw==
X-Gm-Message-State: AOAM5325zN0JzyuNiNZCf/7eY5o8JERR9iic4kxtVYVdY08UWJVwf203
        cLHDIcj5R9v/N+YyrL7Fa+Wc/NUOYcIrRg==
X-Google-Smtp-Source: ABdhPJyFNImwYC7/BK9BLHfQP1tlV0qwhYSn4iaGC2BBVgF4G+Rx9MCslkEx5kqju7DLUmRE86e4CA==
X-Received: by 2002:a05:620a:3cd:: with SMTP id r13mr12645702qkm.317.1619527371348;
        Tue, 27 Apr 2021 05:42:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id s20sm13968715qtn.74.2021.04.27.05.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 05:42:50 -0700 (PDT)
Subject: Re: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor` to
 call the daemon via IPC
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
 <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
 <87mttkyrqq.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <03b4def9-3435-bd44-69f9-1e037df83aaa@gmail.com>
Date:   Tue, 27 Apr 2021 08:42:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87mttkyrqq.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/2021 5:20 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 26 2021, Derrick Stolee wrote:
> 
>> On 4/1/21 11:40 AM, Johannes Schindelin via GitGitGadget wrote:> @@ -2515,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
...
>>> --- a/repo-settings.c
>>> +++ b/repo-settings.c
>>> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>>>  		r->settings.core_multi_pack_index = value;
>>>  	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>>>  
>>> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
>>> +		r->settings.use_builtin_fsmonitor = 1;
>>> +
>>
>> Follows the patterns of repo settings. Good.
> 
> It follows the pattern, but as an aside the pattern seems bit odd. I see
> it dates back to your 7211b9e7534 (repo-settings: consolidate some
> config settings, 2019-08-13).
> 
> I.e. we memset() the whole thing to -1, then for most things do something like:
> 
>     if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>         r->settings.gc_write_commit_graph = value;
>     UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
> 
> But could do:
> 
>     if (repo_config_get_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph))
>         r->settings.gc_write_commit_graph = 1;
> 
> No? I.e. the repo_config_get_bool() function already returns non-zero if
> we don't find it in the config.

I see how this is fewer lines of code, but it is harder to read the intent
of the implementation. The current layout makes it clear that we set the
value from the config, if it exists, but otherwise we choose a default.

Sometimes, this choice of a default _needs_ to be deferred, for example with
the fetch_negotiation_algorithm setting, which can be set both from the
fetch.negotiationAlgorithm config, but also the feature.experimental config.

However, perhaps it would be better still for these one-off requests to
create a new macro, say USE_CONFIG_OR_DEFAULT_BOOL() that fills a value
from config _or_ sets the given default:

#define USE_CONFIG_OR_DEFAULT_BOOL(r, v, s, d) \
	if (repo_config_get_bool(r, s, &v)) \
		v = d

And then for this example we would write

	USE_CONFIG_OR_DEFAULT_BOOL(r, r->settings.core_commit_graph,
				   "core.commitgraph", 1);

This would work for multiple config options in this file.

> I see the UPDATE_DEFAULT_BOOL() macro has also drifted from "set thing
> default boolean" to "set any default value".
 
This is correct. I suppose it would be a good change to make some time.
Such a rename could be combined with the refactor above.

I would recommend waiting until such a change isn't conflicting with
ongoing topics, such as this one.

Thanks,
-Stolee
