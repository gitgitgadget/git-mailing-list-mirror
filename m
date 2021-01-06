Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC99FC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7323332
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbhAFW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAFW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:59:53 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF3C061799
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 14:59:13 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id t3so747561ilh.9
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BbwlFHzOaNreCqtRAtT/vz+SID0jYt08PLVPH4HRNuU=;
        b=kBkURHH1BVSO2zoL0Bi8I3y6HiJXN6yZcNZLJG1XhpyzzQh8A4TXXnkfvOzOX2PAJn
         Ek/NkQ+n2P6gy37+Zuh3fKrURuJocQ9nfpCBBu07NlLHDPdsOOQ2jllUEVZqbOPkORaL
         KwTELoUDU01V7KR9ihyvESqfHV41GBiIYSsiXgmKPYn27BfbA4J/GoR8n9skRO9VB6Ye
         2QHmEELgzpLRYNE2ZxXVSA1LIp4XPfLG0Et3Bnb3BZ6ccsu2sTh4dMYVoP4A29JgVKYq
         KrNZJ/7k6F4WOwFEo24eYMN0jHcACPRm/zw3Kb4Aq8nfqMxm949yhFkCHfIwmCM62MdH
         dapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BbwlFHzOaNreCqtRAtT/vz+SID0jYt08PLVPH4HRNuU=;
        b=ffLu5+rftK1BoXhoQlTzC0OVtunjfrK2ZECYXw4rTtdi2/8v3J5AXsqbhdX59X+RqU
         ygnRzMhruoeJNGWXMngDKRBNFasTl/hdfz6FYotxRIxbdOa2F8ipFvVps4lvXDlDTDpO
         PuiJ/tNW0e+8pVrOzbuX1qtrnTJRERKSoN1NJpS7YTLEgT0oPmrAfJFisIlkoxL3ntcj
         TpC0U0J2A2wfGgx1hE+NG5NHGAMal4jzDcwcYSucNI1N+AyKxXlSeNO2yO+zSm1Fi9Mb
         f2pezkvuEd77OLYJpYZ6hCr5/j4WuMHsRIY4lxjywELW4a+aTwJBqRfqtUxsBmnKbS3h
         STGQ==
X-Gm-Message-State: AOAM533faH6A5SwWn9DgbNFO+8zMUZ1oKskgrQGCm3MLyzqIDyC6Yn/b
        K62O0JAIGKnF3BeHiOMeZOQ=
X-Google-Smtp-Source: ABdhPJzTJ81UBYrYeIYi90NFfaKGEpkLcFRYIxeUEwsjMC2UGGvZ0uB1Pary5iRG5BSTgmdBOdlTAw==
X-Received: by 2002:a92:b510:: with SMTP id f16mr6256153ile.22.1609973952543;
        Wed, 06 Jan 2021 14:59:12 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y5sm2913771ilh.24.2021.01.06.14.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 14:59:11 -0800 (PST)
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
 <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
 <20210106131651.GQ8396@szeder.dev> <xmqq5z49rclc.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3664fffc-c2a0-62d6-298b-8e95f3c58a68@gmail.com>
Date:   Wed, 6 Jan 2021 17:59:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z49rclc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-01-06 à 16:15, Junio C Hamano a écrit :
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> On Mon, Dec 28, 2020 at 07:41:44PM +0000, Philippe Blain via GitGitGadget wrote:
>>> To prevent future regressions, add a simple test that counts the number
>>> of tools shown by 'git mergetool --tool-help', irrespective of their
>>> installed status, by making use of the fact that mergetools are listed
>>> by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
>>> `git config` commands used at the beginning of the test to remove the
>>> fake tools used by the previous test with 'test_might_fail' so that the
>>> test can be run independantly of the previous test without failing.
>>
>>> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
>>> index 70afdd06fa7..ebd3af139e5 100755
>>> --- a/t/t7610-mergetool.sh
>>> +++ b/t/t7610-mergetool.sh
>>> @@ -828,4 +828,14 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>>>   	test_cmp expect actual
>>>   '
>>>   
>>> +test_expect_success 'mergetool --tool-help shows all recognized tools' '
>>> +	# Remove fake tools added in previous tests
>>> +	test_might_fail git config --unset merge.tool &&
>>> +	test_might_fail git config --remove-section mergetool.mytool &&
>>> +	test_might_fail git config --remove-section mergetool.mybase &&
>>> +	git mergetool --tool-help >output &&
>>> +	grep "$(printf "\t")" output >mergetools &&
>>> +	test_line_count = 30 mergetools
>>> +'
>>
>> This new test fails when the topic 'pb/mergetool-tool-help-fix' is
>> built and tested in isolation, because 'git mergetool --tool-help'
>> lists only 29 tools instead of the expected 30.  The reason is that
>> 'pb/mergetool-tool-help-fix' doesn't include commit 6bc9082c0f
>> (mergetools/bc: add `bc4` to the alias list for Beyond Compare,
>> 2020-11-11), which added that 30th tool (and is already part of
>> v2.30.0).
>>
>> It also makes me wonder whether this is the right way to test this
>> fix, because we'll need to adjust this test case every time we add
>> support for a new merge tool (which arguably doesn't happen that
>> often, but since we are already at 30 it doesn't seem to be that rare
>> either).
> 
> Yes, that is a very good point.  Also I can imagine us allowing some
> tools to be excluded depending on a build/installation option and/or
> which platform you are on, so hardcoded 30 smells a bit too fragile
> as an approach for a project like ours.

As I said in my response to Gabor [1], this was a simple attempt at
preventing a future breakage. I agree that it could be improved, but
I'm not sure how without actually re-implementing the code of
'git mergetool --tool-help' in the test itself, especially if more
logic is added as you say for eg. hiding some tools depending
on platform/installation options.

> 
> What was the symptom before the fix?  Is it just missing only some
> tools among 30?  Was there some pattern in names of missing one and
> the ones that still got output?  Or was it more like "we see nothing
> shown"?
> 

The only tools that are shown are the variants, except the alphabetically last variant,
because as I wrote in the commit message,

For shells in which 'echo' does not turn '\n' into newlines, the end result is
that the only tools that are shown are those that are found and have variants,
since the variants are separated by actual newlines in '$variants' because of
the several 'echo' calls in mergetools/{bc,vimdiff}::list_tool_variants.

[Note: I should re-roll and remove "that are found" since that bit is not true).

For example, I get this with Bash 4.4.19 as /bin/sh on Ubuntu 18.04:

---
$ git mergetool --tool-help
'git mergetool --tool=<tool>' may be set to one of the following:
                 gvimdiff
                 gvimdiff2
                 gvimdiff3
                 vimdiff2
                 vimdiff3

The following tools are valid, but not currently available:
                 bc3
                 nvimdiff
                 nvimdiff2

Some of the tools listed above only work in a windowed
environment. If run in a terminal-only session, they will fail.
---

Note that 'vimdiff', 'nvimdiff3' (last variant for vimdiff),
'bc' and 'bc4' (last variant for bc) are absent, and
all other tools that have no variants are absent as well.

I was able to understand what was happening by running 'git mergetool'
with Bash tracing:

PATH=$(git --exec-path):$PATH \
PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }' \
bash -x $(git --exec-path)/git-mergetool --tool-help

P.S.
I noticed that all tools are shown correctly on my Mac,
which has Bash 3.2.57 as /bin/sh. So behaviour of 'echo' regarding
'\n' depends on both the shell and its version (!)


[1] https://lore.kernel.org/git/11b3c261-14e6-0293-02a6-92bd1ea680d2@gmail.com/
