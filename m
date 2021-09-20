Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA62AC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8026460FA0
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhITQbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhITQbE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:31:04 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2558EC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:29:38 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v16so19389134ilg.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UGLNwgj+Nlta66ZBB5eI7e27hH0dC2gQdM4jFqB07io=;
        b=p48mu/CLj4wGaTfB526l8irVeaJZlcJ1q4SpyMpZvw5vyPCT+2YJN9yf9THXrt5HIR
         WshYKkOZ6mLRrxfqAjjPdYy0iUO4EJpFl7O+ZjOGP5aLV5DCNVSqAljdMs0uv9F3mdw5
         rR79TP59ZCTqjJ+lqaI8wODdHm0Axd1PD3ZqYRi6DNiUzRLJS0wo7eVWSCXz9JE3hDXV
         WVlYczZh2ipJPI9lxC99lLqU9/t/AW4cKbCfR1WEf8LvsnyAyDSivNHm2I6Ma2Fx1unv
         VazGia4FDzXNCFnKVwgeR3fdhbNjIMmmXuNWMOr5RVzV3AHe2zQctgXSN4F2N8MvR5iU
         m5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UGLNwgj+Nlta66ZBB5eI7e27hH0dC2gQdM4jFqB07io=;
        b=DL0CfDkFOUK8lrAbjs16LBxNgUBRVdfqe1zn7KYDAE9UtNrLlDNIyRnTDcwn7+XmuD
         hLOHkVaxobcqBrdGOpwk4829fRQ6Fo9yCL+Cn9CxL6pIRd1YX4aVE8+bGyiJDPPLD/yt
         pB7mv/FUdM9SV5K6HT4bR0UoX8CPwB0Ti7nde9IygyFVwaX/+zhqRo2RRMyS5sRfNGh5
         SLftn9f0kVoSDcPnW3zR3vrPc63t2ukmmt+Wh0Cl3VA0fsJ0t5tgC39AzJItAH78+sgW
         /wvg//5XP6BdBJqqK8xb1L5RUJwKKlJOXKfkL04it/ij+EbtMjd4Ko4kDyGIRzdkIJBW
         g22g==
X-Gm-Message-State: AOAM530OC/ZInm2ILfQNLIOTiDsUdUjKymLZT5s48LH5ebQJCbWQUMud
        cabheu8omoZmGM0XlFtVBg3xG8eLLDPUwA==
X-Google-Smtp-Source: ABdhPJzWFSNcVhwyqjxWI7GrSu/U8fWWxyfKHNZKCe3H8q1pg1Y0n8ubC4s9mD1GatSAk7vM6iWsYA==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr18674270ilq.36.1632155377135;
        Mon, 20 Sep 2021 09:29:37 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id l6sm4352516ilt.31.2021.09.20.09.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:29:36 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>
Cc:     git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
Date:   Mon, 20 Sep 2021 12:29:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUiuWSXO1P3JwerH@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 11:52 AM, Taylor Blau wrote:
> On Mon, Sep 20, 2021 at 09:45:14PM +0930, Calbabreaker wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> This was ran:
>>
>> git clone https://github.com/Calbabreaker/piano --sparse
>> cd piano
>> git sparse-checkout add any_text
>> git checkout deploy-frontend
>> git sparse-checkout init --cone
>> git sparse-checkout add any_text

Thank you for pointing this out.

I'll point out that this was likely found because "--sparse" does not
initialize cone mode patterns, but you might have expected it to. This
will increase the priority of adding something like "--sparse=cone"
to the 'git clone' options.

> Thanks for the reproduction. An even simpler one may be (inside of any
> repository):
> 
>     git sparse-checkout init
>     git sparse-checkout add dir
>     git sparse-checkout init --cone
>     git sparse-checkout add dir
> 
> The problem occurs because we keep existing entries when adding to the
> sparse-checkout list, and cone-mode patterns do not mix with
> non cone-mode patterns.
> 
> So after the first init and "add dir", your sparse-checkout file looks
> like:
> 
>   /*
>   !/*/
>   dir
> 
> but then when we convert to cone-mode and try and add "dir" (which in
> cone-mode we'll convert to "/dir/"), we run into trouble when adding the
> existing "dir" entry. That's because add_patterns_cone_mode() calls
> insert_recursive_pattern() on every entry in the existing list,
> including "dir".
> 
> So when we call insert_recursive_pattern() with any pattern list and
> path containing "dir", we first insert "dir" into the list, and then:
> 
>   char *slash = strrchr(e->pattern, '/');
>   char *oldpattern = e->pattern;
> 
>   if (slash == e->pattern)
>     break;
>   // trim off a slash, repeat
> 
> except slash is NULL because "dir" doesn't contain a slash. And that
> explains the problem you're seeing, because (a) we'll stay in that while
> loop forever, and (b) because each iteration allocates memory to
> accommodate the new pattern, so we'll eventually run out of memory.

Yikes! Thanks for digging into the details.

> The wrong thing to do would be to handle this case by changing the
> conditional to "if (!slash || slash == e->pattern)", because we can't
> blindly carry forward some patterns which look like cone-mode patterns,
> since together the list of sparse-checkout entries may not represent a
> cone.
> 
> (An example here is if we added /foo/bar/baz/* without the corresponding
> /foo/, !/foo/*, and so on).
> 
> So I think the problem really is that we need to drop existing patterns
> when re-initializing the sparse-checkout in cone mode. We could try to
> recognize that existing patterns may already constitute a cone (and/or
> create a cone that covers the existing patterns).
> 
> But I think the easiest thing (if a little unfriendly) would be to just
> drop them and start afresh when re-initializing the sparse-checkout in
> cone mode.

This isn't sufficient, as a user can modify their .git/info/sparse-checkout
file whenever they want, so we should fix this bug regardless. We could add
a "Your existing patterns are not in cone mode" error.

It might still be a good idea to let "git sparse-checkout init --cone"
overwrite the sparse-checkout file _if the file is not already in cone
mode_.

Thanks,
-Stolee
