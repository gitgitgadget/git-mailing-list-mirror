Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED39C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiFNPhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiFNPhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:37:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81C60C9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:37:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d123so9753757iof.10
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rp3Zdes41npNr8QJGomMDAIIssmWOrfisS6VSMQs+rY=;
        b=TVCFD1tvqUTGUTpC/i9e6mPbtXZUiVb3AKJOMwo8pPrl09TqlAhJXCgurmScmLBJ8w
         xEDJ/7wEfaTv3dRH4tDyrNhrBv9S1cf2m5+ppCruwGZGPzMWLZJmJQPj1jhGgZp0dtZx
         4BTXNoidtYXLrtzCvlP0GYlyIf9yxw8L+w0mXVGuyF9OtFN1r6pbh7He9CBP3fot21Ab
         NTYgOWhT4RqaM3mNqLlTD5EBeAtjyuL7dSqrT91aHFvDwXWWagpHIEOVdDXqrRwnyidp
         UOfmvBQQXzQJAPl9hNVQJax63KADj8yT1i7x4ZBtLtQ04zgb63s220Qufv0Q48RT5jjI
         7ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rp3Zdes41npNr8QJGomMDAIIssmWOrfisS6VSMQs+rY=;
        b=ROKeY7mY/2DpFBhJcHfgRPpopcTNjcuG5X7wrij4CmWPl3fu6kyJU7V4gJZ2myJHKG
         OtWTNv6Rn/SNOsmtse0EGrr60dajFLoR2l3Wm9cBv7vsBaiXD/NOfvNKS9Q3/wfXL87e
         ycVs7Tvop8cfJG//Uot8NIzI041DQ5M3bSkx1R2CPC+DvJJ6vgEuCa+nBy8CypPLE2Qs
         PAYDh0ySfN3nWqTFLfONWX5+L/IZO4NQ4JfHb0lr5AU2APfgSl4ntSKd1jKBoblb1ius
         nQXZi1K7xuNdO3o/kxFMAEyA6iyeMFYKMsf4X/Cu/KNBWiSGx3jOsY5fopkgbaxHwwEV
         G4Og==
X-Gm-Message-State: AOAM533iZv6UEEVBYeC8GWte2Slyft0IC12rG2SHlYXoaiKa4nROQ4oj
        lsTk62dSYMZX38HI+RLJnzFt
X-Google-Smtp-Source: ABdhPJz8Nho+rZmUHDvkk5YWSv69KIM3lCm6yXbGD0/aj3nDUFEKG4TYN+qyj+PIaIc6zLTEVpuQ8Q==
X-Received: by 2002:a05:6638:3787:b0:331:aaf5:950c with SMTP id w7-20020a056638378700b00331aaf5950cmr3325692jal.118.1655221049208;
        Tue, 14 Jun 2022 08:37:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id b80-20020a6bb253000000b0066958ec56d9sm5581996iof.40.2022.06.14.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:37:28 -0700 (PDT)
Message-ID: <0d00d910-a7aa-dfd8-a24c-51968800c2a8@github.com>
Date:   Tue, 14 Jun 2022 11:37:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] branch: fix branch_checked_out() leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
 <220614.868rq0ytaa.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220614.868rq0ytaa.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2022 8:33 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 13 2022, Derrick Stolee wrote:
> 
>> On 6/8/2022 4:08 PM, Derrick Stolee via GitGitGadget wrote:

>> While TEST_PASSES_SANITIZE_LEAK would be helpful to demonstrate the
>> leakage and prevent it in the future, t2407 uses helpers such as 'git
>> clone' that cause the test to fail under that mode.
> 
> If you apply this:
> 	
> 	diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> 	index 0760595337b..d41171acb83 100755
> 	--- a/t/t2407-worktree-heads.sh
> 	+++ b/t/t2407-worktree-heads.sh
> 	@@ -10,16 +10,8 @@ test_expect_success 'setup' '
> 	 		test_commit $i &&
> 	 		git branch wt-$i &&
> 	 		git worktree add wt-$i wt-$i || return 1
> 	-	done &&
> 	-
> 	-	# Create a server that updates each branch by one commit
> 	-	git clone . server &&
> 	-	git remote add server ./server &&
> 	-	for i in 1 2 3 4
> 	-	do
> 	-		git -C server checkout wt-$i &&
> 	-		test_commit -C server A-$i || return 1
> 	 	done
> 	+
> 	 '
> 	 
> 	 test_expect_success 'refuse to overwrite: checked out in worktree' '
> 
> And compile with SANITIZE=leak then this will pass as:
> 
> 	./t2407-worktree-heads.sh  --run=1,6

Of course this works for the tests that don't need the 'server' repo,
but it fails in the tests that _do_ need it.

I'm able to make this work by creating the 'server' with init and
creating the wt-$i branches from scratch (they don't need to be
fast-forward updates).

The linux-leaks tests still fail due to 'git fetch' and 'git bisect'
calls, but these can be avoided by carefully splitting the tests and
using the !SANITIZE_LEAK prereq.

> Normally I'd just say "let's leave it for later", but in this case the
> entire point of the commit and the relatively lengthy test is to deal
> with a memory leak, so just copy/pasting the few lines of setup you
> actually need to a new test & testing with SANITIZE=leak seems worth the
> effort in this case.

Well, the point isn't to use automation to check for leaks, but instead
to fix leaks and add tests for the case where we previously had leaks.
The tests demonstrate that we aren't accidentally introducing a use-after-
free or double-free.

Thanks,
-Stolee
