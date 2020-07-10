Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5CC433E3
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 15:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89D02065D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 15:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3j1E5jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGJPQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgGJPOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 11:14:38 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE4C08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 08:14:38 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e3so2695461qvo.10
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rVEXFxTNSV3H3cunkiLs/PCp9eNTi0msX3MMUMUWVI=;
        b=s3j1E5jH/4wM/kH04/nRfvXNExj28W54Zf5uTjl3V6P2yj17HXRPEMCZ2tejmWgS8e
         g6BhuElZwpa8bntE4zWOB5IsBJ6XTd2HCBscxgGTgD+Chxsr68IMOtAq3WQoGNgiweGK
         VxXEkLr/FzWDO0j1SS4fqFkm0eWfp3wMJDe9OxuZ5BsFFWUluYtxu6V9zM299MFgGjvR
         /bilqsqlaR7eBpzMdVNUcj3ljROfuCt9Pm+xNPlN2Hl3MkbFkIxps8jYMiVX2Yj3uUT+
         Vp74VgngEn4DCS4hKOJRqMKO8YSE6kFL6KW0+hgkNOCMuysT0aydlDqUNyjo125gRqmr
         ahXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rVEXFxTNSV3H3cunkiLs/PCp9eNTi0msX3MMUMUWVI=;
        b=cn4B1eKyNMj9oqZmthbbozdb2jQQNBYeTZaHyziwWzWj4/pGpjMMSXFNecHGYKgt++
         bUoebLbkIwg9Tu9pv5CvZigOdrEmuY2cpMzVgy6cCx/f0U+Cnm2BAIzq378OTnbRlKOB
         ceKMcdlBePD/wkN+4iUM3sqrbd+SLTlq8xQ/ihKo6LVAj8WqUDyIrUqvG59PvfD+wq+h
         +AW5IcNsrmtiiNTata6vsUilOW6GVwrjliEXh5wih1L7L72T2FRB3XkpxwCnpHlTqWRR
         sfX/baoLgErW0zHbZh8F6WCSzOV9DyyM2kzJhTyY98N+DtQKqzfN+sFZ5koDHQGYH9RE
         980w==
X-Gm-Message-State: AOAM530t0sbc87Pt9K5GnWtTXjq4z7lcnTsom2rSC9OPEQ5znYsp2glV
        5I295k6HnNWo7Pzre4FBfMMMPwuE82I=
X-Google-Smtp-Source: ABdhPJyVBNBYVYzazM9AZ6w7faMduu1+sgC1qJMkY664khNJkohXWJ2lfGeFAQzbiy0dOmdgybQEQQ==
X-Received: by 2002:a0c:b310:: with SMTP id s16mr17149148qve.5.1594394077909;
        Fri, 10 Jul 2020 08:14:37 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f41sm7950683qtk.55.2020.07.10.08.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:14:37 -0700 (PDT)
Subject: Re: [PATCH 00/38] SHA-256, part 3/3
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
Date:   Fri, 10 Jul 2020 11:14:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 10:46 PM, brian m. carlson wrote:
> This is the final part required for the stage 4 implementation of
> SHA-256.

WOOHOO! What a milestone!

As usual, your commits are excellently organized and clear. I could
not find any fault in any of them.

The proof is really in the pudding: does this pass the test suite
when GIT_TEST_DEFAULT_HASH=sha256? You add that as a mode to the
CI scripts, so we will know.

I made a recommendation for a different model with how to do the CI,
but it's super minor and can be done later. Basically, if we create
a new job for SHA-256 mode, then we can more quickly identify when
a test failure is due to that toggle and not other optional GIT_TEST_*
variables.

I hope to play around with SHA256-enabled repos a bit later, to see
if I can find any issues poking around on my own. I doubt I will,
with how thoroughly you modified the test suite.

Thanks for this incredible achievement!

-Stolee
