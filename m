Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74290C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DAD206C0
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHvkHHPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgDHP26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:28:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45187 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDHP26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 11:28:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id m67so433355qke.12
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3M4OBtlZU4K96qMCFiU8UNlKTEVA3wIXd5atAGB9eM=;
        b=SHvkHHPb0tFrD11XpOpT9EkPpWuNVaE1beFVyMsID8iQVe/eBZwwfv49otqd0EnROt
         3ObIJlGXAd4daDVl5luSPgJtWoben0I/i0QzX8W0CZdttcSs93yaK1yP3ZRsuH7JJTLO
         s2kBVLtcDQ987MZLfeE/KRp+B92oPCz5OsDJgGZ0m7Io3ucFUW5k9bDrwY5bBaZ2cETg
         mNqtgeADX8rcLbo8S5KdXYstKLhMbZ+RnkOFiwvVKmi8FHsuuLYEyLtoEora0nttk3Zw
         MOmVMyV0qE2GOnONC7SINYB/wuzybuKkuXvWJ1FoEinbtEjo40aP44j62PE9KpXhjYsE
         viKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3M4OBtlZU4K96qMCFiU8UNlKTEVA3wIXd5atAGB9eM=;
        b=YVKe+WgE23ngBLsw+kSx0MeLI407e3Enwt8zMJVErYR3zI9Qxm0CCg/ppSrt/QAsio
         kO5bPgBhjJ2kZVB7nxpWUtR+uwhr25FeX/pyPLAyZ/yEzmObWijPzfJZJ41H0gRhBPw5
         85LLi3ju7xt/3IgYnvgRTimHC05sY3QfXf49oRC2UmBGLKuweV1mK5NOBlN7CWR5G0yc
         /+bsJsrl6KXXQJeZ/k85iRZ2vko2MV07i4ZDsLphqM7B/GaVvH6L7WRjKxCMxq3svE4W
         8je3/oTKW9NEYm/2t4RC5LPeLfWbXxWQVlAT51+ZfQl1udWVAd2LPVWII7kk/kYQih+T
         pG+g==
X-Gm-Message-State: AGi0PuY3J+fzv63awTp00tdN1Y3UGbxH6tYVkRDNOwI0PGQlOxf/S0mu
        n9mJ9St8BbqjDuHvlGuH/mw=
X-Google-Smtp-Source: APiQypJrHpI+vzGV7EUfFTroUMjJBRp160ZGMJ4Dp2tk0+NpZ6w2BvClQGl0Hd3uJcwegCog1TsduA==
X-Received: by 2002:a37:67c8:: with SMTP id b191mr7806913qkc.166.1586359736096;
        Wed, 08 Apr 2020 08:28:56 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d189sm9960772qkf.118.2020.04.08.08.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 08:28:55 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
Message-ID: <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
Date:   Wed, 8 Apr 2020 11:28:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2020 9:39 PM, Derrick Stolee wrote:
> On 4/7/2020 9:30 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>     This --include-diversions option could use a better name.
>>
>> True, but I do not think of a better (or for that matter a worse)
>> one.  

Here are some alternative names:

	--audit-merges
	--audit-trunk
	--first-merges
	--subtle-merges
	--more-merges

The "audit" name implies some of the intent: we are trying to
audit which merge commits introduced these changes. The --audit-trunk
implies we are using a trunk-based workflow where parent order is
critical. However, "trunk" may be confusing when there are multiple
long-lived branches.

A "first merge" is confusing when we see a sequence of multiple
diversion merges (I include a test with this exact situation in
my next version.)

"subtle" is a bit wishy-washy.

"--more-merges" is not very specific. The way we are adding
merges to the final result may not be the only way we want to
add "more" merges in the future.

So, I think "--audit-merges" is the best of these alternatives.
I'd be happy to be overruled with a different option. Hopefully,
these options inspire better ideas from the community.

>> As a new feature, I think this is a reasonable thing to want,
>> especially it is in line with the push in the past few years to
>> treat the first parent history specially.
>>
>> I wonder how this would interact with the ancestry-path option?
>> That one also, like the simplify-merges option, needs a limited
>> traversal, and if this new mode can do without a limited traversal
>> (in other words, the output can be done incrementally from the tip)
>> and achieve something similar to what these other options wanted to
>> show, that would be great.
> 
> You're right. I briefly considered the --ancestry-path option before
> realizing that would get a huge set of commits (for example: every
> topic based on the branch after the pull request was merged).
> 
> The --include-diversions works incrementally like simplified merges.
> Based on the implementation, it would not change the results when
> added to a --full-history query. This makes sense: a diversion would
> appear in the --full-history results, anyway.
> 
> It is worth adding tests for the combination with --ancestry-path
> and --simplify-merges, as the --include-diversions option would
> add results to those queries.

My gitgitgadget PR [1] is updated with tests and some new logic to
handle the new option along with --simplify-merges. The situation was
a bit subtle, so my next version will include a significant update to
the rev-list documentation under the "History Simplification" mode.

I'll give things some time to calm on the name of the option before
sending a v2.

My v2 also includes adding a new object flag "DIVERSION" to track
these commits from the TREESAME calculation through the simplify-merges
logic. When I was adding a new flag, I realized that I already
messed up the 32-bit alignment of "struct object" when adding the
TOPO_ORDER flags. The parsed, type, and flags bitfields add up to
33 bits!

A solution would include pulling the TOPO_ORDER_* flags to be bits
22 and 23 instead of 26 and 27, but that would collide with what is
happening in builtin/show-branch.c. But then I saw the following
comment in builtin/show-branch.c:

/*
 * TODO: convert this use of commit->object.flags to commit-slab
 * instead to store a pointer to ref name directly. Then use the same
 * UNINTERESTING definition from revision.h here.
 */

Is anyone interested in tackling this problem? I don't see any
test failures when I swap the TOPO_ORDER_ flag locations, but
that might just mean that show-branch isn't tested enough.

Thanks,
-Stolee

[1] https://github.com/gitgitgadget/git/pull/599
