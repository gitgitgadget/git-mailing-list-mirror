Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36169C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBE161105
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDIT2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDIT2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:28:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970FC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:28:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so7792034edu.10
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5DwOgKetKDV7xZqVfKdjCUjo8MYjBBYA9qhMI1WMj20=;
        b=vSoFlniRMm7xiWDg+wsECWOO09UiAOPlmz+EbvmX0ohk/AQDSs0Ku0xBl3rYtbAF27
         j6IW9DoHeyH30anwy6l/wX4VzsCtGybTa0/qRiWphygbPTjAgeCx03tFb4trqffIHGEh
         71SiHN4VbFRcElQuKQJ0+HKdeZumoiSz0kFIj8pSrBR6lXc8ngTNBS6FMIt8I+3gIqRp
         MXFdgfK6ufs4BRlLBPn3TSOoDeIOJaTK4pNRBhYY/DUuUBzW4b7ERXmZyJgLmBCpQdoN
         EeiTf5jXkj9iy1SQddsLQmskKwlbs0gJQUBLzz1B+2eGhGZn/DpaOuiRB4S91lLEZUSg
         fCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5DwOgKetKDV7xZqVfKdjCUjo8MYjBBYA9qhMI1WMj20=;
        b=oGrRyRz9s5gf04Jx1uepENi1+/9/QGJVwAbX3XUABzZ9S8bYRxm1Xy3+MnrLj382eH
         hXE3CXqTcD7IJeYWEQQXqrNrJRbLP+wJJn16Hn1wK0jlPh2cxGdSeFwATrT5iiQv4CxD
         83kM9J0K8N6baJRu+w6VrUJtGPqu2/RuP+ERF4ma7GQCH3TTpaD62v1h4dydPxmDLfVD
         N4zT1k74vkDHUhawCmVg7a7TzznbWBL6bMZl45xeYibLU7RY9cfya7M7xm7o8PCiEQqr
         sR/oTV+bFGG6n8OAn9l8R+3nKN10E40+Mdp5auSOj59c4EzBQUFY3bdGjL0igqkelXb3
         5Ddg==
X-Gm-Message-State: AOAM531S7slGPrC0W9F6eCVjOwhh9lFaW7yCJRdn6T2bPfkpq9ixtXnN
        YilrgaFLYyUvsnG1/hMCgMA=
X-Google-Smtp-Source: ABdhPJxvBZUX6J5liXocg3vy4s094yWKwFIbgg9sA4jznG/WdxPstLoeHdGJ/4flkrmk3F27SvZa1Q==
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr11262288edb.251.1617996484599;
        Fri, 09 Apr 2021 12:28:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z20sm1921195edd.0.2021.04.09.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:28:03 -0700 (PDT)
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
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <243a0aa1-7c0a-d2ab-49ff-8ea8cacc1b81@gmail.com>
Date:   Fri, 09 Apr 2021 21:28:02 +0200
Message-ID: <87im4vgsvx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Derrick Stolee wrote:

> On 4/7/2021 6:26 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Apr 07 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>>> On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:
>>>> +	GIT_TRACE2_EVENT=3D"$(pwd)/prefetch-refspec.txt" git maintenance run=
 --task=3Dprefetch 2>/dev/null &&
>>>
>>> I see this is following some established convention in the file, but is
>>> there really not a way to make this pass without directing stderr to
>>> /dev/null? It makes ad-hoc debugging when reviewing harder.
>>=20
>> As I later found out this is copy/pasted to get around the fact that
>> --quiet is dependent on isatty(), so without this the result would be
>> different under --verbose and non-verbose testing.
>
> Yes, adding --quiet directly is a better pattern.
>
>> So that dates back to 3ddaad0e060 (maintenance: add --quiet option,
>> 2020-09-17), but I see other quiet=3Disatty(2) in related code. I wish we
>> could isolate that particular behavior so removing the 2>/dev/null when
>> debugging the tests doesn't cause you to run into this, maybe an
>> explicit --quiet or --no-quiet option for all but one test that's
>> checking that isatty() behavior?
>>=20
>>> I tried just removing it, but then (in an earlier test case) the
>>> "test_subcommand" fails because it can't find the line we're looking
>>> for, so us piping stderr to /dev/null impacts our trace2 output?
>>=20
>> I hadn't seen seen test_subcommand before, sorry to be blunt, but "ew!".
>
> Saying "I'm about to be rude" before being rude doesn't excuse it.
> I had to step away and get over this comment before I could examine
> the actually constructive feedback below.
>
> A better way to communicate the same information could be "This test
> helper seems more complicated than necessary, and has some gaps that
> could be filled." I completely agree with this statement.

