Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37C9C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 20:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiBNUvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:51:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBNUvi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 15:51:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B0100747
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:51:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so39910803eje.10
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=e/9Hr2iXS1hHE1hBbW+XgcyCXCLqX1w/g5CKDFf9k/U=;
        b=hRo5IO0R/GpB7xSNTkAFCyDjOh1cK7+zVVfZIOVpaWzDJIXEJVy1hCaex4w1zUKQ+L
         1Vo050AAPG2kf/yroi8ZOEAvYzHmyJTaOWTdLKOAmgJFKCty+HJy43vdkcas0gFzA3fb
         5+dXBB5jjrqQln8+Fl8BSSQwzDKhna8M0DJyBHZSUM4uECbbZnuPzjrmfH8mhtyqxQzC
         qZV13Qi6Pd0DLQjoqTZBtf+mRKMYHDticHAdl2umicENMbLLtETs9o3dEJ5hFIYm53lE
         KumEkzoGnuAx5Z7Zn10UgyKum+scE5r11eR/a/VpDrj0EiKz/hJ9OzCj/uyGYywX6qoT
         iOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=e/9Hr2iXS1hHE1hBbW+XgcyCXCLqX1w/g5CKDFf9k/U=;
        b=gYx3EZC/T4rqXTadGMkuXm4O15AMJgA7+aVsZhzhiM0kYrqhsaFLJwpu2p+mX+Iegb
         mn08fZbhoruvlHUWwHyckoVGJ1dgkXdwvpBjE4UAvAoBm35gCoRjPD0N4pYJSiasx6Ye
         Ksg5/L4eEXQNPRm3yjHXMolyf4acqy6IpB7vnem2gEI+b+wNaLZpmy7dyPuBgu6ul91c
         GPqQQ9D0LCWutR2uyHI4/z3ZvXZYmACW25leAf8XygheYZqWQlv/omw25JgRQwxQ4P66
         rRIzR/HxBI7IX7MjMmR5wX8B0u74rPPNT6PojQzuUKHhSKAYKpM6hvZ3DxMJ/mnyz2E+
         4eqQ==
X-Gm-Message-State: AOAM532B0/9RFWFtSUXRLnktS8VFU9/OZZB5Yu7AAuNltAuuE2b3mmQt
        7WRe78ONJJL5DqEnh+nNwEM4/mmsHG5npY4t
X-Google-Smtp-Source: ABdhPJzNdnTNAl+5wzmAWgzgNAyJ74eas4ZCk5GX5cc77/WrrPnsxql6uIBSAZ64IbyoM3vXtbvdzw==
X-Received: by 2002:a5d:4b8d:: with SMTP id b13mr521891wrt.571.1644870164099;
        Mon, 14 Feb 2022 12:22:44 -0800 (PST)
Received: from [192.168.1.94] (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id e9sm12718938wme.12.2022.02.14.12.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:22:43 -0800 (PST)
Message-ID: <6fbd4188-3bb5-6d48-fd25-1bdbe9a3cbfb@gmail.com>
Date:   Mon, 14 Feb 2022 21:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Cogoni Guillaume <cogoni.guillaume@gmail.com>
Subject: Re: [PATCH] t/t3903-stash.sh: replace test [-d|-f] with
 test_path_is_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git.jonathan.bressat@gmail.com,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
References: <20220211134655.1149320-1-cogoni.guillaume@gmail.com>
 <xmqq5yplcme1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5yplcme1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, sorry for the delay of this answer.

> On 02/11/2022 at 7:02 PM, Junio ​​C Hamano wrote:
>
> This is not wrong per-se, and I know I shouldn't demand too much
> from a practice patch like this, but for a real patch, I hope
> contributors carefully check if the original is doing the right
> thing.

It's good that you are demanding even for a practice patch because we 
are here to learn as much as we can. And, we will take a good attention 
to your ideas.

>   * verify that all existing users of test_path_is_file want to
>     reject a symlink to file, and add 'test ! -h "$1" &&' to the
>     implementation of the test helper in t/test-lib-functions.sh
>     (we may want to do the same for test_path_is_dir).
>
>   * introduce test_path_is_symlink and use it appropriately.  This
>     will be a more verbose version of "test -h".
>
>   * introduce test_path_is_file_not_symlink and use it here.

We wouldn't modify test_path_is_file because this function is already 
use and we won't verify if every uses of this are rejecting symlink.

However, we would like to try to implement test_path_is_symlink and 
test_path_is_file_not_symlink and the symmetric for directory.

Thanks for your review and the ideas.
COGONI Guillaume and BRESSAT Jonathan




