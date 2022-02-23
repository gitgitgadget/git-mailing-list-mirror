Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07D4C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 13:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiBWN7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbiBWN7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 08:59:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F5B0D28
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:59:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so1632927wmj.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WU8QuD/CDNAmd0C2YNJ+Fgmki4kRQp3dWs+xetfZNdg=;
        b=GyRJm4ZkZjuksp3kW80peOZzAd5+rec6DR/LWDGYM/TRwGzIF/adTdsaQGwA6hRZfb
         eY4ftwDdby+Y6rw7qpUsT7GtaU9ADAslK6rcE9Ys+uq/BpEaMH+96UcybxTDcUMj4bF/
         nlA6AbGILEWO3yUcgznp+35w+nMgYq1DGe56z5Fg5069YJjOw1H359aYoUIv1uZ+GfO9
         5PaMsfiIedsqJra4IZoqcAtJ2rvItbhqiHYg79QSbxXakYCvIT/JCWkF9UPUI1u/Jp7W
         RiKuTalUlDVIyGNRlpUu7xOTIXVA8KF0YiTRfTF+ap8r8u5Y2W14BOgZoppEIaag7qfC
         InuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WU8QuD/CDNAmd0C2YNJ+Fgmki4kRQp3dWs+xetfZNdg=;
        b=4PmmgOT8e/ANgZeYRsdQma4a/CVLWm34b8zdGtQSrsD6+n93DhCS/eDm0dL2+LLPjZ
         C7NX0sgEvZNtqiaGkZgCxxn2+oazH8mYhVbU32X0jZbwUdBMAZM4W79BSlxe3FsW5Cc8
         xPddwGBcgpte4QPA+Ev7nQQpdMVqoCjWx7htLFoPx8cfsAzY577dtaeFfAmazHZd6TG9
         wtFPjYZlTs/b/6/1+op+6jx/WdOKraD0LM6zWR4QQGtMJCW4OD9khz12MAEAzHbNhc1C
         Mi1CN5iZjeCoQRJze6Qite42ruDnv3zzfrHGBbuNgQoRqykfdAvjTAFJDaA4+ae6GAwS
         4Bog==
X-Gm-Message-State: AOAM531vEAIkkJoMvAJE9QDPW1/qTdWDCTTu+ETZHnqNAbhuMBOTpXyt
        AJ6f8w6UBpdRdlQMDXJocik=
X-Google-Smtp-Source: ABdhPJxe8Ph39GPCQpu8EbbMw7uGPzF/jEAT7GJIp8EdyIe0ZLpZD/cMQiGkpDmHKeRRKr7EepCdxA==
X-Received: by 2002:a05:600c:cf:b0:380:f85a:1cd8 with SMTP id u15-20020a05600c00cf00b00380f85a1cd8mr2239572wmm.1.1645624751271;
        Wed, 23 Feb 2022 05:59:11 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f17-20020a7bc8d1000000b0037bc3effe27sm5432856wml.38.2022.02.23.05.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:59:10 -0800 (PST)
Message-ID: <3bdff4ba-fb5f-e369-306d-5510ab20893a@gmail.com>
Date:   Wed, 23 Feb 2022 13:59:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: BUG: fast-import, ftruncate, and file mode
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CABPp-BERVCynOVvBq0QL49Ah+gy3W2snUVWBHfzXaVpXX3Dpyg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BERVCynOVvBq0QL49Ah+gy3W2snUVWBHfzXaVpXX3Dpyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/2022 07:47, Elijah Newren wrote:
> Hi,
> 
> fast-import makes use of odb_mkstemp(), which creates a secure
> temporary file and opens it with mode 0444, and then uses it for its
> packfile writing.  Sometimes, fast-import will call its
> truncate_pack() function, which makes use of ftruncate().
> 
> According to my local manpage, "With ftruncate(), the file must be
> open for writing; with truncate(), the file must be writable."
> 
> The writable requirement does not appear to be enforced by the kernel
> on common filesystems like ext4 or zfs, but this is enforced on some
> filesystems.  Apparently a "VxFS Veritas filesystem" got triggered by
> this...and some helpful bug reporters tracked this problem down and
> found a workaround (for the filter-repo usecase, they recompiled a
> special copy of git using mode 0644 for odb_mkstemp, since it was just
> an intermediate step anyway and won't be used elsewhere).

Am I missing something or is this really a file system bug? Surely if we 
have opened a file for writing the file permissions when we call 
ftruncate() should be irrelevant?

Best Wishes

Phillip

> I'm not sure if we should (1) just stop calling truncate_pack() in
> fast-import (it's merely an optimization), or (2) modify odb_mkstemp()
> to allow specifying a mode and also have something like
> finalize_object_file() modify the mode before renaming, or (3) if we
> should do something else entirely.  Someone more familiar with the
> object storage side of things probably knows.  But I'm guessing that
> once someone who knows the area states what should be done, that this
> might be a small micro-project suitable for the GSoC interns (or
> anyone else wanting to get involved)?
> 
> Original details from here:
> https://github.com/newren/git-filter-repo/issues/342#issuecomment-1047638304

