Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E26C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EDD22226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 10:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W33M+V3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgKBKgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 05:36:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69AC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 02:36:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o18so13859332edq.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ikk8yi9+QmyvHH6BStLUbxaYpYN75v3CtUzEY1PiEwg=;
        b=W33M+V3s+W2nakeiBfNBolRZha0HvL9LCA1+py202BdTEmBdNCVj+0+XCWu2Dk29en
         FCMGIotMEuGLEp3tvs4wntjg1HA/+U1+QnIpXtISvn1mo3wglcaiRi0X8zJQj65i5OiN
         r3APHmmzLRYNwx/yYDns1bj2RdzfxbckjC2eMz1XhDJyxkNtqZWUPRkHZAzrrYI7DwfT
         ApexifTgPr9XlFjQO1IWS3klwn7Vre00foVYF6R3VkQh6odLGYxL3NkoPsO/zCAq2wek
         5wEqylPoGkqyhDn5VIYUJqJn0T2rbEsEh5bi9Vo2ZEseGhNCCzFEvKGQ0brr7USnKjL1
         4FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ikk8yi9+QmyvHH6BStLUbxaYpYN75v3CtUzEY1PiEwg=;
        b=oOe4nHqmlnevKUUnl4FEJmLDxEdQGUTuUsq7LunGr4/p1BPo+jE3KcM0aP1thOthXW
         mwfW3105fINWZnUG+sHyEjeg6mha0ZP5d8hJtYfjIHTR60cnnY9dLx6rj5cvg/subcde
         jtMDLYhOyz8QTZmk53zAmiln6ADpQwRaKqd/7cmtkmKsz6lkbwyzEpNlQiZ3rXRMIxrK
         i9L+wzsMOsXJ210wtr+I8QR3rYJplqUMZQtwbK4VY4oMg7/CXIfckQ4nOex3S3SJySJI
         im838eLW4p9BxGrtVSo1iUk0toiNtRhx6b+sSmC++WUlOSrXiNrBnYSYaZtkyj7EV9QB
         tyyA==
X-Gm-Message-State: AOAM533E0N9JB5ri6Borl9MQBIuEh8MFTHMAgK92akqxWXKGAz5CG89w
        TEtDoTceb5IOjSh3j+aesMw=
X-Google-Smtp-Source: ABdhPJzTxqZ8fQ7dYE8v823ihLkxgHBKKotVW3BDTzz8m9Opg4f8ueNaMhJQsoRk6wfOXCEcAPXsbQ==
X-Received: by 2002:a05:6402:1615:: with SMTP id f21mr16488346edv.257.1604313375698;
        Mon, 02 Nov 2020 02:36:15 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m27sm4064690ejg.3.2020.11.02.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:36:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Manuel =?utf-8?Q?B=C3=A4renz?= <manuel@enigmage.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: Feature request: Exponential search in git bisect
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de> <87wnzbhntw.fsf@evledraar.gmail.com> <58ba4fcd-50ff-1d1a-fe11-1ee59ad1c533@enigmage.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <58ba4fcd-50ff-1d1a-fe11-1ee59ad1c533@enigmage.de>
Date:   Mon, 02 Nov 2020 11:36:13 +0100
Message-ID: <87r1pcgi5e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 01 2020, Manuel B=C3=A4renz wrote:

>> Let's suppose we have a repository with 700 linear commits:
>>=20=20=20=20=20
>>     set -e
>>=20=20=20=20=20
>>     cd /tmp
>>     rm -rf /tmp/test-repo
>>     mkdir /tmp/test-repo
>>     cd /tmp/test-repo
>>     git init
>>=20=20=20=20=20
>>     for i in $(seq 1 700)
>>     do
>>         touch $i
>>         git add $i
>>         git commit -m"add $i"
>>     done
>>
>> Then let's bisect it from the root:
>>=20=20=20=20=20
>>     git bisect start HEAD HEAD~699
>>
>> And let's further suppose that the feature wasn't introduced until
>> commit 650, and it's broken since 653.
>>
>> With the bisect method of finding this we're going to start our session
>> with these commits:
>>
>>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> good
>>     [d271fdb29129dbba723d3eac1035b58b6dc6f583] add 525 =3D> good
>>     [b0c9b7da646334a6c7eadb333b5ae77ec35388b3] add 612 =3D> good
>>     [2a78858d04cc5542e176dd8f68fa2660b8b48ab3] add 656 =3D> bad (or skip)
>>
>> Whereas with this proposed exponential search it'll be commits #:
>>=20=20=20=20=20
>>     2
>>     4
>>     8
>>     16
>>     32
>>     64
>>     128
>>     256
>>     512
>>
>> So we're going to test 8 commits before we get past the mid-point that
>> bisect now starts with. Of course that may be more efficient, but if the
>> regression is in some random place I don't see why we wouldn't test the
>> middle instead of weighing things towards the start of the history. If
>> the relevant commit is an early one like #50 bisect is still faster.
> That's true. If the feature was broken n commits ago, and exponential
> search has to be useful, then the feature must not have been introduced
> later than a*n commits ago, where a is the exponent.

