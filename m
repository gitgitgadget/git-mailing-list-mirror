Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE75C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22C220722
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY1zXYY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCYOAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:00:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45574 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgCYOAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:00:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9so819850pls.12
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mIaNb7kUWIwWJmNMhoILvIHxve67c8phtqrDnVGp/T0=;
        b=QY1zXYY2FoVr8qq6qb/v+ZVkv2In0M7GR/4pT5feQoNdO7cvSetxvO77/S7vRCyhFp
         2XrWPjN5YW9ScTSgzDiwnIzle2igW/uMHLmVRriE6sHRsdYWyYMXOMezEdPBzJMmIdZK
         9Zyc+yb9rSzlmbSQCIDq38sLwma+IEGHv0LY5fyVxqeTThEzKZj+G6cLTuvpnuthEze4
         qI+PxCc0TjMVXlhQXzIPgjs8UfafbVjIx1SN1vCJrWcxFv/1wGS5/xqZbV5bFhIR3hjc
         NeWQNIFfJiKZUwsrUG6kx0tx2Ycg7y+CSRhPFDmU+NlLI20H9q0YtGkGjzC1m/kVwu8L
         oZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mIaNb7kUWIwWJmNMhoILvIHxve67c8phtqrDnVGp/T0=;
        b=S/mj4mnPIt7pK5zNX0qKRnUoTGOc1lVv+bT+PwQj6icba0x40m/DlQ3GMNcVCKut8c
         s+CkO+1LIPG3AUWCzpmtukqhIXVoYZG6+/YFF/r1ztv0h5uZ78/TOiCeUkMcv5GqeRU1
         HpITgi8lR4fFtY23KnO3obRCoyxKrMWj+PKUwMAqJE7pCf9bt0ducKzEBlui09sbrL/V
         z3mpA7CZY3ZSjXVy/Tn2ysJzPWJinKAG36uaAH1fUPoz4V8wyqS7vtlTk22tu1XPCy88
         lzZYBGswhWqbbwT9Wt+HmibqyhEYQ3WnQV0DDieZsY2ldXRXf1MYHBWWMO5TP/BOFsQS
         VuTQ==
X-Gm-Message-State: ANhLgQ0NzmB9oIFo3NTH1f3OOJA5EzfYTsgFsmeJBD3rsMInI4B/P9vy
        64NP8mbIZFnu2eVTyZzNPQw=
X-Google-Smtp-Source: ADFU+vv2rbEoZhngw6VHaQo7OsgEeKfLWVsAZxwa77UJPusE5wP2/ZMmH7XCS0Flu0xpaCPusfzQxA==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr3833301pjb.147.1585144853104;
        Wed, 25 Mar 2020 07:00:53 -0700 (PDT)
Received: from [192.168.2.6] ([43.247.159.138])
        by smtp.gmail.com with ESMTPSA id 189sm18485573pfw.203.2020.03.25.07.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:00:52 -0700 (PDT)
Subject: Re: [PATCH v2] t9116: avoid using pipes
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
 <20200324093502.32394-1-shanthanu.s.rai9@gmail.com>
 <CAP8UFD2Uu-dPJcZB--T7k0tMuXc0iVeqnMUn3Y_x+3iaFf9xFQ@mail.gmail.com>
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
Message-ID: <4b40a756-c32f-64ad-1e1d-4e31804d8295@gmail.com>
Date:   Wed, 25 Mar 2020 19:30:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2Uu-dPJcZB--T7k0tMuXc0iVeqnMUn3Y_x+3iaFf9xFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25/03/20 12:04 am, Christian Couder wrote:
> On Tue, Mar 24, 2020 at 10:36 AM Shanthanu <shanthanu.s.rai9@gmail.com> wrote:
>> Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) recommends to
>> avoid using pipes, since the exit code of upstream in the pipe is
>> ignored. Hence, redirect the output to a file and parse that file.
>>
>> Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noted that
>> this also allows easy debugging in case the test fails, since the file
>> will be left on disk and can be manually inspected.
>>
>> Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>
> We usually ask for a legal name in a format similar to "<Firstname>
> <MaybeMiddleNameInitial> <Lastname>" where <MaybeMiddleNameInitial>
> can be omitted. The name should also match what is in the "From:"
> field of the emails you send.
Okay, I will keep that in mind.
>> ---
>>  t/t9116-git-svn-log.sh | 53 +++++++++++++++++++++++++++++++-----------
>>  1 file changed, 39 insertions(+), 14 deletions(-)
>>
>> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
>> index 0a9f1ef366..56d68e4aed 100755
>> --- a/t/t9116-git-svn-log.sh
>> +++ b/t/t9116-git-svn-log.sh
>> @@ -61,12 +61,16 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
>>
>>  test_expect_success 'test ascending revision range' "
>>         git reset --hard origin/trunk &&
>> -       git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
>> +       git svn log -r 1:4 >out &&
>> +       grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
>> +       test_cmp expected-range-r1-r2-r4 actual
>>         "
> It seems that the code that your patch changes is repeated a lot in
> this test script. I wonder if it would be better to write a shell
> function to avoid those repetitions.

Oh yeah, that would be better. I will add a function. Just clarifying,
the function should run the git, grep, cut and test_cmp commands?

Also, could you suggest an appropriate name for this function?

