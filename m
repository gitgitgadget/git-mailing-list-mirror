Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92710C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6824660ED8
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhH3RWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhH3RWH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:22:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEF4C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:21:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w19so20751582oik.10
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QfHUjxrLJkxoP/9FEH7IrVwp3sT/SQ2q6YMNKiNU+DM=;
        b=UXffP76mS8lQDPqoN8jcQXyOGU/b85DNGmnIEvG1jaiApZxAAFUOEkAv5ICq7IXFcv
         A6M+blayXj1ITccepL/N/NSbALFshvTuOYQkWnUh97uzSazV7D9MGOtmlRkz3NMqfDZD
         hik1Os/jKIBje9KvMw3oRlbpluE988UjqHrTc2s/B9+jrV63eFLqFStsBNYZNOGCT6RL
         ogEYE43ULsjSFflXd4EiKouaCRWjtJZjNx+fxXBvKMYOfzugtOID7ZR/b76oggCapcVU
         PXknZUnC5to0yw+e37rlnGDVSLJY/8boqK6kLppbtBpCBl6oTpLYZgF4+NSoYSS9gn4m
         QDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QfHUjxrLJkxoP/9FEH7IrVwp3sT/SQ2q6YMNKiNU+DM=;
        b=Gy7alImtq1VXdJ7bNbKzp5ICBhlcRmEdQir8Gu9amI9w+y/glHmJq+9CEkF7sGTiov
         hAudopZ+E8WGtmt5+YOjYXe4MpWcjDZxZaO50KjWvZ6vl3NcE+4V1eVcjARfVYHXnND5
         O1gK/87Bn0Syow21oMEZneKFmaTX7QOzHxKWqCZvYD5c3FyY1i+gGQ44qHn0c1Np1Yiy
         sbXc3w25xnU5DlS3FztJWgOpCeBxABW+8yqYE6VC71xp+DSCC0ehmTeDddFw40QbHgS3
         ZLeDBrRc02vMLIetJhLfAjrm7inwj3XOXBGfo3JVeOFwtyZMTlCk5v3OzG34Dv91+JQ5
         ArMQ==
X-Gm-Message-State: AOAM532kifjHuqkPbszVJMKr4rn6Fsxu7tXCRefj5lqXbZWgW8m+Y30M
        8iChuCNjKhqS9DB9RY3k7Xw=
X-Google-Smtp-Source: ABdhPJx0fzAPTrqLnOCJEoUldemA9e95d6UjDNepCmrVQ2HCxQdQq0SqjPYwMdGwZ4auEHcsRnlSIQ==
X-Received: by 2002:a05:6808:201c:: with SMTP id q28mr153935oiw.18.1630344072818;
        Mon, 30 Aug 2021 10:21:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e4d6:1362:a8d2:be4e? ([2600:1700:e72:80a0:e4d6:1362:a8d2:be4e])
        by smtp.gmail.com with ESMTPSA id k19sm3041130oiw.49.2021.08.30.10.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:21:12 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] merge-ort: expand only for out-of-cone conflicts
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
 <815b1b1cfbfedae7ccbec51b382053e3dcf197de.1629841966.git.gitgitgadget@gmail.com>
 <CABPp-BHzbg0tghxOncOVtLr44R1W45_PoLBk_Mztg8LaVv5hBQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2a1db2d3-d653-f572-d1c0-5d4e3913568b@gmail.com>
Date:   Mon, 30 Aug 2021 13:21:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHzbg0tghxOncOVtLr44R1W45_PoLBk_Mztg8LaVv5hBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 6:47 PM, Elijah Newren wrote:
> On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> +       (
>> +               sane_unset GIT_TEST_MERGE_ALGORITHM &&
>> +               git -C sparse-index config pull.twohead ort &&
>> +               ensure_not_expanded ! merge -m merged expand-right
>> +       )
> 
> These last five lines could just be replaced with the fourth, if you
> just set GIT_TEST_MERGE_ALGORITHM=ort at the beginning of the file.
> 
> Are you worrying about testing with recursive in some of the testcases?

Yes. In fact, since I _stopped_ setting GIT_TEST_MERGE_ALGORITHM at the
start of the file since the previous version, I found and fixed a bug
which forms the new Patch 5 (sequencer: ensure full index if not ORT
strategy).

Thanks,
-Stolee

