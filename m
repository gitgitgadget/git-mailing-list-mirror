Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A2C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440E621D79
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjkJNmb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgIIJoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIIJoD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:44:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C754C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 02:44:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so2219388wrr.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DUK7dzl/673KMyPKdvBHBwjRO4qvt1712UsIjg34Sk=;
        b=gjkJNmb3gYO3wfzrmJRMjCodVFN/SIQBRRnO0uEYOEIpqiSObsDKliJTv78nJczXfK
         eoBClt2laZ5MfnOwT5zniBZ2K8ttzbPg1k4UYfVmwyVaRT6/8GC1a/VfDL4/9MUXc6La
         E83+s1GnrZJd0/T5D3pw+HjrNMlNnC0IVq7cnCs4VXWhek7HP0k5BujD3AzF8zYp4uf9
         pi+A5qovMReF0oFXlfMXp7QxoWKh2MmlOcaSfWfbv1vxGDw5P0Kj+Mauh0GFZRF4Qzd9
         EErZU7PqIfZSgTqvznKJ3+araqwVvqpuJQkHZm5g+KodLHptls4opGzXuBFVM3pSgUi3
         534w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DUK7dzl/673KMyPKdvBHBwjRO4qvt1712UsIjg34Sk=;
        b=ZQosJKpCjMNB/nl+z/2hwQbt+eiTBQVQU3n3Wlxliz6ViP9EGZmh2soGRLGTHcgAKx
         4+vaJLj1lHD6dUSjjRaMHHzkxmQ9/8Umtsa0UQQiHh7G7KbKDDSIh/syMCV52Ue+Tgnk
         7MNiJ3VIZQOV22Rg2NXth3pckoaTRugZbvdg7k4IVrYWrLcs4EgHecV8HcQ1r6ykb3yd
         9hI+ycLHr/YS5qjGHy4+kEe9S8g1a438dEWKi/M10cIWsh2g+rQ5O0QJDQs0fHSrLZpd
         Hg0SrsSMtgEJroUS8uYutk9Laehjk2VOHANha9ZrtnLaK7RHdgjvDh+KxhvXmdboAyXM
         5/ig==
X-Gm-Message-State: AOAM532QL6wAUB2MKD8VD9rJgHRF7xf5T6ipzHVsa4zZZ3yjfkaod6Q8
        6AFl6++aTyW1qHgHQjY8yrcOfEScDDI=
X-Google-Smtp-Source: ABdhPJzlO7ko2LJ4xD+CJUAgTG/Dc7qHgqD6tw8b2fS1CgzaKGkrrkUfIZ0p6Pj+D7rQAE0hu53A2w==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr2299356wrn.81.1599644641208;
        Wed, 09 Sep 2020 02:44:01 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id d3sm3273724wrr.84.2020.09.09.02.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:44:00 -0700 (PDT)
Subject: Re: post-checkout hook aborts rebase
To:     Tom Rutherford <tmrutherford@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com>
 <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
Date:   Wed, 9 Sep 2020 10:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom

On 27/08/2020 01:44, Tom Rutherford wrote:
> Thank you for the response Junio.
> 
> For what it's worth, my hook does not make changes to the repo. It's
> running a command to check that the installed version of our
> dependencies match the version specified in the commit being checked
> out, and merely warns if the two don't match (then exits with a
> nonzero return code).
> 
> For this reason it's been convenient that the hook runs during
> rebases, but I find it surprising that the nonzero return code would
> impact the rebase.

If the checkout succeeds that rebase does not print any of checkout's
output so unfortunately you wouldn't see the message from your hook.

I tend to agree with Junio that we shouldn't be running the 
post-checkout hook when rebasing.

Best Wishes

Phillip

> 
> Tom
> 
> On Wed, Aug 26, 2020 at 5:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> ...  If "git rebase" or whatever
>>> command wanted to place files and the index into some state by using
>>> "git checkout" command, and if the post-checkout hook mucked with
>>> the state in such a way that contradicts with what the "git rebase"
>>> command wanted them to be in, it is not surprising the hook's behavior
>>> broke "git rebase"'s operation.
>>
>> Having said all that, I actually think that "rebase" shouldn't be
>> invoking "git checkout" (and its equivalent) internally when
>> switching to a specific version, in such a way that it would trigger
>> any end-user specified hooks and allow them to muck with the working
>> tree and the index state.
>>
>> I haven't checked the actual implementation of "git rebase" for
>> quite some time to be sure, but we have lower-level plumbing
>> commands that are not affected by the end-user hooks for exactly
>> that kind of "build higher-level commands by synthesis of
>> lower-level machinery", and it is very possible that what we are
>> looking at is actually a bug that needs to be fixed.  I dunno.
>>
>> Thanks.

