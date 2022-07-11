Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F82C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiGKPij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGKPig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:38:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A023EAA
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:38:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so9452084ejj.12
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+KXI+bYPzehXywhZWOhMeVhckAo69JzhS0c5Ifpj33g=;
        b=Xwqsruc9vCRkvqcvVUiixAE3/hdQicUHR4v964piB4fau54U4O8tnmvB7/6n2BNAjc
         dXze061NS66t+EJd5x+iM+QQGGOakK5Prydg3nasJiCN0QbSPpyxS6XHWL5NFM6tdkzA
         CD9k3KxlwfvSmnaghGg2tForWpISkEBTmM/qPX3v+rewIX71Lj758CmueP+Ii9fh+EwQ
         rKSQ1mVog5CWMlTtfF6H7K2WvJXGU8e/q1BQasUBD+UfMu/NiwkMvBDjbtXocRs/sQl8
         LByPe5Gqc49wSGJfRQe0CwM6pLWLNPh0f1oiwxF7L2Aqz8Jl++WcgDKFIx574cRdb0Ge
         6auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+KXI+bYPzehXywhZWOhMeVhckAo69JzhS0c5Ifpj33g=;
        b=GWx0VAxmp1zUrieqvbQajAl2SxPISZF+4bKbBieIuSMzeMxwN2xoyx1u7kqDbEdYD5
         2vx8PM0Qm61Qrn9pJXWTVG/0pSipum6TMO1GtaFAlUMouBhzs6DHL32UbnZWI3RkneSF
         WZbko7N49RhFX3PsHlpz3JTrNhI/4J38Q+493siyfqqqJoECEpJa1IPijajDzMpDr4QU
         kt9zk4csFzvzkgbCK+h/KAuShmxOjnKcgnHQrjtioRxJHHtYkQfBrDsoNL1v/9Xy79+o
         1/gTZ4as6HZKy1Xr1JkFmMBJyCyujVYMDY0TN8nS0GOvJXtL9YB+aCDLBJi58Xg0XP2T
         6Azg==
X-Gm-Message-State: AJIora+95vr3b1Mbf9I7Y9nltJ9DJd5UsqAhKnSFc9FrG1eMcISYfLTN
        2Gehvio8nrrFQYK/lo5RexFdVxgFbFPKVQ==
X-Google-Smtp-Source: AGRyM1tl0YXMqmaUszJ4q4RKIVyJORw6hsr3V7wOXyGJB4m/1R9KeijwKJr8/VNUb8SU+V4HsPrqtw==
X-Received: by 2002:a17:907:3f13:b0:72b:167d:2c22 with SMTP id hq19-20020a1709073f1300b0072b167d2c22mr19579927ejc.473.1657553913560;
        Mon, 11 Jul 2022 08:38:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx23-20020a170907775700b0072af12590fesm2741497ejc.207.2022.07.11.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:38:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAvUV-000wiw-U8;
        Mon, 11 Jul 2022 17:38:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] ref-filter: disable save_commit_buffer while traversing
Date:   Mon, 11 Jul 2022 17:12:37 +0200
References: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Ysw4JtoHW1vWmqhz@coredump.intra.peff.net>
Message-ID: <220711.8635f77j7s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Jeff King wrote:

> Various ref-filter options like "--contains" or "--merged" may cause us
> to traverse large segments of the history graph. It's counter-productive
> to have save_commit_buffer turned on, as that will instruct the commit
> code to cache in-memory the object contents for each commit we traverse.
>
> This increases the amount of heap memory used while providing little or
> no benefit, since we're not actually planning to display those commits
> (which is the usual reason that tools like git-log want to keep them
> around). We can easily disable this feature while ref-filter is running.
> This lowers peak heap (as measured by massif) for running:
>
>   git tag --contains 1da177e4c3
>
> in linux.git from ~100MB to ~20MB. It also seems to improve runtime by
> 4-5% (600ms vs 630ms).
>
> A few points to note:
>
>   - it should be safe to temporarily disable save_commit_buffer like
>     this. The saved buffers are accessed through get_commit_buffer(),
>     which treats the saved ones like a cache, and loads on-demand from
>     the object database on a cache miss. So any code that was using this
>     would not be wrong, it might just incur an extra object lookup for
>     some objects. But...
>
>   - I don't think any ref-filter related code is using the cache. While
>     it's true that an option like "--format=3D%(*contents:subject)" or
>     "--sort=3D*authordate" will need to look at the commit contents,
>     ref-filter doesn't use get_commit_buffer() to do so! It always reads
>     the objects directly via read_object_file(), though it does avoid
>     re-reading objects if the format can be satisfied without them.
>
>     Timing "git tag --format=3D%(*authordate)" shows that we're the same
>     before and after, as expected.

Hrm, so for doing the format we're leaving some performance on the table
as we're currently not making use of this cache, so this makes nothing
worse on that front.

But doesn't this approach then also close the door on using the same
cache for performance improvements in that area? I.e. spotting that
we've already parsed that commit, so we can get it from the cache?

B.t.w. did you try to benchmark this with --no-contains too, I tried e.g.:

    ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"

Which gives me:

	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=3D-O3' './git -P tag --=
contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' -w 1=20
	Benchmark 1: ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e=
 -- "v*"' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):      1.437 s =C2=B1  0.107 s    [User: 1.252 =
s, System: 0.082 s]
	  Range (min =E2=80=A6 max):    1.306 s =E2=80=A6  1.653 s    10 runs
=09=20
	Benchmark 2: ./git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e=
 -- "v*"' in 'HEAD
	  Time (mean =C2=B1 =CF=83):      1.335 s =C2=B1  0.044 s    [User: 1.230 =
s, System: 0.050 s]
	  Range (min =E2=80=A6 max):    1.260 s =E2=80=A6  1.417 s    10 runs
=09=20
	Summary
	  './git -P tag --contains 88ce3ef636b --no-contains a39b4003f0e -- "v*"' =
in 'HEAD' ran
	    1.08 =C2=B1 0.09 times faster than './git -P tag --contains 88ce3ef636=
b --no-contains a39b4003f0e -- "v*"' in 'HEAD~1'
=09
Whereas just --contains shows the benefit you're noting:
=09
	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=3D-O3' './git -P tag --=
contains 88ce3ef636b -- "v*"' -w 1=20
	Benchmark 1: ./git -P tag --contains 88ce3ef636b -- "v*"' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):      1.068 s =C2=B1  0.102 s    [User: 0.886 =
s, System: 0.068 s]
	  Range (min =E2=80=A6 max):    0.889 s =E2=80=A6  1.272 s    10 runs
=09=20
	Benchmark 2: ./git -P tag --contains 88ce3ef636b -- "v*"' in 'HEAD
	  Time (mean =C2=B1 =CF=83):     931.6 ms =C2=B1  39.9 ms    [User: 865.3 =
ms, System: 34.3 ms]
	  Range (min =E2=80=A6 max):   880.5 ms =E2=80=A6 990.1 ms    10 runs
=09=20
	Summary
	  './git -P tag --contains 88ce3ef636b -- "v*"' in 'HEAD' ran
	    1.15 =C2=B1 0.12 times faster than './git -P tag --contains 88ce3ef636=
b -- "v*"' in 'HEAD~1'

But this is against git.git on a loaded system, so maybe it means
nothing...
