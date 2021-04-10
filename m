Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C557C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DD7610D1
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDJLhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJLhj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 07:37:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E2C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 04:37:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g5so5927259ejx.0
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oh7Aop3zcJaKbV77crkskxbYDDOBESq05ObR4zA47d8=;
        b=moEVSsnydJyRwCKO+56H1XLim3C3+vdRc1a8zZeIFocHh1cqOrVFRtVcF6tEnqRq2f
         dV00JUdfGmNhO4aTGUwujC+cK9AUDceDYyFgcLnrptGVI3HI+zc9SlQfw1IXLSN3VpIs
         RY6TMJ0OBNgUuF2rz7lBOtBxsUM6y85iy4TsxRrgP5NEdt/eVHzsIxndP23drKSL7LZz
         PVpUT9Xwcs7FA7MKXJJZ+XiolAJ/8phB+bVaOJdGZ5EoNui4Wzc+zR7Y87kKugSRwRqT
         b2qTdT1QLRjiFEBXUtBWkAKCNUFUrEZwrOEtmhC+VYCpi7izj0ZL7pusC5uUZiR0Z8Z4
         mOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oh7Aop3zcJaKbV77crkskxbYDDOBESq05ObR4zA47d8=;
        b=lkqgZ26eWfEER5NlWG5Zz+sTaxZMMlZtPENFGuwEaK8DYOlRs/70kQ8b3LKJNv++92
         GdDBNR8tRW9YGqnXqgs3PWHyb5j8r2hFLVlFALygQ81mV+/0E4XWPx3S6OhIaYlXmBwv
         EaqjcZ74sZCONVxVbx3TAQB279kVjbYOV51C80g6to4eMjVhju0qIEsfAa7EmsLsdd49
         KXMWKk6DrPB4MI+jUD+SuzmU+Am9LLjdZ0UiDm9+7VF4zYzoC8DCZyYanW0+URMkYrIj
         tWXs1650K4hdFksjq/ugXaUfIHvOuQV9UdHtW1+yf9n2vVyMX1eTzDOoUFj6qM/dV8Oe
         pdHg==
X-Gm-Message-State: AOAM531xETDrz5tJ0cclZTZVbIVeE0rnpn+vLsYF+Bas8VhnIWsh/kXO
        HxLG+qVVOgfMJi0MFpOfsiU=
X-Google-Smtp-Source: ABdhPJx1QhxiuocvR/FCXnIc6487bCBpmtrFR5/o3+TgGQNJ10dGzTYmLlzRZOWE0YU6ZtaZT+TNzg==
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr19421902ejc.2.1618054642963;
        Sat, 10 Apr 2021 04:37:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s20sm2943839edu.93.2021.04.10.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:37:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
 <87o8eqjx0w.fsf@evledraar.gmail.com> <87im4yjspp.fsf@evledraar.gmail.com>
 <243a0aa1-7c0a-d2ab-49ff-8ea8cacc1b81@gmail.com>
 <87im4vgsvx.fsf@evledraar.gmail.com>
 <36aa6837-722c-9ef0-84cc-77e982db9f6e@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <36aa6837-722c-9ef0-84cc-77e982db9f6e@gmail.com>
Date:   Sat, 10 Apr 2021 13:37:21 +0200
Message-ID: <874kgegyku.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, Derrick Stolee wrote:

