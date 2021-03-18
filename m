Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973FC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC40464EB6
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhCRVRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:17:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64166 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhCRVRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:17:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE120AEE12;
        Thu, 18 Mar 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5BkwyQc2M6GaZ9dtWJQDGRMgk4=; b=ZDYao+
        o6PyRi/ppdHsh6D6KcuZFOlKMDXHx9tEprvpA22kyqODD0y5U6PZghkIhRk9125d
        j8NuVGETSxMU93yySV2ARME4J6ZZf0NIScD4p60AVzoz/7+8NbBN631bmDQVWrGo
        lYUXmxmOyAW4UH5brkqWspmsDdF+zDGTlW6a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wLm5GRH3V9MEsr44bpL7YeWBGTEcc7h3
        DfOXfGXB1UkuU2ALOi2gEVF4y/ifnO0zKbEo2UvWUuoN8xd1FlyISQw6Km+I6EDX
        pURCkpt/aQzbp0XC1ROKgfkj5MP+SGjoFZybGOSWCnRATFDBTIniCIJXsX691+Da
        kWIyDXPSHBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5EFCAEE11;
        Thu, 18 Mar 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5245DAEE0F;
        Thu, 18 Mar 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Son Luong Ngoc <sluongng@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH] t: annotate !PTHREADS tests with !FAIL_PREREQS
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
        <YFC33vfLb36pRCO6@nand.local>
        <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
        <YFJCUOCQGKHX2/So@coredump.intra.peff.net>
        <YFKG52H090l/GbP7@coredump.intra.peff.net>
Date:   Thu, 18 Mar 2021 14:17:19 -0700
In-Reply-To: <YFKG52H090l/GbP7@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 17 Mar 2021 18:47:03 -0400")
Message-ID: <xmqqblbgrwkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5312FEF6-882F-11EB-B483-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> So I think the FAIL_PREREQS mode should probably be treating negated
>> prereqs differently (and always pretending that yes, we have them).
>> 
>> I hadn't investigated the t7810 case yet, but looking at it now, it
>> seems to be the exact same thing.
>
> It looks like the problem is indeed somewhat widespread, and there is a
> magic prereq already to skip such tests.
>
> I do still think that this is a fundamental failing of the FAIL_PREREQS
> mode, but it probably makes sense to annotate these tests in the
> meantime (I don't plan on looking further into it myself).

The README file in t/ directory claims that this "is useful for
discovering issues with the tests where say a later test implicitly
depends on an optional earlier test." but apparently it does not
work well with these negated prerequisites.  Its implementation
probably should force a safe bypass of the whole test_have_prereq()
etc. done in test_skip by hooking into test_verify_prereq and
overwrite any non-empty test_prereq with a single hardcoded
PRETEND_FAIL_PREREQ prerequisite that is never satisfied, or
something.

> Another rough edge I noticed: if you set GIT_TEST_HTTPD or
> GIT_TEST_GIT_DAEMON to "yes" in your config.mak, these play quite badly
> with GIT_TEST_FAIL_PREREQS. We think NOT_ROOT is not satisfied, so
> refuse to start httpd, and then complain that the setup fails (and the
> point of "yes" for those values is to loudly complain when setup fails,
> rather than quietly skipping the tests).

... and I think this would also be gone, as the NOT_ROOT test is
done with test_have_prereq that we wouldn't be mucking with if we
limit the FAIL_PREREQS only to tweak the test_expect_* prereqs.

In short, the biggest mistake in the current FAIL_PREREQS design is
to hook into test_have_prereq while the stated objective only needs
to futz with the prerequisite given to the test_expect_* functions,
I would think.

> -- >8 --
> Subject: [PATCH] t: annotate !PTHREADS tests with !FAIL_PREREQS
>
> Some tests in t5300 and t7810 expect us to complain about a "--threads"
> argument when Git is compiled without pthread support. Running these
> under GIT_TEST_FAIL_PREREQS produces a confusing failure: we pretend to
> the tests that there is no pthread support, so they expect the warning,
> but of course the actual build is perfectly happy to respect the
> --threads argument.
>
> We never noticed before the recent a926c4b904 (tests: remove most uses
> of C_LOCALE_OUTPUT, 2021-02-11), because the tests also were marked as
> requiring the C_LOCALE_OUTPUT prerequisite. Which means they'd never
> have run in FAIL_PREREQS mode, since it would always pretend that the
> locale prereq was not satisfied.
>
> These tests can't possibly work in this mode; it is a mismatch between
> what the tests expect and what the build was told to do. So let's just
> mark them to be skipped, using the special prereq introduced by
> dfe1a17df9 (tests: add a special setup where prerequisites fail,
> 2019-05-13).
>
> Reported-by: Son Luong Ngoc <sluongng@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5300-pack-object.sh | 6 ++++--
>  t/t7810-grep.sh        | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index d586fdc7a9..e830a37a38 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -427,7 +427,8 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
>  	test_path_is_file foo.idx
>  '
>  
> -test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
> +test_expect_success !PTHREADS,!FAIL_PREREQS \
> +	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
>  	test_must_fail git index-pack --threads=2 2>err &&
>  	grep ^warning: err >warnings &&
>  	test_line_count = 1 warnings &&
> @@ -445,7 +446,8 @@ test_expect_success !PTHREADS 'index-pack --threads=N or pack.threads=N warns wh
>  	grep -F "no threads support, ignoring pack.threads" err
>  '
>  
> -test_expect_success !PTHREADS 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
> +test_expect_success !PTHREADS,!FAIL_PREREQS \
> +	'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
>  	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
>  	grep ^warning: err >warnings &&
>  	test_line_count = 1 warnings &&
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index edfaa9a6d1..5830733f3d 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -969,7 +969,8 @@ do
>  	"
>  done
>  
> -test_expect_success !PTHREADS 'grep --threads=N or pack.threads=N warns when no pthreads' '
> +test_expect_success !PTHREADS,!FAIL_PREREQS \
> +	'grep --threads=N or pack.threads=N warns when no pthreads' '
>  	git grep --threads=2 Hello hello_world 2>err &&
>  	grep ^warning: err >warnings &&
>  	test_line_count = 1 warnings &&
