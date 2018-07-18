Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CC81F597
	for <e@80x24.org>; Wed, 18 Jul 2018 13:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGROgQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 10:36:16 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:12776 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeGROgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 10:36:16 -0400
Received: from [192.168.2.240] ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id fmy1f0zKroI6Lfmy2fnB28; Wed, 18 Jul 2018 14:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531922290;
        bh=iBompxWwgO/w5eIwsnDmrXyf+25224ZlsBkc+ZNLMSw=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Qamnjz+cG8QRCKGUIAklJftH4XsEjwBQ3Gye9jlxhoikdx3gfLYR20a+K9DGC/Cgj
         MNEPbMzPY/Lcg+/ZRA1mM8u6zwqPFXtFQxPuUls0Us6sHtIjOB+70DDvo4IQID1uOk
         t0lUubDPSxhvJWwr+Q1drRomRTHECCOuF1SfWo9o=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=cETuxoCwAAAA:8
 a=7Z2HMj3QY_YLJzFospAA:9 a=QEXdDO2ut3YA:10 a=tb6VMGFFq-HsUJGUQiVL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: terminate the last line of
 author-scriptproperly
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <86a7qwpt9g.knu@iDaemons.org>
 <aad05e61-db99-429e-bbe6-a8f91ef18e3f@talktalk.net>
Message-ID: <a39862e1-ad27-6989-6a32-1898448525f0@talktalk.net>
Date:   Wed, 18 Jul 2018 14:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <aad05e61-db99-429e-bbe6-a8f91ef18e3f@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMA7m+deYgyRy/qbHbKWpnyGwsHPaVLw/WV/7fGkThu84yHj8KHZwWPUbUwnzhIhWksGHkZf7D+5kxcTRCDDyuyFAYab+3ZmV62QljHtRkY38OYwzwV3
 2ku6iH8nw3sy+8uPDmV4Osg2SujcZ0mTZ16oudofe98ua7hF/T3EK1qy1M6Zd3yRWrbsuMTS4zzVxRVVoQWTlSDMYimkcFh5JZHf4YQAZbCOjuvguE4e3TGv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/07/18 14:50, Phillip Wood wrote:
> 
> Hi Akinori
> On 12/07/18 12:18, Akinori MUSHA wrote:
>>
>> It looks like write_author_script() intends to write out a file in
>> Bourne shell syntax, but it doesn't put a closing single quote on the
>> last line.
>>
>> This patch makes .git/rebase-merge/author-script actually parsable by
>> sh(1) by adding a single quote and a linefeed to terminate the line
>> properly.
>>
>> Signed-off-by: Akinori MUSHA <knu@idaemons.org>
>> ---
>>   sequencer.c                   |  1 +
>>   t/t3404-rebase-interactive.sh | 13 +++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 4034c0461..5f32b6df1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -651,6 +651,7 @@ static int write_author_script(const char *message)
>>               strbuf_addch(&buf, *(message++));
>>           else
>>               strbuf_addf(&buf, "'\\\\%c'", *(message++));
>> +    strbuf_addstr(&buf, "'\n");
>>       res = write_message(buf.buf, buf.len, 
>> rebase_path_author_script(), 1);
>>       strbuf_release(&buf);
>>       return res;
>> diff --git a/t/t3404-rebase-interactive.sh 
>> b/t/t3404-rebase-interactive.sh
>> index 352a52e59..345b103eb 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>>       test_line_count = 6 actual
>>   '
>> +test_expect_success 'rebase -i writes out 
>> .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
>> +    test_when_finished "git rebase --abort ||:" &&
>> +    git checkout master &&
>> +    set_fake_editor &&
>> +    FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>> +    test -f .git/rebase-merge/author-script &&
>> +    unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
>> +    eval "$(cat .git/rebase-merge/author-script)" &&
>> +    test "$(git show --quiet --pretty=format:%an)" = 
>> "$GIT_AUTHOR_NAME" &&
>> +    test "$(git show --quiet --pretty=format:%ae)" = 
>> "$GIT_AUTHOR_EMAIL" &&
>> +    test "$(git show --quiet --date=raw --pretty=format:@%ad)" = 
>> "$GIT_AUTHOR_DATE"
>> +'
> 
> Have you checked that this test fails without your fix being applied? I 
> just ran
> 
> sh -c 'eval "$(cat .git/rebase-merge/author-script)"; echo 
> "$GIT_AUTHOR_NAME"'
> 
> while a rebase was stopped for an edit and it worked despite the fact 
> that there is a missing quote at the end of the GIT_AUTHOR_DATE in the 
> author script file.
> 
> Best Wishes
> 
> Phillip

Please ignore that, I messed up, there was a closing "'" as I was using 
the shell version by a mistake.

Sorry for the noise

Phillip

>>   test_expect_success 'rebase -i with the exec command' '
>>       git checkout master &&
>>       (
>>
> 

