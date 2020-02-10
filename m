Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE89C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEBE20658
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5J2AUmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBJPCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:02:10 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40086 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBJPCK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 10:02:10 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so3285074qvb.7
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iRyQEfVYm0oBWWBlEW0E+yaDqAM9uOD0qsLNsAkPXY0=;
        b=Z5J2AUmGi3P+7OUyaWnKGY8sO7eKq+BQbp1iF3ZsEkAiJzvwVpV/ZNSZ0ZKeRw/7j0
         ABYfJ+zYtpyCzj9JwWnnAePFbQ/B/rH0U+30MrzT/FlDzoipuEnn3u7N2W3VuLuYUoHN
         BONFSfoAisf3z5C1b+47ExIvCSMMecYwwjS2PdWrtGNo/XtpmnCbbRbNUVQRKuSL5dOn
         Zi/bY3jE4KCg5cOYgtrc2eRp3kDskJ9CYZGqzqdyaH9mujBSbJ4i6ffXgwBl5U3UJy64
         9PCEyBWLnhGe6hXX42msKmDWJAOpCLQhi1w7lMbP2pQo60sNbdtWR4+pb12pddcY8Khr
         B2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iRyQEfVYm0oBWWBlEW0E+yaDqAM9uOD0qsLNsAkPXY0=;
        b=C7x19CXuLOGt2bYAyMWpN8GpZwXDui325/nTsMWpheuF9oiom3D0UeIp0ANB2/I6UP
         hqr5VsRxO+OlNLOeBXDLiUxcAlUoWMKrbWJ2Qif0nQ7BU42xzRqICtpJpuhHZsZ7I+Ds
         XAeSSBP7jaUIV6UO9XUKDgKBI2gZ3TZ8CUgSC6bE/sUuNy9plcEeDiTvUTRfO57cwz4c
         ddk3vZRnU9rxbt5MD6Ue1QEhxnIzOO8J0n/YsaPsPobsI64kJZf3eVKtrW3DPO7n0d02
         SZ5epoEkAeFtV8rOO6Dq87WvpiXR5xE2XZw1c143L5wj+XmjFNb+idndpYC8jpDgBWRZ
         DFUg==
X-Gm-Message-State: APjAAAVD93qDRYsTylN5yY6yytrnQUMOZsAQzBJxXxYvX9ec5bTwUOFS
        Z6SI6a6wDB16pwFc11IMFNVsBGzUmxc=
X-Google-Smtp-Source: APXvYqx1IyclFiYgGhLHHI74b40MOEPFlKxc0P3OSYMRGZjxx+7aIiQpvzYwTQqGcjvmrXkqXqZ17Q==
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr10414315qvb.49.1581346924162;
        Mon, 10 Feb 2020 07:02:04 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3922:b15f:4fe8:fef? ([2001:4898:a800:1012:ea55:b15f:4fe8:fef])
        by smtp.gmail.com with ESMTPSA id n4sm274758qti.55.2020.02.10.07.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 07:02:03 -0800 (PST)
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
References: <20200207221640.46876-1-johannes@sipsolutions.net>
 <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
 <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
 <28b6fd7f-85ea-9ef1-1977-888cdd737c6d@gmail.com>
 <c077a2100038edf2b0c486c0d364bd00f3921074.camel@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08dbc3be-34a7-fb8d-e0bd-56a79ab5b65a@gmail.com>
Date:   Mon, 10 Feb 2020 10:02:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <c077a2100038edf2b0c486c0d364bd00f3921074.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2020 9:50 AM, Johannes Berg wrote:
> On Mon, 2020-02-10 at 09:46 -0500, Derrick Stolee wrote:
> 
>> Part of my initial plan was to have this incremental file format.
>> The commit-graph uses a very similar mechanism. The difference may
>> be that you likely allow multiple .midx files found by scanning the
>> pack directory, 
> 
> Right, just scan and use any midx that exist, then compare the packs in
> there against all the packs found, and then remove any packs that
> actually *are* in an midx from the search list. That leaves you with all
> information, but optimised by midx where possible.
> 
>> but I would expect something like the
>> "commit-graph-chain" file that provides an ordered list of the
>> incremental files. This can be important for deciding when to merge
>> layers or delete old files, and would be critical to the possibility
>> of converting reachability bitmaps to rely on a stable object order
>> stored in the multi-pack-index instead of pack-order.
> 
> Right, if we delete then we have to also remove any midx covering the
> deleted pack, that's pretty rare in bup as a backup tool though.
> 
>> The reason the multi-pack-index has not become incremental is that
>> VFS for Git no longer needs to write it very often. We write the
>> entire multi-pack-index during a background job that triggers once
>> per day. If we needed to write it more frequently, then the incremental
>> format would be more important to us.
> 
> So, wait, what if a new pack is created? Does it just get used in
> addition to the multi-pack-index, if it's not covered by it, like I
> described above?
> 
> If so, I guess it wouldn't actually really matter here. I was afraid
> (but didn't check yet) that git would always use only the single multi-
> pack-index file, and not also search additional packs, so that it always
> has to be maintained in "perfect order" ...

Git loads the multi-pack-index file, which includes a sorted list of
the packs it covers. It then scans the "pack" directory for pack-indexes
and checks if they are covered by the multi-pack-index. If not, then
Git will add them to the packed_git struct and use them as normal.
The hope is that this list of "uncovered" packs is small compared to
the data covered by the multi-pack-index.

This allows Git to continue functioning after an action like "git fetch"
that adds a new pack but may not want to rewrite the multi-pack-index.

Our background maintenance essentially runs these commands:

 1. git multi-pack-index write
 2. git multi-pack-index expire
 3. git multi-pack-index repack

Step 1 ensures all packs are pulled into the multi-pack-index. Step 2
deletes any pack-files whose objects are contained in newer pack-files.
Step 3 creates a new pack-file containing all objects from a set of
small pack-files (using the --batch-size=X option). This process helps
incrementally reduce the size and number of packs. That may be helpful
for your backup took, too.

Perhaps after an incremental multi-pack-index is added, then Git could
(optionally) have a mode that only checks the multi-pack-index to
avoid scanning the packs directory. It would require inserting a
multi-pack-index write into the index-pack logic so Git.

I'm not sure if that mode would be helpful, since the pack directory
scan is typically done once per command and is relatively fast.

>> That said: if someone wanted to contribute an incremental format,
>> then I would be happy to review it!
> 
> I might still get motivated to do so :-)

YOU CAN DO IT! (Did that help?)

-Stolee
