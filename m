Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC0C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 02:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A082054F
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 02:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8L3dVLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfLLCvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:51:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37053 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfLLCvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 21:51:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so982333otn.4
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 18:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhFaSNsrG5P+TSJLj0DE/LZAdgMWQbJPBCYDnABbEUA=;
        b=a8L3dVLLFufX+1E7phQBsadtn/Wno0cXilKfQ/G1oUWKeeBGaioY0pB7xJM1YU+HLe
         5PiLpvgbFnT7rmCRr5l7B+WcHd8cMZGionBFnIrewVdzgdHhb6K6cICv0rU638AMXJ9u
         S6Za0I1wvlaIRgDwW9Tp8TfWJc9VCuJU5XeT2WuMufwDO7pVn0XvyUnBevgNwJVNbCTu
         4Arqa2bpMkcNK1Y+Uy7vvfmLN7y9nGwTf0aKtaGzj606E8Dh2/VDSNDwl7TtCRNtizxt
         NXfgg8XIYZUIbp6M7LY8HVfX3kRD2wqgAbyf+/Ayt/VnfeFxvukbfAEGxjsf8e4aXcvx
         lB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhFaSNsrG5P+TSJLj0DE/LZAdgMWQbJPBCYDnABbEUA=;
        b=KeBDxk/6zNeKmcV3hnVgjHI4NmuruHrtJLYlT5oKESHxQwdAxAax6vNw2WZ7rwT3qS
         62RMDyJxV+2znrC4FGhyn2nSt0z0oLetOFNpcGx+06VvxfOhHHwQo55JAcT8pcQlJBsh
         k3ndhW/Ux83bMMOc1FM8wU+KOmVmsSxbXAtNrpPLq/+syCay6FTzvK3qUtwemFdyzu7n
         6X3o47d+4xISXFjsyu9Pb5hNh7nA4jlUFx3Vs5pqx50pqFv4XSWfzpUS4SRd/caFbVSK
         JUYGoit+EtNJ0bwSwFCr+iezHKGuEBirnh1b8OlZHTsn+LUCSaoWCl5oDEuFjatzuCld
         EQsA==
X-Gm-Message-State: APjAAAU40ta1Lmu/+ccUqK5WzP2WgEjhYHqvZQ6z3jewUcfJSEt6j96F
        iSMWwq8m6sww+linf7kaws4=
X-Google-Smtp-Source: APXvYqxEV9GVGIUVOzrrgmLxOAKl1IEqKKLlC4ueVcX+677z3orskksmOBhleip9sdfeJgpZoZ2wrA==
X-Received: by 2002:a05:6830:2361:: with SMTP id r1mr5218644oth.88.1576119072283;
        Wed, 11 Dec 2019 18:51:12 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p21sm1681485otc.21.2019.12.11.18.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:51:11 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
 <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
 <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
 <9dbf6d43-ac1e-4790-84e5-4829d21f5fdb@gmail.com>
 <xmqqeexaocos.fsf@gitster-ct.c.googlers.com>
 <3e64b470-93cc-5491-09e1-e499f0a7583d@gmail.com>
 <xmqqa77yo86g.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <85f4574b-80fa-6638-3f32-a2e8177ff960@gmail.com>
Date:   Wed, 11 Dec 2019 21:51:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqa77yo86g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 4:37 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The specific example I have in my mind is that the filesystem can have
>> "README.TXT" as what it would report by readdir(), but a user can type
>>
>> 	git add readme.txt
>>
>> Without core.ignoreCase, the index will store the path as "readme.txt",
>> possibly adding a new entry in the index next to "README.TXT". If
>> core.ignoreCase is enabled, then the case reported by readdir() is used.
>> (This works both for a tracked and untracked path.)
> 
> Yes, but which one is "correct"?  readme.txt read from the index or
> README.TXT read from the filesystem?  Presumably, when the paths got
> first checked out of the index, it would have been in "readme.txt"
> on the filesystem, so the user must have done on purpose something
> to cause the file to be named in all uppercase since then.

Ah. The issue here is that with core.ignoreCase=true, the index and
filesystem agree. It's just the user input that differs.

>> This is a case that is difficult to control for. We have no source
>> of truth (filesystem or index) at the time of the 'git sparse-checkout
>> set' command. I cannot think of a solution to this specific issue
>> without doing the more-costly approach on every unpack_trees() call.
>>
>> I believe this case may be narrow enough to "document and don't-fix",
>> but please speak up if anyone thinks this _must_ be fixed.
> 
> I do not think it "must be" fixed in the sense that "if it hurts,
> don't do so" is a sufficient remedy.  But then for exactly the same
> reason, I do not think it is worth doing what you do in this patch.
> 
> On the other hand, I think runtime case folding, just like what we
> do when "git add" is told to handle a path in different case, would
> be the only "right" way to match end-user expectations on a case
> insensitive system, even though that is a "nice to do so" and
> certainly not a "must do so" thing.
> 
>> The "git add" behavior made me think there was sufficient precedent
>> in Git to try this change.
> 
> Since I view that the "git add" behaviour is a "nice to do so"
> runtime conversion, I would actually think the approach you
> discarded would be more in line with the precedent.
> 
>> I'm happy to follow the community's opinion in this matter, including
>> a hard "we will not correct for case in this feature" or "if you want
>> this then you'll pay for it in performance." In the latter case I'd
>> prefer a new config option to toggle the sparse-checkout case
>> insensitivity. That way users could have core.ignoreCase behavior without
>> the perf hit if they use clean input to the sparse-checkout feature.
> 
> I value correctness more---a system that does incorrect thing
> quickly is not all that interesting.
> 
> Assuming that your users are sensible and feed good data, how much
> "performance hit" are we talking about?

I'll need to build a prototype to test the performance hit. Maybe
I'm overestimating the effect of using a case-insensitive hash.

> Wouldn't this be something
> we can make into a "if you have the paths in the correct case, we'll
> see the match just as quickly as in the case sensitive system, so
> most of the time there is no penalty, but for correctness we would
> also fall back to try different cases"?

I think we would want the config option present to say "my data may
not be in the proper case, please do extra work for me". I can't
think of a way to do the fallback in real-time.

I'll try again with the case-insensitive hash algorithm and see
how that shakes out.

Thanks,
-Stolee


