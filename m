Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372DC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30439619A0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhC1BrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:47:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59442 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1BrP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:47:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A6AB122510;
        Sat, 27 Mar 2021 21:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4orKzZC/D1pG
        ID2chbjhPoJmD+0=; b=k0URHjwqevDW1Jgmv65LwHoWvh+GUFjQ8wQKxueu3KHl
        JM/vr22pD0D/TrAsLpgqNRWNRlwsOUUJhNriz4XT2DO5C2dYwLnmPtQ5CA8MKA+N
        nsLLE5k7ciuDeRh44j8ifYGXTZwrf6EjWuw5TCNE3vCelI8MNl8isRVBi3b6unA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LRS+Iq
        0G2G9SIe1H65W6SBfD77+8mlv6paBBZ2243SVVSpEY/1jtbmZNLfEVY/7/uYIvX6
        sNhj8bfwYbUm10Hq8q1HaYaTFzsME5U5RHSPXwKH0fIkLfLJnraHcYV7KEzM7VXx
        EAdba8RU8AGUVuf61c6C5NqqC4kqo53zkKjSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8238412250F;
        Sat, 27 Mar 2021 21:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB57D12250E;
        Sat, 27 Mar 2021 21:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/20] sparse-index: design doc and format update
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <6426a5c60e53e30091360c00c61c9123803fe9c1.1616507069.git.gitgitgadget@gmail.com>
        <20210326202940.GC2271@szeder.dev>
Date:   Sat, 27 Mar 2021 18:47:11 -0700
In-Reply-To: <20210326202940.GC2271@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 26 Mar 2021 21:29:40 +0100")
Message-ID: <xmqq8s68oxr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84460C9A-8F67-11EB-9FF2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +To start, we use a new repository extension, `extensions.sparseIndex`=
, to
>> +allow inserting sparse-directory entries into indexes with file forma=
t
>> +versions 2, 3, and 4. This prevents Git versions that do not understa=
nd
>> +the sparse-index from operating on one, but it also prevents other
>> +operations that do not use the index at all.
>
> Why is this not a non-optional index extension?  ...
> This really should be a non-optional index extension.

Yeah, the index extension mechanism was designed with optional and
required kinds because we wanted to support exactly a use case like
this one.

Thanks for pointing it out.
