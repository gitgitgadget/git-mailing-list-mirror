Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5DC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C70206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok/VCJ4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgFHOCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgFHOCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 10:02:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0043C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 07:02:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so17547798wrt.5
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Akp6ooQHfCJDYpzzSVopqfcy7VgafhgdzqQPhSgT+5k=;
        b=ok/VCJ4I0oZG3SI5DB59utngBsVJILuobJsC7WYeosTxZ0gN5RtHM7/sjUcYQjZ3Qf
         ZAn0VPLQQ9mDwXDwoYCihCCGI+aaY5MQ0LaaVTH7c82PZ9AE+KKzJZwG5pvyMPwwMesP
         nWwxqg7Xo3cUqcinNZodzq8KWtsX9bfoQTbFj8hbZIPGyExw0wtMla6g+zpYF6+pl2qi
         /ci9klOeZvGl/Tp1xI60+ZO4pwe88vyKFu0uyiyxOeh6gmgLkP/oAtXZKJVBNDfrE57W
         XftcM1jHaKi6E4Y47kQCZWSxcw1EC3Ym7VOcxGoH3uQ5PefWatk4vYpzcx0k1vW4hWow
         nUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Akp6ooQHfCJDYpzzSVopqfcy7VgafhgdzqQPhSgT+5k=;
        b=b6atNqgLW0vTG9/qclNp3+U/7IWWlsCFuweArtFuHcVc29cc+xDxD3weaGqoB9uiIh
         qbseTdyg+1/AtIfTtQth/fGA77X4KKCac41JrT0EejCIfQpe0s1l/BDuX85F6MxdRIZf
         UbVA5YE8NV+OF4kyo2qEqFVLnWlN5cOAB7yilyoffpXvOpglKPj30F6Gzk/u7yttvpO8
         qFTGOq2JqWW+LNyVjYEcUcNYu6q7ifOwiZJMJtoMthg2bGs57fV75yRTp6VjBCtZnmes
         3GgFBIiw7WjY6GKEAfGZc80luTUaXuy+Le7RwDqUnLuIzHvPKuq78S+NvgtIoHPGLq79
         zWWw==
X-Gm-Message-State: AOAM531X9Qg40vwdwBWwQygUqnbOaQkGXQjc5OslGMux/6sjuTcJhA/t
        mK5cdBMgvkITp8ehysusQ1WChI/Q
X-Google-Smtp-Source: ABdhPJyPTiBxFA8uYN2vgHzokdKKWqYyBhGoKFGT1N/UrzOLK/QnPCZ26UPlCkUWBnc2GKr6BnIkSQ==
X-Received: by 2002:adf:f0c3:: with SMTP id x3mr23310355wro.35.1591624970506;
        Mon, 08 Jun 2020 07:02:50 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id 128sm24204457wme.39.2020.06.08.07.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:02:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] grep: add configuration variables for --heading
To:     Simon Ser <contact@emersion.fr>, Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "me@ttaylorr.com" <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
 <C5PlGbi78_QpceNrgFm_-Wt6BooqbntaL8OdH7XjxjXCtyIfsisyeOQMslLOwNY68Dg7iUxGIvzLPAvUEWyMIC0GdpTgeWwgwD5sWlsyrSM=@emersion.fr>
 <xmqqeer5mina.fsf@gitster.c.googlers.com>
 <2lg0C_0k4SnWqhB0oW3wGE6eixtc_ZT5GgZJFzH8XC6g5dJXmSGGnrV9uZVT4QIOG9Sjc7yuLOR_v5kwGIV1hnMSojXinNG16G3tOOMg-Fc=@emersion.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1c61583e-5af4-2c11-0147-213b1c484fbd@gmail.com>
Date:   Mon, 8 Jun 2020 15:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2lg0C_0k4SnWqhB0oW3wGE6eixtc_ZT5GgZJFzH8XC6g5dJXmSGGnrV9uZVT4QIOG9Sjc7yuLOR_v5kwGIV1hnMSojXinNG16G3tOOMg-Fc=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon

On 08/06/2020 11:22, Simon Ser wrote:
> On Wednesday, May 27, 2020 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Naturally it follows that a command-line option
>>
>> $ git config grep.heading yes
>> $ git grep --no-heading -e pattern
>>
>> is a way to countermand the configured default per invocation
>> basis.
> 
> Is see where you're getting at, but this is missing for a handful of
> options, like grep.lineNumber and grep.column. I'd rather not create an
> inconsistency here.

Those options do exist - try
   git -c grep.column=true grep --no-column ...
and you will see that the column number is not printed. This is because 
OPT_BOOL() without the PARSE_OPT_NONEG flag creates as --no- option.

If these existing options are not documented or tested perhaps you would 
be able to add a second patch to fix that.

>> When writing new tests, we often get too excited and stop at showing
>> off how well the shiny new feature works, but we should make sure
>> that we test the "negative" case, too, i.e. that the "feature" can
>> be disabled when the user does not want to trigger it, and that the
>> "feature" notices incorrect invocations and fails appropriately.
>>
>> E.g.
>>
>> git -c grep.heading=yes grep --no-heading ...
>>
>> should not leave the opt->heading true, and
>>
>> git -c grep.heading=nonsense grep ...
>>
>> should fail, saying "grep.heading must be a bool" (or something
>> along that line).
> 
> Note, these new tests are only required if --no-heading is added to the
> patch.

That is not correct in the case of `git grep -c grep.heading=nonsense 
grep ...`. Anyway --no-heading does exist.

Best Wishes

Phillip
