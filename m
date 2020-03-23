Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F2C10F26
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 07:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7AD2072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 07:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQsvKpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCWHE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:04:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCWHE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 03:04:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so6723213pgm.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uEU3cBy0ZaOcpJgIG3PDswJj2byEURnKvI/lykAa4VU=;
        b=NUQsvKpSEDbnc3ah4GVx47HVn3yiOqcSHRTybWlRJy2latbwA2y7NMZQpdJE+SLMP0
         rlSPkJtPpTbnhAcuQ8AssjKxiNU91kNkSCdMUs0Essn3lHJ6C3wIWDY5K61baoo1LxsL
         Ha0TtTY5GluhMmyG+gkyoFx76Ox+Iu0es9s/6THsPQh/DHewuzffDjV2po9+wA6NV4pr
         mfb9MW+VmR+amd4bp1OT03dOLdairjQbgdhy5cmdbmzC2R0MULhdO4IwVpcTXskMk53d
         B+17rmamtYFxeqZRCJMqB8gXUbJtvwnAvWon2xkLLOY+5qUO6AQYJ6m24lCrmaeGHWUV
         v6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uEU3cBy0ZaOcpJgIG3PDswJj2byEURnKvI/lykAa4VU=;
        b=Lm4vnvUIEdvX5rstBZ9fs5rpYvnSubQ1TCOvty5CE1r/z4MtRm1m3hatHZlRp7sSY0
         xYlt1g8qTOSbbtIkdID9RtKQY1YKGtkKxKXi2TV+yuOSZrIf7hUXYs5EhMGq7ZryZmb/
         twRgn+ggneKA8gu0/9BMVfEkOoe3QFXHVZnfkyzR6W/ZcHQjXuEZjtXEc+5o4tLPGPBj
         mol3pl9tYlLvS89NlN4CJuN9F7htv+38UMi5a6/pHPeUrS+9PzKY1WLoOsgc7lr4oG+w
         c4nM9m9rAB2I1A1Z0+ItHeoqS7LBnPwQXpFuHMvpwQpSXf1GvBWntfZBBCqz0K2x6e1v
         Jscg==
X-Gm-Message-State: ANhLgQ1JGFBHQBL7wHGkQTNi+WBpi9iDKKjXLBb+yW8KEvI5YPIze/MN
        Fbqw6JaMd9DVACcJohpPBQkOy+mU7kI=
X-Google-Smtp-Source: ADFU+vsf0Ak5pkIv0JJAkdQy0kdeLh6/6CdBuh+x4rz0dbLIzFLmbegk4rgE+DiAjKfCrqS/dLFhzg==
X-Received: by 2002:a62:170f:: with SMTP id 15mr22244305pfx.12.1584947066393;
        Mon, 23 Mar 2020 00:04:26 -0700 (PDT)
Received: from [192.168.2.6] ([43.247.159.138])
        by smtp.gmail.com with ESMTPSA id r64sm11403786pjb.15.2020.03.23.00.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 00:04:25 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/1] t9116: avoid using pipes
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
 <20200322124619.30853-2-shanthanu.s.rai9@gmail.com>
 <20200322173616.wnz3umcxz25upv63@tb-raspi4>
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
Message-ID: <3f490717-fd3c-6c20-6a47-51b84b4c4860@gmail.com>
Date:   Mon, 23 Mar 2020 12:34:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322173616.wnz3umcxz25upv63@tb-raspi4>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review!

On 22/03/20 11:06 pm, Torsten Bögershausen wrote:
>> Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noticed that
>> when grepping through the output of a command, there is always a
>> chance that something could go wrong.
> That "something could go wrong" may deserve little bit more explanation
> in the commit message.
> One thing when using pipes is that we may loose return codes of programs
> being part of the pipe.
> The other thing is that it is hard to debug, if the test case fails.
> Having the "out" file left on disk allows manual inspection, and tracking
> down why it failed.

Yeah makes sense. I will update the commit message by adding the above
details.

> Having said this, we can make the test case even easier to debug, and consistant
> with other test cases, please see below.
>
>> So, redirect the output into a file and grep that file. Thus the log
>> can be inspected easily if the grep fails.
>>
>> Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>
>> ---
>>
>> In test 'test ascending revision range with --show-commit (sha1)',
>> 'out1' variable is used since 'out' variable was already in use.
>>
>>  t/t9116-git-svn-log.sh | 36 ++++++++++++++++++++++++------------
>>  1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
>> index 0a9f1ef366..d82aa0fab9 100755
>> --- a/t/t9116-git-svn-log.sh
>> +++ b/t/t9116-git-svn-log.sh
>> @@ -61,12 +61,14 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
>>
>>  test_expect_success 'test ascending revision range' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
>> +	git svn log -r 1:4 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
> That could be written as
> 	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
> 	test_cmp expected-range-r1-r2-r4 actual
>
> Or something in that style  (and similar below).
> What do you think ?
>
>>  	"
>>
>>  test_expect_success 'test ascending revision range with --show-commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
>> +	git svn log --show-commit -r 1:4 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
>>  	"
>>
>>  test_expect_success 'test ascending revision range with --show-commit (sha1)' "
>> @@ -74,7 +76,8 @@ test_expect_success 'test ascending revision range with --show-commit (sha1)' "
>>  	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
>>  	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
>>  	git reset --hard origin/trunk &&
>> -	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
>> +	git svn log --show-commit -r 1:4 >out1 &&
>> +	grep '^r[0-9]' out1 | cut -d'|' -f2 >out &&
>>  	git rev-parse \$(cat out) >actual &&
>>  	test_cmp expected-range-r1-r2-r4-sha1 actual
>>  	"
>> @@ -83,45 +86,52 @@ printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
>>
>>  test_expect_success 'test descending revision range' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
>> +	git svn log -r 4:1 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
>>  	"
>>
>>  printf 'r1 \nr2 \n' > expected-range-r1-r2
>>
>>  test_expect_success 'test ascending revision range with unreachable revision' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
>> +	git svn log -r 1:3 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
>>  	"
>>
>>  printf 'r2 \nr1 \n' > expected-range-r2-r1
>>
>>  test_expect_success 'test descending revision range with unreachable revision' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
>> +	git svn log -r 3:1 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
>>  	"
>>
>>  printf 'r2 \n' > expected-range-r2
>>
>>  test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
>> +	git svn log -r 2:3 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
>>  	"
>>
>>  test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
>> +	git svn log -r 3:2 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
>>  	"
>>
>>  printf 'r4 \n' > expected-range-r4
>>
>>  test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
>> +	git svn log -r 3:4 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>>  	"
>>
>>  test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
>> +	git svn log -r 4:3 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>>  	"
>>
>>  printf -- '------------------------------------------------------------------------\n' > expected-separator
>> @@ -138,12 +148,14 @@ test_expect_success 'test descending revision range with unreachable boundary re
>>
>>  test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
>> +	git svn log -r 3:5 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>>  	"
>>
>>  test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
>>  	git reset --hard origin/trunk &&
>> -	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
>> +	git svn log -r 5:3 >out &&
>> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>>  	"
>>
>>  test_done
>> --
>> 2.26.0.rc2.28.g7fcb965970
>>
Yeah, this looks good! I will add these changes in the next patch version.
