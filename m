Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF89EC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE4361052
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhJFKjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJFKjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:39:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6FC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:37:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso3668307pjb.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgGfZVtShCCpTvaVG1PC3lZnuw2tdwzXWvBHg4mNuUY=;
        b=SUbGcRLoBT+kQ/s/230gGbTEbLPs54Dh1f4WWjuge1cdqjcm2Ls42zBDmSq03UsVU6
         4H7xURoLnnHhoD3HThIn9HqRelTibag177ESCt6nbVNSd5acTA7xqYDSwETayytJ2pi+
         HVa92d5pzkI2I0kMDou8lrxWwZ1fmBd/pwBsCDf+ioHvh24CaNgJaZRJnKjf4efF5iER
         nLyr+/wn1FzGoTzz5LxrodeQ6D0X92VzfrmzuMqCqnFb4cNlR/x3UfN3PaqoNY2Sa63W
         mQt1WR92gqIvXeLUQMlpjXZAcdUAdWr3lfuVEDmqo4qPEh7EHZQ6Y99IpXHZ35EZYmtw
         c97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tgGfZVtShCCpTvaVG1PC3lZnuw2tdwzXWvBHg4mNuUY=;
        b=kIENtQIK2IDFZEBUwgeSHrTbYT3yxxzbgli194BjV5WyKCHmpl35W8/sOE/tZtJx3z
         Aju13nophURDO+EJ+un+nWZ/79vlcvPaWf4Ku/7nM49GVjYX44K5i+GdKrqjrz3bJnqP
         L7IK2qF8ZrjE79lBlKYACOeRS2pSRkM0UBURSzxmrNzEBqcW/5u3i/HEP7D+zeiNaD7T
         VxG+Tu0wPf0K2B7kc6BDy0WWBZEIgdKc+tHMBynbM+pbHvCKdVRd/QxB092dvULa6oSx
         LdKGIUizUG1/bX6bam89UxP00r0i75rXhWhYl5eLw6gO9PlB/M8macqFzqg1U9orIxxy
         Hcug==
X-Gm-Message-State: AOAM532Ba7H9JX3HFZJz+uatIM6MMnYBnzbk0Q9wJzg4iYkHBksKhQBm
        trERCiwp1wFLP1lnGiKhb7c=
X-Google-Smtp-Source: ABdhPJxrL6M/KxMvFiFyTFGj4ilb0dy2EK+2CF0FPd2N6FSMOuiJMg9QWZ8j41hBmL6TvGAh8W0jUQ==
X-Received: by 2002:a17:902:a3c9:b0:13e:2e41:2a76 with SMTP id q9-20020a170902a3c900b0013e2e412a76mr10325423plb.43.1633516673232;
        Wed, 06 Oct 2021 03:37:53 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id y3sm19986282pge.44.2021.10.06.03.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:37:52 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] unpack-trees: improve performance of
 next_cache_entry
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <aa963eefae75d41983201e24398bc5692267b91b.1633440057.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ca698f10-9870-021e-766c-d52c51447545@gmail.com>
Date:   Wed, 6 Oct 2021 17:37:49 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <aa963eefae75d41983201e24398bc5692267b91b.1633440057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/21 20.20, Victoria Dye via GitGitGadget wrote:
> The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
> (unpack-trees: preserve cache_bottom, 2021-07-14)).  Therefore, to retain
> the benefit `cache_bottom` provides in non-sparse index cases, a separate
> `hint` position indicates the first position `next_cache_entry` should
> search, updated each execution with a new position.  The performance of `git
> reset -- does-not-exist` (testing the "worst case" in which all entries in
> the index are unpacked with `next_cache_entry`) is significantly improved
> for the sparse index case:

Did you mean `a separate `hint` ... should be searched`?

-- 
An old man doll... just what I always wanted! - Clara
