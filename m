Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA7C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3916124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 10:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhDGK0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhDGK0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 06:26:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D02C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 03:26:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so4250003ejj.3
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ef+QDhZ6iGM9y/1CBILp1Lpi98MKjOZl8RwlZsXREPU=;
        b=TeKRBKyVW6HPdt5sGPMfXuJ8bAwLcZ8dCDf3C5F+qnYQx57Tg3qik0MKnFE2MvM2Nw
         RhAEogn1g7qI77J7LT9k46Id9Q3GNUJYWSMdnKjpCowRjCq8uhvSfRDwpc9VnkXzkx13
         Ifz7omtaZ9Af1CK3Pdyz1h3uv83e3TJFeGANvP7MWgsn6yISzQTwHh2FxNRdkUenvGy5
         kiEBhxLRP9S/eINMeDaxigVpcg0W+NHyniBnktZHwFBivMp7r1/mBkZ57bAm2jgqSg5m
         uZ41a4kZLh2hSVSKrW/e83YzL/lr4iMsqivL/+ryUzaP/GlLDYO2NB/sH7V9hX+bTJbU
         cf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ef+QDhZ6iGM9y/1CBILp1Lpi98MKjOZl8RwlZsXREPU=;
        b=Z2O6n2Kgl0KGuWROyRD5rwYQFKAAr1quToD+u9kc7i5XDpopE1G9P/yc8O+EcuHa/+
         lAOkf74YWM1xFHFgwLqFP5WtO4Sk4Q8+S5fNNtY3byB4A1H8zULT46Pp4ZUQmgW910uy
         pA/IZUIYoD0dvhVRTqE8z1c/2g8hDzy8zm2IDaOA0jcQr1DAHaT2EXpI12ZhKyGVDm97
         gCZG+WRQ+TXA5OZ6qQa78nXvC+K5KQU1OBTzL61TCx7mV1Ze12Oy7NqK60ZB+1l215bu
         84r08WgAON278ED0/oOWxnaKmWUdwux0vtaqU7+wAmDNpGv/8m07Qin2LadPbM8GN4bZ
         gfKQ==
X-Gm-Message-State: AOAM532xIHjPgw4yrrk2ZpwTLZKyAhHWiEztBWrVTxut/aPhJcIsbpnp
        m7sEhg3RDwVEQlIxRppgWLGTjEQpxViuuA==
X-Google-Smtp-Source: ABdhPJyvuXplXHPINfwxj/jKxuAydIBA3XeOzP3iA2AxqR5J6whCsrJ1OIvzQsiXjQc/9fiu7oajLA==
X-Received: by 2002:a17:906:e286:: with SMTP id gg6mr2891204ejb.37.1617791203374;
        Wed, 07 Apr 2021 03:26:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v8sm15331795edc.30.2021.04.07.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:26:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
 <87o8eqjx0w.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <87o8eqjx0w.fsf@evledraar.gmail.com>
