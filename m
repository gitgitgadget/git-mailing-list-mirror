Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D05CC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378066AbiATWqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiATWqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:46:06 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE965C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:46:05 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e8so6230201ilm.13
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NkGJ2RdS02GksxD9ItncU5ZEWvK78se24OQPbMemh/Y=;
        b=AHUWGuuB2uTcg4GMpuaGlEVlP2iCVZtGAwSSVUly0JA4HBV1un4mO+8qD/1vzrn+fo
         bH7Cqf8UyZ6bDGQvDaNS8Yi0RgVQgmU5sUDy18zkzEWumLXpVl+jIr38syLHexEdDqKO
         5UCE7KvzVnPdpdSkcWl0hCRUKRI2YN7ba0A08IaBrjmiQfavf84z1LfW5DLpqfBbOGkC
         /knH0YFm4v4PfW66lwe2/hzlPfzKlq3RlDvjTxBmYk8c7qR0kEzqyElLPfoDd84m8Po1
         e81Z1YwMKd9LTJXWrQEZcScdSRehLgzFYmaZxhtn3148tvlW6OKhyW5MO839PLb4ISzM
         bPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkGJ2RdS02GksxD9ItncU5ZEWvK78se24OQPbMemh/Y=;
        b=mnoouVcUhNZmD0WEuiCyLWRXO3yX8W0PUtJYJ2q0bAfVo9a4PSPKzwCwAURWVVNxND
         1Dr2Op/dcS0khUgNOmWP0B+JDD5c8FaHFjF136G3tg4p2k1fB08WVscq7it0OtOxz0kU
         C/Vz3sCEcoCSZgJ4rjvqrLkNLDTzVFvf4kKH4G6fg7Wpgx2BnE2+jThB1y8WBPd2S2hN
         8MPHwYlMGNgY2JWXMdmFfayyyUvmVh3yYMd5CtG3cnkV24FKRyxjUxH4eSiuQL8rvtm5
         tBlp+V+DFzafTtFd5X115UR8H7wzbhZ/CGo6836nQX4q6b6u0rsb6boxHrEs78zEbLyp
         3+KQ==
X-Gm-Message-State: AOAM533KOyd1wpZx4FMz5KWAoOhl2FSJXRNY8bJ90JBVRofH4xzD71Ci
        KE6yzC1da85nQX78Z25pDmN9iw==
X-Google-Smtp-Source: ABdhPJydLxR/IsGUtXgELS+ppdPlaDg4YQRQsz1rP75Wk/ZQv2VbDuITHe8q85hGjMyOCtjG9plaQg==
X-Received: by 2002:a05:6e02:1a2f:: with SMTP id g15mr663782ile.85.1642718765376;
        Thu, 20 Jan 2022 14:46:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y3sm327557iov.29.2022.01.20.14.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:46:05 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:46:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after
 permutation
Message-ID: <YenmLJ9yvG0sdxoV@nand.local>
References: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
 <20220120175541.3099054-1-jonathantanmy@google.com>
 <YeneJrzjp160edGG@nand.local>
 <xmqq5yqeghck.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yqeghck.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 02:41:47PM -0800, Junio C Hamano wrote:
> Am I on the same page as you two?

Yes, exactly.

Thanks,
Taylor