> On 4/9/2021 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Apr 09 2021, Derrick Stolee wrote:
>>=20
>>> On 4/7/2021 6:26 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> I think converting the whole thing to something like the WIP/RFC patch
>>>> below is much better and more readable.
>>>
>>> This is an interesting approach. I don't see you using the ERR that you
>>> are inputting anywhere, so that seems like an unnecessary bloat to the
>>> consumers. But maybe I haven't discovered all of the places where this
>>> would be useful, but it seems better to pipe stderr to a file for later
>>> comparison when needed.
>>=20
>> Yes, it's probably not a good default here. For the test-lib.sh tests
>> there's check_sub_test_lib_test and check_sub_test_lib_test_err, most of
>> the tests only test stdout.
>>=20
>>>> +test_expect_process_tree () {
>>>> +	depth=3D &&
>>>> +	>actual &&
>>>> +	cat >expect &&
>>>> +	cat <&3 >expect.err
>>>> +	while test $# !=3D 0
>>>> +	do
>>>> +		case "$1" in
>>>> +		--depth)
>>>> +			depth=3D"$2"
>>>> +			shift
>>>> +			;;
>>>> +		*)
>>>> +			break
>>>> +			;;
>>>> +		esac
>>>> +		shift
>>>> +	done &&
>>> Do you have an example where this is being checked? Or can depth
>>> be left as 1 for now?
>>=20
>> It can probably be hardcoded, but I was hoping someone more familiar
>> with trace2 would chime in, but I'm fairly sure there's not a way to do
>> it without parsing the existing output with either some clever
>> grep/awk-ing of the PERF output, or stateful parsing of the JSON.
>>=20
>> I thought that for git maintenance tests perhaps something wanted to
>> assert that we didn't have maintenance invoking maintenance, or that
>> something expected to prune refs really invoked the relevant prune
>> command via "gc".
>>=20
>>>> +	log=3D"$(pwd)/proc-tree.txt" &&
>>>> +	>"$log" &&
>>>> +	GIT_TRACE2_PERF=3D"$log" "$@" 2>actual.err &&
>>>> +	grep "child_start" proc-tree.txt >proc-tree-start.txt || : &&
>>>> +	if test -n "$depth"
>>>> +	then
>>>> +		grep " d$depth " proc-tree-start.txt >tmp.txt || : &&
>>>> +		mv tmp.txt proc-tree-start.txt
>>>> +	fi &&
>>>> +	sed -e 's/^.*argv:\[//' -e 's/\]$//' <proc-tree-start.txt >actual &&
>>>> +	test_cmp expect actual &&
>>>> +	test_cmp expect.err actual.err
>>>> +} 7>&2 2>&4
>>>
>>> I think similar ideas could apply to test_region. Giving it a try
>>> now.
>>=20
>> Probably, I didn't even notice that one...
>
> I gave this a few hours today, and I'm giving up. I'm the first to
> admit that I don't have the correct scripting skills to do some of
> these things.
>
> I've got what I tried below. It certainly looks like it would work.
> It solves the problem of "what if the test is flaky?" by ensuring that
> all subcommands (at depth 0) match the inputs exactly.

Looks good!

> However, the problem comes when trying to make that work for all of
> the maintenance tests, specifically the 'incremental-repack' task.
> That task dynamically computes a --batch-size=3DX parameter, and that
> is not stable across runs of the script.
>
> This was avoided in the past by only checking for the first of three
> subcommands when verifying that the 'incremental-repack' task worked.
> That is, except for the EXPENSIVE test that checks that the --batch-size
> maxes out at 2g.
>
> The thing that might make these changing parameters work is to allow
> the specified lines be a _prefix_ of the actual parameters. Or, let
> each line be a pattern that is checked against that line. Issues come
> up with how to handle this line-by-line check that I was unable to
> overcome.
>
> The good news is that the idea of adding a '--prefetch' option to
> 'git fetch' makes the change to t7900-maintenance.sh much easier,
> making this change to test_subcommand less of a priority.
>
> I include my attempt here as a patch. Feel free to take whatever
> you want of it, or none of it and start over. I do think that it
> makes the test script look much nicer.

I think a good way to deal with that is to have a lower-level helper
function that doesn't do the test_cmp, and instead just runs the
command, and leaves the stdout/stderr files in-place for another "check"
helper.

On a WIP topic I split up the t0000-basic.sh "test test-lib.sh itself"
code to do pretty much that:
https://github.com/avar/git/blob/avar/support-test-verbose-under-prove-2/t/=
lib-subtest.sh

It's basically back to the existing model of "run a command and grep it
later", except that we can pass the JSON through some basic parser, and
extract common cases like test_cmp, prefix munging before test_cmp etc.