I didn't mean to be rude, my understanding of "blunt" is more like
"forthright" or "without mincing words" or something to that effect, but
I'm not a native speaker of English, so I'll take your understanding
over mine and apologize, sorry.

What I meant to say is: When we look at some prior art in the test suite
that does similar things this pattern is needlessly convoluted, and
separates the command invocation from the test assert itself. Something
similar-ish to check_sub_test_lib_test would allow you to run the
command, but do any asserting of the proc tree in the helper.

>> So we're ad-hoc grepping trace2 JSON output just to find out whether we
>> invoked some subcommand. But unlike test_expect_code etc. this one
>> doesn't run git for you, but instead we have temp *.txt files and the
>> command disconnected from the run.
>>=20
>> And because you're using "grep" and "! grep" to test, you're hiding the
>> difference between "did not find this line" v.s. "did not find anything
>> at all".
>
> You're right that there is value in comparing the ordered list of
> subcommands run by a given Git command. That will catch buggy tests
> that are checking that a subcommand doesn't run.
>
>> Because of that the second test using test_subcommand is either buggy or
>> painfully non-obvious. We check that "run --auto" doesn't contain a
>> "auto --quiet", but in reality it doesn't contain any subcommands at
>> all. We didn't run any because it exited with "nothing to pack".
>
> That exit is from the third command, which does not pass the --auto
> command. The "nothing to pack" output is from the 'git gc --no-quiet'
> subcommand that is being checked in this third test.
>
>> I think converting the whole thing to something like the WIP/RFC patch
>> below is much better and more readable.
>
> This is an interesting approach. I don't see you using the ERR that you
> are inputting anywhere, so that seems like an unnecessary bloat to the
> consumers. But maybe I haven't discovered all of the places where this
> would be useful, but it seems better to pipe stderr to a file for later
> comparison when needed.

Yes, it's probably not a good default here. For the test-lib.sh tests
there's check_sub_test_lib_test and check_sub_test_lib_test_err, most of
the tests only test stdout.

>> +test_expect_process_tree () {
>> +	depth=3D &&
>> +	>actual &&
>> +	cat >expect &&
>> +	cat <&3 >expect.err
>> +	while test $# !=3D 0
>> +	do
>> +		case "$1" in
>> +		--depth)
>> +			depth=3D"$2"
>> +			shift
>> +			;;
>> +		*)
>> +			break
>> +			;;
>> +		esac
>> +		shift
>> +	done &&
> Do you have an example where this is being checked? Or can depth
> be left as 1 for now?

It can probably be hardcoded, but I was hoping someone more familiar
with trace2 would chime in, but I'm fairly sure there's not a way to do
it without parsing the existing output with either some clever
grep/awk-ing of the PERF output, or stateful parsing of the JSON.

I thought that for git maintenance tests perhaps something wanted to
assert that we didn't have maintenance invoking maintenance, or that
something expected to prune refs really invoked the relevant prune
command via "gc".

>> +	log=3D"$(pwd)/proc-tree.txt" &&
>> +	>"$log" &&
>> +	GIT_TRACE2_PERF=3D"$log" "$@" 2>actual.err &&
>> +	grep "child_start" proc-tree.txt >proc-tree-start.txt || : &&
>> +	if test -n "$depth"
>> +	then
>> +		grep " d$depth " proc-tree-start.txt >tmp.txt || : &&
>> +		mv tmp.txt proc-tree-start.txt
>> +	fi &&
>> +	sed -e 's/^.*argv:\[//' -e 's/\]$//' <proc-tree-start.txt >actual &&
>> +	test_cmp expect actual &&
>> +	test_cmp expect.err actual.err
>> +} 7>&2 2>&4
>
> I think similar ideas could apply to test_region. Giving it a try
> now.

Probably, I didn't even notice that one...
