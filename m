Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337CDC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B8E610FB
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhINK3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhINK3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:29:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74CEC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:27:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so19352680wrn.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5MBWqGzxOi4H2+xMM0aSFO0A2BavpL662S8NkcS4hU=;
        b=VS56ZbZDdqirWGQ1cHzvJCyjy304QHlmozrQ8jlIwxitiVmfXiFBhTBHTzIoLDTYHk
         nXp7RbzCn7/70W5zosGF9RgsPHkIJa0TP48Q6OL0U1RclonMC5xySWlUqET8grimR1+q
         La77x2mTkg0970uHWCFO6byM0Ff7h6S7ZgzsJ8jJxKlOsmiuMs23rS3BID8BVYuhxth3
         ppQGskGoT5eUCrs6PFXxxz9TjoW4+51+ifDJClwoNT1mimSGBmbUEow0ZOXwsnt3UlYN
         81tUiXDt+FTLtL638Q1FX+aiEQ/puh4wYfzgVdnn5Vok5fR2unFXoMV2mUc/4JFM5PCr
         iK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5MBWqGzxOi4H2+xMM0aSFO0A2BavpL662S8NkcS4hU=;
        b=g3V8t/KgcQwjYDcl4EDfVm/87nonfedBbHqmECHNx0YPV50LsmlN5ubf78tBagZVt8
         mR9+D5W2nBK0wGocPK1lde2q8LsU+f7KRPI4LizAxLGVXlaUS22urENnqHqGC/G75kVl
         VXS7CXnQqG7x8PjGphBF1HzuuwOEh02c+NJ8gw9CzNSQH0HZ9egn/sG6mbJtlGrFEfyf
         /YFsew0TekpHd7FfI7WNJyAYkZ+NnJ16DFiyGG1QzOOtU6ZLkQQ4e4fMsLUSO9QAKATo
         M80vpo9k9Fo5Y9cPEqkiAxxy7X69HfMGcYvxepn5yOJ8hqW3VF523OiesyF4rTkuROs4
         YXxA==
X-Gm-Message-State: AOAM530ePQdjw8NRO6lUF1B2d6AlR5t0wVkHnYZaGNAg687zdyJFBcDP
        4jyjTZzJQv56cl7306m/1+TcNAYNt60=
X-Google-Smtp-Source: ABdhPJy4IAtF3dgQJRvH6phUKoH0jOmpg9Vla5vjW++HrUE4PjFdow/JWwY7WzQPKWGDmmdVL6Jqtw==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr17632191wrq.58.1631615274288;
        Tue, 14 Sep 2021 03:27:54 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-48-114.w92-156.abo.wanadoo.fr. [92.156.201.114])
        by smtp.gmail.com with ESMTPSA id q7sm9956015wrc.55.2021.09.14.03.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:27:53 -0700 (PDT)
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20210913185941.6247-1-alban.gruin@gmail.com>
 <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
 <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
 <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com>
Date:   Tue, 14 Sep 2021 12:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Le 13/09/2021 à 23:57, Eric Sunshine a écrit :
> On Mon, Sep 13, 2021 at 4:42 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>> Le 13/09/2021 à 21:26, Eric Sunshine a écrit :
>>> On Mon, Sep 13, 2021 at 3:14 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>>>> This adds the --recursive option, an alias of --recurse-submodule, to
>>>> git-clone's manual page.
>>>
>>> Considering that the `--recursive` option was intentionally removed
>>> from `git-clone.txt` by bb62e0a99f (clone: teach --recurse-submodules
>>> to optionally take a pathspec, 2017-03-17), it's not clear that this
>>> change helps the situation.
>>
>> The patch you mention also hides --recursive from the option array, but
>> that was reverted with 5c387428f1 (parse-options: don't emit "ambiguous
>> option" for aliases, 2019-04-29).  The option should be re-hidden, or
>> even removed.
> 
> I don't quite follow. As far as I understand both by reading
> 5c387428f1 and by testing, 5c387428f1 fixed tab-completion so it would
> _not_ show `--recursive`.
> 

bb62e0a99f hid --recursive from `git clone -h' with PARSE_OPT_HIDDEN,
but 5c387428f1 reverted that:

$ git checkout 5c387428f1~
$ make
$ bin-wrappers/git clone -h
...
    -s, --shared          setup as shared repository
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone
    -j, --jobs <n>        number of submodules cloned in parallel
...

$ git checkout 5c387428f1
$ make
$ bin-wrappers/git clone -h
...
    --recursive[=<pathspec>]
                          initialize submodules in the clone
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone
...

The two options were then reordered by c28b036fe3 (clone: reorder
--recursive/--recurse-submodules, 2020-03-16), and this is where we are
today:

$ git clone -h
...
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone
    --recursive[=<pathspec>]
                          alias of --recurse-submodules
...

Junio did mention[0] that --recursive was no longer in the manual, but
not that it was once hidden from the option list.

> Anyhow, another approach which we've used elsewhere is to mention the
> option in the documentation but indicate clearly that it's deprecated.
> That way, people who run across the option in existing scripts or old
> blogs can at least find out what it means. Something like:
> 
>     --recurse-submodules[=<pathspec>]::
>         After the clone is created, initialize and clone submodules
>         within based on the provided pathspec.  If no pathspec is
>         provided, all submodules are initialized and cloned.
>         (`--recursive` is a deprecated synonym.)
> 
> I don't have an opinion as to whether or not we'd want to do that in this case.
> 

[0] https://lore.kernel.org/git/20200316212857.259093-3-gitster@pobox.com/

Alban

