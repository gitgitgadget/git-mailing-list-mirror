Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46F4C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7698761005
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 21:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhDEVDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDEVDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 17:03:02 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20582C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 14:02:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v70so12860184qkb.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ajqXOiBoujgPPQ3WVFXfXj3rqOMftYT1p6pDqplbKy0=;
        b=juvWSavBE714tOzqmRHp0qfLrFQc9glk2be1nURKyUfYGMlSvrQOfuYYAqrSlby6Z5
         ue09vFwVLXdJQIUk4uWKH8TnbG4duwv+KZrF5Y1cW+Y1bA7udtw3KSvNZB1yrGGsS4xV
         mrKgilnE2PsySqU5OS+CoRK0NDj4pWe7Ssr1vpbIYHviRrgpxy66mWmJO5TDWqgBAIEm
         Vw3EGz50zxGVm0iOpsY+xX3YY1DCRqI+yeDckKgzeHR65cZz7RYAKDP6Tmn6FyH5unK2
         gXtw2l6c5lkWER9SRAIOlf9h06S82E+Nr9HWnlSoxXiLtftowVudi0kJWqn6RWqOvdiZ
         FulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajqXOiBoujgPPQ3WVFXfXj3rqOMftYT1p6pDqplbKy0=;
        b=nbsgDnFW6rBh90L3Z22AZdflDnG1RnsPYktY+llnliyHE5SzckuIZV0bRcW7HaYqaj
         EFhw858xDhMfvDPRv/cQOPtBNa4b6v7mojIs0GOOcUeNd8RoJZ0THXpWE0Q9gzd6pJmK
         q+zUZvxCNjQCl9blTBVnSRJASpdCpJGwquBcYpOeyWxpC1BcW/dHDDeBsEmpiCi7Nd35
         DaZ+LgmcK7iJ9qxUrVOaB/E9jzcPve4DPCT8nIs/dvJsf+KlNkx4PY2icBAYMHTJBOpK
         ZCjGrKlk/Jy/+r+3My5H+bcIiFw9Wy9KSJQv4UahTnRFBJLAj18JUpiULD312P4oPt70
         Twkg==
X-Gm-Message-State: AOAM532aculLXgPr/QaHrBy1Riu07RTLcJLqbnKFgTbCIhJR6cGM/5zE
        b4jaHEXbM21UOhi44Y/gXL0=
X-Google-Smtp-Source: ABdhPJz1PbkPX/mLh9hs9qfUiMDBy9KTwTDlHks/AlX7oSL5stQQ/352VrvfgFRtcifGFBdN8IlHwQ==
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr25404023qka.103.1617656574157;
        Mon, 05 Apr 2021 14:02:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id h13sm13112258qtn.26.2021.04.05.14.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 14:02:53 -0700 (PDT)
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <50fce64e-d3f5-05e6-5e2a-645864211176@gmail.com>
Date:   Mon, 5 Apr 2021 17:02:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 10:01 AM, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf
> and error strbuf. Instead, we can provide two single strbuf:
> final_buf and error_buf that get reused for each output.

s/two single strbuf/two buffers/

> When run it 100 times:
> 
> $ git for-each-ref
> 
> on git.git :
> 
> 3.19s user
> 3.88s system
> 35% cpu
> 20.199 total
> 
> to:
> 
> 2.89s user
> 4.00s system
> 34% cpu
> 19.741 total
> 
> The performance has been slightly improved.

This is a nice amount of time! Perhaps simplify the
presentation:

  The performance for 'git for-each-ref' on the Git
  repository itself with X references changes from
  3.2 seconds to 2.9 seconds.
 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: use single strbuf for all output
>     
>     This patch learned Jeff King's optimization measures in git
>     cat-file(79ed0a5): using a single strbuf for all objects output Instead
>     of allocating a large number of small strbuf for every object.

This part of the cover letter could be put into the
commit message itself. Use the correct formatting,
though:

  This approach is similar to the one used by 79ed0a5
  (cat-file: use a single strbuf for all output, 2018-08-14)
  to speed up the cat-file builtin.

I found the code change to be correct. Thanks!
-Stolee
