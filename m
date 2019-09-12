Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1631F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfILT2B (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:28:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44380 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbfILT2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:28:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so30985282qth.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qtKmiqOhKByWhhazW6GbgsTwyRKvEnRKZOXjEByQL0I=;
        b=eCRYs4XbCwSAOyraK8Jgh3eM7Elx76VIh9yp0r8/tMJSH+kqoVMr4u2Ns3crtctqjV
         YlujH3c1WsDOkrLhBo8MF5gYVs6wWrlOYQNXuvCzsDDSTscQJRCnQP/+kkHC2J0BnopK
         5SOZPLUPXAErcYiNI3tcGe9O/hzVjAS2XD86aut6gY07E9lxiEc/0WBHZUzwm4730grK
         KkAXyiYXgViuJIZYABbAi35Smbs7XrKa2cwFO0Luyyx9VdkoxbpwaWM2Kq4qH86g4s1p
         tBIoOLWkfp/etMbDMFqksUYYs7xgL4iK+d/Ec7CQ4sE70wKK7V2xJV/JDtSNAFhynZSy
         N52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qtKmiqOhKByWhhazW6GbgsTwyRKvEnRKZOXjEByQL0I=;
        b=Vu98vvg3nPAZN9BtdmeJ+Rv9Fy+UgZvPHuryGc0+uvr9hCPPN7xz8+ppTh+JR3xaCp
         SlRTq3lhya4o1jpS6q0bzV760ystWotWAtKA1WNbEceOmiaVWMPUmA+ReDFHbGRsPtGH
         9JsJYIiDbmoLubKbcRZBhgiNke74NWTVjpQ/D0KJHy+yqgOJrYTqMlEoWOSNWFR497LR
         N8Pq1dSnga6A+yaV8phQK1tt2RLuNh1pEbOtKy4P4ZJEPaOhkWmUlMGBjmVSNJro6TWk
         1U7W8tUs5nbofsMLvwJSY7/jQXMeXQonqOiVbAQSel5/Lh4DYIa86eUEE8WTSE1WKdhg
         PINQ==
X-Gm-Message-State: APjAAAUxyG3VZGqwZCjuYE7hqbImxeYeOgLoT2PF2/1z8BIQSkCrOZCo
        AhbD1T4N9lgWQFOWS5HgzDE=
X-Google-Smtp-Source: APXvYqyCF/XqREpGDKXvI9IYmITbpNgxb8lPa0Rf1R6brgioORA76DiaEOWDwYvN5pHS74Pxqm8png==
X-Received: by 2002:ac8:2d0f:: with SMTP id n15mr29626676qta.305.1568316479948;
        Thu, 12 Sep 2019 12:27:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:3977:64ab:d1ea:251b? ([2001:4898:a800:1012:c20b:64ab:d1ea:251b])
        by smtp.gmail.com with ESMTPSA id c126sm11092583qkd.13.2019.09.12.12.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:27:59 -0700 (PDT)
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for shallow
 traversal
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <fdb81ce0-20ee-5880-2a6c-0c8b3f1739b9@gmail.com>
 <20190912142306.GE23031@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <875aea73-eebd-fd8a-4d4b-c3b9df027a04@gmail.com>
Date:   Thu, 12 Sep 2019 15:27:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190912142306.GE23031@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2019 10:23 AM, Jeff King wrote:
> On Thu, Sep 12, 2019 at 08:23:49AM -0400, Derrick Stolee wrote:
> 
>>> That creates an interesting problem for commits that have _already_ been
>>> parsed using the commit graph. Their commit->object.parsed flag is set,
>>> their commit->graph_pos is set, but their commit->maybe_tree may still
>>> be NULL. When somebody later calls repo_get_commit_tree(), we see that
>>> we haven't loaded the tree oid yet and try to get it from the commit
>>> graph. But since it has been freed, we segfault!
>>
>> OOPS! That is certainly a bad thing. I'm glad you found it, but I
>> am sorry for how you (probably) found it.
> 
> Heh. I'll admit it was quite a slog of debugging, but _most_ of that was
> figuring out in which circumstance we'd have actually parsed the object.
> Finding the problematic end state was pretty easy from a coredump. :)
> 
>>> diff --git a/commit-graph.c b/commit-graph.c
>>> index 9b02d2c426..bc5dd5913f 100644
>>> --- a/commit-graph.c
>>> +++ b/commit-graph.c
>>> @@ -41,6 +41,8 @@
>>>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>>>  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
>>>  
>>> +static int commit_graph_disabled;
>>
>> Should we be putting this inside the repository struct instead?
> 
> Probably. The only caller will just pass the_repository, but it doesn't
> hurt to scope it down now.
> 
> It could potentially go into the commit_graph itself, but it looks like
> with the incremental work we may have multiple such structs. It could
> also go into raw_object_store, but I think conceptually it's a
> repo-level thing.
> 
> So I put it straight into "struct repository".
> 
>> Your patch does not seem to actually cover the "I've already parsed some commits"
>> case, as you are only preventing the commit-graph from being prepared. Instead,
>> we need to have a short-circuit inside parse_commit() to avoid future parsing
>> from the commit-graph file.
> 
> Maybe I was too clever, then. :)
> 
> I didn't want to have to sprinkle "are we disabled" in parse_commit(),
> etc. But any such uses of the commit graph have to do:
> 
>   if (!prepare_commit_graph(r))
> 	return;
> 
> to lazy-load it. So the logic to prepare becomes (roughly):
> 
>   if (disabled)
> 	return 0;
>   if (already_loaded)
> 	return 1;
>   return actually_load() ? 1 : 0;
> 
> and "disabled" takes precedence.
> 
> I've added this comment in prepare_commit_graph():
> 
>         /*
>          * This must come before the "already attempted?" check below, because
>          * we want to disable even an already-loaded graph file.
>          */
>         if (r->commit_graph_disabled)
>                 return 0;
> 
>         if (r->objects->commit_graph_attempted)
>                 return !!r->objects->commit_graph;
>         r->objects->commit_graph_attempted = 1;
> 
> Does that make more sense?

Ah. That does make sense. I now see the connection between parsing and this
change.

> Unrelated, but I also notice the top of prepare_commit_graph() has:
> 
>         if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
>                 die("dying as requested by the '%s' variable on commit-graph load!",
>                     GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
> 
> as the very first thing. Meaning we're calling getenv() as part of every
> single parse_commit(), rather than just once per process. Seems like an
> easy efficiency win.

Absolutely. Move this to after the "have we attempted already?" condition.

Thanks,
-Stolee

