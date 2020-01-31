Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB6EC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51D20707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ8ff+pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgAaNWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:22:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38226 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgAaNWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 08:22:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so5354902qtp.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nje7vHSa1T7zZDr5ofveUaDWB0EoZrhVi7/3CQLMqEU=;
        b=UZ8ff+pSenVeIwxoMOBK8zMM31LutzP78jZoSXhK9EUyJZZt1nv9TrKv4V/lOgHkiS
         peagYVAFxQ/ASs1u8rIBLdo6lCV5m9Oa/KoLjD4jiBFWO/RJtEGHD6rLxSdeIU0TRqcq
         YSUJ3g8eb4G6JcsD/zvtv1sezk4WtShkxd9uj0Wm/NerUZUh6nvFCVpekV9Ybh5RaVVz
         gOU7DoJEX1foi3nDYY7oMrMikXnd3K2vqF32nJhuJ5pNvJe6GdrWAmvVH761Y+z43OE+
         CDYPNirss5peed1LcicqrSEsqjk01ytPa99IdMRBag0Gao8agcXXYT16gdXRxPNovTKY
         Qg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nje7vHSa1T7zZDr5ofveUaDWB0EoZrhVi7/3CQLMqEU=;
        b=Ot0XLmE67StPKo6gj3Yjj2dGxGJrTBNayAI/VMmLykezxWz+VumwG9M8bqdyw/sAon
         +aFR1BrzuNPqFFaxJ8GjuPJHULc5d/IthgJ/M34MJY9VdPwKvCKLhVIUkHZN0+e4hSsJ
         1wrvmsMy4F2BohF2pUoFmYXPbOQ502rLR1f8Z9tKQMIgDqbHjV6OKTYBZNvjSealxzNK
         g7vAKIJF8H8VkwhT5BqWdIx76hbv/1z9tUA49LDBE8pcJ7yfZfbRKxAXufUGhOV8lkW+
         HdcW/BMmupxZdbu4SBHI3qOwRHnzoECX6LHCCLPX4H9Sa1HADGhYcNGtufB0GrEDiAvX
         ooEw==
X-Gm-Message-State: APjAAAXMlyQhnm7qCjzmydN98T2Kc4SPp2ZPR6V0YjJ0zyvqrBaOfSpC
        jhBc4tY2P/PxomwDzLl9CCU=
X-Google-Smtp-Source: APXvYqzKNRlwHHMWZFDidcu7vE8sYAJTFDt53gHjoyT2ijtfgEK/P0NHMOSqvtXNMDYZByqHMCF2QA==
X-Received: by 2002:ac8:38c7:: with SMTP id g7mr10422537qtc.229.1580476963438;
        Fri, 31 Jan 2020 05:22:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1012:9328:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id k62sm4405382qkc.95.2020.01.31.05.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:22:42 -0800 (PST)
Subject: Re: [PATCH 0/6] commit-graph: use 'struct object_directory *'
 everywhere
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
References: <cover.1580424766.git.me@ttaylorr.com>
 <20200131103008.GD2916051@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60a4d129-c6a9-1e5f-a467-7db0babbcffa@gmail.com>
Date:   Fri, 31 Jan 2020 08:22:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200131103008.GD2916051@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/2020 5:30 AM, Jeff King wrote:
> On Thu, Jan 30, 2020 at 03:00:40PM -0800, Taylor Blau wrote:
> 
>> This series became a little bit longer than I was expecting it to be, so
>> here is the high-level structure:
>>
>>   - 1/6 fixes a bug in a test that would cause a subsequent failure if
>>     unaddressed.
>>
>>   - 2/6 does the first half of the removal by using 'struct
>>     object_directory *'s within the 'commit_graph' structure.
>>
>>   - 4/6 does the second half by removing 'char *object_dir' usage in the
>>     'write_commit_graph_context' structure.
>>
>>   - 5/6 ties 2/6 and 4/6 together by removing all path normalization
>>     completely, fixing the uninitialized read bug.
>>
>>   - And 6/6 cleans up.
> 
> With the exception of the patch-ordering discussion in the sub-thread
> with Martin, this looks good to me.

I agree. Martin's comment is a good one. I can't find anything else
to improve the series.

> Patch 3 is a change in user-visible behavior, as it restricts how
> --object-dir can be used (it must be the main object-dir or an alternate
> within the repository). I don't _think_ anybody would care, as the
> semantics of those options seemed kind of ill-defined to me in the first
> place. But it's worth calling out as a potential risk. I suppose the
> alternative is to make a one-off fake "struct object_directory" within
> the process that isn't connected to the repository. But if nobody cares,
> I'd just as soon avoid that.

I think that this change of behavior is fine, especially because if
someone writes a commit-graph to an --object-dir that is not an
alternate, then that repo will not discover the new commit-graph
anyway.

I do like that you state a possible work-around in case someone shows
up with a legitimate use case for a non-alternate object-dir.

Thanks,
-Stolee

