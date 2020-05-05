Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB90C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5342206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4cDF7pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEEM0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEEM0M (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:26:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43ABC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 05:26:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l18so1729039qtp.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6lbaUC6e3DQHhDHZHbmgxSOTQK29MPB6N6yerAs/UI0=;
        b=P4cDF7pl9nL+9OCd2x/wbbZig2J297jReRTHtDhXn6IhYaSW3eeOWF1/WKt/WGH24L
         mudT/91V8bAYH7Ksp4Ry6F0io2sXFC7ZKZU5G7AIgopZ0uRCfanImn7FBoIvnk1/nk4d
         Rc6dmQggfYM7dLG51keJf5X7hbMseLHLqQ2O8MDtQgPll9mmN5jFBMQs3p8QPuaTyzYX
         7y4ZFP4KZXNxRR27NjDcjYgB/z2CAO2pVTMit6WvLkZsISQk0MjiMxOkgjhj+a60gRDP
         10/f7A5zib1GhKa9rNgpBxPmcZpu6kR72aheRCGfgdltVBID3C6/KrANWBq+AHIJLZdJ
         l82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6lbaUC6e3DQHhDHZHbmgxSOTQK29MPB6N6yerAs/UI0=;
        b=fz8Tx88oYayFxzbf8Z++SmwX30jN8+1OY3fhSBgWCCPLxp3EW783+jZS5pzJL8DwaJ
         hTS3G7WoSv23wUNeyaIcYRMeAnFzMrZ/GqqY5OIAZxk5XJ4hsMbcHetVx5Wgtkdj82uH
         lwbXOv+WQwZLmAFAHQSEud3KFVr4Spv2MPNusc/t2+DTOxJGEdkHA7LQekFYIY52I4oq
         vezVmqxfwqNaGIC62qeXskgiSwVKosFfFbe4MnKV5il0rpzCpHAsVUGxWUaL8bTIuUhD
         Xsy2b+0i5TLMUVqwj9i6+wFF6qmqPh24XjMnM4TUysK+4vvze3n5pbeutBVDtPE6PUS1
         Nk9w==
X-Gm-Message-State: AGi0PuacmnLCFJB11WPfD+c1yyXy8JsRcQSjXJ66zmcaaWix0aFAdQ14
        bYfHYxCeTKvKHNvOA/7VqmSfUhyhE69pLw==
X-Google-Smtp-Source: APiQypKzMoX9R5HMHesQjP0srzSe5E4M84xq3qtp2eXM5DYAAfYJL+uUi8CrgotVJYmLG18SggwzUQ==
X-Received: by 2002:ac8:6d1d:: with SMTP id o29mr2276224qtt.327.1588681569881;
        Tue, 05 May 2020 05:26:09 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o33sm1620911qtj.62.2020.05.05.05.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:26:09 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
To:     Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        sandals@crustytoothpaste.net, christian.couder@gmail.com,
        dstolee@microsoft.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-3-shouryashukla.oo@gmail.com>
 <xmqq7dxyxlpj.fsf@gitster.c.googlers.com> <20200502061355.GB5582@konoha>
 <xmqqzhanhehd.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e11d316-f8d6-3921-f1a6-026584d9291d@gmail.com>
Date:   Tue, 5 May 2020 08:26:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhanhehd.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 12:06 PM, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
>> On 29/04 10:09, Junio C Hamano wrote:
>>>> ---
>>>> I wanted to ask why is there no mention of partial cloning in
>>>> the 'git-clone' documentation? Is it because it is an experimental
>>>> feature?
>>>
>>> If the folks that have been pushing the feature haven't bothered to
>>> document it fully, by definition, it must be a work in progress that
>>> is not ready for the prime time ;-)
>>>
>>> Jokes aside, the --filter=<filter-spec> option is mentioned in the
>>> documentation and it says "...is used for the partial clone filter",
>>> without even defining what a "partial clone filter" really is.
>>>
>>> The topic deserves its own subsection, between the "Git URLs" and
>>> the "Examples" sections, in git-clone(1).
>>
>> May I try to add it? If yes then are there any points to be kept in mind
>> while writing this part (for eg., length of the subsection, writing
>> style, what all is to be written etc.)?
> 
> I am much less qualified to answer these questions than others on
> the CC: list.
> 
> Who added the mention to --filter and "used for the partial clone filter"
> to the page anyway?  Did you run "git blame" to find out?
> 
>     ... goes and looks ...
> 
> It was added by 4a465443 (clone: document --filter options, 2020-03-22).
> 
> Derrick, perhaps you can help Shourya to find a good place to give
> a birds-eye description for the partial-clone feature and figure out
> what points about the feature are worth covering there?

Yes, in the series that added those options I requested help in
documenting the partial clone. This was started in [1] but seems
to have gone stale. 

CC'ing Dyrone to see where they are with this.

Shourya: would you be willing to help the patch [1] get finished?
You could probably incorporate it into this series (adding your
sign-off). Let's see if Dyrone gets back to us.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/c1a44a35095e7d681c312ecaa07c46e49f2fae67.1586791560.git.gitgitgadget@gmail.com/
