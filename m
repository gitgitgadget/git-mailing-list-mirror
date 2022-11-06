Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF7BC4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 22:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKFWW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKFWWY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 17:22:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17F8FACB
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 14:22:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so13778944wrt.11
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j3L80VlGSujy8DS1CsjTm4eVEX3W45WmBraq/t9gSE=;
        b=RP/QCbn36f0PYC4QKUbcDMZySl2AQHzwy9xy6C5NoWdQtPWpeP/k6zWsAgqIgMTTdM
         OwDCUo1U4P6qjp4oFouh1e5ZnFzhsLbkZfIk6+FyLnTZzMG/RSvabVBXNKyJRj1Lfmpn
         xUGPdJVCYcpuNArkydk7f2Nv/OdKitAD2jm5hpSnjOxzFvg3ZznKbiLEPn8pNoP/AssQ
         UprbqSLOmcvqrmwOWa79AjaIzqLBsPAXNgTwEutTXME4dLuhncmJIoTpmYHKxzGoIHfK
         8e2X0BGvwSmCCBGff/+BV3lrJM/pYX7NzweWKQjVvZ6VUaZ9zJI55Y/hA8bhzWzF6NXg
         zj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1j3L80VlGSujy8DS1CsjTm4eVEX3W45WmBraq/t9gSE=;
        b=Gov4G3Wxx+RTE2U2n6jsHwheH3VexRnRj/hNOM/s3Z5X/39q0y3KGTVI7a71CQv42y
         dH9yKIKHT/Sz6Q0hacLhQqUEFmjI4bztxnX7FjmolwYdJdxLv8F0C3cmJpSQuVEfvntE
         3to5rvLaAcKYpLfs5Em+62DXwgF1y9Ppj1VfFd/REUE75DXbCHSIrfDZT3eHzdFOZIH+
         fiAVaRKHC55rSi8bB1fpbmqj4P8IIpXaCXeNsVkvotnfOU8cE+fYz2EB0fSjvj9AuYN5
         vcsaoF8VSUl31gHTnHCxiVccRY/CZCk1dQROdHCz7xkezf6l19gA7niAq4zh7m9p7sH9
         Sccw==
X-Gm-Message-State: ACrzQf0ugmvWw+K5q2p2MPHWRz+sym5vO4ctRRvDlCals7DNtPhmDtVQ
        iCuXAeALo0gicyU6MjBngjI=
X-Google-Smtp-Source: AMsMyM4/j12zFVjOISpuF3CjPRjrvlJTJBgtzFAur2WKALXLGCQl7zRWWc7jLo27cc9t6Uw98vS5MQ==
X-Received: by 2002:a5d:4008:0:b0:235:a4c4:97c2 with SMTP id n8-20020a5d4008000000b00235a4c497c2mr30176412wrp.295.1667773342081;
        Sun, 06 Nov 2022 14:22:22 -0800 (PST)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a6125562e1sm6560637wms.46.2022.11.06.14.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 14:22:21 -0800 (PST)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH v2] branch: gracefully handle '-d' on orphan HEAD
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Martin von Zweigbergk <martinvonz@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <Y2F9lkCWf/2rjT2E@nand.local>
 <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
 <Y2H/1S3G+KeeEN/l@coredump.intra.peff.net>
 <f21bf37f-4efe-326c-0090-d13ed54696b9@gmail.com>
 <Y2SkxJAnjOtwKX6o@coredump.intra.peff.net>
Message-ID: <a42f2d94-d727-fd99-1116-593dd3814a88@gmail.com>
Date:   Sun, 6 Nov 2022 23:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y2SkxJAnjOtwKX6o@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/22 6:36, Jeff King wrote:

> I didn't find any instances, either, but I also didn't look. My
> reasoning was mostly that by making the change to this code in
> isolation, we could be sure not to have accidental effects in other
> code. Now it _could_ be useful to handle NULL in those other call-sites,
> but I didn't want making a judgement on that to hold up this fix.
> 
>> The segfault possibility was introduced in 6cc017431 (commit-reach: use
>> can_all_from_reach, 2018-07-20).  Before that, NULL was tolerated by
>> is_descendant_of (and indirectly by in_merge_bases) and returned, still today
>> (as you described in your message) as 1.  So IMHO we can safely put a check for
>> NULL there and return 1, as a fix (or protection) for this segfault.  Something
>> like:
> 
> Yes, the segfault possibility was introduced there. But that doesn't
> mean the code intended to handle a NULL commit in that case. I think it
> ends up doing the right thing, but the behavior is a little
> questionable. It actually sees an error from repo_parse_commit(), and
> then aborts the whole in_merge_bases_many() operation (not even looking
> at the other entries in the "reference" array, although in this caller
> it will always be the only element of the array).
> 
> So I find it too hard to blame 6cc017431 here; I don't think
> is_descendant_of() ever intended to handle NULL, and it was just luck
> that it did before then.
> 
> So a fix there might be OK, but...
> 
>> diff --git a/commit-reach.c b/commit-reach.c
>> index c226ee3da4..246eaf093d 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -445,7 +445,7 @@ int repo_is_descendant_of(struct repository *r,
>>                           struct commit *commit,
>>                           struct commit_list *with_commit)
>>  {
>> -       if (!with_commit)
>> +       if (!with_commit || !commit)
>>                 return 1;
>>  
>>         if (generation_numbers_enabled(the_repository)) {
>>
>> and leave the checks for NULL in branch.c, as optimizations.
> 
> I don't think that does the right thing. We are asking if "commit" is a
> descendant of any element in "with_commit". If "with_commit" is empty,
> we say "yes" by returning 1.  But if there is no "commit", is the answer
> also "yes"? It seems like it should be "no", returning 0.

Correct.  I'm sorry :-/, I meant 0.  My reasoning was to maintain, for NULL
commit, the same result with or without generation_numbers_enabled.  Nothing to
blame on 6cc017431, as nothing states that repo_is_descendant_of needs to
support a NULL commit; but as generation_numbers is not enabled by default, it
is easy to leave that aside if only checked with defaults.  But of course, your
change and 0cc017431 are correct, and your tests cover both execution paths, so
nothing needs to be changed.

>> This patch also /fixes/ the error message when:
>>
>> 	$ git init -b initial
>> 	$ git branch -d initial
>> 	fatal: Couldn't look up commit object for HEAD
>>
>> Now we get the much clear:
>>
>> 	error: Cannot delete branch 'initial' checked out at ...
> 
> OK, good. That surprised me at first, because the check in
> branch_checked_out() doesn't use the same head_rev variable. But it is
> just the case that the die() I removed was aborting much earlier, and
> now we get far enough to do the right message. The distinction is
> relevant because it means that I didn't miss a spot where I should have
> checked the behavior of NULL head_rev; the head_rev value is not used
> directly here.

My comment was just to suggest that maybe it is worth adding a test for this :-)
If you think it is, maybe this can be useful:

----- 8< -----

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..2c1c16cc17 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -315,6 +315,13 @@ test_expect_success 'git branch -d on orphan HEAD (unmerged, graph)' '
 	grep "not fully merged" err
 '
 
+test_expect_success 'git branch -d orphan error message' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_must_fail git branch -d orphan 2>err &&
+	grep "checked out at" err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
----- >8 -----

> 
> -Peff
> 

Sorry for the noise.

Un saludo.
Rubén.
