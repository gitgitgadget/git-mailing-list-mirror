Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8234C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiCRTAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiCRTAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 15:00:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E624F290
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 11:59:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A72FA190455;
        Fri, 18 Mar 2022 14:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iwJqj0sUEVq3
        1YIJKQTlcc8NawC9A8hgfgSc9A9qoak=; b=TNamM2wkiFara0BPEAduCtB6xski
        HqSLGUEfpqo2qH4RR2IqMSYxdUKdAGgPlm97NUlk1u52TS8OMKk4PixfzIHvXNGY
        eJ9wUtBx49yon1AM3bYYFByk0a9FN4cwNGJZelBIvTuVaDcsl/diQ1gOk9S/PdqT
        3JyLlH4sDcbbJGQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F0AE190454;
        Fri, 18 Mar 2022 14:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19277190452;
        Fri, 18 Mar 2022 14:59:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
        <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
Date:   Fri, 18 Mar 2022 11:59:19 -0700
In-Reply-To: <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 18 Mar
 2022 01:33:56 +0100")
Message-ID: <xmqqczij9jeg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 847268B4-A6ED-11EC-9D83-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add an alternative to the "test_expect_failure" function. Like
> "test_expect_failure" it will marks a test as "not ok ... TODO" in the

"will marks" -> "marks".

> TAP output, and thus document that it's a "TODO" test that fails
> currently.
>
> Unlike "test_expect_failure" it asserts that the tested code in
> exactly one manner, and not any other.

ECANNOTPARSE due to a verb missing.  For now I'll assume "It asserts
that the tested code fails in exactly one matter" and keep going.

> We'll thus stop conflating
> e.g. segfaults with other sorts of errors, and generally be able to
> tell if our "expected to fail" tests start failing in new and
> unexpected ways.

The above makes it sound wonderful but I got somewhat confused when
I tried to see how well it conveys what it wants to tell by picking
an example from this patch.  Say, for example:

> -test_expect_failure 'git grep .fi a' '
> -	git grep .fi a
> +test_expect_todo 'git grep .fi a' '
> +	test_must_fail git grep .fi a
>  '

So, we used to say

    "We eventually, when things are fixed, want 'git grep' to find a
    string '.fi' in file 'a', but currently this does not work".

Now the updated one says

    "We know 'git grep' fails to find string '.fi' in file 'a'"

If it is a trivial single statement test like the above, the
distinction does not matter, but if it were a test with multiple
steps, the readability would become quite different.  It would turn

	test_expect_failure 'sample test' '
		preparation 1 &&
		preparation 2 &&
		git command invocation that we want to succeed
	'

into

	test_expect_todo 'sample test' '
		preparation 1 &&
		preparation 2 &&
		test_must_fail git command invocation that we want to succeed
	'

"expect_failure" expects the whole thing to fail, so we will miss if
any preparation steps fail, but "expect_todo" is like "expect_success"
so it will help us debuging the test by catching a silly mistake in
preparation steps.

Marking the step that demonstrates the current shortcomings with
"MUST FAIL" is a bad taste, but let's pretend that we didn't notice
it ;-).  Other than that, it looks like an improvement.

>  * More generally, "test_expect_failure" by design doesn't test what
>    does, but just asserts that the test fails in some way.

Exactly. =20

It matters in complex tests that !(A&B&C) is different from
(A&B&!C), the latter of which is what we want to do with tests that
document what currently does not work.

>   - test_expect_failure [<prereq>] <message> <script>
> =20
>     This is NOT the opposite of test_expect_success, but is used
> -   to mark a test that demonstrates a known breakage.  Unlike
> +   to mark a test that demonstrates a known breakage whose exact failu=
re
> +   behavior isn't predictable.
> +
> +   If the exact breakage is known the "test_expect_todo" function
> +   should be used instead. Usethis function if it's hard to pin down
> +   the exact nature of the failure. Unlike

"Usethis" -> "Use this"

> -test_expect_failure 'clone --local detects misnamed objects' '
> -	test_must_fail git clone --local misnamed misnamed-checkout
> +test_expect_todo 'clone --local detects misnamed objects' '
> +	git clone --local misnamed misnamed-checkout
>  '

Just like too many negatives confuse readers, I have to say this is
quite confusing.  Do we or do we not want "git clone" invocation to
succeed?

> +test_expect_failure () {
> +	_test_expect_todo test_expect_failure "$@"
> +}
> +
> +test_expect_todo () {
> +	_test_expect_todo test_expect_todo "$@"
> +}

It is a bit surprising that _test_expect_todo does not share more of
its implementation with test_expect_success, but let's pretend we
didn't see it.

Looks like a good first step.  I'd stop reading the series for now
at this one.
