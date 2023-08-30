Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D08EC83F1A
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjH3S3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbjH3NYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C65137
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 06:24:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so557284f8f.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693401853; x=1694006653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4011Ml3jx5TvPLmvCNglPhH5uoD02Cmeq/JtGwgGRbQ=;
        b=KtiIsTPDcvlFCNg4cWBxT53SVqxos8ttJ2cniWY3Z2d47K9QPKVeBKlSXOEf6bSnGn
         sKVOMijeTB1I4aBo0v4vGapvHuU8Fif5EfH7K9W/TqN9bpED8TH7otYTN9EXgVtvPiUY
         h+3sHUHDFa/1p+wlJIZLcC4M7QBVelADOpFsfsgWHw2OB+FBrtt7XHTQ+OxOYjkcsBdI
         sKmBjs18KqIgi4QSFAgYc676yQ7kYpU2davlhHZ6LOqHqo+eOz2mG6pvCxzOmZ+bgclP
         fOASjZg6/kB6ZDSUbYGJ8hKHYWtxseZpWNvUTUfkp+FawSfB2cBeGOcaivxmSTAe0pBN
         Hqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401853; x=1694006653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4011Ml3jx5TvPLmvCNglPhH5uoD02Cmeq/JtGwgGRbQ=;
        b=UvuvG/GWDGyDDY5B8E0ZZWpv0MnrKEFOUolUjX334gTLx32ls7cstbBr0FRD44rZP/
         qdcBDHrA+mZvyntN3qxO7dKpLA4jrx9vtQ/fvOa8JPUIwObGOlj6Am2DDdwHH5guds/U
         8bjtEV3A5t89P509g1YC65IWnalacNjAbObwCF1NLhq3EVtprOqe9mCYG4oCAlKufYIY
         G5uYxfixUfBHzHIK4pk0norXmfRmGyhm/75cmzjQOIQXmPIZdXCBg913VQ3SdpQPB78g
         CT2CoyCa3ddC4S/V70gB/dmzr5tqcXueEL5LyKh2v1VPwWLww9inwFktJkwf5EGWcpXh
         GSiQ==
X-Gm-Message-State: AOJu0YzOzCOyHraFVw7WVjKWNVvuyOBjmHTmEY8qdlGUXEOcKB8zYwI5
        BLM6oDAzwFkAckBA2rdr6c6gN3ps8CdUsw==
X-Google-Smtp-Source: AGHT+IGT/ZdVWWjxItMWqnxE0LxrcLuR9obqYyyZisKw16Vhq/Htw6kd27mOFXIW+OY1dxHsWqBKbQ==
X-Received: by 2002:a5d:5234:0:b0:319:6b56:94d9 with SMTP id i20-20020a5d5234000000b003196b5694d9mr1947294wra.2.1693401852640;
        Wed, 30 Aug 2023 06:24:12 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id i15-20020a5d630f000000b0031989784d96sm16743605wru.76.2023.08.30.06.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:24:12 -0700 (PDT)
Message-ID: <2ad36ef4-4bfa-4e2a-956e-a25d80ce25fd@gmail.com>
Date:   Wed, 30 Aug 2023 14:24:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/22] sequencer: use repository parameter in
 short_commit_name()
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20230829234305.GA226944@coredump.intra.peff.net>
 <20230829234339.GA227087@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230829234339.GA227087@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/2023 00:43, Jeff King wrote:
> Instead of just using the_repository, we can take a repository parameter
> from the caller. Most of them already have one, and doing so clears up a
> few -Wunused-parameter warnings. There are still a few callers which use
> the_repository, but this pushes us one small step forward to eventually
> getting rid of those.
> 
> Note that a few of these functions have a "rev_info" whose "repo"
> parameter could probably be used instead of the_repository. I'm leaving
> that for further cleanups, as it's not immediately obvious that
> revs->repo is always valid, and there's quite a bit of other possible
> refactoring here (even getting rid of some "struct repository" arguments
> in favor of revs->repo).

I think opts->revs is only initialized when we're building to todo list 
for cherry-picking/reverting a sequence of commits so I the scope for 
removing "struct repository" arguments is pretty limited as any function 
that is called by "cherry-pick --continue" or rebase needs a separate 
repository argument. I'm pretty sure your v1 was safe but this version 
is much more obviously safe.

Best Wishes

Phillip

