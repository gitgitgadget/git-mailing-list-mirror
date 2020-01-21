Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D4C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA31217F4
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1wX8k0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUQOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:14:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39376 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAUQOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:14:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so3233782qko.6
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9wiT+M4fHNpncxoTimnn8wcE/8a4a0GFiNlVdV/c0Ow=;
        b=h1wX8k0cFO+sDphImvSt7BdDnQHxIy1iKQNcz8ysIaJk75tZaDTBSz2Sx0AZ6/QUOm
         keTO034RAddajFd3q3nqdoX90TwcGlRjivGr3l7uqBw12AmNzGVHYp2dpdvSIkbXFG2f
         HWzo/kTHJa5tiYWKcOKnubGeT9X1y56yagpyVaRQjGCwRIZN4Fc9kUX3fYz51iUrLMKn
         NtcVPxtnIOza6WnD2jWsQC+kHLdj1TYLR++6nMH+Jls56OROwP72jDV+0+Xbm/UiDdoQ
         1t+RysFGh5iDDE5MgR5uoIGv+f7EclmFuzffwFolhtKlHW9X+ajCII/8dlppQ6ZuEY0V
         yQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wiT+M4fHNpncxoTimnn8wcE/8a4a0GFiNlVdV/c0Ow=;
        b=MGdZ9IaM65x69lbpjTN6DTDwXg1ls8a43oC1Mr+NMaxv5i8U1yijzpQlV0lJko1cIQ
         dyTuqmkvGPBtIDHxCKlEkq3SgzYLchubK+BoSdTbxLoN/g9J7XYrsS/Wtxp7yCo89iaY
         vv7sGEfe0JISvwjb8k53opYyQlYUa4U2ADIU+2yQuXQmIeJIbnNyFb/gdGnPnDcvbVC8
         Q6IXYKIpDnH1nqqrhh/JHqlDPzv1csFefi9tt7w/izGb7Ar0PRMo5sFRANB/2LNMohLI
         buHVeVPgHwSK/BHS5Q1PM29Ff4B/5TggdMDy4VztvIVE9y6clN424mOsqZBuczsya9j0
         mVPg==
X-Gm-Message-State: APjAAAWR3c6h84nARlhNzyBzGhZLvYwLDvtOVeSt0Rh1N+DHhWiqcMA2
        NI4gx8L+bwNQfs9qhbdRp5Y=
X-Google-Smtp-Source: APXvYqyX4b2LKIHa071S9HtKf5aOjkcu6vPoyRenxx3CyG5FbEE63xC/BHs6/0LD7SJ4NPwVnveHrQ==
X-Received: by 2002:a37:514:: with SMTP id 20mr4917860qkf.321.1579623289403;
        Tue, 21 Jan 2020 08:14:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:5192:ef3a:c240:b399? ([2001:4898:a800:1012:2c7:ef3a:c240:b399])
        by smtp.gmail.com with ESMTPSA id k9sm19411486qtq.75.2020.01.21.08.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:14:48 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <86d0c44f5s.fsf@gmail.com> <3aaf02fe-ac83-5694-2c69-e133879a0030@gmail.com>
 <868sm2ck7w.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <f5625b23-d7c4-9a72-4ed6-69893de103b0@gmail.com>
Date:   Tue, 21 Jan 2020 11:14:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <868sm2ck7w.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/20/2020 8:48 AM, Jakub Narebski wrote: >>                                      How often a file has been touched
>> also makes a difference. The performance gains are less dramatic if the 
>> file has a very sparse history even if it is a deep file.
> 
> This looks a bit strange (or maybe I don't understand something).
> 
> Bloom filter can answer "no" and "maybe" to subset inclusion query.
> This means that if file was *not* changed, with great probability the
> answer from Bloom filter would be "no", and we would skip diff-ing
> trees (which may terminate early, though).
> 
> On the other hand if file was changed by the commit, and the answer from
> a Bloom filter is "maybe", then we have to perform diffing to make sure.
>

Yes. What I meant by statement however is that the performance gain i.e. 
difference in performance between using and not using bloom filters, is not 
always as dramatic if the history is sparse and the trees aren't touched 
as often. So it is largely dependent on the shape of the repo and the shape
of the commit graph. 
 
>>
>> The numbers from the git and linux repos for instance, are for files 
>> closer to the root, hence 2x to 5x. 
> 
> That is quite nice speedup, anyway (git repository cannot be even
> considered large; medium -- maybe).
> 

Yeah. Git and Linux served as nice initial test beds. If you have any 
suggestions for interesting repos it would be worth running performanc 
investigations on, do let me know! 

> 
> P.S. I wonder if it would be worth to create some synthetical repository
> to test performance gains of Bloom filters, perhaps in t/perf...
> 

I will look into this after I get v1 out on the mailing list. 
Thanks! 

Cheers
Garima Singh
