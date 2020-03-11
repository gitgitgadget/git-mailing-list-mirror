Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991EAC2BB1D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B1920737
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dcCjZuNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgCKRvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:51:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbgCKRvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 13:51:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61B29C4F87;
        Wed, 11 Mar 2020 13:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W1Em9T9omplC
        8MAp1fRBCF32ykk=; b=dcCjZuNgWhMMPpiA8mw3C//0reJtTaTpGZl/NILO/yzF
        PgKx1VizBXnyLP980BSC+FthafHudHOwYi19NglsH8kUUFgI/8HrVBTF0MYDpWDu
        q/64jYol8Z7RyKG6+Fk9onzR4L+2g8vSwtYQQrGwvqKEwO608zpaYl2JSeaU7eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zvninn
        MlxdNAYfsi/v6ywomL/BZEOxEFTc1EZVpXbM38sM1t3oYdyeohZvdVYg9S2Ktxxc
        lZeXUoifHQl6oZekZBO74QVt9iHhM/o16UnnRWBpTrHPZb9u1LdMkf10YBrkyFGd
        dursDpjUFz7uzaiyx/Xd1IUuE+kRbD1ju0xRI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 595E5C4F86;
        Wed, 11 Mar 2020 13:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9CF81C4F85;
        Wed, 11 Mar 2020 13:51:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [Breakage] t0410 - subtests report unable to remove non-existent file.
References: <010b01d5ee87$09be74d0$1d3b5e70$@nexbridge.com>
        <20200310110008.GA3122@szeder.dev>
Date:   Wed, 11 Mar 2020 10:51:28 -0700
In-Reply-To: <20200310110008.GA3122@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 10 Mar 2020 12:00:08 +0100")
Message-ID: <xmqq5zfaixun.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F06A72C2-63C0-11EA-B60E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>   promise_and_delete () {
>           HASH=3D$(git -C repo rev-parse "$1") &&
>           <...>
>           git -C repo rev-parse my_annotated_tag | pack_as_from_promiso=
r &&
>           <...>
>           delete_object repo "$HASH"
>   }
>
> The failing 'rm' is in the 'delete_object_repo' helper function.
> The 'pack_as_from_promisor' does the following:
>
>   pack_as_from_promisor () {
>           HASH=3D$(git -C repo pack-objects .git/objects/pack/pack) &&
>           >repo/.git/objects/pack/pack-$HASH.promisor &&
>           echo $HASH
>   }
>
> Notice that both 'promise_and_delete' and 'pack_as_from_promisor' set
> the $HASH variable.  This is usually not an issue, because
> 'pack_as_from_promisor' is invoked in a pipe, and thus most shells
> execute it in a subshell environment.
>
> However, apparently 'ksh' doesn't run this helper function in a
> subshell environment, and the value set in 'pack_as_from_promisor'
> overwrites the value set in its caller, thus 'promise_and_delete' ends
> up trying to delete a non-existing object (it's the SHA1 of a
> packfile).
> ...
> Note, however, that 'ksh' is not utterly wrong in doing so, because
> POSIX does allow this behavior: POSIX 2.12 Shell Execution Environment,
> the last paragraph of the section:
>
>   "each command of a multi-command pipeline is in a subshell
>    environment; as an extension, however, any or all commands in a
>    pipeline may be executed in the current environment."
>
>    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02=
.html#tag_18_12
>
> So apparently 'ksh' implements this extension.
>
> The trivial fix would be to mark $HASH as 'local' in both helper
> functions,

Or
	git -C repo rev-parse my_annotated_tag |
	(pack_as_from_promisor) &&

that would not require local?

> but this would not help 'ksh', of course, as it doesn't
> support 'local'.  However, since we use more and more 'local's in our
> testsuite, 'ksh' might be considered a lost cause anyway.

That's somewhat sad, especially since "local" is outside POSIX, but
probably re-whipping our test suite into shape to be usable with
POSIX shells is too much effort for little benefit X-<.

> Or we could rename these HASH variables to something more specific to
> prevent this name collision, e.g. PACK_HASH in 'pack_as_from_promisor'.
>
> Note that there are tests in t0410 that set and use the $HASH variable
> outside of these helper function, and, worse, there is a test that uses
> the $HASH variable set in the previous test.  Luckily, none of those
> tests use 'promise_and_delete' or 'pack_as_from_promisor'.
