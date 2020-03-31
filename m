Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0DC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77103212CC
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkA+DRV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgCaRsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:48:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41525 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgCaRsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 13:48:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id f52so22934306otf.8
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D3HWxe+H0W+bRjBUSbOz4mOn3qkh1ayCiVXUWIiEJ9Y=;
        b=BkA+DRV8c0SLdCFqAWaPor+EBiiGB6Q585t/MXUvVeWgJesBIRpqn2uSYe7R61v4sO
         0O6emI2qO/BHkA3GajNEU6h27YahrAr0ODeNRDtnDHpJUaGJ1YQzqHivZ6o+h7NxllJD
         iYF/urPrP1acIKvUVNnhCBQ8Ma2rGnhHCYd21xG0Y976bpoqhHeG7XDZ8+Oso5iww8ee
         9EWcO53vlD9IJMre5zeqJkuod7eSYZwtARk9C+4quuU9Z/lT5vYHdeSVzzZdfCCwzf/Z
         ipzTnIm+FhKJXCwxjJUvj+sO+6DZb0qGC9XLNatzZZk+OA/ENnne6AEx5wWiWIy6bv7X
         7DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3HWxe+H0W+bRjBUSbOz4mOn3qkh1ayCiVXUWIiEJ9Y=;
        b=qSe025TKo1wbI0jFLkx2eMwYH4nO5ULqILy2ie6F6bo/iyVriXVZpNbReZbzpjPFd/
         rxqr14WzcjQKIE8AILRDSEJZ93ajgXuHe3LxQ5l6zkkQ/1/VEcwBJs1+PdB+jKB1ahTb
         39QFMMluQrC2LsxFK4oULsNNvuQvj1ODyutaYUyb2LyUyQtN6eDusv6Y5/ERmDEvQFaF
         Wpawck5tG3w+Gahp3o19mXlv+UlBHHEfkIvb2r/1mPwnbsUzygEPpe1b9gcinRQ643HL
         ObT24VZifCypKRQ5Z2uiGJdgvc8kn2LGhUBOLWC+uLQZLYqr8BrVtQ0im7+fjGVakCPS
         j6bA==
X-Gm-Message-State: ANhLgQ065qeR2CBAcSan49AM9r4J2d5tiBZ1d5rjLpWJ+0vn6SPrhHF1
        HjG8oulRoUysyYHlFqX3qUdFsrU7f/A=
X-Google-Smtp-Source: ADFU+vuZ5DHP7J384uMg4HWmaopdeQy45tSpvznr3KXnM+18du/XXAvsCICcPbRMGBFNAQV9aIS2ZA==
X-Received: by 2002:a9d:3405:: with SMTP id v5mr14539684otb.131.1585676893112;
        Tue, 31 Mar 2020 10:48:13 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b2sm5286420oii.20.2020.03.31.10.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 10:48:11 -0700 (PDT)
Subject: Re: [PATCH] diff: restrict when prefetching occurs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com>
 <20200331165058.53637-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d1995983-c5b2-8d44-3949-10286b3f7c0e@gmail.com>
Date:   Tue, 31 Mar 2020 13:48:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200331165058.53637-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2020 12:50 PM, Jonathan Tan wrote:
>> This conflicts with [3], so please keep that in mind.
>>
>> Maybe [3] should be adjusted to assume this patch, because that change
>> is mostly about disabling the batch download when no renames are required.
>> As Peff said [2] the full rename detection trigger is "overly broad".
>>
>> However, the changed-path Bloom filters are an excellent test for this
>> patch, as computing them in a partial clone will trigger downloading all
>> blobs without [3].
>>
>> [3] https://lore.kernel.org/git/55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com/T/#u
>>
>>> [1] https://lore.kernel.org/git/20200128213508.31661-1-jonathantanmy@google.com/
>>> [2] https://lore.kernel.org/git/20200130055136.GA2184413@coredump.intra.peff.net/
> 
> Thanks for the pointer. Yes, I think that [3] should be adjusted to
> assume this patch.
> 
>>> +		for (i = 0; i < rename_dst_nr; i++) {
>>> +			if (rename_dst[i].pair)
>>> +				continue; /* already found exact match */
>>> +			add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
>>
>> Could this be reversed instead to avoid the "continue"?
> 
> Hmm...I prefer the "return early" approach, but can change it if others
> prefer to avoid the "continue" here.

The "return early" approach is great and makes sense unless there is
only one line of code happening in the other case. Not sure if there
is any potential that the non-continue case grows in size or not.

Doesn't hurt that much to have the "return early" approach, as you
wrote it.

>> 	if (!rename_dst[i].pair)
>> 		add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
>>
>>> +		}
>>> +		for (i = 0; i < rename_src_nr; i++)
>>> +			add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
>>
>> Does this not have the equivalent "rename_src[i].pair" logic for exact
>> matches?
> 
> Thanks for the catch. There's no "pair" in rename_src[i], but the
> equivalent is "if (skip_unmodified &&
> diff_unmodified_pair(rename_src[i].p))", which you can see in the "for"
> loop later in the function. I've added this.
> 
>>> +		if (to_fetch.nr)
>>> +			promisor_remote_get_direct(options->repo,
>>> +						   to_fetch.oid, to_fetch.nr);
>>
>> Perhaps promisor_remote_get_direct() could have the check for
>> nr == 0 to exit early instead of putting that upon all the
>> callers?
> 
> The 2nd param is a pointer to an array, and I think it would be strange
> to pass a pointer to a 0-size region of memory anywhere, so I'll leave
> it as it is.

Well, I would assume that to_fetch.oid is either NULL or is alloc'd
larger than to_fetch.nr when there are no added objects.

This is now the fourth location where we if (to_fetch.nr) promisor_remote_get_direct()
so we have already violated the rule of three.

My preference would be to insert a patch before this that halts the
promisor_remote_get_direct() call on an nr of 0 and deletes the "if (nr)"
conditions from the three existing callers. Then this patch could use
the logic without ever adding the "if (nr)".

Thanks,
-Stolee
