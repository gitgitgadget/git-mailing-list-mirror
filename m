Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FBDC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBBD20776
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URxP34hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgEZRBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEZRBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 13:01:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B80C03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 10:01:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so4557674qkh.1
        for <git@vger.kernel.org>; Tue, 26 May 2020 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dtPyMVN4CCxB3emDv03CMlw4vA1k/VB0HJkGLJdkZBc=;
        b=URxP34hWhhH8Wn3PQkzzeRhYeqzMTL6pJwyATo+/rqzZS6llhdjwVTDHUgg+YgS+Sk
         SvwLBN0A+xQiiDJrL1bWGXOzZUQTQLCrKO87RczSkt/4e6sUYoh/R2cMzSWZtfFs1A/E
         7QxGK7sbg8aginh8B0SYHW3Q2HTzMm9STXeJ5MXlQOZ16TTeBKTXofYw+y+YsqmFmWks
         39KEIC+qCgOFLH1ad6etBjfYGovljhmTnadU7rhxhYFdK4l69y7zMriK/nhQui2ewq9p
         /IgkpBifAo2o/pqOmA9Uhk5NDzsUIhU0wlgSsQ6UGc9cfQ0xZV8mCE4zZaMsAVGHsnbU
         SZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dtPyMVN4CCxB3emDv03CMlw4vA1k/VB0HJkGLJdkZBc=;
        b=jeWV8HLAkjTUkBmG0ReIZfrILM/Jlo3vd0xpVJkOIJpfAyJlYGzoRTyi5OA30OxYuT
         gwG1YE8zepXYGiK7WCgxl7pbd/JidDx6JRwxSPxSYwpm8mZwqz5jO2gLUvckR/mIfycR
         BXxit99ytVh7hhmM0UAwscQ5OYq8PCgtye6hcdmrJ4VVrETNUUBZiyBzxvIJb6mQdysa
         T8d8sU0ewsPS4MD7uZ3V2vwzvx1EjtBzJzWoQPpLQxilT4ZkZUeX0GDMjv8BQ4a1JsNm
         teq2oUWwv2xQbvD9HN64hxXOv1dvs09i8ouCtwXyaPAz/l8LDF0G1+vguQ2nljQUyk/4
         uIzQ==
X-Gm-Message-State: AOAM5308yncos7n+UpQg6/l4q3QEJaEom7jxFi6A6DpC+uFox0kUoysb
        9k6z/3f/jyuqtkbCohMyNv6T/YFi6QQ=
X-Google-Smtp-Source: ABdhPJwajVmsz3M83FSPfIyF7ul1hX3c1qY4t7LTxb41tyukDYqxxHEavibO/50GjFhNNEBMOXkb5Q==
X-Received: by 2002:a37:8581:: with SMTP id h123mr2320617qkd.157.1590512500891;
        Tue, 26 May 2020 10:01:40 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x2sm154214qke.42.2020.05.26.10.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 10:01:40 -0700 (PDT)
Subject: Re: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
 <20200525170607.8000-1-martin.agren@gmail.com>
 <xmqqv9kiohfv.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <474bbf51-bd40-837a-77de-1688f6488ae3@gmail.com>
Date:   Tue, 26 May 2020 13:01:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9kiohfv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/26/2020 11:16 AM, Junio C Hamano wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
> 
>> Let's start a list for `--show-pulls` where we start actually discussing
>> the option, and keep the paragraphs preceding it out of that list. That
>> is, drop all those pluses before the new list we're adding here.
> 
> The way the "History Simplification" section is organized is
> somewhat peculiar in that it begins with a short list of what's
> available, followed by mixture of detailed explanation in prose.  I
> agree with you two that the result of this patch fits very well to
> the surrounding text.
> 
> This is not a new issue introduced by this patch, but ...
> 
>> +--show-pulls::
>> +	In addition to the commits shown in the default history, show
>> +	each merge commit that is not TREESAME to its first parent but
>> +	is TREESAME to a later parent.
>>  +
>> +When a merge commit is included by `--show-pulls`, the merge is
>>  treated as if it "pulled" the change from another branch. When using
>>  `--show-pulls` on this example (and no other options) the resulting
>>  graph is:
> 
> ... "is treated AS IF" somewhat made me go "huh?"; with or without
> the option, the merge did pull the change from another branch,
> didn't it?  The only effect the option has is to make that fact
> stand out in the output.

I guess the 'as if it "pulled" the change from another branch' sentence
is literally talking about the "git pull" command, as opposed to the
"git merge" command, or creating the merge upon completion of a pull request
on a Git service (which is almost always using libgit2 to generate a merge
commit).

Perhaps there is no semantic difference between "pulling" and "merging"
and then this could be reworded to be less awkward.

Thanks,
-Stolee
