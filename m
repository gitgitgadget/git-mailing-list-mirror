Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53568C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 18:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhLLSq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:46:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56192 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhLLSq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 13:46:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD100158305;
        Sun, 12 Dec 2021 13:46:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1Jg/zudDEDODEtKjQ54/zLb8zO1a8ii5VIZNz
        Ef4p0=; b=qd4BCn9Q/nHqBVJulwiiV4q8Zsm8tA1CvywhQUvFvcPJ0athb6TBhJ
        arFXpkFY3xKsoGocTr2CZgAgxI/Wb7fWod6puSfpRDpw4FlIo2fQElQ5Fo5ABcVe
        9kcy0eXatD6HQ70TdGGw6899OeTrOXxzrA/mJm99to0IvT7m5MoIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5862158304;
        Sun, 12 Dec 2021 13:46:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BD76158303;
        Sun, 12 Dec 2021 13:46:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
        <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
        <xmqq5yrwm7km.fsf@gitster.g>
        <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
Date:   Sun, 12 Dec 2021 10:46:23 -0800
In-Reply-To: <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 11 Dec 2021 15:51:01 +0800")
Message-ID: <xmqqy24pk6f4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEDC99F0-5B7B-11EC-9324-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> It is unclear if you mean "dev1" exactly point at the commit tagged
>> as v1.1, or you want the branch "dev1" that is a descedanant of
>> v1.1.  Without telling that to the reader, the above explanation is
>> useless.
>>
>
> I meant the former.
>
>> And whether you meant the former or the latter, neither use case does
>> not make much sense.
>> ...
>> So, "--to-branch v1.1" that finds and checks out a branch whose tip
>> exactly points at v1.1 would be pretty useless.
> ...
> "git branch --contains v1.1" can find all branches whose history contains the
>  commit tagged as v1.1. So what if "git checkout --contains v1.1"?

I already said, whether you meant "the only branch that points
exactly at" or "the only branch that contains", the feature does not
make sense.  Forcing users to keep only a single branch that either
points at a given tag is simply impossible and also useless.  Once
the branch gains even a single commit, it will no loger be pointing
at the tag, so "let's prepare a branch pointing at v1.1 just in case
when I want to start working from there" would not be a good
workflow to begin with.  Forcing users to keep only a single branch
that contains a given tag would encourage even a worse workflow to
throw in unrelated things, whose only commonality is that they all
want to fork from a single tag, into a single branch.

IOW, there is nothing we want to add to "git checkout/switch" for
this topic.  "git checkout --contains $tag" smells like a solution
looking for a problem.


