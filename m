Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C2BC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 22:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4F06052B
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhKCWq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 18:46:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56822 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCWq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 18:46:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD881E5EB0;
        Wed,  3 Nov 2021 18:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xPCDb4NfnrCM
        DZHwvcHv7/JQSXkRkT0kRA1sJ7acQOo=; b=yegn1zBxYsTvZZJEAaFE31tTZ/uB
        cL/+vjBrTCoiiYrOQ6PPjQ30RGoErF03wKhQLPqbFXkaXwvxDK5KbsyZb7AoA2pL
        5dGkW2x/P/Y12cOhyTnfU0zjbvB9fJgjWz6c+Q06QI8GvxPMvuctQqoYCF2qt4UV
        q29XhoAB619cWAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92600E5EAF;
        Wed,  3 Nov 2021 18:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9AC5E5EAE;
        Wed,  3 Nov 2021 18:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re* [PATCH v8 2/2] tests: add a test mode for SANITIZE=leak, run it
 in CI
References: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
        <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
        <patch-v8-2.2-90ecd49c910-20210923T091819Z-avarab@gmail.com>
Date:   Wed, 03 Nov 2021 15:44:17 -0700
In-Reply-To: <patch-v8-2.2-90ecd49c910-20210923T091819Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Sep
 2021 11:20:46
        +0200")
Message-ID: <xmqq4k8s6eri.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9496C79A-3CF7-11EC-827B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue test
> mode. When running in that mode, we'll assert that we were compiled
> with SANITIZE=3Dleak. We'll then skip all tests, except those that we'v=
e
> opted-in by setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
> ...
> This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=3Dtrue" wil=
l
> be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue:

I've been playing with this locally, but cannot shake the nagging
feeling that GIT_TEST_PASSING_SANITIZE_LEAK must default to true.
Otherwise, it is one more thing they need to find out and set when
they do

    make SANITYZE=3Dleak test

because they want to be a good developer and to ensure that they did
not introduce new leaks.

If we want to encourage folks to locally run the leak checks before
declaring their own work "done", that is.

Those who are hunting for and cleaning up existing leaks can and
should set it to false, no?


In any case, here is a small fallout out of my adventure into this
corner.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: t0006: date_mode can leak .strftime_fmt member

As there is no date_mode_release() API function, and given the
set of current callers it probably is not worth adding one, let's
release the .strftime_fmt member that is obtained from strdup()
before the caller of show_date() is done with it.

This allows us to mark t0006 as passing under the leak sanitizer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-date.c | 2 ++
 t/t0006-date.sh      | 2 ++
 2 files changed, 4 insertions(+)

diff --git c/t/helper/test-date.c w/t/helper/test-date.c
index 099eff4f0f..e15ea02626 100644
--- c/t/helper/test-date.c
+++ w/t/helper/test-date.c
@@ -53,6 +53,8 @@ static void show_dates(const char **argv, const char *f=
ormat)
=20
 		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
 	}
+
+	free((void *)mode.strftime_fmt);
 }
=20
 static void parse_dates(const char **argv)
diff --git c/t/t0006-date.sh w/t/t0006-date.sh
index 6b757d7169..5d01f57b27 100755
--- c/t/t0006-date.sh
+++ w/t/t0006-date.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test date parsing and printing'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # arbitrary reference time: 2009-08-30 19:20:00
