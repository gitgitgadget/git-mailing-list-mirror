Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEE5C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 07:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBVHUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:20:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiBVHUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 02:20:12 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE4CA716
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 23:19:48 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FE4417BC6B;
        Tue, 22 Feb 2022 02:19:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Hp5lC+85oB0jqLZtz+1mYhCAC
        LP6zJPwC5lLv5FXIAw=; b=hxHDcfkPdvTfPpDYvZd0t0s2d1vETrQzc08iS2M7n
        zmGpI5FNBTwfmKiGMp8z7igLW5UEGFONuhJ1KGWTdtgsCS9hS5z7ge9i9FSXETuh
        yR0wobxaMVG2GHi0vE8ZirnR97fAfk0GvNQlzV3mzmLhvjoKdtVbXblNKNz9O3Wg
        B0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6ABD617BC69;
        Tue, 22 Feb 2022 02:19:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4F4917BC68;
        Tue, 22 Feb 2022 02:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
        <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
        <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
        <YhPL+wSxtI0KIz07@nand.local>
        <220221.868ru4avw6.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Feb 2022 23:19:42 -0800
Message-ID: <xmqqee3vwepd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEA201D4-93AF-11EC-9625-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Sorry to notice this so late, but this hunk caught my eye. What happen=
s
>> if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t")?
>
> I think that the preceding 2/4 should cover your concern here, i.e. I
> think that's not possible.
>
>> Before this change, we would have set GIT_BUILD_DIR to the parent of
>> whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll sti=
ll
>> do the same thing with this patch if TEST_DIRECTORY ends in "/t". But =
if
>> it doesn't, then we'll set GIT_BUILD_DIR to be the same as
>> TEST_DIRECTORY, which is a behavior change.
>
> Indeed, but I believe (again see 2/4) that can't happen.

It is not like "can't happen", but "whoever wrote the TEST_DIRECTORY
override logic did not mean to support such a use case".

I am perfectly fine if we declared that we do not to support the use
of that override mechanism by anybody but the "subtest" thing we do
ourselves.  If we can catch a workflow that misuses the mechansim
cheaply enough (e.g. perhaps erroring out if TEST_DIRECTORY is set
and it does not end in "/t"), we should do so, I would think, instead
of doing the "go up and do pwd", which will make things worse.

Thanks.
