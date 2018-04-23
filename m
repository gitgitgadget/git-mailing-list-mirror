Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B8D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbeDWRJe (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:09:34 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:46273 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755473AbeDWRJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:09:21 -0400
Received: by mail-vk0-f47.google.com with SMTP id v205so9859002vkv.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2MAddTWA86YB3zPKOZayQ0gvpT+Vs2sWU0KNx57YBx4=;
        b=AJkkcUvMMP8e3kIMtzf7dP4/hhUuNArOAKf40Y3j+08urMJ08/p40Psp1s/VDEHx64
         ZzPYarxt6g8pNEDW3cD8DZre7wpaNRjvkHUD9AWWSYpfBttlsew2pYobuaN4HvuEF/42
         OFaYfXJbj5KGtuqYfMkaeuhAXSwSEniKLCGMhd4ppx+lDZyl1+oxNNujx8mkmRZ4qGiX
         QwqSVzL2aKb01Lidh3A58KDwP0wrve6Ueto793lKPHbdImX4f0MP9rMldM+jiAqoRT4f
         3WAxeLLJwD1dxADiKs9K9M7v/H9sWuiMQoX6VkOlPHTFlgxqeGAXydeQ7lCK4PrvJD5s
         hEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2MAddTWA86YB3zPKOZayQ0gvpT+Vs2sWU0KNx57YBx4=;
        b=VsqGIs3JmsKP+iTf3YDFpkEbFHuCCL4u/sIPEOFvwm1ikbJvZqRQGg2OeIOj/vzSPO
         /F8VfLE+98iAYnNuzdjT/jZgt6oie1ow/QtrETSVax+0BJwC8bxOv6tOqaCCpZAlDlVf
         yy6zLOMBT/XsZpXmt35QXvfG1Sy7GFLMvAw0TdQeZZmNhD6bA54W7aQhXZDilydrPwUX
         xvwsi205onPEIl6QkyOefJ6p0fj1jQThtuxHtsUCmJ1mNEJCU+DbNNCTs0Z6bSkrKQAe
         NqwLybywBXb6qBlIluqw86NhCNnbcsQHa5oZheudNiFwFaff4ntSRkXKpf/AH9fcrd6r
         2ecw==
X-Gm-Message-State: ALQs6tC57Nl//pgKOeuQKWrukwL1DGdiCXt+FYvmZjZg5TywCsvyCA5d
        6lVGVa0XJzcduSu+R6FhHhiOoHZu7td30oMU/78=
X-Google-Smtp-Source: AIpwx49mrRd8V8ho8jjQYF1iSmQAH6lkCQoFyDyU3C9b69DfdINqsVMsomQHPdC5nwwNSPKS/QsN6knRr7LUBHkC2YA=
X-Received: by 10.31.148.135 with SMTP id w129mr15108450vkd.7.1524503360924;
 Mon, 23 Apr 2018 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 23 Apr 2018 10:09:20 -0700 (PDT)
In-Reply-To: <CACsJy8D4OYphLG5vStr+M9qkiqyH_LR517M-JOPS2wJeTFNGRg@mail.gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com> <20180421193736.12722-1-newren@gmail.com>
 <CACsJy8D4OYphLG5vStr+M9qkiqyH_LR517M-JOPS2wJeTFNGRg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Apr 2018 10:09:20 -0700
Message-ID: <CABPp-BFuuywXrJuzfb4V1bRLb9eVZpLKiCDwQWetHk8bymC6EQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with
 split_index when src != dst
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Apr 22, 2018 at 5:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>   - there's a better, more performant fix or there is some way to actually
>>     share a split_index between two independent index_state objects.
>
> A cleaner way of doing this would be something to the line [1]
>
>     move_index_extensions(&o->result, o->dst_index);
>
> near the end of this function. This could be where we compare the
> result index with the source index's shared file and see if it's worth
> keeping the shared index or not. Shared index is designed to work with
> huge index files though, any operations that go through all index
> entries will usually not be cheap. But at least it's safer.

Yeah, it looks like move_index_extensions() currently has no logic for
the split_index.  Adding it sounds to me like a patch series of its
own, and I'm keen to limit additional changes since my patch series
already broke things pretty badly once already.

>> However, with this fix, all the tests pass both normally and under
>> GIT_TEST_SPLIT_INDEX=DareISayYes.  Without this patch, when
>> GIT_TEST_SPLIT_INDEX is set, my directory rename detection series will fail
>> several tests, as reported by SZEDER.
>
> Yes, the change looks good.

Great, thanks for looking over it.

> [1] To me the second parameter should be src_index, not dst_index.
> We're copying entries from _source_ index to "result" and we should
> also copy extensions from the source index. That line happens to work
> only when dst_index is the same as src_index, which is the common use
> case so far.

That makes sense; this sounds like another fix that should be
submitted.  Did you want to submit a patch making that change?  Do you
want me to?

Elijah
