Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B022C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC32242F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBLxPc7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgKCVRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbgKCVJt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:09:49 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E254C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 13:09:49 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id z6so16629775qkz.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2xF2Yw0em0ya6qT3qDSy6hb5jQTwVQmts513rilZptI=;
        b=nBLxPc7PWqupGRfCrMQmmc7gO+yjirzVw+potk8HT65OI+fWh7sMps7sJRx84+N5MP
         J0n5j3EgfFPp2Oaul4VJNaNfLXehr1JZpoZ3EgDOyM7WWwj38JhZNMfqMx203pWZQxVO
         ALVeU4Yeajy4wrkUgOh6c1SIBneotUCihXiTW+Oz7cWeksg1l7ryY7X7jtXzrBlOwFPm
         g+BoTDDU4Z3nbLZNou/nUbqSFJzkZKQ9Vd74UPaIY32YjjcjLMLYKmgbcBTKIJzx1O9m
         4EmZUwP6AwkqMLJ8H2dt9PbCtyv4W/OozH265KAYUe9Z0RA4xz3spgwqx5YoZFqBv1Tx
         eFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2xF2Yw0em0ya6qT3qDSy6hb5jQTwVQmts513rilZptI=;
        b=du31fn/3HdPkErS64M29DmQMWXmRab8AFU1JB96+4vBoarEdXo8w9ICZncgQQSBUJU
         n9mP6JJ2uDm8x/K4uAN2dKkaf9g5oeShNP7qwtQv5Kg7VnQp4iqlHYIQg4rVpxU/VpVp
         DYU4wqwNcVyKhjNVEezSifuyQ6mYXrwhyHKgTlzVdcl36f8+6F9nUsjSttL3daQ8Li1Q
         K12wNP3hsIaZQ+wEc/snD1l1I8VxQTOziQhHm6Xf3vDKS6eRS/z6T81+573HbHBJVoSl
         MaPR17bevbcrIWYqWm3n+XT8RxZVf1rl2Vn7hOoDT16yOgXm5bzl5cfAK4ASbluekzaN
         +hWg==
X-Gm-Message-State: AOAM532BUfgBt8WbNZYQnnbwF1YyB7NrdGQLgBEX8QuEVYOxIMS4JWc9
        8lgEgHVAVXrcz9pRrQ90nMo=
X-Google-Smtp-Source: ABdhPJym2QXTynQU39NmdNtzLDw6KtyJWoPz1MyLreXao/H7r7ZWJtN4zH3wSeVyuGTediA5Bf6cdA==
X-Received: by 2002:a05:620a:1250:: with SMTP id a16mr21778775qkl.411.1604437788304;
        Tue, 03 Nov 2020 13:09:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 22sm11875684qkg.15.2020.11.03.13.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:09:47 -0800 (PST)
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com>
Date:   Tue, 3 Nov 2020 16:09:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 3:21 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This is based on ds/maintenance-part-3.
> 
> Ah, I forgot to ask those on CC list how carefully they read the
> part 3 of the series, as it's been left on 'seen' for some time, and
> I do not know if it is ready to start cooking in 'next'.

It has been a while since anyone has commented, and I've been
running the patches locally for quite a while. I'd be very
happy to see them cook in next. I wasn't quite to the place
to be pushy about it.

I'm hoping that parts 3 and 4 can make it in time for 2.30,
so the feature is universally available for all platforms.
I realize that's not entirely up to just me.

Thanks,
-Stolee
