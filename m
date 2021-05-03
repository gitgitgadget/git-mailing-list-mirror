Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD3C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF01611C2
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhECMMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhECMMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 08:12:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619F3C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 05:11:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 1so3454478qtb.0
        for <git@vger.kernel.org>; Mon, 03 May 2021 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QLC4yFCBTXbY3EqRuLVNCgeWlikKlSwCdrT1Mm7Is9o=;
        b=Qdk+MrZsCdmSnT9cLV3bTptaf27QHGJngCMLnqwR9DwGkZc3st9rS28ngwgj+mE4wh
         oYFNZEeUwyFNwcSQX7413x32PgbANQrF4uzvPzXUOZV3lOqYDjMGr00tlzKfuBSamlFi
         5dm8DkK46iTvhJpMgNwLAJ8PsKvOHhXKpPbOR0Epag7WR6P9MZFSfqsHmI1lt0VxSTJo
         Ov2VW5oLR/Idq28sfIq909Xm0ve0OTK2e7KDE7NMTIxH8PMNlyC/2uDLNPg8GLKMLkl/
         hj12PWZnoZ6NUm8oPcIqQQOxb/Adiqx8biNlkQF8nr56PgcS4qxrIcKtzXPrI0VfwIva
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLC4yFCBTXbY3EqRuLVNCgeWlikKlSwCdrT1Mm7Is9o=;
        b=doYHYN8Y5FPNMoNunM/JFsKuPlQfuQ6X4b4Ay7S3OqQ73NAmt5KGZ4GXCIFSDpQeOs
         5j2eb2JTisd5Nb5xhrwcUlLYDgvTKRuJiqrsiqdaGZVbMHlnDK3lmKhj07ehSd9nv1Hi
         BbSIS3cPlOPwCuacUjlWjL+ikPM3w5BG1ZtNatkuUFCNPiRcDLxzIKuiLqnPkAGZ6sZo
         GZzBUBjZo5pa2QFK7eZTsTwkDkKgomkEyQmvQWuyzy640olvQyx+yk11pgeAymqTYHeC
         rvMe7O68FR84SvUUayuB/ujXXY//sXz1iEMjDITzELEFBjKxtbtT6Ni2Kst1rzkli+bG
         balw==
X-Gm-Message-State: AOAM532Ygi4oCcOjMtOrioz+8ArdV8kOH3ZCs44aNdfKN7Huiw0ro+3L
        tZd4k6pO/GHK7Q8ciDr9MK4=
X-Google-Smtp-Source: ABdhPJzjc0Q3d7UeZkX/3qTDwb2jnHe8Xz+QJD7EF2WYub6mo7F+eex6BQDopfQsYwnsfcXCrO7RxQ==
X-Received: by 2002:ac8:7205:: with SMTP id a5mr16973173qtp.244.1620043909553;
        Mon, 03 May 2021 05:11:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e8cc:2a25:fb4:a65b? ([2600:1700:e72:80a0:e8cc:2a25:fb4:a65b])
        by smtp.gmail.com with ESMTPSA id z128sm935331qkb.135.2021.05.03.05.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 05:11:49 -0700 (PDT)
Subject: Re: [PATCH 5/5] pack-objects: clamp negative depth to 0
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1f8jKReuE3LXVH@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd080fd4-00cc-0e53-2cbd-30871c598b4d@gmail.com>
Date:   Mon, 3 May 2021 08:11:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YI1f8jKReuE3LXVH@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2021 10:04 AM, Jeff King wrote:
> A negative delta depth makes no sense, and the code is not prepared to
> handle it. If passed "--depth=-1" on the command line, then this line
> from break_delta_chains():
> 
> 	cur->depth = (total_depth--) % (depth + 1);
> 
> triggers a divide-by-zero. This is undefined behavior according to the C
> standard, but on POSIX systems results in SIGFPE killing the process.
> This is certainly one way to inform the use that the command was
> invalid, but it's a bit friendlier to just treat it as "don't allow any
> deltas", which we already do for --depth=0.

Makes sense to me. This whole series LGTM.

Thanks,
-Stolee
