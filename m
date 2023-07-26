Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8214AC001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 13:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjGZNLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZNLt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 09:11:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29531FDA
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 06:11:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-316eabffaa6so5303770f8f.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690377107; x=1690981907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TD/9mdmmxM+zvBo+BR4A3BN+vSMXMdL72X4x4ySIfx4=;
        b=AqWsV7+4ryYXbS255EqclZ7f15PgEqqqf6BSDXXDkD8tQH72+TuVPEij39ZK1n/mC2
         D6e11WZabM/PjwlpnEzxg8FoKwxGB2ui6aXBBJuoaIegivRbqCV0YgE4+EKbsHRMNF4L
         /CVjgngS8Bo1Cs4AJfUw4ZqrJW0zK8Vfl+JKbYv2IOL6WiLlVWIHZ+AlsyjjIAUVGmfv
         NuSXmn49UkDcY+HfE6bmcSJjm5mtEeWkKZd1q3mPxftBi1b4vZdg0fpddduTbKtPwf9x
         kq+Gy4zy1zXj9uMtR3L48S1vPiNKvwHTUPYcVNKFqQ4qeuYsjB3agdxGUwfMBf9PJuFU
         4YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377107; x=1690981907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD/9mdmmxM+zvBo+BR4A3BN+vSMXMdL72X4x4ySIfx4=;
        b=Ee8vd0xtFDkwBmh8/p7cK57C/hZv6tUccdg8SI/JNx+wgKPu1swIFnqMokI5dSNsSW
         3zNG3DJviBkUYMcA+shQZ8QKTDE3keApR3m9i7WAseqVft1i3TPqVcRh/syICzexSZzf
         TZ9jkARbekr0JMofI/oU7vYnBExj/jhWcbySRTHJxgcmlhzIdP/ZSqnwmnrLogfWqSNo
         qvzEgT4hfycNE/dDCDWvl09IXgBRRbTVJav1DM2MnoRXWXYQxSe1K/BuuLoSEB9Rw3u/
         W1kPSmDC9pJ0uYFTV5tWrDKZXURsezWAw7QSD9XCiusY2sgH3Y3OHNYHxjwo1EZqUmxH
         FCJQ==
X-Gm-Message-State: ABy/qLaC1qUY6wSYKbkcwT2mW8LWzrHO9pUKKyks6spLISqaaPeSJumD
        CxTz6VRoj+W732ZwLyRcy4bsHmx1icNILA==
X-Google-Smtp-Source: APBJJlFkG7m9Cu425bKfyQSk4sfvhfX8ajHeIkNVHmIMitJsb3kn5bOB9+opqDGxGwZW17gVIlhj8g==
X-Received: by 2002:adf:f7c5:0:b0:317:5d3d:d37c with SMTP id a5-20020adff7c5000000b003175d3dd37cmr1430816wrq.24.1690377107226;
        Wed, 26 Jul 2023 06:11:47 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id w2-20020a5d4b42000000b0030ae53550f5sm19673058wrs.51.2023.07.26.06.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:11:47 -0700 (PDT)
Message-ID: <9d2f119d-7da7-003d-d011-5c3aa7f94ae7@gmail.com>
Date:   Wed, 26 Jul 2023 14:11:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqedkvk8u4.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqedkvk8u4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/2023 21:57, Junio C Hamano wrote:
> * pw/rebase-i-after-failure (2023-04-21) 6 commits
>   - rebase -i: fix adding failed command to the todo list
>   - rebase: fix rewritten list for failed pick
>   - rebase --continue: refuse to commit after failed command
>   - sequencer: factor out part of pick_commits()
>   - rebase -i: remove patch file after conflict resolution
>   - rebase -i: move unlink() calls
> 
>   Various fixes to the behaviour of "rebase -i" when the command got
>   interrupted by conflicting changes.
> 
>   Will discard.
>   Have been expecting a reroll for too long.

I am slowly working on a new version, but it probably makes sense to 
drop it in the meantime as it has been so long that the new version 
probably wants to be rebased onto master anyway.

Best Wishes

Phillip

>   cf. <xmqqsfcthrpb.fsf@gitster.g>
>   cf. <1fd54422-b66a-c2e4-7cd7-934ea01190ad@gmail.com>
>   cf. <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com>
>   source: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>

