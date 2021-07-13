Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391BC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D007611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhGMIVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:21:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AFC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:18:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1612457pjo.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OJFtno5/DKrjyP0P1DvAG5B4OL0MIc6XaNYWi9EDX2o=;
        b=XnqdqEQRWZ5zVC5MsLZGkEAFUPU3l3lZGdwHug+vnAuXx/3pntMW8AxDKzkUej5fuf
         4YVtrLhby/+GdFSIM96o720srrRERbHrCPWeHPJX8mbB6sE6aF3iW3dIMt0X1ldFPFge
         XiXyma4xRvNVhXQVTpFydFtklJi6K0+XZTuPYgdEljs3ib9bZkU+RvTcprxSZoHvPbzA
         6g8uBYjoLNQUx0dw6ToflB6F5iyzS6e+igN23huHXNkStKfrCsmSfc5GS6q34r3eIuYf
         YMWVzu3m+PmSBB5IhkF6bwEFx+S7ZhY7oI2Ihh+eBmCE9QEG9AmQPi+8ajQGYdXtTsBs
         wEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OJFtno5/DKrjyP0P1DvAG5B4OL0MIc6XaNYWi9EDX2o=;
        b=hUMeEBfsuQUkXZO55KSvToDJBxI2zJ93Y26gDgBItRzRQwO3HCoUk25IpsGAw5TwLA
         zxNxyeUM2EAXxe2In45KnT7xpehfWGvFvqvRJlTtq6h1BgWd798Rdt5au3N4jDZIW35W
         IBLuvM/m27Twn1dr8uCi0JIc/3ujTPC8nvwjK+5dhyPHv4Vch/5KR9ptEcTFWVy9OppK
         cGn7jGXdf9O+Q2rCyABCaVdtOzqxJNOOLLQcpjJv1KoL9jx51tEe0h9PVxVICnRsA0jq
         0l0r5zvZ03o3gojRhqErEixNtyPAUZ4CoCpqsx375eNBeXWEpjwKgtE/r5ce3e+G7e5d
         Znbw==
X-Gm-Message-State: AOAM531nXQGTi8EV/JOvX9qTmkn0/I58C+SbzgpnOVoVqkpNE6LRmtv9
        cDyAUGgjilml/uigD2venG4=
X-Google-Smtp-Source: ABdhPJwq28XPViAPKh8KVfhPH/mcgwW6fZcnt9Iom5POLnZx9wSOWLju5lQO+MVqb+9JLWbOoXr1Mw==
X-Received: by 2002:a17:90a:6be1:: with SMTP id w88mr3223343pjj.121.1626164293341;
        Tue, 13 Jul 2021 01:18:13 -0700 (PDT)
Received: from [192.168.127.232] ([106.195.46.193])
        by smtp.gmail.com with ESMTPSA id h8sm166365pfi.47.2021.07.13.01.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 01:18:13 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bGSoC=5d_My_Git_Dev_Blog_=e2=80=93_Week_8?=
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
References: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com>
Date:   Tue, 13 Jul 2021 13:48:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 11/07/21 4:48 pm, Atharva Raykar wrote:
> Here's my weekly update:
> https://atharvaraykar.me/gitnotes/week8
> 
> I am currently blocked by trying to pass a super-prefix parameter
> to another command, when calling it from within C.
>

 From the blog:

> When queried by the get_super_prefix() function, the answer is (null).
> This boggles my mind to no end (see update). The implementation is basically
> the same getenv() call?

Good to see that you were able to identify the reason yourself.

> I am not sure how to tell Git that the environment variable has in fact
> been modified, and that it needs to be reinitialized. Maybe I am going
> about this whole thing wrong?

I get the same feeling too. I took a brief look at how the issue could be
fixed and it seems to me that you exploring to set super-prefix might not
lead us to the solution. Alternatively, you could explore how other sub-commands
handle recursing into submodules. To me it looks like they handle it by spawning
a sub-process is likely the easiest approach for achieving recursion. That would
solve the super-prefix problem as you have observed.

Unfortunately, there's not yet proper support for handling recursion of submodules
which calls for working with the data of multiple Git repositories in the same
Git process. There was an effort[1] few years ago to make working with
other Git repositories simpler without having to spawn a sub-process. The state
of the effort is unclear to me. As far as I know, it has been stalled. I hope
others could provide more details about it.

So, you could try the approach of spawning of sub-process for now. In case there's
a better approach than spawning sub-process others might be able to point during
review. In the meanwhile, I'll try to take a better look later and see if I could
find anything.

[1]: https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/

-- 
Sivaraam
