Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5C620373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdCMVT1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:19:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36526 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdCMVTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:19:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so52997711pge.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2mmsIEfblFaVhr4RGAhutkXB0zOkAafrTY3+Ak7DZsA=;
        b=YySS27b6DvZ+zu5dLnHx6O5t3AOh1Afklh0KcUucEQf3K/TUOod9NAL+GLj/SQSjAB
         wF5XW48genY4KHpv9PGUeomvg0sigCoXuscx05LNx1TgKWEpi32Sd30G0wA07GD6Uq7b
         J7CkOkXim1p4PjE9Yj3WiJ8UuJUVYhbtqwG2eQuVvN+oLM45GlzGqy15848bGzngiU2l
         Mr/wNxzDY7shiVF+34q+c8QlOaz8iZ9Ss3tKUQw2MIbZF3XDmRnDy3c3iwiFNRtR4xId
         uqtjvWlEw52YO4B0KsjtibxPB+32/7jgMx6oBijd28B4PFqJ57vWQPtcPGK0gS+r4sHA
         ufMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2mmsIEfblFaVhr4RGAhutkXB0zOkAafrTY3+Ak7DZsA=;
        b=EBYy34I+SM9SgmGUNmXSgFBGRvI0FsOKYH3RaKND+aWp2+tad3TEXykL6KNSSEDEvE
         kRp2hqr2W2irfyqQB05+VAlV4Oi6pKENaeyjg5WxyQTAsXAU0sAukuoRzxnIXpwNF6kG
         9LDX3qfk4DqFJI17SUHIStjr+j3eFy7gUBqpnvR388Vq/TAfM4hqBHwCvqqOQVdzRhO2
         lxa8XVQdQQCzC6VXSpFF92VCwbnl/u0+jiYjGPF5ZTk7PEnODfGV0RwB+KBrWshzu0oL
         S0hmHcu0ZhqI+6I1s21hoWqcUizxyhpo/7qvV6ESMn/pMSK28kjEwyobVhFF3OBnLPdw
         sEog==
X-Gm-Message-State: AMke39lvadvpAFE2IF7dpTQ239U5e19YTWaGeMUzl6PcPnic5+bnz+TUdVoATdjMfMQVMi2tT3Ahky/Wnim7mVAA
X-Received: by 10.99.140.77 with SMTP id q13mr38593102pgn.179.1489439963837;
 Mon, 13 Mar 2017 14:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 14:19:23 -0700 (PDT)
In-Reply-To: <1489430233.10192.56.camel@novalis.org>
References: <1489180018.10192.45.camel@novalis.org> <CAGZ79kZmWaobW9e4iPY05y0N6PLcFphGnZmDHtrGKeV0Up70vg@mail.gmail.com>
 <1489430233.10192.56.camel@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 14:19:23 -0700
Message-ID: <CAGZ79ka=OwSWGDBqiZ5X9LvOXphFe5=QjmH9DoeWLu2svmVtyg@mail.gmail.com>
Subject: Re: bug?: git reset --mixed ignores deinitialized submodules
To:     David Turner <novalis@novalis.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> The change is not really lost, as you can get it via
>>
>>     git checkout HEAD@{1}
>>     git submodule update --init
>
> Sure, the commit isn't lost entirely.  But a mixed reset is often used
> to mean "go back to before I committed", and here, that's not precisely
> what's happening.

Well, you ran the deinit after the commit, so I don't think
we expect to undo everything up to "just before the commit".

> In other words, it's not confusing to the user.

ok, great :)

>
>> This works most of the time, but it is unreliable as the
>> submodule may have had some gc inbetween which
>> threw away important objects.
>
> Sure; that's a separate issue.
>
>> Steping back a bit, rereading the subject line,
>> what do you think is the bug here?
>>
>> * git-status not reporting about uninitialized submodules?
>
> Here, I think git-status is correctly reporting the state of the repo.
>
>> * git reset --mixed not touching the submodule worktree
>
> Yes, possibly.
>
>> * lack of --recurse-submodules in git-reset? (and that not
>>   being default, see prior point)
>
> Or possibly this.

Well even in this case a reset recursing into submodules doesn't change
the (de-)init status of a submodule. All it would alter is the
submodule HEAD pointing to, IMHO.

>
>> * submodules being in detached HEAD all the time?
>
> In this case, the submodule is not initialized, so it is not in any
> state at all.

Oh right.

>
>
> For me, the bug (if any) is the bad user experience of doing a mixed
> reset and expecting to be able to commit (possibly with some git-add
> operations) from there and get back something like the commit to which
> the user had git-reset.

Technically this is also doable,

    git reset --mixed HEAD^ # as in the original email
    git update-index --add --cacheinfo \
        160000,$(git -C .git/modules/sub1 rev-parse HEAD),sub1
    git add another_file
    git commit -m "recreate the commit"

>
> That's why I have the question mark there -- it's not clear that this
> is a reasonable expectation.

Fuzzing around with gitlinks that are non-populated submodules is
a messy business.

So another way would be to populate the submodule manually

    GIT_DIR=.git/modules/sub1 \
    GIT_WORKTREE=sub1 \
    git checkout -f # implies last HEAD

and then continue in the superproject.

I am making up excuses for poor UX here, though.
I do agree that the expectations may vary wildly because of poor UX
in submodules.

Stefan