Right, but it seems like a rather trivial saving in even those cases
compared to binary search, and I'd think in practice any such gains
would be outweighted by the practical trade-off that in real
repositories older commits tend to be harder to test/build
(e.g. requiring old library versions or compilers).

>> With the disclaimer that I may be missing something, I'm just plowing
>> ahead:
>>
>> I don't see the usefulness of this proposed exponential search, but I
>> definitely *do* see the usefulness of a "bisect undo", and I've been
>> bitten many times by the lack of that myself. We should definitely have
>> that.
> What exactly would you undo? If an older commit has been marked as
> "bad", should e.g. a later "good" marker undo the earlier "bad" marker?
> I don't know how this helps because the bigger problem is that if I tend
> to mark old commits as good rather than skip, I will more likely
> accidentally mark a bad commit as good, and I don't see how I could undo
> that.

Sometimes I mistype "good" or "bad" (usually via some shell history
accident) and have to manually recover from seeing where I'd narrowed
down before with "log", so just an "undo" that allows you to revert the
previous step(s) would be useful.

>> And as Christian pointed out in [1] it seems you're (understandably, it
>> can be confusing) conflating skip and "good" in your example.
> Yes, knowingly, unfortunately. Or to put it more precise: I cannot write
> a script that is good enough to really detect a good old commit reliably.
>>  So to
>> re-state the problem you have, if I were to use "skip" in the above
>> example bisect for me will do:
>>=20=20=20=20=20
>>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> skip
>>     [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 =3D> skip
>>     [c985feffa2c92b2d3d9804a43b215e26c7275549] add 374 =3D> skip
>>     [effa691ec5dc2d80c0b070c4d8ac9fa70cbfea9f] add 168 =3D> skip
>>     [212a5ee3ff55834196661d0632f584098e9f6fb2] add 369 =3D> skip
>>     [2ca67a4500c9f3cd489b9e529d41eb99252dc8f6] add 179 =3D> skip
>>     [4067ee067e2298e1b104f4ff9aab15f4e815e101] add 337 =3D> skip
>>     [...]
>>
>> If only there was a way to be on 350 and say "skip everything up to this
>> point", so I implemented it!:
>>
>>     [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> skip-to-here
>>     [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 =3D> skip
>>     [6f7b5ca1dcc21c28af658a172136e503d7a2d0ea] add 420
>>     [...]
>>
>> etc. now we're not jumping around in 1..350:
>>
>>     $ git config alias.bisect-skip-to-here
>>     !f() { good=3D$(git for-each-ref refs/bisect/good* --format=3D"%(obj=
ectname)"); git bisect skip $good..HEAD; }; f
>>
>> Great eh? Not really, because I've just discovered a really tedious and
>> expensive (I created 350 "skip" refs) of re-inventing what I could do if
>> I just did "good" on commit 350[2] :)
>
> I'm not entirely sure whether I understand yet. If you mark a whole
> range of commits untestable, then yes. But how do you know whether the
> whole range can be skipped? Maybe the feature was really introduced in
> 300, 320 broke it and 350 just broke it because of a typo?

I don't, but whatever problems I have with mislabeling 1..350 you'll
also have in mislabeling 16..32, 32..64 etc.

> Maybe another possible, simpler feature would be a different
> (configurable?) skip algorithm. It could move exponentially as well.
> (I'm not sure how useful that would be, though.)

I think the feature that would solve the problem you described in your
original E-Mail would be some sort of verification mode for
bisect. I.e. after we find that commit 656 is the bad one we could
optionally continue testing. If we then found that something was "good"
on the side that should be "bad" or the other way around we'd walk back
in some "undo on steroids" mode to figure out where the mislabeling
happened.

But I don't see how the problem you described would be solved by
changing how we do the commit walk during bisect. We could binary
search, we could walk exponentially, we could test in chunks of 100
etc. All of those approaches would go equally wrong if we mislabel good
as bad or bad as good.

