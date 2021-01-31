Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF053C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7046864DCC
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhAaDxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhAaDxl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:53:41 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4BC061574
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:53:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n15so12987564qkh.8
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q/gCHiL60RNqNk9gFy4N9KrcDwcRKaq4PnhH0Fgj3Ks=;
        b=FyOO1n5m5yt41r5/nbqc/MKYrkraf+o4f1dL14kx8WRsQrM4oGLijI0QItaSMZ9JPq
         Bhn8QaT9B8Qsm0yktyAuqNSqs2cbJchqpuWC5x02g4XYi8VkhpHFPWGGacOw/rbXXpRR
         bTm1DB6xcLrh88M/9YyGYw2yAQJKVJIJ3uAW6nc8FC9YemkMjm1kCKflU6kdUcbZy8iC
         u+zCbujmS+jg++ku3L0ZSAyGWXc03vdRJYFMyFnjFNnaOKaljr0wVNi6pIF311Txjdjf
         n1t6t4dE3tsbdV0eAqeo1xSYc/foOwncoUeMcBaNq2CDJm5QVv55hXJhQmkWgSo5pJWg
         E5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q/gCHiL60RNqNk9gFy4N9KrcDwcRKaq4PnhH0Fgj3Ks=;
        b=hFFgSZe+0zcyi+0wiNuzIzcG6KeXWokny4jUcpj4xNF3xl+jORxFpvKguZ9hz/dsXS
         m9N+DUsaI9cxBzsEWBmryGjO4Lp94PrUI2Imd02NJvhNzzouWA5Sivyxs/EkAJubLvBV
         Lxhg7J32/JFSXoYVHMyqw1E70MpdgInbo51xKDR5b98ljCS3iUqFSMIMRabASBtAZAqu
         FwEkgTwLWAdgkpqkO1N6K2wgPmUeV5AL9mbB3M0Ky++HTNaZ3OVIpSvcsNAVJ0Up+3pK
         Cn8ZiNtDXrpY2ZIj+ynNW2FVivDVfI2jUIislqv//TGnBhG52MDT5i0oLlX4ejiTzE0H
         JWpQ==
X-Gm-Message-State: AOAM532omkY3I/mXVk3S9SEVrmoJul5szeWv7n2zvjnoYzrXKcWpxKkI
        Ys0BYd74HKbbMWXRKoEr294=
X-Google-Smtp-Source: ABdhPJxuAllvzMuPPyVwLqCq/U4uPtz3edDDvKUsQxhWLSrogBGE4kIIfbhqF9xQzv03g32VtzAzsA==
X-Received: by 2002:a37:9ad0:: with SMTP id c199mr10954081qke.112.1612065180428;
        Sat, 30 Jan 2021 19:53:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:383e:f17:3be5:db8d? ([2600:1700:e72:80a0:383e:f17:3be5:db8d])
        by smtp.gmail.com with UTF8SMTPSA id m10sm6138644qtp.72.2021.01.30.19.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 19:52:59 -0800 (PST)
Message-ID: <75225d59-877e-92ad-1370-632d40af71cf@gmail.com>
Date:   Sat, 30 Jan 2021 22:52:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
 <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
 <198f7766-190d-d361-d6f4-23adefedaf6c@web.de>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <198f7766-190d-d361-d6f4-23adefedaf6c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2021 12:11 PM, René Scharfe wrote:
> Am 28.01.21 um 21:51 schrieb Junio C Hamano:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +	/* rearrange array */
>>> +	dup = xcalloc(cnt, sizeof(struct commit *));
>>> +	COPY_ARRAY(dup, array, cnt);
>>> +	for (i = 0; i < cnt; i++) {
>>> +		if (dup[i]->object.flags & STALE) {
>>> +			int insert = cnt - 1 - (i - count_non_stale);
>>> +			array[insert] = dup[i];
>>> +		} else {
>>> +			array[count_non_stale] = dup[i];
>>> +			count_non_stale++;
>>> +		}
>>> +	}
>>> +	free(dup);
>>
>> The "fill stale ones from the end, non-stale ones from the
>> beginning" in the loop looks unnecessarily complex to me.  I wonder
>> if we can do only the "fill non-stale ones from the beginning" half,
>> i.e.
>>
>> 	for (i = count_non_stale = 0; i < cnt; i++) {
>> 		if (dup[i] is not stale)
>> 			array[count_non_stale++] = dup[i];
>> 	}
>>
>> without the "keep the stale one at the end of array[]", and clear
>> marks using what is in dup[] as starting points before discarding
>> dup[]?
>>
>> Or do the callers still look at the entries beyond count_non_stale?
> 
> Had the same reaction.  Both callers ignore the stale entries.

Ok, I can update that logic accordingly. I wanted to keep consistent
with the comment at the start of the method:

	/*
	 * Some commit in the array may be an ancestor of
	 * another commit.  Move such commit to the end of
	 * the array, and return the number of commits that
	 * are independent from each other.
	 */

but if no caller actually needs that, then I can remove this
behavior. Anyone mind if it is a follow-up patch to change this
part of the behavior?

>> Other than that, nicely done.
>>
>>> +	/* clear marks */
>>> +	for (i = 0; i < cnt; i++) {
>>> +		struct commit_list *parents;
>>> +		parents = array[i]->parents;
>>> +
>>> +		while (parents) {
>>> +			clear_commit_marks(parents->item, STALE);
>>> +			parents = parents->next;
>>>  		}
> 
> This loop clears STALE from the parents of both the non-stale and
> stale entries.  OK.  Should it also clear it from the stale entries
> themselves?

clear_commit_marks() walks commits starting from the input commit
(parents->item in this case) and clears the STALE bit as long as
it is present. This way, the accumulated clear_commit_marks() will
walk each commit only once _and_ will visit any of the commits from
'array' that received the STALE bit during the above walk.

Thanks,
-Stolee
