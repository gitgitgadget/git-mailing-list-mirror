Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA6C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiASUCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 15:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 15:01:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727A6C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:01:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so427952wma.5
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=RTShQ2BRK1ZeEPFf99WDEmEB1LmPd5eWz7udSclFD1Q=;
        b=R9qRkO277QjpeXy2W8ibabF6PDjubyewHNPv5rKL1hi52AnS/u33P7+qJgJtGcp3ju
         pgF/NEzQBvI9MlEd0PJaMTC5FYOWwCO4ULD/J9Ny4fmQJJ2bH5Id47EUTI8aCQpNLzr+
         NNI8PSukOGJvHFYnReifh7uZtQYVjqn6BseH0mHvgranaE/fBkxCMJyPc1kk2iogb0cA
         axwZFJAGuZyc+qXxMdxBsGrOYVwiz6wCp+yv5MNli9n2EUA5A6dv4YfQ4nIDiqZXCM42
         BIcevUumwytgqI4e1OICpeIPm37KElSSfIfaVT0pWiAoOMzPwokg5hcCB+OdWuzfWRgm
         dLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=RTShQ2BRK1ZeEPFf99WDEmEB1LmPd5eWz7udSclFD1Q=;
        b=vSPlwptBdCd6p39gvtifzL6XPvJeXMu5naq9eMXBHYSV+Pi3ySl/eDsZKovM4qA1ni
         vyqK+ugoZs9I6tOeAB+m0MwdpUH6CvGtWPJPaWWxt/SPjUnsQiHEZjUI10IKoPNq/K20
         xA5i7jbS5BPtQrAfbK7urFnpZWsXFXRa45bMlQWMB+qJ3HbHjpL+OOutc224hkbXa5qU
         w2pbysFbgicPSnI2I7Qoa2jYeSQ0ywSGp8Egb++5yBoaHO4hvk30nZ1evGDOGVnxGjrN
         wBrdW1t6hwObrZ8tIxJhcko7vNR2iMGXuYlICktlIuLj9UNMe7I7UAT5xQQckKpKTA/+
         OrKA==
X-Gm-Message-State: AOAM530UonDv5jYq6NcqcOrYyZKfTnn+acVuglEpp2bnx/qP4dTddrfm
        w1jWLgnEB29TiH/yIAOjhWQ=
X-Google-Smtp-Source: ABdhPJxXT9g7tFj9CmFVZjmD3Nsxr4lUW/nh6qpAzQeTmKeGliC459ZAXPTHGwOPQyXRutymVllb0g==
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr5208189wme.40.1642622517865;
        Wed, 19 Jan 2022 12:01:57 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id i15sm1063966wry.100.2022.01.19.12.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:01:57 -0800 (PST)
Message-ID: <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
Date:   Wed, 19 Jan 2022 20:01:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
Reply-To: phillip.wood@dunelm.org.uk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
 <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
 <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com> <xmqqv8yovlc2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv8yovlc2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 12/01/2022 18:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm not sure I want to go with your extra changes. I've left some
>> comments on them below
>>
>>> @@ -488,12 +499,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>>>   	else if (starts_with(p, "@@ ") ||
>>>   		 (hunk == &file_diff->head &&
>>>   		  (skip_prefix(p, "deleted file", &deleted)))) {
>>> -		if (marker == '-' || marker == '+')
>>> -			/*
>>> -			 * Should not happen; previous hunk did not end
>>> -			 * in a context line? Handle it anyway.
>>> -			 */
>>> +			hunk->splittable_into++;
>>> +		/*
>>> +		 * Should not increment "splittable_into";
>>> +		 * previous hunk did not end in a context
>>> +		 * line? Handle it anyway.
>>> +		 */
>>> +		complete_file(marker, &hunk->splittable_into);
>>>    		ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>>>   			   file_diff->hunk_alloc);
>>
>> I deliberately left this alone as I think we should probably make this
>> BUG() out instead of silently accepting an invalid diff.
> 
> As we are reading our own output, I agree that such a data error is
> a BUG().
> 
> In any case, a helper to see if the file ended without post-context
> is one thing, and a helper that specify what happens after we are
> done with a single file, before we move on top the next file or
> after processing the last file, is another thing.  The latter may be
> able to make use of the former, but the latter may want to do more
> than that in the future.
> 
> As complete_file() is about finalizing the processing we have done
> to the current file, it should be used for that purpose, and nothing
> else, I think the hunk I see at
> https://github.com/git/git/commit/c082176f8c5a1fc1c8b2a93991ca28fd63aae73a
> (reproduced below) is simply a nonsense.
> 
> Stepping back a bit, though, is this helper really finalizing the
> current file, or is it finalizing the current hunk?  If it were the
> latter, then its use in the hunk I called "nonsense" above actually
> makes perfect sense.

Even if the helper is finalizing the current hunk then I think that 
"nonsense" hunk would still wrong as it would be calling finalize_hunk() 
on _every_ context line in the hunk rather than just being called once 
to finalize the hunk. We could call the function something like 
update_splittable() but then we'd need to explain why we were calling 
that function at the start of a diff and at the end of the loop.

> There may not be anything other than finalizing
> the last hunk when we see the end of a file right now, so we may not
> need to add a finalize_file() helper right now, and when we need to
> do something more than finalizing the last hunk, we may need to capture
> the distinction by adding one.

Yes, if you're happy lets leave this series as it is

Best Wishes

Phillip

> diff --git i/add-patch.c w/add-patch.c
> index 89ffda32b2..6094290c86 100644
> --- i/add-patch.c
> +++ w/add-patch.c
> @@ -578,8 +578,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   			    (int)(eol - (plain->buf + file_diff->head.start)),
>   			    plain->buf + file_diff->head.start);
>   
> -		if ((marker == '-' || marker == '+') && *p == ' ')
> -			hunk->splittable_into++;
> +		if (*p == ' ')
> +			complete_file(marker, &hunk->splittable_into);
>   		if (marker && *p != '\\')
>   			marker = *p;
>   
> 

