Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB380C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiJZNbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiJZNbd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 09:31:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB097C773
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 06:31:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a24so9819436qto.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlkH7/skqaFL9oGXONS/tvJ2/6cnyioMemX6hX+QXnM=;
        b=VO9tsmlwBdr/b0mC8DrCBBu82ltdbtmnzqSAvyB9IJ4msKUwDoZoWJgDwSxDC5R1ot
         LmSAXcEVKyl6Use1llBFZnsVRR4HimeTYZCZsqENp311GBcCc/mHDvy5OnH89KSr0+E2
         e4FFtzUQXVc9Fk266Kg902qasFrlKtUlu95Zk++xOtRtnEbZ+gJ7lVbN/Qvqrbhm7mqh
         MHwu9JM3wMfjJ8DVWObHKNnP29vKIqv9D33DKEMgmS5VXdJuv14iF+WzYbaRUdwH41kM
         QWGx7NzASNxzlNy/j1Z2exvLButRNo4/qOYNvSgmleKsJSbggsupiGStPsOUEBGMJBUL
         TKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlkH7/skqaFL9oGXONS/tvJ2/6cnyioMemX6hX+QXnM=;
        b=AfhdlqTwVu+LiOt08JrwSfCTubseiHuXU9yTNY+nJOdaP8OpHqamUnO3UKGMgVJ7BW
         1okUG3OhsdAz6I9gz4wnJxOBO6mRxgql5aAi5LAWEhxAdqslA3BxCJTWlR9akZIknOKU
         scMiVdwmseEQ/AzwcMu4YbzeIWMm38vUVzptWuxNPph1B5vTC62iO3QZbyJP/kDwYuJ3
         Bozffs35++L8FZnCHCvhAbDgmDft5x3huT4jv2hs/7T97CjHbZjyiaiPv3CAz87QYq6z
         7XUmqSDcIKh0+cHQRFEqSRrd5/QN06/jhVKdMKV3lm5qFAumx3htlok1IEuHjoOPkgid
         NFLA==
X-Gm-Message-State: ACrzQf1WXRvY9QHheyknH6Mv05Ligvkzv7lwlHNvxaF5kTNRtSVe8HRj
        D8nbXYjOAaijdixPmm/+jAAd9wTPUrQQ
X-Google-Smtp-Source: AMsMyM503jrsx8H+d1aByCW3ZGCYOQAFUsPmsKhkKeN/ArOVGHZcra3I3ggEyJgxBYa73X5BG1hExQ==
X-Received: by 2002:ac8:5741:0:b0:39b:ddca:545 with SMTP id 1-20020ac85741000000b0039bddca0545mr36135765qtx.630.1666791090227;
        Wed, 26 Oct 2022 06:31:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:84fb:805a:cf4:e815? ([2600:1700:e72:80a0:84fb:805a:cf4:e815])
        by smtp.gmail.com with ESMTPSA id t23-20020a37ea17000000b006cf19068261sm3890684qkj.116.2022.10.26.06.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:31:29 -0700 (PDT)
Message-ID: <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
Date:   Wed, 26 Oct 2022 09:31:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] midx.c: clear auxiliary MIDX files first
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>
 <Y1jIo1dPl0M2TSHo@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y1jIo1dPl0M2TSHo@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/22 1:41 AM, Jeff King wrote:
> On Tue, Oct 25, 2022 at 02:25:20PM -0400, Taylor Blau wrote:
> 
>> Since they were added in c528e17966 (pack-bitmap: write multi-pack
>> bitmaps, 2021-08-31), the routine to remove MIDXs removed the
>> multi-pack-index file itself before removing its associated .bitmap and
>> .rev file(s), if any.
>>
>> This creates a window where a MIDX's .bitmap file exists without its
>> corresponding MIDX. If a reader tries to load a MIDX bitmap during that
>> time, they will get a warning, and the MIDX bitmap code will gracefully
>> degrade.
>>
>> Remove this window entirely by removing the MIDX last, and removing its
>> auxiliary files first.
> 
> We remove that window, but don't we create a new one where a reader may
> see the midx but not the bitmap? That won't generate a warning (it just
> looks like a midx that never had a bitmap generated), but it will cause
> the reader to follow the slow, non-bitmap path.

Yes, this is the worrisome direction. The midx is read first, then that
points to the .bitmap file (based on its trailing hash). If the midx isn't
there, then the .bitmap will not be read.

> Ideally this would just be atomic, but short of stuffing the metadata
> into the same file, we can't do that. But the replacement of the midx
> file itself is atomic, and I'd think everything would (or should at
> least) follow from there.

The interesting case here is that this is in clear_midx_file(), which
is called when repacking to a single pack and no longer needing a midx
file. So it's not using the atomic rewrite from the midx writing code,
but instead the "atomic" deletion.

In this case, a reader will check for the midx first, before looking
for individual packs. Further, the new pack is written, but the old
packs have not been deleted (or the midx would be invalid). So the
new code introduces the window where a midx exists without a bitmap,
so some readers will act as if no bitmap exists on-disk.

This was always possible before, too: the midx could be read by a
reader process before the repack process deletes that file. However,
if the reader does not also gain a handle on the corresponding
.bitmap before the repack process deletes that file, too, then the
reader is also left thinking that no .bitmap exists.

I think the old code is more correct, here. The window is slightly
smaller, and the new code creates a window where the filesystem
doesn't need to change for readers to get an imperfect view of
things.

Aside: in these cases where a .bitmap file is not found for a midx,
do we fall back to trying to find a .bitmap file for a pack-file?
That would assuage most of the concerns here about what happens in
this window where the repack has a new .pack/.bitmap pair but the
old midx still exists (without a .bitmap, depending on timing).

Thanks,
-Stolee

