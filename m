Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F72C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4792076C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SnS2Lq2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409046AbgJPU4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:56:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55014 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732640AbgJPU4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:56:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2905930B9;
        Fri, 16 Oct 2020 16:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O/RiJ1Lx9SJf
        dHi8RPVlSmXp1L0=; b=SnS2Lq2XiiDtCxr34EO2vYhHnjT3REdXl7VRYMK9OUxW
        nB91Y9ccGao0cg6FY9n4NCOz8hfqqmJbwA47N9I1Mr5U9Sz4iuyhCPRAKjcf0CNI
        NwVl3PX70KqwitIllSb4ncLkNnXSVsh+xLJphAmFvyqIg4LXnAlJJ2dOGs1LeX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SfYTqW
        6JNqJ8/GNCnMJw7dzso6tLMBc4TNsI0T1uqtwaUksF6DnxsVFgIzhRVyODb+eclr
        GyUqd/6yRTonD+FzkbQ55LtHwJmkVy9CmRhZBq03Qi6x8Tn8jHIZcphHf2PxoXae
        vC5PoH5K+M/IrFnnoaMN8QPof2ZsEdA6yF7sE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 997AA930B8;
        Fri, 16 Oct 2020 16:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16D4A930B4;
        Fri, 16 Oct 2020 16:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
References: <20200809060810.31370-1-sunshine@sunshineco.com>
        <20200809174209.15466-1-sunshine@sunshineco.com>
        <20201016001704.GA2937048@coredump.intra.peff.net>
        <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
        <xmqqzh4maugq.fsf@gitster.c.googlers.com>
Date:   Fri, 16 Oct 2020 13:56:00 -0700
In-Reply-To: <xmqqzh4maugq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Oct 2020 11:36:53 -0700")
Message-ID: <xmqqv9f9ao0v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFFB0598-0FF1-11EB-B810-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, I agree that the "both must be file" is a bit too eager and
> ignores that "they must match, but the possible reasons they may not
> include one of them may be missing" use case.
>
>> =C3=86var ran into the same issue recently[1] and came up with the sam=
e
>> workaround. Despite its good intention (trying to catch bugs in
>> 'test_expect_failure' tests), this change[2] doesn't seem to have
>> caught any genuine bugs (it wouldn't even have caught the bug which
>> served as its inspiration[3]), but has nevertheless caused a couple
>> hiccups already. As such, I would not be opposed to seeing the change
>> reverted.
>
> Sounds good.  Anybody wants to do the honors?

For now I've queued this directly on top of the offending change and
merged the result in 'seen', perhaps to be advanced to 'next' and
'master' after the 2.29 final unless a better version comes.

Thanks.

-- >8 --
commit b0b2d8b4e00fd34c0031b6dbcd67b4bcf22d864c
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Oct 16 13:51:04 2020 -0700

    Revert "test_cmp: diagnose incorrect arguments"
   =20
    This reverts commit d572f52a64c6a69990f72ad6a09504b9b615d2e4; the
    idea to detect that "test_cmp expect actual" was fed a misspelt
    filename meant well, but when the version of Git tested exhibits a
    bug, the reason why these two files do not match may be because one
    of them did not get created as expected, in which case missing file
    is not a sign of misspelt filename but is a genuine test failure.
---
 t/test-lib-functions.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 21225330c2..3103be8a32 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -905,13 +905,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
=20
 test_cmp() {
-	test $# -eq 2 || BUG "test_cmp requires two arguments"
-	if ! eval "$GIT_TEST_CMP" '"$@"'
-	then
-		test "x$1" =3D x- || test -e "$1" || BUG "test_cmp '$1' missing"
-		test "x$2" =3D x- || test -e "$2" || BUG "test_cmp '$2' missing"
-		return 1
-	fi
+	eval "$GIT_TEST_CMP" '"$@"'
 }
=20
 # Check that the given config key has the expected value.
@@ -940,13 +934,7 @@ test_cmp_config() {
 # test_cmp_bin - helper to compare binary files
=20
 test_cmp_bin() {
-	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
-	if ! cmp "$@"
-	then
-		test "x$1" =3D x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
-		test "x$2" =3D x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
-		return 1
-	fi
+	cmp "$@"
 }
=20
 # Use this instead of test_cmp to compare files that contain expected an=
d
