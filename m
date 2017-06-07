Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A761FAE8
	for <e@80x24.org>; Wed,  7 Jun 2017 10:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdFGKrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 06:47:06 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:13956 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdFGKrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 06:47:05 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id IYUQdIvZjcpskIYUQd7ruN; Wed, 07 Jun 2017 11:47:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496832423; bh=hCnGQFuhIGeRiz2pXelbsAhCnz7Nt4tVDQWc82O5ijc=;
        h=Reply-To:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=TUuUP1v70RaD+m1Yphl7cR22KlwNGgdnX/xAixiqcMOdxUfCQjVt5I9HhcS1g+lI9
         RP4A3sfrX7wSky9xUAap7+kVJue8Wnj6X5SEpuPNeTLwpDQUBfv7UJujTFyAxocxQa
         nLA8QxpeH4LdMnV/pea3qytmr6hBaS3NAAGp51XQ=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=9rlqLSI5SiDNAZZ9ZSYA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Message-ID: <5309bbe7-edd8-0c34-82ff-c3162d7d9e66@talktalk.net>
Date:   Wed, 7 Jun 2017 11:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGWBxmFeAn6f3J39eGMArJrFDlohsN/3CQNoThvFHXknzp/6pgV8gnX1duMK7XU9galqFlIiULryzUIU6CLIGk+jNHPUHyJtsQRTfT4Hng5P0MvQMFxY
 K0cN7s2AkADg9xm3zPc/zBew2nZrG4I6sMuVkd+sKdx++2gXguRDSZZjPTqkz9dOMfMieidxn2VkFQlskBoLnchKdvwKirLhXEDXwOCtwOjAVf2UAn6xiqAD
 KkaYu+xIPYpjJQ4fiowvAJ+V5mwzBPrG3aTCCcZuuEE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

Thanks for your feedback
On 01/06/17 13:56, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 31 May 2017, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Check the console output when using --autostash and the stash applies
>> cleanly is what we expect. To avoid this test depending on commit and
>> stash hashes it uses sed to replace them with XXX. The sed script also
>> replaces carriage returns in the output with '\r' to avoid embedded
>> '^M's in the expected output files. Unfortunately this means we still
>> end up with an embedded '^M' in the sed script which may not be
>> preserved when sending this. The last line of the sed script should be
>> +s/^M/\\r/g
> 
> Like Junio pointed out, this sed script would not be portable. To
> elaborate: there are two major variants of sed out there, GNU sed and BSD
> sed. Typically GNU sed allows a little more powerful instructions, e.g. \t
> and \r.

I'm confused by this as my script does not use the escape sequence "\r"
out of portability concerns. It has a literal carriage return as you get
from typing Ctrl-Q Ctrl-M in emacs or Ctrl-V Ctrl-M in bash which I
think should be portable and replaces the carriage returns in git's
output with the literal string '\r'. I did this so that the expected
files don't have control characters in them that mess up the display
when you cat them or read them in an email client

> But we should simply take a step back and ask why test_cmp is not enough
> to ignore the CRs in the output?
> 
> Also, about the commit IDs. As long as the tests are consistent (i.e. they
> use test_commit rather than plain `git commit`, or at least call
> `test_tick` beforehand), the commit IDs should actually be identical
> between runs and not depend on the time of day or the date.
> 
> The only exception to that rule is when some previous test cases call
> `test_commit` but are guarded behind some prereq and may not be executed
> at all. In that case, the precise commit IDs depend on the particular set
> of active prereqs.

The other exceptions are when the commit hash algorithm changes or the
contents of the commits changes because of some update to the test
script. That's why I didn't want to rely on matching fixed SHA1s

> 
> But as far as I can tell, t3420 does not have any test cases guarded by
> prereqs.
> 
> Taking an additional step back, I wonder whether we have to hard-code the
> commit IDs (or XXX) to begin with. Why not generate the `expect` files
> with the information at hand? We can simply ask `git rev-parse --short`.
> 
> For the stash's commit ID, there is no record in the ref space, of course
> (because it was created with `git stash create`). But I think in this
> case, it is legitimate to simply grep the output.

That's a good approach to handling the stash hash if we want to generate
the expected files from the test script

> That way, the test would be precise and resilient.
> 
> So for example instead of adding the t/t3420/expected-success-am verbatim,
> you could generate the output via
> 
> 	cat >expect <<-EOF
> 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\\$" output)
> 	HEAD is now at $(git rev-parse --short HEAD~2) third commit
> 	First, rewinding head to replay your work on top of it...
> 	Applying: second commit
> 	Applying: third commit
> 	Applied autostash.
> 	EOF

This approach works well for the cases where there aren't control
characters embedded in git's output, but for the interactive tests there
are so we'd end up with control characters in the test script which I
wanted to avoid or doing $(printf '\r'). I steered clear of generating
the expected file in the test as i) it was more work (both for me
(rebase --merge has a few commit hashes in it's output) and when the
script is running) and ii) it's a bit messy to implement given the way
the tests are structured in a helper function that's called with a
parameter indicating the type of rebase to test.

I can go ahead with generating the expected files from the script if you
really want but I wonder if changing the test to generate the sed script
with printf as below might be a simpler way to mitigate the carriage
return problem, though it would be less strict than generating the real
hashes with rev-parse.

--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -189,6 +189,16 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '

+test_expect_sucess 'rebase: create sed script to sanitize output' '
+	printf "\
+s/^\(Created autostash: \)[0-9a-f]\{6,\}$/\1XXX/
+s/^\(HEAD is now at \)[0-9a-f]\{6,\}\( .* commit\)$/\1XXX\2/
+s/^[0-9a-f]\{6,\}\( .* commit\)$/XXX\1/
+s/\(detached HEAD \)[0-9a-f]\{6,\}/\1XXX/
+s/\(could not apply \)[0-9a-f]\{6,\}/\1XXX/g
+s/\\r/\\r/g" >$TEST_DIRECTORY/t4320/remove-ids.sed
+'
+

Let me know what you think,

Best Wishes

Phillip

