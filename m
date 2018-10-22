Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174191F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJVKHi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 06:07:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37074 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJVKHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 06:07:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id x8-v6so24401269qka.4
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g+px8ytR+uvFqHTjbObL1LS95HpXI5VtZdqADjH0p0c=;
        b=N9/QwICGCGbgCtqVMhzEeTdR3uXUIoyRwU6e1gFTz22lIhp0jOCASmj/d3106P3GXM
         PjDnwNAlpmip4uyvSRbXcer5CrwkOYzRJqUXmkdrPIjJJTyrZh11qGCJJZmg9K5JKLbc
         dt7OUj4dUxZreIKF7fyT/cvZU0zf0Jafa1axMb+Np/XDl0BpQcMhU+XnTjBdeohmmyDQ
         G7oj7MNXv37cL5E7axWvQ8LCWhdOvoFdpnPhgjQr1W2/O0IfZv5djQ9W10o3/pYOLM/V
         e//BSU+uAFrao2jym+jACFLcrz0ikLG2bc6UIT5W85zaQ/rx7x0MS7RVo3824p3pjyMf
         DEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g+px8ytR+uvFqHTjbObL1LS95HpXI5VtZdqADjH0p0c=;
        b=pPttsJmXrDTWBpmWjeT65gUJNNDtQalEhG/xqsjfSZ5IHTZUB622swaakUmcG8kY6p
         1kykd9/WtTOdi/nYrrvmvMOtw88sIjsVygzNmo0rSvkcybgpClgiS8d5xTqnlWedOYAz
         cM7C70irMxbyRXIKe02vfU22lGwx9neFHv6GttevRo+diBRwqP6NdFwU5MivOqjbKD0+
         JfB4XzhXaRRliHU5KK/saBsUgfN/TUl6h8rLgqxxP60jQkWHC6tND4yEYRklAwFxhNIO
         C7OQjpEMM2OQElbZ7Ua7/nu/Q/2GqU9WgkftHUz/d2f+sDTwfhbnkT/GlxDFoi71dASx
         Y4ZA==
X-Gm-Message-State: ABuFfohiR2ezqrcS0HwRkBKY0aFe5Eqtbiv1EYHriuldsEoQsnERHtm+
        CUprKpU+/wTQyk7e24/WvUQ=
X-Google-Smtp-Source: ACcGV63YRjuczR1xlXwQJjp5zOYBm3SQBYoVXEEi1S9Kfqtmgtbm8PjsDYfOsrzzXUG3+VX34gcBGg==
X-Received: by 2002:a37:b6c5:: with SMTP id g188-v6mr40366704qkf.188.1540173073216;
        Sun, 21 Oct 2018 18:51:13 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v23-v6sm8507928qtv.65.2018.10.21.18.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 18:51:12 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
To:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
 <pull.25.v4.git.gitgitgadget@gmail.com>
 <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
 <86h8hfguqc.fsf@gmail.com> <xmqqa7n6zswl.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com>
Date:   Sun, 21 Oct 2018 21:51:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7n6zswl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/2018 9:12 PM, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> So if revs->limited is set (but not because revs->topo_order is set),
>> which means A..B queries, we will be still using the old algorithm.
>> All right, though I wonder if it could be improved in the future
>> (perhaps with the help of other graph labelling / indices than
>> generation numbers, maybe a positive-cut index).
>>
>> Do you have an idea why there is no improvement with the new code in
>> this case?
> I didn't get the impression that it would not be possible to improve
> the "--topo A..B" case by using generation numbers from this series.
> Isn't it just because the necessary code has not been written yet?
> In addition to what is needed for "--topo P1 P2 P3..." (all
> positive), limited walk needs to notice the bottom boundary and stop
> traversal.  Having generation numbers would make it slightly easier
> than without, as you know that a positive commit you have will not
> be marked UNINTERESTING due to a negative commit whose ancestors
> have not been explored, as long as that negative commit has a higher
> generation number.  But you still need to adjust the traversal logic
> to properly terminate upon hitting UNINTERESTING one, and also
> propagate the bit down the history, which is not needed at all if
> you only want to support the "positive only" case.

Actually, the code has been written, but the problem is the same as the 
performance issue when I made paint_down_to_common() use generation 
numbers: the algorithm for deciding what is in the set "reachable from A 
but not reachable from B" uses commit-date order as a heuristic to avoid 
walking the entire graph. Yes, the revision parameters specify "limited" 
in order to call "limit_list()", but it uses the same algorithm to 
determine the reachable set difference.

You can test this yourself! Run the following two commands in the Git 
repository using v2.19.1:

     time git log --topo-order -10 master >/dev/null

     time git log --topo-order -10 maint..master >/dev/null

I get 0.39s for the first call and 0.01s for the second. (Note: I 
specified "-10" to ensure we are only writing 10 commits and the output 
size does not factor into the time.) This is because the first walks the 
entire history, while the second uses the heuristic walk to identify a 
much smaller subgraph that the topo-order algorithm uses.

Just as before, by using this algorithm for the B..A case, we are adding 
an extra restriction on the algorithm: always be correct. This results 
in us walking a larger set (everything reachable from B or A with 
generation number at least the smallest generation of a commit reachable 
from only one).

I believe this can be handled by using a smarter generation number (one 
that relies on commit date as a heuristic, but still have enough 
information to guarantee topological relationships), and I've already 
started testing a few of these directions. It is possible now that we 
have concrete graph algorithms to use on real repositories. I hope to 
share a report on my findings in a couple weeks. I'll include how using 
this algorithm compares to the old algorithm in the B..A case.

Thanks,

-Stolee

