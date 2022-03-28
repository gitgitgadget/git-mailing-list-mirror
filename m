Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiC1OGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiC1OGG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:06:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7F19283
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:04:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 1so11432013qke.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dnnLQsiqVqjUL2gQwr8Npv/Oj+rLq9mK743kZRd60cY=;
        b=CjvgQnXIppmf85e+UKxMLf22wu4sE4RBG8tzL9kSRgFKTugIeEkqyYHiVBWMmHT+we
         dt6UlYp0RXocc5HZJi9Hs+mO/EwHIuywXpAiK7Pv++zJMxMrue7QK+xgWlVibBeIc/6a
         scNybL9D169jnCvQGQTK8ZqLahEZsBoSkvzWG6u8/nnB174/W/NTbNQWE68OpM8GyLBw
         UdmBg+N6hvxNadJE4dPp59dvb4trODtZPECz6jIQCceHUBhB5vTYUmHQ1Irz/gnk9Wnr
         5ZSiBWxvnneza6l1EyuCfSGNdEyMW0atsZyuMgdyCKUZQD3xSKf6ydvnpqzvcVBTU5NQ
         /VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dnnLQsiqVqjUL2gQwr8Npv/Oj+rLq9mK743kZRd60cY=;
        b=bjPCoQry9YgOen4/XS3cG7UBjqjjKoIW1RPpzNEenGuYKE7q3eWnJiBw2pgVXMAUzo
         3DGAlJHEpY52EJJUuU/v9Urcb1uZ3bhHsjDyf9ftT7fcBKHJ3/VM+eEfzAZBl46PJrme
         8TiV2nybQSbOtHe6zWHGof6C1CctGixr4cLbOJar7NTneypfKyTxrg1eJiA68yPmaVNZ
         4lkvCBo1vc13qYUP2dYH8CepXj0hQdf24gFH5kEwxv6Qg7iLddgJrUrkU+lJHDI8wvcJ
         V3McTiyGuj0qf4SuyiMOe6omPkUzRUYBSJqknR600jRq47OnPCh54FXADEbFmcwcGgM/
         IF1g==
X-Gm-Message-State: AOAM5311w2oGLH+ni0LJd3V4d7g7TjgpmbB0gfr8cx7CK60fvdLL9oP+
        jbMVczhDHBESQag5JVYzab6M
X-Google-Smtp-Source: ABdhPJyoZT+ErRLVjb+PUEEDhoZHLz7jLshy6KeTwrgFMd5s08iYZ7uw177dE97lQKZB+koSOGzMag==
X-Received: by 2002:a05:620a:4544:b0:67b:d13:be96 with SMTP id u4-20020a05620a454400b0067b0d13be96mr16528780qkp.596.1648476264179;
        Mon, 28 Mar 2022 07:04:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f34-20020a05622a1a2200b002e1a35ed1desm12979396qtb.94.2022.03.28.07.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 07:04:23 -0700 (PDT)
Message-ID: <6511a6b4-79da-ffe8-8000-982018a7e701@github.com>
Date:   Mon, 28 Mar 2022 10:04:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
 <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
 <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
 <220325.86mthdlx59.gmgdl@evledraar.gmail.com>
 <d90bb9c8-3155-ca5f-8363-154876a7ad0a@github.com>
 <220326.865yo1leay.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220326.865yo1leay.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 8:52 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 25 2022, Derrick Stolee wrote:
> 
>> On 3/25/2022 1:34 PM, Ævar Arnfjörð Bjarmason wrote:>>> 	-	list_objects_filter_copy(&revs.filter, &filter_options);
>>> 	+	/* attach our CLI --filter to rev_info's filter */
>>> 	+	memcpy(&revs.filter, filter, sizeof(*filter));
>>> 	+	memset(filter, 0, sizeof(*filter));
>>
>> Here, you are removing a deep copy with a shallow copy. After this,
>> freeing the arrays within revs.filter would cause a double-free when
>> freeing the arrays in the original filter_options.
> 
> Yes, and that's what we want, right? I.e. we don't want a copy, but to
> use the &filter for parse_options(), then once that's populated we
> shallow-copy that to "struct rev_info"'s "filter", and forget about our
> own copy (i.e. the memset there is redundant, but just a "let's not use
> this again) marker.
> 
> Of course this will leak now, but once merged with my
> release_revisions() patch will work, and we'll free what we allocated
> (once!).


>> Even if you fix the deep/shallow copy above, you still need to
>> clean up the filter in two places.
> 
> If you "fix" the shallow copying you need to free it twice, but if you
> don't you free it once.
> 
> I.e. this is conceptually the same as strbuf_detach() + strbuf_attach().
> 
> But maybe I'm missing something...
> 
> (If I am it's rather worrying that it passed all our tests, both in your
> series + merged with the release_revisions() series).

My problem is that you need to know that the filter data was
"detached" in a different scope than it is defined.

 * filter_options is defined in cmd_pack_objects()
 * The detach and reattach to revs is in get_object_list()

Your model requires internal information from get_object_list()
to know that you shouldn't release filter_options within
cmd_pack_objects(), which I think is a code smell. Better to
have something allocated in cmd_pack_objects() be freed in that
same method so it is visually detectable that we are freeing
correctly.

Thanks,
-Stolee

