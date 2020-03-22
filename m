Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3151C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33BE2072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toBrKzjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCVQpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:45:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34264 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 12:45:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so9629433qtp.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lJFMbLMoyQHFLBCuoL+AdMeUFfQCuoSpLsF6wo5ACm8=;
        b=toBrKzjyF9lQ59D3h7+KNSi9qasrHIC8sgU9KWDaYT1kNa38uFZ3zMeKkCQgGzqLpE
         wcodZhiT+CGvXT2jL+6YfP4LAf7geGIz1euLoiFBuhGU/IMjO5yaP4r8k7ZGmmOVnmi3
         qsPKiu5C7KZhUMJR0TNQw9r+EcVP58PuH8HjVA8iyC+/4suFCwsa5IEsr5Csd/IJSqE+
         U8R5f8GfKbIxwZzReIrxIH37sdXHP5Gv7JOQSI/+0VAgMsfa3E/qmqiySZPXP455u+zv
         dJJp+4riSI94AKE+X3uesRBdfSBCfKn5h4dRkNHg1R0PQxp8hg2jJLrNZhiTskVRU6Ee
         hppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lJFMbLMoyQHFLBCuoL+AdMeUFfQCuoSpLsF6wo5ACm8=;
        b=bCWcf+sDwB0gQUo7o2YHibZzoled5LGzExnUK0rNDKn2XBu06MC4UGs0B4hKWkPXC2
         Grg16PdQuqYcN11Vll6JUf3fofkRpFaFZdB369k2lH6t7wLo3dB4N4iNkXsudIn97YNh
         b3Tu7CBH2HdS4IBSj39Bl4fDQ0+/i34SANOlGK7K6PGeRpNQgITnDcvlWPTPvlBdLjgV
         9jIqKUkVv0R/ou105GMBi8FGZXZcZ3if+eJnY17pl3hGR02PviPxgWSwyRtewwteC5qs
         hyDB3vZv8Z86uDRkObQXCAxJ6IkIDEH4N/Lx5T0W/Wl60DzHCPsAmM8sz9IfwNZzlm2D
         kyqA==
X-Gm-Message-State: ANhLgQ0qdc3sYlVynCAdZ6ruPc2dUD/HlE7R5an16mnFJ6FV814ejvBy
        JMVNMTEMruWHNONqS7E2+Ls=
X-Google-Smtp-Source: ADFU+vuoQutoYxOkeT23xPq+QVDsMPoOim7Hyi2n/xpvnlX7N3AanJKnqnuqcIM5L2v09N8pEfsPGQ==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr13183494qtq.78.1584895531584;
        Sun, 22 Mar 2020 09:45:31 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r207sm8807380qke.136.2020.03.22.09.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 09:45:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <20200322095137.GB635598@coredump.intra.peff.net>
 <CAP8UFD1mCXvcfUQxY4uMEPEjZp8+yPwu6SgTmZBEH6GR=8ixSA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5baf9f4c-9ce0-0384-1113-431038c2a646@gmail.com>
Date:   Sun, 22 Mar 2020 12:45:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1mCXvcfUQxY4uMEPEjZp8+yPwu6SgTmZBEH6GR=8ixSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/2020 6:58 AM, Christian Couder wrote:
> On Sun, Mar 22, 2020 at 10:51 AM Jeff King <peff@peff.net> wrote:
>>
>> On Thu, Mar 19, 2020 at 05:28:05PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>> This was something discussed briefly at the contributor summit: users will
>>> have a hard time remembering git clone --filter=blob:none <url>. This series
>>> simply adds a --partial option that is equivalent to --filter=blob:none,
>>> with the ability to specify a size using --partial=<size> that is equivalent
>>> to --filter=blob:limit=<size>.
>>
>> I have mixed feelings on this. I do like making things less arcane for
>> users. But are we locking in a behavior for --partial that we might not
>> want to live with forever? I.e., the current thinking for partial clones
>> is to fetch no blobs at all, get all commits and trees, apply sparse
>> filters, and then fault in the blobs we need. But imagine we later grow
>> the ability to easily avoid fetching all of the trees. Would we regret
>> having the simple name "--partial" taken?
> 
> I agree with that. Something like "--filter-blobs" for
> "--filter=blob:none" and perhaps "--filter-blobs=<size>" for
> "--filter=blob:limit=<size>" might be worth it though.

Thanks for the perspective on this. The --filter-blobs[=<size>] should
be less likely to collide with an alternative definition of "partial".

While we are thinking in this space, what if we had a "partial-clone"
builtin? It could be a light wrapper around "git clone" where

  git partial-clone [--limit=<size>] [options] <url> [<dir>]

would do the same thing as

  git clone --filter=blob:[none|limit=<size>] [options] <url> [<dir>]

Just spit-balling here.

In the meantime, I'll work to adjust my patches to only be the
documentation of the --filter option.

Thanks,
-Stolee
