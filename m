Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF21FC34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98652208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt9hbJLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgBSVUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:20:22 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43279 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:20:22 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so883573qvo.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytEdHpwV+GqBsAivSjJEc1eFusL/AAosd2MG22QWFO4=;
        b=Kt9hbJLqw1fhWwivXBt72RPwbIibDXE0t2CxaNR0J157s1QP9H7kMjJgdxAuGyweCr
         nMjNDJTfjZgEklHSCTvctrViAYMmW7kCb6nxOUbzVzEu9vfKjjmRJX8xtYAlbUMS45Ac
         WT76ss57/fRCpXC4sU3x4i9d4LOY5E2Sya1GkciO2ZRSvhlDA3mBManp8EqdM0Amd8w6
         5oDP68BWRZ+iN2t4KDPb7vVFrSSIwCRaxFbPtDsOKblvJ+uFr/TfLYTI4Li811DgvXwU
         XkQiVLRsTOTRSjkd8ytoIAzqwN9WSZ1REICHFQLyhufKfFZFcGLSkcRQ3fcYxx/jIZEY
         Jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytEdHpwV+GqBsAivSjJEc1eFusL/AAosd2MG22QWFO4=;
        b=SryUeXhU6wjVjz6eaaN/hlChoMCexISGvmnHO8OXlOvr/0DwcuFGXeDhBbDs/Mi8MZ
         Uo5wu2QLJzJ/X2ByL+G+AcAidlJzUBDEiouhpWpWYEcn3It9dR6vWwRz6XK/VzPp6PgE
         Jv5jynf/8l+jarzEiaVFn1HZsxjE1awP37F987gvBUyUqNNSJbFHNB3yFK5uBNwN4JOG
         ol6UGU8SuwseaZBZvsAq1b7GrZH3hdJ4e5+38wBAEDyOav9rAM+oU+zmytgMWY3Uw9ye
         spKlMBIraKW4MUwyvReUaPGNeFew/RY2s5fluYxMUeKcZJDxd6WegCScJik93/v392ND
         rW+g==
X-Gm-Message-State: APjAAAUzr3RC3Bbjpt4Kn6JNZ4ET3+YVJpy7oDNfESYX6ZKNay5AJKUf
        ZNQkCZK5sNkhR2Eg5alSsbU=
X-Google-Smtp-Source: APXvYqxeCuN7Z/zyVe3+xNUYiMkhBLbvASTMliQYc4K82pCriHLKVnD5a0GVfAhUE3dEIYsQ2PJltQ==
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr22756420qvm.237.1582147221448;
        Wed, 19 Feb 2020 13:20:21 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:5cfd:e9c7:d1b7:62ee? ([2001:4898:a800:1012:e31:e9c7:d1b7:62ee])
        by smtp.gmail.com with ESMTPSA id x8sm508845qkf.4.2020.02.19.13.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:20:20 -0800 (PST)
Subject: Re: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
 <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
 <xmqqimk2e1vl.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT+MO_JmZf_qfxu8ZkPLWDOpZSe8rZxt-7LK4d6+RJ6JA@mail.gmail.com>
 <xmqqblpue0oq.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c57b9bff-dc6d-2117-f708-46a02d06d5ef@gmail.com>
Date:   Wed, 19 Feb 2020 16:20:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <xmqqblpue0oq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/19/2020 4:17 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Wed, Feb 19, 2020 at 3:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> +test_expect_failure 'verify fetch succeeds when asking for new tags' '
>>>> +     git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
>>>> +     for i in I J K
>>>> +     do
>>>> +             test_commit -C src $i &&
>>>> +             git -C src branch $i
>>>> +     done &&
>>>> +     git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
>>>> +     git -C tag-test fetch --tags origin
>>>> +'
>>>
>>> Is this about an ultra-recent regresssion?  When applied directly on
>>> top of v2.25.0, this one seems to pass already without any change.
>>
>> True, although both fail when applied atop "master".
> 
> I flipped the first one (i.e. test #24) to expect success and run
> bisect between 3f7553ac ("Merge branch 'jt/t5616-robustify'",
> 2020-02-12) and the tip of 'master'.
> 
> Interesting that bisecting it points at 684ceae3 ("fetch: default to
> protocol version 2", 2019-12-23).

Thanks for tracking this down. I had originally been working on
top of master, but then rebased onto v2.25.0 to test this on our
VFS for Git/Scalar fork [1]. I have since noticed that the test
passes in that case.

Thanks,
-Stolee

[1] https://github.com/microsoft/git/pull/247
