Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D2DC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38CA2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5JzYcw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLIPI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:08:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40457 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfLIPI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:08:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so12444381oto.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiuy0rC4pG4DOMIs3/L6z9nJWxNj9lK3tcRpE+e9Ygk=;
        b=C5JzYcw1FkQfhP79lOXVJfFie4N3Df6i8OfXheMxhMFxM3RiBAeIDqquU10UQqaUDP
         Gbg+C7i/GkizIjJ9RsPERbOqgXiOC283hX8tmpw2tBpYwfPyvEiKF+KVI+EdHZDEnH73
         sgL/7T8sIoB+yLPYW1x/OXeJjdCKZuhJ6zmWasIdAwl8OuYTCXS9HoW/DtaebP2Ab9eY
         h19zJsBf1mz8By62kQPW2AaH38l6sjbxXqp9p8PHs/CV8Ygh/knOMbXdRntb3kk4aKyA
         g22+pFMun5Qwj6desmfX1xF2wnyjkLK5tvoJaBO+/8MXtIVg+BTsFPNsx9xfSxUiJQpc
         k3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiuy0rC4pG4DOMIs3/L6z9nJWxNj9lK3tcRpE+e9Ygk=;
        b=GVnWs4cKDwbonN29OnZYLWlKK9lX2dvNz7UmN2q4PAJiDEkKfO0wTqMygH4rVfci+5
         d7wEwo9HPZVPDxS8tkT8rv9aJoqgCzyOjiDUjfFSQbA2LHRhYI2rKxMg66yZAv0BZJzi
         RbSOGxIbn8T3wFdn3Ohpt39PUobBhNIU02SCXS8ecf5eJ5gV/1GmmW5HlxJdOx1fifxR
         E6LD/4ReCFgXvUcNdIB1v07bv+jhnh+G1eXIf3cqLF6Qyg9BF1qbQ90x5DRR+tds+Jbw
         6nCwHOclGgfLws+QHeN7MPxpFLCCzRW8h+wKkbugESpohrEtojC7OeOS/exptgulTkU2
         9Wzw==
X-Gm-Message-State: APjAAAViwTfuEP91jpwib3lOR4a23Chr0LgjeanlOWGo2GNAO3aXLfWg
        cGKaTt4cTx/wKNLNsapiUHBYRe5KfxU=
X-Google-Smtp-Source: APXvYqxzrzfmDu0Dnq7iHTxIb5NtC6L9w+dUsPmF1IUM+hgCmnY8NwM/FiqVTfNcgN7o6LAy05wHlA==
X-Received: by 2002:a05:6830:1501:: with SMTP id k1mr22886318otp.209.1575904135117;
        Mon, 09 Dec 2019 07:08:55 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g8sm8479614otq.19.2019.12.09.07.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:08:54 -0800 (PST)
Subject: Re: [PATCH v3 00/14] name-rev: eliminate recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a589cd6d-f074-e31b-3b22-ee856090b02a@gmail.com>
Date:   Mon, 9 Dec 2019 10:08:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 6:52 AM, SZEDER Gábor wrote:
> 'git name-rev' is implemented using a recursive algorithm, and,
> consequently, it can segfault in deep histories (e.g. WebKit), and
> thanks to a test case demonstrating this limitation every test run
> results in a dmesg entry logging the segfaulting git process.
> 
> This patch series eliminates the recursion.
> 
> Changes since v2:
> 
>   - Add the new patch 12 to use 'name->tip_name' instead of
>     'tip_name', to make the patch eliminating the recursion a bit even
>     easier to follow (only with '--ignore-all-space', though, without
>     that option that patch's diff is still mostly gibberish).
>     The end result is the still same, see the empty interdiff.

This new commit makes sense, and I see how it adjusts the context lines
in the patch that follows. This series looks good to me.

Thanks,
-Stolee
