Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB4CC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhLQFTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhLQFS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:18:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F8C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:18:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so3361638eds.10
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FC/P58BPNxMQxyd6hbAy1+BTHAcYn3RwUt3hGQf3szI=;
        b=hW4tsP0S5XditEz43Jhpl1+DxOilM6jRsT8pqpTsXT9HgcB+u1KiYAHr0TAAzj/dRi
         tn2aNIU6jQ6u2tUWjQLxYDE/oxlGHFArMaMl5JLffCEpdrUWgQn/TOcn1Kkhf0uWUqBB
         dEEilj1JHVV68LPeTKUELPeIdpsLqeX5iVb5KthBoBGuQXUiPLlfja2iZQchCfOf1CLk
         v7BwhCavSFNzHgdNkxnjtCSf2zf4aLninnA0lYO4yugqBvqiefQ7zy6D2QQn2NFDjtB+
         nyOBY6IF1KhldYvEKSb0fmTt/pcWb40I01t0QSwHvW1RGGSHuoXqJPRwG8g5YcFdfrkA
         QceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FC/P58BPNxMQxyd6hbAy1+BTHAcYn3RwUt3hGQf3szI=;
        b=i6pYUQVI9M3AJZn2zehlKVuM7D3wfh7H6ToM7tbicmB8g3d76dQ6R7m9EK3FZIUnRR
         Agsy3M41bNrA0HGmRoXpFoeRlt/qxN8Hi9IseKxHeXBTlKJMuaTLFFjh4OUV93l8jDTO
         QNeGbIBAU1shK5gZ6qYoBg87Lf+hX5q5if7SiQVxLfFNrQUYC/E4PoSWHRP6H/KUTCJZ
         47VdiTrTxBtDNFKi0Rf5X54bKlX+Z23Ucp1868+FfPRSdz4wNwY5L75+pQ73VrCx2uwy
         CdlKhuNPfbGzLOYdnWkQVDvZRM9eW/nwzvoMRUIbK59S+XQgrOjSBQSyt3zv4ujooE6L
         Zhtw==
X-Gm-Message-State: AOAM531eF8OrmIuRDJFaG1bDKBL3VSn/VrO8JWlDglHDifWkRy7qqHzG
        7LInxu1MlyUc1JbhjYYnn64=
X-Google-Smtp-Source: ABdhPJzUs++teaTEeNQDAkhDvhAZ+P4mqNY2f5qrGjkPFuM8xLjDSONXUDfYZGZV5vNJi4Z0RHwd0A==
X-Received: by 2002:a17:906:c14b:: with SMTP id dp11mr1287620ejc.294.1639718337806;
        Thu, 16 Dec 2021 21:18:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 14sm2407189ejk.215.2021.12.16.21.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 21:18:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my5dw-000k4M-J1;
        Fri, 17 Dec 2021 06:18:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH V5 2/2] git-apply: add --allow-empty flag
Date:   Fri, 17 Dec 2021 05:51:59 +0100
References: <20211213220327.16042-1-jerry@skydio.com>
 <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee6dz5s9.fsf@gitster.g>
Message-ID: <211217.86wnk395bz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 15 2021, Junio C Hamano wrote:

> Jerry Zhang <jerry@skydio.com> writes:
>
>>  t/t4126-apply-empty.sh      | 22 ++++++++++++++++++----
>>  4 files changed, 30 insertions(+), 7 deletions(-)
>> ...
>> diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
>> index ceb6a79fe0..949e284d14 100755
>> --- a/t/t4126-apply-empty.sh
>> +++ b/t/t4126-apply-empty.sh
>> @@ -7,10 +7,12 @@ test_description='apply empty'
>>  test_expect_success setup '
>>  	>empty &&
>>  	git add empty &&
>>  	test_tick &&
>>  	git commit -m initial &&
>> +	git commit --allow-empty -m "empty commit" &&
>> +	git format-patch --always HEAD~ >empty.patch &&
>>  	for i in a b c d e
>
> When merged with anything that has ab/mark-leak-free-tests-even-more
> topic, this will start breaking the tests, as it is my understanding
> that "git log" family hasn't been audited and converted for leak
> sanitizer.
>
> This is sort of water under the bridge, as the other topic is
> already in 'master', but come to think of it, the strategy we used
> with TEST_PASSES_SANITIZE_LEAK variable was misguided.  
>
> If the git subcommands a single test script uses were only the
> subcommands that the test script wants to test, the approach to
> default to "this subcommand has not been made leak sanitizer clean",
> and then to add TEST_PASSES mark as we sanitize the subcommand makes
> perfect sense, but most test scripts need to run git subcommands
> that are *not* the focus of the test---they run them only to prepare
> the scene in which the subcommands being tested are excersized.  In
> such a situation (which is exactly what happens here), marking that
> "right now, all the tested subcommands and also all the subcommands
> that happen to be exercised to prepare fixture are clean" would
> force us to flip-flop with "now we use a subcommand we didn't use in
> this script before to prepare the scene, and it is not yet sanitizer
> clean, so we need to unmark it", which is not quite ideal, but is
> much better than forcing the contributor who is *not* working on making
> these subcommands leak-sanitizer-clean to worry about such a breakage.
>
> I am tempted to drop the "TEST_PASSES" bit from this script for now,
> but I have to say that the "mark leak-free tests" topic took us in
> an awkward place.  We probably want to do something a bit more fine
> grained about it.

I don't see how us not having a 1=1 mapping between say a "mktag.sh"
test script and that script *only* running "git mktag" makes the
approach with SANITIZE=leak misguided.

You can, FWIW, mark things in a more gradual manner than un-marking the
script entirely. There's the SANITIZE_LEAK prerequisite for individual
"test_expect_success".

Yes it's painful that topics in-flight have this happen to them, but
that pain will mostly go away one the "big leaks" are solved,
i.e. checkout/commit/log etc.

I have all those patches, but they've been held up by the pace these
changes have been getting integrated at.

E.g. f346fcb62a0 (Merge branch 'ab/mark-leak-free-tests-even-more',
2021-12-15) just hit master, but that series has been on-list since the
31st of October, and was picked up & noted in What's Cooking on the 2nd
of November[3]. The only changes in it are adding the same
"TEST_PASSES_SANITIZE_LEAK=true" marking to 104 test scripts.

Part of that delay is the release that happened mid-November, but even
accounting for that I wish we could find ways to make this go
faster.

I.e. I understand that a general change to git.git might take this time,
but in this case really all the proof we should need is "does CI
pass?". So I don't see why we couldn't make this go a bit faster.

Similarly for things that add new free()'s we can (unless the code is
tricky, which is usually obvious, i.e. adding highly conditional free)
count on libc/SANITIZE=[leak|address] to validate that the memory
management is OK.

Anyway, I had hoped to submit the "struct rev_info" freeing sometime
soon, depending on how you'd queue up other prerequisites for it.

But with an UNLEAK() for it in-flight I'll delay it even more, since it
will directly conflict both textually & semantically with the changes to
fix the same memory leak.

So as painful as other parts of this are I'd really like it if we could
avoid taking one step back and two steps forward each step of the way by
plastering over things with UNLEAK(). See [4] for earlier discussion on
that.

1. https://lore.kernel.org/git/?q=ab%2Fmark-leak-free-tests-even-more
2. https://lore.kernel.org/git/cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com/
3. https://lore.kernel.org/git/xmqqy267851e.fsf@gitster.g/
4. https://lore.kernel.org/git/211022.86sfwtl6uj.gmgdl@evledraar.gmail.com/



