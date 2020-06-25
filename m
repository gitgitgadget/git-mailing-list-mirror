Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F2C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10F220789
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8W0Z3Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbgFYSRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbgFYSRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 14:17:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107DC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 11:17:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so6937841wml.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9LUjhZC0Tte9SNyUBEXU6iC3epJn6EtV+9c5D/hYYzA=;
        b=C8W0Z3EzwfBgRWd74AOosyowqhikD4WgyysyEDH7D4q7aD6M3oOtRcKDm+QS1/7Im6
         2bU4fewYvqGoKzQTuc/mFDC/MuIjZMaaZ5J9SjlM2oROSClsUDt2Yh5QFOnwp6V1Klf1
         97vpBsKuyqPMlRdB6SAsFvOjquz8Ep5wxyup8u3FX7T/jfs4yv+pL8XZEZXJ13ECIYtx
         UbvBs7CS4A/NbckBOoPvwi7WmJcu6qaAE8PzUP1MIsXGeQArJrmW4C2io8iGOVn/ApSl
         5dYPubb5b9Hzz7b8mxbMSqXxIzlMUkV7jto5wYes9xjvgifBpG0hN/OsInjVa6hW7haR
         My9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9LUjhZC0Tte9SNyUBEXU6iC3epJn6EtV+9c5D/hYYzA=;
        b=gS0kKZ+vbENi+hAQI3DEGDqhKhhK+66kKWi+YXDHUUfg1y2zTpRmyoJR90msrOYO+R
         BR/0wvpfrJIZ/LMmpxL+BuNsUL1p/W6AU22tg1ra8subAw3M51NthKB5u9mPprw2cnCq
         oGCgLYg7cKJQIiO0fn0NRIfkhJmHt3rnWZ50D1vdg2fcCK+zqHtPOCGprGCQ14n1W90G
         oXUDgKcyFJKLwQabUul7f6tM5al9VoeEkaSKhx9kRHJ5mzGvY6X9cIC8kegb2C6AUTkM
         x/lguRnijrNtyyTiBvOubHt6gBgUfJcvbmQ39XnBa/2VspvRkwpolmQ2s9GnTGwU6W4y
         WdZw==
X-Gm-Message-State: AOAM533xvgTIXIo3SdW1mlM5r3U5PAToVNPmUrGh05t/hHgPTMG1os07
        LZe8c/HMZlZEA/RohJNwQn4=
X-Google-Smtp-Source: ABdhPJyISYI0E8IhCkzucs5BusFd/mNPKZddY9CDOyB2Gc+UWYBiSQTAQFr3FHgwrYpQTFkk/rzUcg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr4788270wmj.20.1593109058397;
        Thu, 25 Jun 2020 11:17:38 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id m10sm14127607wru.4.2020.06.25.11.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 11:17:37 -0700 (PDT)
Subject: Re: [RFC PATCH v1 02/17] merge-one-file: rewrite in C
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-3-alban.gruin@gmail.com>
 <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
Message-ID: <32ce88bd-14ce-0cd4-b938-285a95302cae@gmail.com>
Date:   Thu, 25 Jun 2020 19:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/2020 16:16, Phillip Wood wrote:
> Hi Alban
> 
> I think this series is a great idea
> 
> On 25/06/2020 13:19, Alban Gruin wrote:
>> This rewrites `git merge-one-file' from shell to C.  This port is very
>> straightforward: it keeps using external processes to edit the index,
>> for instance.  Errors are also displayed with fprintf() instead of
>> error().  Both of these will be addressed in the next few commits,
>> leading to its libification so its main function can be used from other
>> commands directly.
>>
>> This also fixes a bug present in the original script: instead of
>> checking if a _regular_ file exists when a file exists in the branch to
>> merge, but not in our branch, the rewritten version checks if a file of
>> any kind (ie. a directory, ...) exists.  This fixes the tests t6035.14,
>> where the branch to merge had a new file, `a/b', but our branch had a
>> directory there; it should have failed because a directory exists, but
>> it did not because there was no regular file called `a/b'.  This test is
>> now marked as successful.
>> [...]
>> +static int merge_one_file(const struct object_id *orig_blob,
>> +              const struct object_id *our_blob,
>> +              const struct object_id *their_blob, const char *path,
>> +              unsigned int orig_mode, unsigned int our_mode, unsigned
>> int their_mode)
>> +{
>> +    if (orig_blob &&
>> +        ((our_blob && oideq(orig_blob, our_blob)) ||
>> +         (their_blob && oideq(orig_blob, their_blob))))
>> +        return merge_one_file_deleted(orig_blob, our_blob,
>> their_blob, path,
>> +                          orig_mode, our_mode, their_mode);
> 
> It would be nice to preserve the comments from the script as I find they
> help a lot in understanding which case each piece of code is handling.
> The code above appears to be handling deletions but does not appear to
> check that one side is actually missing. Shouldn't it be something like
> 
> if (orig_blob &&
>     ((!their_blob && (our_blob && oideq(orig_blob, our_blob))) ||
>      (!our_blob && (their_blob && oideq(orig_blob, their_blob))))
> 
> Maybe this could do with a test case

The reason your version works is that if only one side has changed
read-tree will have done the merge itself so this only gets called if
one side has been deleted. However the original script printed an error
if someone accidentally called when the content had changed in only one
side and there were no mode changes. I think we want to keep that behavior.

In the future we could probably update this to also handle the cases
that read-tree normally takes care of rather than erroring out but I
don't think it is a high priority.

Best Wishes

Phillip
