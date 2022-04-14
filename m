Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C55C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 10:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiDNK3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiDNK26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 06:28:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EFF716D0
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 03:26:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79CCB179904;
        Thu, 14 Apr 2022 06:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RB/YAtkS4OYM3noKZQ1qj4bel
        T/Uq4EPDFpL/mEeWsU=; b=El+kUNCkyFCbdA7VS8s6CA47oZfReV00PQO4Mj5Fs
        f7AKQcoziE+NTWU9nQh4QptpShHubVZOTQh9fTzhqKIocOyrqBFWtbEURTlH0Ejq
        oTY0ZzI/UASAAdB7yr7c6H2SuTeViUYURZ9HvVF0EulS0ncLDVTFUQ7lgNaWJ/FV
        D4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71DD0179903;
        Thu, 14 Apr 2022 06:26:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72F99179902;
        Thu, 14 Apr 2022 06:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH v4 0/6] CI: js/ci-github-workflow-markup rebased on
 "use $GITHUB_ENV"
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
        <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
Date:   Thu, 14 Apr 2022 03:26:26 -0700
Message-ID: <xmqq35ig2c6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 584737A6-BBDD-11EC-B2EE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> 6:  1d2b94436fc ! 6:  b291f64821c ci: call `finalize_test_case_output` =
a little later
>     @@ t/test-lib.sh: trap '{ code=3D$?; set +x; } 2>/dev/null; exit $c=
ode' INT TERM HUP
>       	test_failure=3D$(($test_failure + 1))
>       	say_color error "not ok $test_count - $1"
>       	shift
>     - 	printf '%s\n' "$*" | sed -e 's/^/#	/'
>     - 	test "$immediate" =3D "" || _error_exit
>     +@@ t/test-lib.sh: test_failure_ () {
>     + 		say_color error "1..$test_count"
>     + 		_error_exit
>     + 	fi
>      +	finalize_test_case_output failure "$failure_label" "$@"
>       }

This part, specifically the following from [6/6], looks iffy. =20

@@ -782,13 +782,13 @@ trap '{ code=3D$?; set +x; } 2>/dev/null; exit $cod=
e' INT TERM HUP
 # the test_expect_* functions instead.
=20
 test_ok_ () {
-	finalize_test_case_output ok "$@"
 	test_success=3D$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
+	finalize_test_case_output ok "$@"
 }
=20
 test_failure_ () {
-	finalize_test_case_output failure "$@"
+	failure_label=3D$1
 	test_failure=3D$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -798,18 +798,19 @@ test_failure_ () {
 		say_color error "1..$test_count"
 		_error_exit
 	fi
+	finalize_test_case_output failure "$failure_label" "$@"
 }
=20


With the other 29-patch series applied on the same base as before,
test_failure_ does not have such "fi" inside.  Misapplication of
rebase or something?

In any case, I've wiggled both series in and rebuilt 'seen'.
Looking good as before.

Thanks.

