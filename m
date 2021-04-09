Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E57C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B43610CC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhDILsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhDILsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 07:48:46 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9DC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 04:48:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so5358860otq.10
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3XecGcbxD/+fX9OaZbJMoQhUnzzYQ49DmqjEeMby/As=;
        b=F96GBZ0U5oO+PnafMsS9B7YddGQOx6tvymYSxXKtZR6ImHgpgrHLEzbevu4wqoLfAu
         V1WbXjmSj88QsxfLLV3Y8yL13I5VNPfXI3jdEFXXNMATcpdaT36lDtVjLrZWMpqRzurl
         nqzaAk7vbwdyeIfve+Xp3CO9XKoJZMe8gAV29Gl2HVV7RvaKo23oNlIV5vhOJUBK0o2x
         VWgCPlAvP2VaVRPd1MAvEkEuGHc9imfvEeswq65daPVT9zW2rPRf5MtTOaONhFy7hKgQ
         byscCuVA5IPwT4QMQ7+YwXjyEvYAOKkie4IWtl7nkMUMb5WOJMMSwdOHhcCwEzV4NLtJ
         7qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XecGcbxD/+fX9OaZbJMoQhUnzzYQ49DmqjEeMby/As=;
        b=HW5iG9jBDiNCSy2JZH5nDkmjG0u7R4Wk3/RETtDIz44uSVwrIbKNbclE6GkPaBqSC8
         CIED8yz6uX4yuZaXrh6trg91BdLXftqd599VMYlYUpbdAI1x+Jt/MxgsjHrpX23M42xR
         F9NRkjQKz5w3RGrv5u5+uU3tln0m79c3o6W0rj3TXWYSwEaKNWy1vuxmgoIzuT9anIkO
         sI7WfJoa67qdJv15SrrzTM89RFw4Q2tmG59AsAfLJT9pGgDNZWrY1iQwD3DDD0hhJgnu
         VjHopqLyXzPdwcu76C8WilAs5StYxZZN0yD0IKA//Iz4jEl+q5EPl9hyZPiE20iNvSHV
         0ZMQ==
X-Gm-Message-State: AOAM530KUPSDbZJvz/8qhplGJt6r5yySTP6cftNQM9HAjiaZ8EryGfjV
        d9t1ZPou6iRME0uf+1WoJLg=
X-Google-Smtp-Source: ABdhPJxotuJoP3YOQiR//D3BJ2TedW+66d7QBvnllqQy2A1qvl6LxgUeqllz2h7dtUWWQmSS9nqXHw==
X-Received: by 2002:a9d:5ae:: with SMTP id 43mr363089otd.347.1617968912771;
        Fri, 09 Apr 2021 04:48:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e556:d73b:6b67:5b9f? ([2600:1700:e72:80a0:e556:d73b:6b67:5b9f])
        by smtp.gmail.com with ESMTPSA id o23sm557143otp.45.2021.04.09.04.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 04:48:32 -0700 (PDT)
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
 <87o8eqjx0w.fsf@evledraar.gmail.com> <87im4yjspp.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <243a0aa1-7c0a-d2ab-49ff-8ea8cacc1b81@gmail.com>
Date:   Fri, 9 Apr 2021 07:48:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87im4yjspp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2021 6:26 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 07 2021, Ævar Arnfjörð Bjarmason wrote:
> 
>> On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:
>>> +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
>>
>> I see this is following some established convention in the file, but is
>> there really not a way to make this pass without directing stderr to
>> /dev/null? It makes ad-hoc debugging when reviewing harder.
> 
> As I later found out this is copy/pasted to get around the fact that
> --quiet is dependent on isatty(), so without this the result would be
> different under --verbose and non-verbose testing.

Yes, adding --quiet directly is a better pattern.

> So that dates back to 3ddaad0e060 (maintenance: add --quiet option,
> 2020-09-17), but I see other quiet=isatty(2) in related code. I wish we
> could isolate that particular behavior so removing the 2>/dev/null when
> debugging the tests doesn't cause you to run into this, maybe an
> explicit --quiet or --no-quiet option for all but one test that's
> checking that isatty() behavior?
> 
>> I tried just removing it, but then (in an earlier test case) the
>> "test_subcommand" fails because it can't find the line we're looking
>> for, so us piping stderr to /dev/null impacts our trace2 output?
> 
> I hadn't seen seen test_subcommand before, sorry to be blunt, but "ew!".

Saying "I'm about to be rude" before being rude doesn't excuse it.
I had to step away and get over this comment before I could examine
the actually constructive feedback below.

A better way to communicate the same information could be "This test
helper seems more complicated than necessary, and has some gaps that
could be filled." I completely agree with this statement.

> So we're ad-hoc grepping trace2 JSON output just to find out whether we
> invoked some subcommand. But unlike test_expect_code etc. this one
> doesn't run git for you, but instead we have temp *.txt files and the
> command disconnected from the run.
> 
> And because you're using "grep" and "! grep" to test, you're hiding the
> difference between "did not find this line" v.s. "did not find anything
> at all".

You're right that there is value in comparing the ordered list of
subcommands run by a given Git command. That will catch buggy tests
that are checking that a subcommand doesn't run.

> Because of that the second test using test_subcommand is either buggy or
> painfully non-obvious. We check that "run --auto" doesn't contain a
> "auto --quiet", but in reality it doesn't contain any subcommands at
> all. We didn't run any because it exited with "nothing to pack".

That exit is from the third command, which does not pass the --auto
command. The "nothing to pack" output is from the 'git gc --no-quiet'
subcommand that is being checked in this third test.

> I think converting the whole thing to something like the WIP/RFC patch
> below is much better and more readable.

This is an interesting approach. I don't see you using the ERR that you
are inputting anywhere, so that seems like an unnecessary bloat to the
consumers. But maybe I haven't discovered all of the places where this
would be useful, but it seems better to pipe stderr to a file for later
comparison when needed.
> +test_expect_process_tree () {
> +	depth= &&
> +	>actual &&
> +	cat >expect &&
> +	cat <&3 >expect.err
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		--depth)
> +			depth="$2"
> +			shift
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done &&
Do you have an example where this is being checked? Or can depth
be left as 1 for now?

> +	log="$(pwd)/proc-tree.txt" &&
> +	>"$log" &&
> +	GIT_TRACE2_PERF="$log" "$@" 2>actual.err &&
> +	grep "child_start" proc-tree.txt >proc-tree-start.txt || : &&
> +	if test -n "$depth"
> +	then
> +		grep " d$depth " proc-tree-start.txt >tmp.txt || : &&
> +		mv tmp.txt proc-tree-start.txt
> +	fi &&
> +	sed -e 's/^.*argv:\[//' -e 's/\]$//' <proc-tree-start.txt >actual &&
> +	test_cmp expect actual &&
> +	test_cmp expect.err actual.err
> +} 7>&2 2>&4

I think similar ideas could apply to test_region. Giving it a try
now.

-Stolee
