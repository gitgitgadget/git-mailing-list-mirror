Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77762C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D784206D6
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxGR+/lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBJOq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:46:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35896 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgBJOq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:46:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so5299801qto.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oPJ1Kekqx32DYvQWcrO4xo6dext7g2PmHQp68CPKVjM=;
        b=kxGR+/lYn8LEnoUMFTDJkMp4c1biahES5UNxgqGvyb1hVKxP4n4DbV+GCVzBB15geK
         L+e21RDoy7mOpbcG++m3ViE+ij1S+CmlTiWxdu7UYbPmRWURNDz6IYYYFVN9k4QDGc5W
         BaUZQ2ueg53FRclg46VJ1CFg9SSUuWr9/zl+L8risBxEnnslY5rXk0iYzWkFGOCCaHzk
         RtAdkKIJ9CxzweM45Y253IxYmoOdc/PCOWFqaFxDd9haoixgNpfokx4oiXbHofKSEwKP
         2oQImuUk1FCxh5zFNtgoAUCQp9G91J/KhSgR2rpgGkG7flehJDVGCY0vo71kTA9Wqqwm
         8R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPJ1Kekqx32DYvQWcrO4xo6dext7g2PmHQp68CPKVjM=;
        b=RJ3IdsatzrtLee6pPMccFUdGpeUUZ/qjAww7JKN3WBQ8v6dY3ko0PUtE1zg7yzYY3Q
         Ma9Czk7UWwmmXm8YQfghMFxQxPAEHz2rJ1LrjG72XRyIYU2Nmx8Yg9iLv0GL8qdT9LMO
         pyMhUQ5siQxxu5tAB3qCBlFdgRQbLYdkgHM99UtoOPGPCzVAr0WELPqgE+aPhOyCZTRd
         I5yaaNd8HB7jw4s4vEsBdmHbakZyHLttTUT/kgdNHfM3LPkB/OC5DPp2nuCuTIMaQxfa
         sHHq355lR1dYaz99E3F5b9gHa3UzdB8kzU/g3dA2pbYMHq2tinJYLX0F5ayVXHnofc3q
         MQhw==
X-Gm-Message-State: APjAAAVmCzRqT0/yT6tszKR/ZxXAZhu9VqSxwTz0L1neuYzdp7f1cELs
        nxSwITAkKGxclvs1jsV3wL4vpZQadWQ=
X-Google-Smtp-Source: APXvYqyhsCORMT3rEBLLmJd2LJzJ7csVSdJrt68CB7SFk4fKo48SY0a+dMMqDk9PQMHM5vdhLsnmHw==
X-Received: by 2002:aed:3eee:: with SMTP id o43mr10372656qtf.33.1581346017962;
        Mon, 10 Feb 2020 06:46:57 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3922:b15f:4fe8:fef? ([2001:4898:a800:1012:ea55:b15f:4fe8:fef])
        by smtp.gmail.com with ESMTPSA id z8sm276314qth.16.2020.02.10.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 06:46:57 -0800 (PST)
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
References: <20200207221640.46876-1-johannes@sipsolutions.net>
 <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
 <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28b6fd7f-85ea-9ef1-1977-888cdd737c6d@gmail.com>
Date:   Mon, 10 Feb 2020 09:46:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2020 9:22 AM, Johannes Berg wrote:
> On Mon, 2020-02-10 at 09:18 -0500, Derrick Stolee wrote:
>>
>> Thank you for finding this doc bug. This is a very subtle point,
>> and you have described it very clearly.
> 
> I was going back and forth on the wording a bit, glad I found something
> that you think is a good description :)
> 
> Are you familiar with the multi-pack-index and how it's used, by any
> chance?

Yes. I wrote the first version, and we use it a lot in VFS for Git.

> I came here from bup (https://github.com/bup/bup/) and needed a way to
> store the offset to find objects in "pure bup", today it only stores
> object *presence* and *pack* in its multi-index, but not the offset.
> 
> However, it seems to do a bit better in terms of not requiring a single
> multi-index, but instead storing it in midx-*.midx files and multiple
> can describe the repository state. Why wasn't something like that done
> for git as well? It's a bit annoying to have to recreate the full midx
> every time a pack file is added, and searching in two or three midx
> files wouldn't really be a big deal?

Part of my initial plan was to have this incremental file format.
The commit-graph uses a very similar mechanism. The difference may
be that you likely allow multiple .midx files found by scanning the
pack directory, but I would expect something like the
"commit-graph-chain" file that provides an ordered list of the
incremental files. This can be important for deciding when to merge
layers or delete old files, and would be critical to the possibility
of converting reachability bitmaps to rely on a stable object order
stored in the multi-pack-index instead of pack-order.

The reason the multi-pack-index has not become incremental is that
VFS for Git no longer needs to write it very often. We write the
entire multi-pack-index during a background job that triggers once
per day. If we needed to write it more frequently, then the incremental
format would be more important to us.

That said: if someone wanted to contribute an incremental format,
then I would be happy to review it!

> Anyway, that's just an aside, but during all this investigation I
> stumbled across this small inconsistency - I'm glad the docs exist at
> all! :-)

I'm glad they helped.

Thanks,
-Stolee

