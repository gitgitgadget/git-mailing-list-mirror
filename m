Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FAC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 09:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B4760233
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 09:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhFNJ6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNJ6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 05:58:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19442C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 02:56:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b11so45684195edy.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oKwJqCiy3QbGEaIex4NhBrWqrLYqAw5+s6Av3vvDyTY=;
        b=TWY6f6ojblXVwjy/PpTHU9ZoP/dmvoVzPLJxFkMJb6tIcqyfuH7ZmbI+LghdUnTW1S
         bXJf5OWrtLzO9wr2tUzx27Y/IuysiWGAcmg+KiVsTSioewkpnNByVvGn/+ymcOamZpFw
         XkL0YGICajxHyOm9vps408lYZGilkyjsU6ESXJZmu5oExIbu/aabnyLq/TiY805xfEmI
         LSxIdRtmj5q4XsTQOhyiC/44Sabcw+XO7e5inIBCD/kJWcy72CF/Bg/GH1mZBI1aZrNm
         fIbNPNXbSUG0M1KbJ5eoYkuIU8aWR40s/kIGFVLo7P2jGd6pIv05wDTHvNdzgV5BA1p6
         clDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oKwJqCiy3QbGEaIex4NhBrWqrLYqAw5+s6Av3vvDyTY=;
        b=FxsiyuHCjeJoCFWFMPGRpok6/1vHHT8Ww/qAMd913TnMZDgY/5O/OWQkaK6jfvvDnS
         M8lvccwjtyD0VG7eJgooZEwFh0xgTlN5P2Kwdbo64J8yxJXjj13x+tJhM/GB78E5yorC
         yhBX0NXoaZNoOdpQoNm/4KpFTA522fu3K/iuNRTvHCRw0LuwgyrPt7xCmeD1SujVsadm
         JQQcXT8viuUjbeQaa9B6/0qK4thtLuu1Q+nstBQxf68BO+nwq2VR8snjtIZdiRys4/UL
         4tJ+Q95rqcA0Humxu0Nv8JfIl5qOjv4HNfLOFfkLB//0VOUOxg+YkLHfy91yzT5fWqlc
         foxg==
X-Gm-Message-State: AOAM533C43cUfYNxbIjhDvnF32HLMIXtto1xmmXeosB3eAInd7eGXOWk
        b4ahwkdSYUcqx4PT/I+WGy8=
X-Google-Smtp-Source: ABdhPJygzpJuYcg84e0ToW6SVctuWXspZswYYczJLOBZSTx6InnwFIfp1UIAGGb/XY3kNg0XISV+sw==
X-Received: by 2002:aa7:d6cc:: with SMTP id x12mr16182459edr.55.1623664585600;
        Mon, 14 Jun 2021 02:56:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bn7sm7088595ejb.111.2021.06.14.02.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:56:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Mon, 14 Jun 2021 11:33:12 +0200
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60c715dd9939e_436208f3@natae.notmuch>
Message-ID: <8735tk22if.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, Felipe Contreras wrote:

> Jeff King wrote:
>> On Sun, Jun 13, 2021 at 10:44:10AM -0500, Felipe Contreras wrote:
>> 
>> > > Unfortunately, this isn't a complete solution.
>> > 
>> > Software will never be perfect.
>> > 
>> > We don't need to wait for a perfect solution, all we need is something
>> > better than the current siuation.
>> 
>> Sure, but if you don't fully understand the situation (e.g., that --root
>> and TEST_OUTPUT_DIRECTORY are not equivalent), then you may end up
>> revisiting the incomplete fix later,
>
> The fact that you may end up revisiting a solution is a fact for *all*
> changes (including 2d14e13c56 (test output: respect
> $TEST_OUTPUT_DIRECTORY, 2013-04-29)).
>
>> or even making things worse (as this patch did).
>
> I think breaking the test suite is objectively worse than having a few
> extra files in the output directory, but to each his own.

We've got both in-tree and out-tree things that rely on e.g. the
*.counts in that directory to have a 1=1 mapping with "real"
tests. E.g. "make aggregate-results".

>> > > I think solving the whole issue would require a mechanism for passing
>> > > TEST_OUTPUT_DIRECTORY in a way that can't be overridden (whether in an
>> > > environment variable or the command-line).
>> > 
>> > Why do we even have TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS? Looking
>> > for a reason there's 2d14e13c56 (test output: respect
>> > $TEST_OUTPUT_DIRECTORY, 2013-04-29), there it says it's for
>> > valgrind/analyze.sh.
>> > 
>> > I don't know who uses that script, or how. There's no documentaion,
>> > nothing on the mailing list, and nothing found on Google.
>> 
>> Perhaps 268fac6919 (Add a script to coalesce the valgrind outputs,
>> 2009-02-04) is enlightening.
>
> That makes it clearer.
>
>> I don't know if anybody still uses it these days, though. I suspect it's
>> outlived its usefulness, in that we would typically not have any
>> valgrind errors at all (so coalescing them is not that interesting).
>> 
>> Possibly folks investigating leak-checking via valgrind could find it
>> useful, but even there I think LSan is a much better path forward.
>
> Yeah, but even if they do run this tool, they can set
> TEST_OUTPUT_DIRECTORY manually.
>
> The needs of the few should not otweight needs of the many.

Do we need to bring Spock into this?:)

I think the following alternate/on-top patch (which you should feel free
to squash in with my SOB if you agree) solves the issue both of you are
noting.

It will barf if you run the tests under e.g. --tee with that environment
variable, but that's intentional. It's better to loudly error if we
don't have the expected test-results than to silently write in the wrong
place.

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2c6e34b9478..29bf67d49bf 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -76,6 +76,12 @@ _run_sub_test_lib_test_common () {
 		# this variable, so we need a stable setting under which to run
 		# the sub-test.
 		sane_unset HARNESS_ACTIVE &&
+
+		# These tests should emit no metrics or output that
+		# would normally go in the "test-results" directory.
+		TEST_NO_RESULTS_OUTPUT=1 &&
+		export TEST_NO_RESULTS_OUTPUT &&
+
 		cd "$name" &&
 		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
 		test_description='$descr (run in sub test-lib)
@@ -89,14 +95,12 @@ _run_sub_test_lib_test_common () {
 		EOF
 		cat >>"$name.sh" &&
 		export TEST_DIRECTORY &&
-		TEST_OUTPUT_DIRECTORY=$(pwd) &&
-		export TEST_OUTPUT_DIRECTORY &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
 		if test -z "$neg"
 		then
-			./"$name.sh" "$@" >out 2>err
+			./"$name.sh" --root="$(pwd)" "$@" >out 2>err
 		else
-			! ./"$name.sh" "$@" >out 2>err
+			! ./"$name.sh" --root="$(pwd)" "$@" >out 2>err
 		fi
 	)
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c64279..9e9696a3185 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -252,8 +252,14 @@ TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
 TEST_NAME="$(basename "$0" .sh)"
 TEST_NUMBER="${TEST_NAME%%-*}"
 TEST_NUMBER="${TEST_NUMBER#t}"
-TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
-TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
+if test -n "$TEST_NO_RESULTS_OUTPUT"
+then
+	TEST_RESULTS_DIR=/dev/null
+	TEST_RESULTS_BASE=/dev/null
+else
+	TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
+	TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
+fi
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
@@ -1124,7 +1130,7 @@ test_done () {
 
 	finalize_junit_xml
 
-	if test -z "$HARNESS_ACTIVE"
+	if test -z "$HARNESS_ACTIVE$TEST_NO_RESULTS_OUTPUT"
 	then
 		mkdir -p "$TEST_RESULTS_DIR"
 
