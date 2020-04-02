Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA48C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 12:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E44720757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 12:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiCSlMYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgDBMmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:42:07 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46303 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgDBMmH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 08:42:07 -0400
Received: by mail-qv1-f67.google.com with SMTP id bu9so1497904qvb.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cYQMuuONHJLlshTGde8CHqoz6Wpo/C22k/nRpTruraE=;
        b=TiCSlMYhvWhAgzFylXJD+x1rOI+KTpcQiC7aReVHQNNPSzirb7FitNZW/fP/uWkT7p
         GzZeARSz9yWlzRwWDMq5KCbIDdVcyHss7BMMjO4vI/IxUlE4fqdeKg0TDc7lcuowXq5X
         GJgIFRKzz87uUeFs4hzEhPc531aBRu3gFLYNOjavYxULrt0bhlhHuIeWRd2i2PZLE/+k
         u6DwFsBg8hr4RFzBkuDLMNIMvPxgm4hEq+T3nhMXt7UNX9TeL4cFGp2InOu0VK0+we2f
         Ev96OVO3Ut8nYQTlKWZM8ZD8PjXCO9A88+qcnZPtGnitXgPKomzN/bZkUeHS//54M+i2
         LUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYQMuuONHJLlshTGde8CHqoz6Wpo/C22k/nRpTruraE=;
        b=bPl3505b8VjnVu/WqUhHkD6nHfjmqRpEfng37Ep5CDL3bOK6pZN9f3ApUlrXnjQ2Y2
         2t3sd7DXxPVQnleYLDFk1CONXH+EfcFPYMXe5dPBUxiRyWQ+3kkOhaUQOJYjxDeRWrhX
         yLNpH3jjkZi3FrZ1EtPBCfaSzlD+68w9aNvdLqPq8LIlj6XZeRtTMYm4FLu1NBZYslEK
         aOvlVob39i+j0dwfQSf9RnMy9F+PHB7dT4/8jcCCMU6p7RjDFFzmSFUsYZTYFav+b5NZ
         iBE/LiLWz7IVDCHOwqPgrw/bDTf3AFlMVWV3Ff6TqOzj+iKeUR9kd64VZos7jPQKgUgw
         WNPA==
X-Gm-Message-State: AGi0PuaCcBhsp0VfMjmeVH4XpDGsU4PRPT1ZYCkjCH8QXMVI0mKe322Q
        ZrByCb4xoBpC4Z/ibFWSX97rtekm
X-Google-Smtp-Source: APiQypJhM4mxozQx1+Nfff3clePYpyAf2+hO6d4KHNIa7ONG4V8m4I4wYAoP1SiEXhVHuMN8mC4iaQ==
X-Received: by 2002:ad4:496b:: with SMTP id p11mr2963632qvy.202.1585831326052;
        Thu, 02 Apr 2020 05:42:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:b00:7980:4998:ad38:3313:aa07? ([2600:1700:b00:7980:4998:ad38:3313:aa07])
        by smtp.gmail.com with ESMTPSA id z16sm379803qkz.112.2020.04.02.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:42:05 -0700 (PDT)
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <eb588d3b-eec4-b904-82ed-80b228387726@gmail.com>
Date:   Thu, 2 Apr 2020 08:42:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2020 7:04 PM, Junio C Hamano wrote:
>
> --------------------------------------------------
> [Stalled]
> 
> * gs/commit-graph-path-filter (2020-03-30) 16 commits
>  - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>  - t4216: add end to end tests for git log with Bloom filters
>  - revision.c: add trace2 stats around Bloom filter usage
>  - revision.c: use Bloom filters to speed up path based revision walks
>  - commit-graph: add --changed-paths option to write subcommand
>  - commit-graph: reuse existing Bloom filters during write
>  - commit-graph: write Bloom filters to commit graph file
>  - diff: skip batch object download when possible
>  - commit-graph: examine commits by generation number
>  - commit-graph: examine changed-path objects in pack order
>  - commit-graph: compute Bloom filters for changed paths
>  - diff: halt tree-diff early after max_changes
>  - bloom.c: core Bloom filter implementation for changed paths.
>  - bloom.c: introduce core Bloom filter constructs
>  - bloom.c: add the murmur3 hash implementation
>  - commit-graph: define and use MAX_NUM_CHUNKS
> 
>  Introduce an extension to the commit-graph to make it efficient to
>  check for the paths that were modified at each commit using Bloom
>  filters.
> 
>  Expecting a reroll.
>  cf. <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com>
>  Breakage due to byte-order dependency reported.
> 

Hey Junio!

I sent out v3 of this series on the 29th of March. 

See: 
https://public-inbox.org/git/pull.497.v3.git.1585528298.gitgitgadget@gmail.com/T/#u
and
https://public-inbox.org/git/6b61fec4-3334-8bfc-d4b8-3921e35cf6a6@gmail.com/

The sequence of commits you have here is actually the updated version and I 
see it getting picked up in 'pu' as well. 
However, the series is still marked as 'Stalled'. 

Shouldn't this be in the 'Cooking' section with an updated description
now that it has been rerolled? 

Again, Thanks for the patience and letting this bake in pu. 

Hope you and everyone on here is staying safe and healthy in 
these trying times.

Cheers,
Garima Singh


