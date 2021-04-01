Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A853DC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0FD610F9
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 22:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDAWZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 18:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAWZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 18:25:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E6C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 15:25:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w70so3333012oie.0
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MAntvnxUPFbDBoIXaGn6xH+y/s2nIDu5GzaPvFx51I=;
        b=G06ljMm+qjxkz85GOhbGuAbr6GHAlfSG2lnapJlFCVe54j8Q8lMF6FCqG0QSIcz60+
         paspZ9FF4Vage7EL2mKxxTjBAJUwYn5AdvIUiFyHG5jWGxiS5qFYxgAondHwipvODyiw
         Txz/ImEm2prOuNfgdIoF6heVZi/HUI15sz0enMpzbPcDxOMmOXuroVHdNaxyrQ44OPRy
         dRvp7Tye80swZ113vZfw4LG0/yeCHdkPjy3LQ7eywtUyAoRwKuEZuj9B68nv7HKqwJJe
         DC/p6lE81qHgUtpxNQx283FNhNCx49u5cQpX8QDp57e+HF+qsB8O3pi/Me1kfEfRyf7O
         jacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MAntvnxUPFbDBoIXaGn6xH+y/s2nIDu5GzaPvFx51I=;
        b=H7EcbMc1lhq4RsqvifZmeTJfN/kV8oQODP1HafbFeAxuaDRDu886/+kOEUZpdlJtmB
         XggX9ixWhr97UDIaWVoudE80FBOicKNfFEl3KKVXLmKwxH+tg2jF82QRfzNEKN4lJt8Q
         4QZzLUZNExRadp/k7pQ1TRXU7X5Lz0yoTPQUiIbWM+129E7QoEJACTKeal/R8Hwtqyqy
         AP9lWix6f/qo6r/y9HZ+kaOHJk2Z0I7T2Rv8V83TlAu+hmxMQl7GkaTL3pexnwRQE0go
         DnJIxvB4t5eifoBUBTtwlHi9bwecQvTX+QMwyD83E71+iEfIGgvXCZhC1dQbLA7kf87i
         Q7VQ==
X-Gm-Message-State: AOAM531zrldYlGH6QxEXq5Pi250frb/ls2pr0Swto7ErZiGdfHPjSsTC
        wlORQVv5QOiaXnzJQBEZ9eSBKPEeBrf0Lw==
X-Google-Smtp-Source: ABdhPJzDlQkQhS74UG/aOo0i5QlzyXiDFKJgEKcRXCVxs8n4Dk/gGjZMDVFH1slb0ayhEYmYOg9KOw==
X-Received: by 2002:aca:4c0c:: with SMTP id z12mr7751842oia.109.1617315939269;
        Thu, 01 Apr 2021 15:25:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b1eb:378f:df28:cf2e? ([2600:1700:e72:80a0:b1eb:378f:df28:cf2e])
        by smtp.gmail.com with ESMTPSA id h20sm1303380oor.8.2021.04.01.15.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 15:25:38 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
Date:   Thu, 1 Apr 2021 18:25:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s613gqa.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 4:14 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 4/1/2021 2:49 PM, Tom Saeger wrote:
>>> I've recently setup git maintenance and noticed prefetch task
>>> fetches ALL remote refs (well not tags) and does not honor
>>> remote fetch config settings.
>>
>> This is intentional. The point is to get the latest objects
>> without modifying any local copies of refs. You still need
>> to run "git fetch" manually to update the refs, but that
>> should be faster because you have most of the objects already
>> in your copy of the repository.
> 
> You answered only half of the question, I think.

You are right. Thanks, both, for pointing that out.
 
> The plain vanilla refspec after you clone would be
> 
>     [remote "origin"]
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 
> and "maintenance prefetch" intentionally redirect the destination
> part away from refs/remotes/origin/ to avoid disrupting the
> reference to @{upstream} etc. that are used locally.  And
> intentionally doing so is good.
> 
> But imagine you are tracking my 'todo' branch which has nothing
> common with the history of Git.  You'd have
> 
>     [remote "origin"]
> 	url = git://git.kernel.org/pub/scm/git/git.git
> 	fetch = +refs/heads/todo:refs/remotes/origin/todo
> 
> If "maintenance prefetch" does "+refs/heads/*:refs/prefetch/origin/*",
> you'd end up the history of Git, which is not interesting for you who
> are only interested in the 'todo' branch (to be checked out in the
> Meta subdirectory to use Meta/cook script or read Meta/whats-cooking.txt
> file).
> 
> So, redirecting the right-hand of configured refspec is a good idea;
> not copying the left-hand of configured refspec, and unconditionally
> using "refs/heads/*" is not.
 
This makes sense as a way to augment the feature. It doesn't seem
like a common scenario, but it would be good for users to have
that flexibility.

Upon initial inspection, it shouldn't be too much work. However,
there is some generality to the refspec that might not be wholly
appropriate for prefetch (such as the exact_sha1 option). I'm
unfamiliar with the advanced forms of the refspec, so it'll take
some time to have confidence in this approach.

Thanks,
-Stolee
