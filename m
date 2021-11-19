Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B0C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA761131
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhKSUgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhKSUgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:36:46 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ABCC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:33:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso18604167ote.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aDOYw9n/egqqIJfD5D8Cwx6QCBgZ19zSUFSX+9WPe/E=;
        b=M2tuTkp+0i1O854p231Ofhm++M6+uiqWUYWRLklr0xI9s9Os6akDWgQudiH10TTkmj
         JgT/3jtXMQ6EqFu6roLCXJrNL0oJn5G4YjZIw4K5UbHoNtHr0fvPQ1bdZoZr0XR4cAwy
         mcpyUztRsmnh7jboHbWWWlWOPkj+o3KwQ/XnBV+xQiI0KNF73GkCMxwDiUPZQI2iyErS
         4wvJdt78p9H84W9nFuxW+t/X+XmkDkiic0LnHDlcnvrBp5nWyZhAKhzK4E5PsyUzvQxJ
         QoE1M/3nOOI+MTmJmTzHJEkzZR5Ih8cUemarV2nJg7g5ksRkh8YnIdf9ez3BNoP8GNTq
         Zerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aDOYw9n/egqqIJfD5D8Cwx6QCBgZ19zSUFSX+9WPe/E=;
        b=6SnCPt0njfDRfaxQm2Xf9BdiY61XgVqxvdRxpuQWxkc58YzxIoneACZya83GIBYk6v
         lW7NWeZ+kTFYRdN7TuM7TKpUrXXqfwdGcOUf7861R3B24CLtHXtaLvbxrG3zPkN7LSVp
         GxwErncSIJNuIJZHMYhSyVCIIfy6hJB4tdguE8XZtQQI3WjdTEV0vgPPe8yy+/pglPlA
         koPxPxA3LoaqzeZpPIeDTnYZoeVOipMYewuuBPumiHKcXbfqbEoG06L2pSV0g10l9hYk
         7MJ0kNgToW88+qSijusrbNEEwYWc8NNq4tdzJOYVzYilTMVnQfMzYZGSVoionKD4cB1r
         MEvA==
X-Gm-Message-State: AOAM532l25pQLdrHMTB5Ueebh+xUnd6yb342eXyuplfAnKmHVXndzST6
        D2Ae1z59FmRHr29xshlH9eY=
X-Google-Smtp-Source: ABdhPJzXgizbp+cv0k4yHaDtY6sAzCJAOhm0GsTqtIkp/E8/9ZySZRFFsX2yqNh842zutBAC02JAUA==
X-Received: by 2002:a9d:2077:: with SMTP id n110mr6975512ota.261.1637354023119;
        Fri, 19 Nov 2021 12:33:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3441:8b39:39a2:9208? ([2600:1700:e72:80a0:3441:8b39:39a2:9208])
        by smtp.gmail.com with ESMTPSA id c9sm183248oog.43.2021.11.19.12.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 12:33:42 -0800 (PST)
Message-ID: <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
Date:   Fri, 19 Nov 2021 15:33:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
 <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
 <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
 <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2021 3:05 PM, Johannes Sixt wrote:
> Am 19.11.21 um 15:51 schrieb Derrick Stolee:
>> What is unclear to me is what exactly "match a directory" means.
>> If we ignore a directory, then we ignore everything inside it (until
>> another pattern says we should care about it), but the converse
>> should also hold: if we have a pattern like "!data/**/", then that
>> should mean "include everything inside data/<A>/ where <A> is any
>> directory name".
>>
>> My inability to form a mental model where the existing behavior
>> matches the documented specification is an indicator that this was
>> changed erroneously. A revert patch is included at the end of this
>> message.
>>
>> If anyone could help clarify my understanding here, then maybe
>> there is room for improving the documentation.
> 
> You form a wrong mental model when you start with the grand picture of a
> working tree. That is, when you say
> 
> - here I have theeeeeese many files and directories,
> - and I want to ignore some: foo/**/,
> - but I don't want to ignore others: !bar/**/.
> 
> This forms the wrong mental model because that is not how Git sees the
> working tree: it never has a grand picture of all of its contents.
> 
> Git only ever sees the contents of one directory. When Git determines
> that a sub-directory is ignored, then that one's contents are never
> inspected, and there is no opportunity to un-ignore some of the
> sub-directory's contents.

So the problem is this: I want to know "I have a file named <X>, and
a certain pattern set, does <X> match the patterns or not?" but in
fact it's not just "check <X> against the patterns in order" but
actually "check every parent directory of <X> in order to see if
any directory is unmatched, which would preclude any later matches
to other parents of <X>"

So really, to check a path, we really want to first iterate on the
parent directories. If we get a match on a positive pattern on level
i, then we check level (i+1) for a match on a negative pattern. If
we find that negative pattern match, then continue. If we do not see
a negative match, then we terminate by matching the entire path <X>.

I'm still not seeing a clear way of describing the matching procedure
here for a single path, and that's fine. Me understanding is not a
necessary condition for fixing this bug.

Thanks,
-Stolee
