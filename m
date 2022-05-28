Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F9C433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 04:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiE1E0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 May 2022 00:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiE1E0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 May 2022 00:26:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631185BE41
        for <git@vger.kernel.org>; Fri, 27 May 2022 21:26:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j14so5980258qvo.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 21:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=rbC/BW/4FhKbHXdeMSski26xLwwm2T03NY5zvEQ9fHw=;
        b=fbsCbbs9gTOTu5GN07ljfmGPyiOFGile77eUGwBygq5ZNO1/7KmWZkOs62SX9WZC1J
         aBZcUVgfL47temKOF+UG1Kr0xt10rWkeYfwbDwDlK/RVCWBx+P4CBTFAJIUcXIZcLV9X
         BO2XzAQiBuHURDjEr35LMM1f+pakiR5TUw3ZYionw97/5N+ARMmPMt7Tlmm5c5+DdSJa
         kHZ5aD0A63FWd7Uog+jTw/UYN72glyDswrkmYT6T5KK7eXp7VU7OkcYbBYbVTSAiB2IU
         3Ahqo9RtEz89TqjUTFDYKw6UiDAdkMisiBtaBO7/qlrOxadRniYctIXabY2zgQxsmVXN
         E30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=rbC/BW/4FhKbHXdeMSski26xLwwm2T03NY5zvEQ9fHw=;
        b=2IPAeTVtEBYhpKzQh3UN7O2a3uGSZIYgPJkl6GjI6SQHCYZDnPgY0K40O+89FoBqmy
         oYRrJcLb89GV1FPcrVnAMz+SoiU7bKaxmhoZnXDwW/Phuyfc8Z0UZqhSNTL4G1SNmc2d
         ra6zIbR0DGCpNXHAbOGFGpKwse2TzNGRqWPMPEpRhw7Z9z/fYzY8aGiABK0D9lne/Okt
         wKn5gOM0UUu6owP6hr/Bnmflc06nw3iAXWKqSHoj1lLoOdXnXC6EVz7axx4Fzcb7hb/r
         gtq/QIJJ6I9mayY01bxxdM05ok/8nrKFpMs56/MuHJUhPtignZ/0iVglSFu+sKDOKDel
         mneg==
X-Gm-Message-State: AOAM531h1gpIj9M2DFUXBaxCDO9xtmkxZac18QoHkZkDzMS+nqC/cfrI
        3QDFnnJVnynrdmEJv/czx+7w5sPYVWJ8OQ==
X-Google-Smtp-Source: ABdhPJzmQZhhsvMiLamaU8+8uVD3CVIRFFaQdn4k807w7MuwvBDZ8TFz9JUAuI/SR8HDBZVTZP7YFQ==
X-Received: by 2002:a0c:c206:0:b0:461:d481:b54b with SMTP id l6-20020a0cc206000000b00461d481b54bmr38025472qvh.65.1653712002491;
        Fri, 27 May 2022 21:26:42 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006a10c8d5d96sm4201403qko.3.2022.05.27.21.26.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 May 2022 21:26:41 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
Date:   Sat, 28 May 2022 00:26:40 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <E0D2A9A0-FB95-47ED-B672-93AAFE798CD9@gmail.com>
In-Reply-To: <xmqqzgj21xm4.fsf@gitster.g>
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
 <xmqqzgj21xm4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 27 May 2022, at 17:20, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> In order to allow users to use one executable for multiple hooks,
>> provide a GIT_HOOK variable that is set to the hook event that triggered
>> it.
>
> I agree it would be handy to give hooks to play multiple roles by
> dispatching on its name, just like our "git" potty can dispatch
> built-ins when called "git-foo".
>
> I do not think GIT_HOOK is a good name for the environment variable
> that is used for that purpose, though.  It is easily mistaken as if
> end users can set GIT_HOOK environment themselves to point at a
> program and cause "git" to run it whenever it may want to run any
> hook, for example.  IOW, the name is overly broad.

Yes, I see what you mean. It would be good to pick a more specific variable.

>
> How about calling it with a name with "HOOK" and "NAME" in it?

For lack of imagination, would GIT_HOOK_NAME still be too broad?

>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index 26ed5e11bc8..a22c1a82a5e 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -38,6 +38,18 @@ test_expect_success 'git hook run: basic' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success 'git hook run: $GIT_HOOK' '
>> +	test_hook test-hook <<-EOF &&
>> +	printenv GIT_HOOK
>> +	EOF
>
> This will introduce the first hit from "git grep printenv".
>
> It is not even in POSIX.  Do we absolutely need to?

certainly not, I'll change this.

>
> Perhaps
>
>     echo "$GIT_HOOK"
>
> is sufficient, or if you want to distinguish an unset and set to
> empty string:
>
>     if test "${GIT_HOOK+set}" = "set"
>     then
>         echo "GIT_HOOK is set to '$GIT_HOOK'"
>     else
>         echo "GIT_HOOK is unset"
> 	exit 1
>     fi
>
> may be another way.
>
>> +	cat >expect <<-\EOF &&
>> +	test-hook
>> +	EOF
>
> For one-liner,
>
> 	echo test-hook >expect &&
>
> should be a more compact and equally understandable way to write this.

good point!

>
>> +	git hook run test-hook 2>actual &&
>> +	test_cmp expect actual
>> +'
