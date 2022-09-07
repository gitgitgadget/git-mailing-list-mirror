Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0AEC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIGOPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIGOPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:15:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60214624C
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:15:39 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e195so11585635iof.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oZvVD6q9hHb9PnW88/4Y8m6Ti3oVLllgbTyKBMj90sI=;
        b=IjYCbIZInmgdmWHWO1gI+b9K27c4SxGVKGnBqoNQBfDCDoEFB5lVzCNdCJCXXcbVUz
         +oXUIzlNxsW7F2OqCxhaLFikHiUqu3siDPTOsCJUQ5rveDQkdS/5+oEa0eA9qLYBuvwR
         xN5afE81Qa1Ry9aecVoHnw0SBO87nhsCrOulSNoMMAySNs7vD8Y9J/IKb490j+cKHgBU
         Af1jpy0S0+ncZi+JrEhZmwQ43WS6LUd5YxclW/SfBzAulVeko7gGHSsMhPlZX971X7I1
         t7dhO4uqLurdT0SXp94pCuj5vr4NShirgv/gM9HbCBvev1+gTDrcQwZpmYB7wJ16wETd
         lvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oZvVD6q9hHb9PnW88/4Y8m6Ti3oVLllgbTyKBMj90sI=;
        b=7b77r43zvZTuYo0zYFDpjTtdQi9eKgN8bXaTmVAcrZZc4BKmqABAPFDVFff0mGsSYF
         NBCgaxPL0X7v6mAQ3FiwY/zRZ8D+8P95cofXIS8kG7pVcDbb4UWYNySRPtb1Df1wmJVU
         ceaBQCSHFImrtwHICygusR6M64oyFwoM03kEyYSleKD3jp+R1wpzcLoUFUS6pdnX0gxV
         y07TdjwkLY60HC56FKZ+0Ej4N2PRGFQs12mdggRzcn5/OXulMi9QIxAr0YWkIsROo2CD
         YMvRobo4vepnQSHwJCS9mW4yKhTC35N5l1skQSium5IJfx3D9/usAvwXZlJoTEsGbMRG
         /9Ww==
X-Gm-Message-State: ACgBeo3y+ckCt3B/RWpKRsC10S6MdEm/CjSmdeU/mOYvZkPGj/jsqSVL
        UFOwODWLlmQSVzr5v06ahWQt
X-Google-Smtp-Source: AA6agR7Xnqj0Kbv0EIwZtIPRzRswGbZf3MaYmaUhxUOD7Qimhs+lkhS1psLerJlXsZzHDobFRkUrJQ==
X-Received: by 2002:a05:6602:2111:b0:688:4a2c:cc84 with SMTP id x17-20020a056602211100b006884a2ccc84mr1978091iox.137.1662560138800;
        Wed, 07 Sep 2022 07:15:38 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r15-20020a92d98f000000b002ead95306c1sm6453756iln.51.2022.09.07.07.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:15:38 -0700 (PDT)
Message-ID: <f79b0ccd-3e36-f447-0dbb-6e40ad547c8d@github.com>
Date:   Wed, 7 Sep 2022 10:15:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] parse_object(): allow skipping hash check
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfRTubqh7aFvNJs@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YxfRTubqh7aFvNJs@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2022 7:01 PM, Jeff King wrote:
> I'm sorry, I know the argument here is really hand-wavy. But I really
> think this isn't making anything much less safe.

I agree with you that this is the safest way to move forward here.
 
> I was actually tempted to rip out the blob hash-check entirely by
> default!  Anybody who really cares about checking the bits can do so
> with read_object_file(). That's what fsck does, and we could pretty
> easily convert "rev-list --verify-objects" to do so, too. So this is the
> less extreme version of the patch. ;)

A quick search shows many uses of parse_object() across the codebase.
It would certainly be nice if they all suddenly got faster by avoiding
this hashing, but I also suppose that most of the calls are using
parse_object() only because they are unsure if they are parsing a
commit or a tag and would never parse a large blob.

I think this approach of making parse_object_with_flags() is the best
way to incrementally approach things here. If we decide that we need
the _with_flags() version specifically to avoid this hash check, then
we could probably take the second approach: remove the hash check from
parse_object() and swap the places that care to use read_object_file()
instead. My guess is that in the long term there will be fewer swaps
to read_object_file() than to parse_object_with_flags().

However, this is a good first step to make progress without doing the
time-consuming audit of every caller to parse_object().

Thanks,
-Stolee
