Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA5C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA38161029
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhDBVIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:08:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53249 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhDBVI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:08:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BB3812F7C0;
        Fri,  2 Apr 2021 17:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pIBAtcIAA3NM
        wp66bJ5DiiyVyhg=; b=EVKA5ZSP9vS9Kf0uFpvueqmxLs4WaLqyBZmgSHjPSHxY
        KiYbmB/vTolFE93zExEHSsz9jExlbyzdVj1k0FN+D6NSOB+US5cbRxlc08R9n547
        C1A5LDJXydKqFNBqbc08w/ckR9xU/cfpBURRGXuOoY65F2bM0oFCoYibfvy5h7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gQiQRQ
        Sebr8sVaWWuDSgL+s7s8T2aq9YuJHjzcR0JE3G/D0v804iRzWwRita/Rb+wScucM
        zZZ6QDdmSDF3JIY+X5iT4g8cBuyppwN9N59p5Qut6Af8tctfquPv1g7KgLxswD+S
        hi2xSubPS3Kc4WaE016n0Mfq2gcfpa2sgHqVc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D81612F7BF;
        Fri,  2 Apr 2021 17:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B56112F7BB;
        Fri,  2 Apr 2021 17:08:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 08/18] blame: emit a better error on 'git blame
 directory'
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-08.19-3c2ca98716d-20210331T190531Z-avarab@gmail.com>
        <xmqqwntm52ht.fsf@gitster.g> <87blaxkpg6.fsf@evledraar.gmail.com>
Date:   Fri, 02 Apr 2021 14:08:22 -0700
In-Reply-To: <87blaxkpg6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 02 Apr 2021 11:26:01 +0200")
Message-ID: <xmqq5z144cop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FE3F096-93F7-11EB-A211-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 01 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Change an early check for non-blobs in verify_working_tree_path() to
>>> let any such objects pass, and instead die shortly thereafter in the
>>> fake_working_tree_commit() caller's type check.
>>>
>>> Now e.g. doing "git blame t" in git.git emits:
>>>
>>>     fatal: unsupported file type t
>>>
>>> Instead of:
>>>
>>>     fatal: no such path 't' in HEAD
>>
>> Sorry, but I fail to see why "unsupported file type t" is quite an
>> improvement.  Is this one of these irrelevant clean-up while at it
>> whose benefit is unclear until much later, I have to wonder.
>
> Because "t" is directory we can stat() and which exists in the index, s=
o
> it makes more sense to fall through to the stat() codepath.

't' is not in the index, even though many things with 't/' prefix
may.

But my understanding of the point of that loop is to catch cases
where one side may have 't' as a directory, the other side may have
it as a blob, and we have a 't' regular file during a process of
resolving a conflicted merge (perhaps the tentative resolution has
already been "git add"ed to the index).  So "git blame t" would want
to start from the "working tree state", which is made into a virtual
commit, with two "virtual" parents, one is HEAD that has 't' as a
directory but the other MERGE_HEAD may have 't' as a regular file,
so "blame" should be able to follow the history of that regular file
through the merge in progress.

If we change, like the proposed patch does, the loop to exit
immediately after we notice 't' exists in HEAD (as a tree), without
even looking at the second parent to notice that it is a regular
file there, wouldn't that change the behaviour?

> I think the "unsupported file type" message is a bit odd, but it's the
> existing one, perhaps changing it while we're at it to something like:
>
>     fatal: cannot 'blame' a directory
>
> Would be better,...

Sure.  As long as the change does not break the original use case
the loop intended to support, that is fine, and the message would be
a lot better than the "unsupported file type t".