Date:   Wed, 07 Apr 2021 12:26:42 +0200
Message-ID: <87im4yjspp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 07 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:
>
>> [...]
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index fc2315edec11..3366ea188782 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
>>  	test_commit -C clone2 two &&
>>  	GIT_TRACE2_EVENT=3D"$(pwd)/run-prefetch.txt" git maintenance run --tas=
k=3Dprefetch 2>/dev/null &&
>>  	fetchargs=3D"--prune --no-tags --no-write-fetch-head --recurse-submodu=
les=3Dno --refmap=3D --quiet" &&
>> -	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefet=
ch/remote1/* <run-prefetch.txt &&
>> -	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefet=
ch/remote2/* <run-prefetch.txt &&
>> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefet=
ch/remotes/remote1/* <run-prefetch.txt &&
>> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefet=
ch/remotes/remote2/* <run-prefetch.txt &&
>>  	test_path_is_missing .git/refs/remotes &&
>> -	git log prefetch/remote1/one &&
>> -	git log prefetch/remote2/two &&
>> +	git log prefetch/remotes/remote1/one &&
>> +	git log prefetch/remotes/remote2/two &&
>>  	git fetch --all &&
>> -	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
>> -	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
>> +	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/on=
e &&
>> +	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/tw=
o &&
>>=20=20
>>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>>  	git log --oneline --decorate --all >log &&
>>  	! grep "prefetch" log
>>  '
>>=20=20
>> +test_expect_success 'prefetch custom refspecs' '
>> +	git -C clone1 branch -f special/fetched HEAD &&
>> +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
>> +
>> +	# create multiple refspecs for remote1
>> +	git config --add remote.remote1.fetch +refs/heads/special/fetched:refs=
/heads/fetched &&
>> +	git config --add remote.remote1.fetch ^refs/heads/special/secret/not-f=
etched &&
>> +
>> +	GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-refspec.txt" git maintenance run -=
-task=3Dprefetch 2>/dev/null &&
>
> I see this is following some established convention in the file, but is
> there really not a way to make this pass without directing stderr to
> /dev/null? It makes ad-hoc debugging when reviewing harder.

As I later found out this is copy/pasted to get around the fact that
--quiet is dependent on isatty(), so without this the result would be
different under --verbose and non-verbose testing.

So that dates back to 3ddaad0e060 (maintenance: add --quiet option,
2020-09-17), but I see other quiet=3Disatty(2) in related code. I wish we
could isolate that particular behavior so removing the 2>/dev/null when
debugging the tests doesn't cause you to run into this, maybe an
explicit --quiet or --no-quiet option for all but one test that's
checking that isatty() behavior?

> I tried just removing it, but then (in an earlier test case) the
> "test_subcommand" fails because it can't find the line we're looking
> for, so us piping stderr to /dev/null impacts our trace2 output?

I hadn't seen seen test_subcommand before, sorry to be blunt, but "ew!".

So we're ad-hoc grepping trace2 JSON output just to find out whether we
invoked some subcommand. But unlike test_expect_code etc. this one
doesn't run git for you, but instead we have temp *.txt files and the
command disconnected from the run.

And because you're using "grep" and "! grep" to test, you're hiding the
difference between "did not find this line" v.s. "did not find anything
at all".

Because of that the second test using test_subcommand is either buggy or
painfully non-obvious. We check that "run --auto" doesn't contain a
"auto --quiet", but in reality it doesn't contain any subcommands at
all. We didn't run any because it exited with "nothing to pack".

I think converting the whole thing to something like the WIP/RFC patch
below is much better and more readable.

The pattern is basically stolen from test_commit and
check_sub_test_lib_test_err, respectively.

As an aside: The new test_expect_process_tree function would be much
less painful if we had a helper that took the JSON output and emitted
some sensible subset of the information therein. For now I just ad-hoc
grepped the "perf" output. AFAICT the only way to get "depth" from
trace2's JSON so to count slashes in SIDs.

In the case of your tests you're mostly/(only?) interested in a slice of
the "child_start" events. If we had a helper to spew out a pretty-print
version of that (or a subset of it) we could test_cmp against that
directly.

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 3366ea18878..d03fb361562 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -30,28 +30,41 @@ test_expect_success 'help text' '
 '
=20
 test_expect_success 'run [--auto|--quiet]' '
-	GIT_TRACE2_EVENT=3D"$(pwd)/run-no-auto.txt" \
-		git maintenance run 2>/dev/null &&
-	GIT_TRACE2_EVENT=3D"$(pwd)/run-auto.txt" \
-		git maintenance run --auto 2>/dev/null &&
-	GIT_TRACE2_EVENT=3D"$(pwd)/run-no-quiet.txt" \
-		git maintenance run --no-quiet 2>/dev/null &&
-	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
-	test_subcommand git gc --no-quiet <run-no-quiet.txt
+	test_expect_process_tree --depth 0 git maintenance run <<-\OUT 3<<-\ERR &&
+	git gc --quiet
+	OUT
+	ERR
+
+	test_expect_process_tree --depth 0 git maintenance run --auto <<-\OUT 3<<=
-\ERR &&
+	OUT
+	ERR
+
+	test_expect_process_tree --depth 0 git maintenance run --quiet <<-\OUT 3<=
<-\ERR &&
+	git gc --quiet
+	OUT
+	ERR
+
+	test_expect_process_tree --depth 0 git maintenance run --no-quiet <<-\OUT=
 3<<-\ERR
+	git gc --no-quiet
+	OUT
+	ERR
 '
=20
 test_expect_success 'maintenance.auto config option' '
-	GIT_TRACE2_EVENT=3D"$(pwd)/default" git commit --quiet --allow-empty -m 1=
 &&
-	test_subcommand git maintenance run --auto --quiet <default &&
-	GIT_TRACE2_EVENT=3D"$(pwd)/true" \
-		git -c maintenance.auto=3Dtrue \
-		commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet  <true &&
-	GIT_TRACE2_EVENT=3D"$(pwd)/false" \
-		git -c maintenance.auto=3Dfalse \
-		commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet  <false
+	test_expect_process_tree git commit --quiet --allow-empty -m 1 <<-\OUT 3<=
<-\ERR &&
+	git maintenance run --auto --quiet
+	OUT
+	ERR
+
+	test_expect_process_tree git commit --quiet --allow-empty -m 2 <<-\OUT 3<=
<-\ERR &&
+	git maintenance run --auto --quiet
+	OUT
+	ERR
+
+	test_expect_process_tree git commit --quiet --allow-empty -m 3 <<-\OUT 3<=
<-\ERR
+	git maintenance run --auto --quiet
+	OUT
+	ERR
 '
=20
 test_expect_success 'maintenance.<task>.enabled' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a5915dec22d..cd1187b473c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1625,6 +1625,38 @@ test_path_is_hidden () {
 	return 1
 }
=20
+test_expect_process_tree () {
+	depth=3D &&
+	>actual &&
+	cat >expect &&
+	cat <&3 >expect.err
+	while test $# !=3D 0
+	do
+		case "$1" in
+		--depth)
+			depth=3D"$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+	log=3D"$(pwd)/proc-tree.txt" &&
+	>"$log" &&
+	GIT_TRACE2_PERF=3D"$log" "$@" 2>actual.err &&
+	grep "child_start" proc-tree.txt >proc-tree-start.txt || : &&
+	if test -n "$depth"
+	then
+		grep " d$depth " proc-tree-start.txt >tmp.txt || : &&
+		mv tmp.txt proc-tree-start.txt
+	fi &&
+	sed -e 's/^.*argv:\[//' -e 's/\]$//' <proc-tree-start.txt >actual &&
+	test_cmp expect actual &&
+	test_cmp expect.err actual.err
+} 7>&2 2>&4
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
