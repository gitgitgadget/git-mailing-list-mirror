Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EB51F597
	for <e@80x24.org>; Wed, 18 Jul 2018 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGROYX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 10:24:23 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:23725 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbeGROYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 10:24:22 -0400
Received: from [192.168.2.240] ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id fmmXf0y4noI6LfmmYfnAiC; Wed, 18 Jul 2018 14:46:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531921580;
        bh=6ch0zq3LUqYpxhxeXQ8pzRDJn6OxdRZ3F8vHMl7F6zI=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GoHvAEDjJqeLppJXwPUKOEoKwOgv4BBcFqiwxGwrr66qDqOdumJ7M6/kNWDZEFjD0
         Zt00g12oQG7sL4KahtSxxufHqNHNujbhG7+eY7K1IgcyZt0+QiIm88yBgIoRlaGniq
         JP+6L0YXBxcXyKu+PZmJ2U8T4tr6rSnkdBgWjjXA=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=cETuxoCwAAAA:8
 a=0ObAd42rMqL0LYfQSe0A:9 a=QEXdDO2ut3YA:10 a=tb6VMGFFq-HsUJGUQiVL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: terminate the last line of
 author-scriptproperly
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>
Cc:     git@vger.kernel.org
References: <86a7qwpt9g.knu@iDaemons.org>
 <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
 <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
Message-ID: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
Date:   Wed, 18 Jul 2018 14:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKVSQwLJ+LcUmeJ82AFC/so1qgt7fK78gCQ/Q1sgMHifCHcJjUxbxUhKa8ifHii2gqObwwCT+dnTPC0Oy78ZLx82mOiwJg5DN94lKbizI3ZyCqlmpIUe
 kQkKXwFo4kpTWALOgN3Fq0xpZ0uzV445nhBjb3kxsRPJ6EPMV9zNOEQ9G2Ikm5fkto/hQqIaox85wBRMzm8M1Np8I/LRMYc6N4mCfjSZoe1cRA31tNlgdMUY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/07/18 10:45, Phillip Wood wrote:
> 
> Hi Junio
> 
> On 12/07/18 18:22, Junio C Hamano wrote:
>>
>> "Akinori MUSHA" <knu@iDaemons.org> writes:
>>
>>> It looks like write_author_script() intends to write out a file in
>>> Bourne shell syntax, but it doesn't put a closing single quote on the
>>> last line.
>>
>> s/closing single quote/& and the terminating newline/?
>>
>>>
>>> This patch makes .git/rebase-merge/author-script actually parsable by
>>> sh(1) by adding a single quote and a linefeed to terminate the line
>>> properly.
>>
>> Sounds good.
>>
>> I wonder why this breakage was left unnoticed for a long time,
>> though.  It's not like writing and reading the author-script from C
>> code was done first in the "rebase -i" and friends that are users of
>> the sequencer machinery 
> 
> The only consumer of a faulty author script written by the sequencer is 
> read_env_script() in sequencer.c which doesn't worry about checking that 
> quotes are paired. 

That's not quite true anymore, recently another consumer 
read_author_ident() was added which uses sq_dequote() instead of custom 
code. Looking more closely at write_author_script() the quoting of 
single quotes is buggy they are escaped as \\' instead of \'. The code 
in read_env_script() expects the buggy quoting so it works. I just tried 
the code path that uses sq_dequote() by doing rebase --root with an 
author containing a single quote and that worked but I'm not sure why.

The shell versions of rebase use the code in
> git-sh-setup.sh to create the author script which does write valid posix 
> shell.
> 
>> (I think we had code to do so in "git am"
>> that was rewritten in C first).
> 
> The code in builtin/am.c doesn't try to write valid posix shell (if one 
> assumes it is the only consumer of the author script then it doesn't 
> need to) 

Though it will break if git gets upgraded while am is stopped for a 
conflict resolution. Given that the code has been around for a while 
that may not be much of a concern now

which results in simpler code, but external scripts cannot
> safely eval it anymore.
> 
>>  Do we have a similar issue over
>> there as well?  If not, perhaps if we reused the existing code that
>> was not broken, we wouldn't have seen this breakage on the sequencer
>> side?
> 
> Best Wishes
> 
> Phillip
> 
>> Thanks.
>>
>>>
>>> Signed-off-by: Akinori MUSHA <knu@idaemons.org>
>>> ---
>>>   sequencer.c                   |  1 +
>>>   t/t3404-rebase-interactive.sh | 13 +++++++++++++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 4034c0461..5f32b6df1 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -651,6 +651,7 @@ static int write_author_script(const char *message)
>>>               strbuf_addch(&buf, *(message++));
>>>           else
>>>               strbuf_addf(&buf, "'\\\\%c'", *(message++)) >>> +    strbuf_addstr(&buf, "'\n");
>>>       res = write_message(buf.buf, buf.len, 
>>> rebase_path_author_script(), 1);
>>>       strbuf_release(&buf);
>>>       return res;
>>> diff --git a/t/t3404-rebase-interactive.sh 
>>> b/t/t3404-rebase-interactive.sh
>>> index 352a52e59..345b103eb 100755
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>>>       test_line_count = 6 actual
>>>   '
>>> +test_expect_success 'rebase -i writes out 
>>> .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
>>> +    test_when_finished "git rebase --abort ||:" &&
>>> +    git checkout master &&
>>> +    set_fake_editor &&
>>> +    FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>>> +    test -f .git/rebase-merge/author-script &&
>>> +    unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
>>> +    eval "$(cat .git/rebase-merge/author-script)" &&
>>> +    test "$(git show --quiet --pretty=format:%an)" = 
>>> "$GIT_AUTHOR_NAME" &&
>>> +    test "$(git show --quiet --pretty=format:%ae)" = 
>>> "$GIT_AUTHOR_EMAIL" &&
>>> +    test "$(git show --quiet --date=raw --pretty=format:@%ad)" = 
>>> "$GIT_AUTHOR_DATE"
>>> +'
>>> +
>>>   test_expect_success 'rebase -i with the exec command' '
>>>       git checkout master &&
>>>       (
>>> -- 
>>> 2.18.0
> 

