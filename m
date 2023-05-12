Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03BC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 14:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbjELOsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbjELOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 10:48:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B130E5
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:48:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6186119b766so14470596d6.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683902882; x=1686494882;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtcx/BjHPJxwD/69NiHrGfmQBt1/2o0aiv/EMwv1G7g=;
        b=I1/6aCOm9MoxiIe61OG8fR5TTKH5DUsVUwLJt6pJIFw4qqXPo9PnUWnZADtEz/m5hG
         yy3aj3JfT4kwR+Jl9GM+2zSO8MTSJdMZaRUirW1hohCMMGW5tROK+gYbqzX1fEJLEfVG
         DnCigccEjjYtXZrnf0QiKsRtjnIvOZNTKlr5L+xhwQISs1yhc012tAmrpkrJkxAXgd6t
         5UQ6p11HzWsVEr0nLTvappExmCODTbNPGAlL9HubERQclvv03XXTqB6fOlNDFI5OTXs2
         OTrT6bTNYnmwBkGdB/9n7g25FOCF7y/1dSQV+n9zwxTW/54fTFb82sIuMe4azt7AkiGs
         8fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902882; x=1686494882;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtcx/BjHPJxwD/69NiHrGfmQBt1/2o0aiv/EMwv1G7g=;
        b=jClsd7ucQQ/nM0FnrFJnWdVANiPaR+on0Se9ZIKL7D17rP26IuR/rbQatnBudX3uzO
         vS8Hyj4zF/GzGzN0/SPESQi3oW1H9ZVB4vwi98Ht7C2uY0lKCrkP08HlyMzzOl2saViw
         pUJR1LHaqRtVyiDkWHaKqyGXS5dKOdsDpVN5bq1Ui1/2L2DJQ5d1kjk5BBfDXjfMvbIj
         B4z78NChV3Qj99v/d/IA0zq7p2x1cp6D0yyE6OEsDLEpedpqLXOfNsU1jqNX5YMldmDl
         qfg4CgKwYdh1ZqvY0oBcLbs7w/pLAK2Uz+3ymd+5LpeCwP2r6KCf8duPJDZtgWMmgKx2
         x06g==
X-Gm-Message-State: AC+VfDwZ780Q2SWVe8H0Z1W3H73gwqSxpq1xGNjE3FM2fu+9QwTyqwt7
        Xiz58iyaVoPHo0rk8AUppzW4o6l/7oc=
X-Google-Smtp-Source: ACHHUZ4TcDjUbwW9aVia9Lrn/kMfVzoFwR69s3lFP+7NvyVMq38X872SNxSyaTgHWnhkpJ0RE62FNg==
X-Received: by 2002:a05:6214:3001:b0:61b:c013:ef4e with SMTP id ke1-20020a056214300100b0061bc013ef4emr35324466qvb.2.1683902882174;
        Fri, 12 May 2023 07:48:02 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:4533:8b00:18f3:8a21:eac1:94c8])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cb2cb000000b0062154861574sm1795941qvf.111.2023.05.12.07.48.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2023 07:48:01 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 4/4] pack-refs: teach pack-refs --include option
Date:   Fri, 12 May 2023 10:48:00 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <80E985AF-40B2-46F4-8873-4FA4A18B881F@gmail.com>
In-Reply-To: <xmqq8rduvdj0.fsf@gitster.g>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
 <xmqq8rduvdj0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 11 May 2023, at 16:06, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -1198,7 +1191,13 @@ static int should_pack_ref(const char *refname,
>>  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
>>  		return 0;
>>
>> -	return 1;
>> +	if (opts->visibility && ref_excluded(opts->visibility, refname))
>> +		return 0;
>> +
>> +	if (opts->visibility && ref_included(opts->visibility, refname))
>> +		return 1;
>> +
>> +	return 0;
>>  }
>
> When the user did not say --exclude or --include, can we not have
> opts->visibility?  IOW, can opts->visiblity be NULL?
>
> Even if it can be NULL, shouldn't we be defaulting to "pack", as we
> rejected refs to be excluded already?
>
>> @@ -33,5 +38,14 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>>  	for_each_string_list_item(item, &option_excluded_refs)
>>  		add_ref_exclusion(pack_refs_opts.visibility, item->string);
>>
>> +	for_each_string_list_item(item, &option_included_refs)
>> +		add_ref_inclusion(pack_refs_opts.visibility, item->string);
>> +
>> +	if (pack_refs_opts.flags & PACK_REFS_ALL)
>> +		add_ref_inclusion(pack_refs_opts.visibility, "*");
>> +
>> +	if (!pack_refs_opts.visibility->included_refs.nr)
>> +		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
>
> Given the above code, I think visibility is always non-NULL, and the
> inclusion list has at least one element.  So the above "what should
> be the default?" question is theoretical.  But it would be nicer if
> we do not check opts->visibility there.  By writing
>
> 	if (opts->visibility && ref_included(opts->visibility, refname))
> 		return 1;
>
> you are saying "if visibility is defined and it is included, say
> YES", and logically it follows that, if we did not return true from
> here, we do not know if the end-user supplied inclusion list did not
> match (i.e. ref_included() said no), or we skipped the check because
> the end-user did not supply the visibility rule.  It is easy to
> mistake that the next statement after this, i.e. "return 0;", is the
> default action when the end-user did not give any rule.
>
> But that is not what is going on.  Because visibility is always
> given,
>
> The last part would become
>
> 	if (ref_included(opts->visibility, refname))
> 		return 1;
> 	return 0;
>
> and the "return 0" is no longer confusing.  If inclusion check says
> yes, the result is "to include", otherwise the result is "not to
> include".  Even shorter, we could say
>
> 	return !ref_excluded(opts->visibility, refname) &&
> 		ref_included(opts->visibility, refname) &&
>
> which we can trivially read the design decision: exclude list has
> priority, and include list is consulted only after exclude list does
> not ban it.

Yes, this is the logic. I agree that getting rid of the opts->visibility check
would make it more clear.

thanks
John

>
> Thanks.
