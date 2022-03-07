Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920EEC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiCGRmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiCGRmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:42:49 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2293984
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:41:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j5so12591097qvs.13
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 09:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=wB/vJ9z/t2nTqcb4iYqgR0CzRogR0Bu2AXhcalL3d+E=;
        b=LiGfACsUNWua8n0iOpXg+zQjGPATmtYjX0lRvHffGvhPHK6j8PZ3vyyOFK0VQi7GLH
         43PLycsrsLOivZ7aV5GHCyhKEeZ+BMPXzuLAOcZJd3fyI3kKfge/FzjZWGrrUG8uwIjz
         0/Hy0Tiyek7nCt5NjaMylY9HYrzdV6fXAP5N04d0YxlyZi//olWw8zFfYgqTHmD2/Pi2
         dq8z2XDeq+ePFFqh45CVu12pmmHvZuFWKrSHLwABCq9GR/5A4y5Lzp9qlnAv5tQG6YLH
         UcqQF118WvJOjl9avXfNzCR9AKMdxUb2ey7BtgYjf5kVyxMaiknHd2jJmVdHTJ4S3i7w
         S1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=wB/vJ9z/t2nTqcb4iYqgR0CzRogR0Bu2AXhcalL3d+E=;
        b=wNn0IWrV9T5kI+X0zkX8bKuU+1JqOJu/QhqVdXQgjoyChKsXmpqTz0CatEE6kwo5C2
         VmEe1P0X5nyb2lwinSV9y78fMh29zaEyLmcahzUtKzgIRnyRoPRfch6KlbofBqEYrKl9
         CvhRx7TlniYHbPfA4jtYQqWW25Okq2dcEMVcCFlITyVff5aE20RsWpF9Yn2kMm6ukHnA
         xQY1KmtOI1+9h2opPIfsHStxQf2bAaQOAdaYTqqFJibLmJQltCYW3y+0kcPD9AKePhyN
         H0PR96oJxN1gUDNqeCPMHb/NcIcjcGwxGDbfydfW1WKgsbsXo4yhZXPbkvPzGgwqy8tq
         j6mQ==
X-Gm-Message-State: AOAM530S78G8kacTOwaMK07Zq+R4oaJFQnwWQlPB4m/1ej/Kp2CXUHnB
        WFY2A4oiGlcOJa55Xwtvvumn/er5iVQ=
X-Google-Smtp-Source: ABdhPJwl6s/wVfx9h6giDNNW8mkvoCSo+qYr8JSXQC4Wuh+umeKoEb52rWNrRLn08cKZnyxcKKAM0w==
X-Received: by 2002:a05:6214:2609:b0:435:1db0:7578 with SMTP id gu9-20020a056214260900b004351db07578mr9074863qvb.20.1646674913364;
        Mon, 07 Mar 2022 09:41:53 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id r14-20020a05622a034e00b002de72634a7asm9015490qtw.37.2022.03.07.09.41.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:41:52 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cat-file: skip expanding default format
Date:   Mon, 07 Mar 2022 12:41:52 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <68505E7E-AEED-4DA7-A70F-8B4FE214C05D@gmail.com>
In-Reply-To: <xmqqilsquwaw.fsf@gitster.g>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <xmqqmti2uwzr.fsf@gitster.g> <xmqqilsquwaw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 7 Mar 2022, at 1:11, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> When format is passed into --batch, --batch-check, --batch-command,
>>> the format gets expanded. When nothing is passed in, the default format
>>> is set and the expand_format() gets called.
>>>
>>> We can save on these cycles by hardcoding how to print the
>>> information when nothing is passed as the format, or when the default
>>> format is passed. There is no need for the fully expanded format with
>>> the default. Since batch_object_write() happens on every object provided
>>> in batch mode, we get a nice performance improvement.
>>
>> That is OK in principle, but ...
>>
>>> +	if (!opt->format && !opt->print_contents) {
>>> +		char buf[1024];
>>> +
>>> +		print_default_format(buf, 1024, data);
>>> +		batch_write(opt, buf, strlen(buf));
>>> +		goto cleanup;
>>> +	}
>>> +
>>> +	fmt = opt->format ? opt->format : default_format;
>>
>> ... instead of doing this, wouldn't it be nicer to base the decision
>> to call print_default_format() on purely the contents of the format,
>> i.e.
>>
>> 	fmt = opt->format ? opt->format : default_format;
>> 	if (!strcmp(fmt, DEFAULT_FORMAT) && !opt->print_contents) {
>> 		... the above print_default_format() call block here ...
>> 		goto cleanup;
>> 	}
>>
>> where DEFAULT_FORMAT is
>>
>> #define DEFAULT_FORMAT = "%(objectname) %(objecttype) %(objectsize)"
>>
>> and
>>
>>> @@ -515,9 +543,7 @@ static int batch_objects(struct batch_options *opt)
>>>  	struct expand_data data;
>>>  	int save_warning;
>>>  	int retval = 0;
>>> -
>>> -	if (!opt->format)
>>> -		opt->format = "%(objectname) %(objecttype) %(objectsize)";
>>
>> retain the defaulting with
>>
>> 	if (!opt->format)
>> 		opt->format = DEFAULT_FORMAT;
>>
>> instead of making opt->format == NULL to mean something special?
>>
>> That way, even if the user-input happens to name the format that is
>> identical to DEFAULT_FORMAT, because we only care what the format
>> is, and not where the format comes from, we will get the same
>> optimization.  Wouldn't it make more sense?
>
> Actually, doing that literally and naively would not be a good idea,
> as the special case code is inside batch_object_write() that is
> called once per each object, and because the format used will not
> change for each call, doing strcmp() every time is wasteful.  The
> same is true for
>
> 	fmt = opt->format ? opt->format : default_format;
>
> as opt->format will not change across calls to this function.
>
> So, if we were to do this optimization:
>
>  * we key on the fact that opt->format is NULL to trigger the
>    optimization inside batch_object_write(), so that we do not have
>    to strcmp(DEFAULT_FORMAT, fmt) for each and every object.
>
>  * a while loop in batch_objects() or for_each_*_object() calls is
>    what calls batch_object_write() for each object.  So somewhere
>    early in that function (or before we enter the function), we can
>    check opt->format and
>
>     - if it is NULL, we can leave it NULL.
>     - if it is the same as DEFAULT_FORMAT, clear it to NULL.
>
>    so that the optimization in batch_object_write() can cheaply kick
>    in.
>
> would be a good way to go, perhaps?

thanks for looking into this. Yeah, I think the approach you outlined makes
sense for the reasons given.
