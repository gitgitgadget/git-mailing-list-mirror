Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08914C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64942083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvvmNM3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgAQOL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:11:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgAQOL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 09:11:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so22831647wro.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMnaozahx4aNbU/BZx0+sQu7R7Sh6mWB3z//9FC4UOk=;
        b=cvvmNM3S6jSj2Pkmrl3uABdseeGpv88Vy0q/tLG4sXo+p0zhn985DZxdU3mVf8V0z0
         wcIxEyBr3Cp7q/Q1gnuBzT9SD9x66sJr6E10SpVAWPHiTMyGEyGTLrMNn4AJ7TLfOTrF
         /vmLUNCwVTD5IMHMiyFHO9KnADj3IUxrvRmqVQPMQWZZcL5L59gR9sPSZyeO0keMi0jL
         LC4MMTPwpa4t8ic6oeI8RdA8k0jW9B+4chbGruc/12V3aeEcTUz59TYNjFp3x1wgzRua
         ovxZcy1gJ5NaRpm/R2jKXC4H5NQhQzOLtbGDUPLYXRKHi1/1dxkLYFH6oeyu1ltUh/6v
         Yi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xMnaozahx4aNbU/BZx0+sQu7R7Sh6mWB3z//9FC4UOk=;
        b=TbTbqYWkxKpe3X+9gP6ZQ+m3s9FBsOeY7jNIs16FwNpndEh0Tm+8ilKgbXwYm8sQbf
         plpIlDLaoyZNdHzfQdHZlXaN3qxiC/csktCfahj7DONPzcjxo83hPhh7TFeFpvvGawgT
         wPK/Xn0ReUl5udy/CwxYBFZIVgw0cbHgTAG97Z/sIgaWV9cvLCGk3DyabKKzPjPYXaTm
         NlhXqYqSgwUK1xxMi/Wges97+H+P9Qwmk9kyOEV8hKTmtTe/J0weXbGkupFGFJI8MTJ+
         MPkgvZSYgkFwMvVfN2w5EDE8gHjeRM6XpZbR2JpSXNQfgFGus1oSinkKegSpcgYEEQEX
         31GQ==
X-Gm-Message-State: APjAAAUOYbszByS8MYPc5RDJkzdx9XrEffsBO4H2pFiF+xoAqoVbvHti
        CKm35raD7cBv9ycL9HOqDeY=
X-Google-Smtp-Source: APXvYqzi7COvaw0iLoSQa7jkVmjcdHn+YzjfcDAYxNBKZqJAl5Pi/eYNdQ5Wvs2Uh+LxcavgkdanTg==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr3412922wrv.302.1579270283629;
        Fri, 17 Jan 2020 06:11:23 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id 18sm2707150wmf.1.2020.01.17.06.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:11:23 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
 <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
 <nycvar.QRO.7.76.6.2001121936290.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cdada301-b521-78b4-badc-192af2fa3d08@gmail.com>
Date:   Fri, 17 Jan 2020 14:11:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001121936290.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 12/01/2020 18:41, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Sun, 12 Jan 2020, Phillip Wood wrote:
> 
>> On 12/01/2020 16:12, Phillip Wood wrote:
>>> I'm concerned that there are some bugs in this series and think
>>> it may be best to revert it before releasing 2.25.0. Jonathan
>>> Nieder posted a bug report on Friday [1] which I think is caused
>>> by this series. While trying to reproduce Jonathan's bug I came
>>> up with the test below which fails, but not in the same way.
> 
> Thank you so much for your thoughts and your work on this. For what it's
> worth, I totally agree with your assessment and your suggestion to revert
> those patches _before_ releasing v2.25.0. (I seem to remember vaguely that
> there were repeated requests for better test coverage and that those
> requests went unaddressed, so I would not be surprised if there were more
> unfortunate surprises waiting for us.)

Yes there were more surprises - when we fork `git merge` 
--committer-date-is-author-date is broken. That was tested but with a 
commit where the author date was the current time so it did not detect 
the failure.

> [...]
>> --- >8 ---
>> diff --git a/sequencer.c b/sequencer.c
>> index 763ccbbc45..22a38de47b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -988,7 +988,7 @@ static int run_git_commit(struct repository *r,
>>                  if (!date)
>>                          return -1;
>>
>> -               strbuf_addf(&datebuf, "@%s", date);
>> +               strbuf_addf(&datebuf, "%s", date);
> 
> I have to admit that I have not analyzed the code before this hunk (it
> would be much easier to increase the context in a non-static reviewing
> environment, e.g. on GitHub, but the mailing list does not allow for
> that), so I do not know just _how_ likely our `date` here is going to
> change or remain prefixed by a `@`. Therefore, this suggestion might be
> totally stupid: `"@%s", date + (*date == '@')`

The date was read from the author-script so I think we should leave it 
as is in case the user has edited it and is using a different date 
format. Having said that I'm keen to make a bigger change to Rohit's 
implementation and just get the author date out of the argv_array 
holding the child's environment as this avoids re-reading the 
author-script file. It has taken a bit longer than I planned so it'll be 
next week before I post the fixes.

Best Wishes

Phillip

> Thanks again,
> Dscho
> 
>>                  res = setenv("GIT_COMMITTER_DATE",
>>                               opts->ignore_date ? "" : datebuf.buf, 1);
>>
>>> The
>>> test coverage of this series has always been pretty poor and I
>>> think it needs improving for us to have confidence in it. I'm
>>> also concerned that at least one of the
>>> tests ('--committer-date-is-author-date works with rebase -r')
>>> does not detect failures properly in the code below
>>>
>>> 	while read HASH
>>> 	do
>>> 		git show $HASH --pretty="format:%ai" >authortime
>>> 		git show $HASH --pretty="format:%ci" >committertime
>>> 		test_cmp authortime committertime
>>> 	done <rev_list
>>>
>>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>> [1] https://lore.kernel.org/git/20200110231436.GA24315@google.com/
>>>
>>> --- >8 ---
>>> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
>>> index 5166f158dd..c81e1d7167 100755
>>> --- a/t/t3433-rebase-options-compatibility.sh
>>> +++ b/t/t3433-rebase-options-compatibility.sh
>>> @@ -6,6 +6,7 @@
>>>    test_description='tests to ensure compatibility between am and interactive backends'
>>>
>>>    . ./test-lib.sh
>>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>>>
>>>    GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>>>    export GIT_AUTHOR_DATE
>>> @@ -99,6 +100,22 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
>>>           done <rev_list
>>>    '
>>>
>>> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
>>> +       git checkout commit2 &&
>>> +       (
>>> +               set_fake_editor &&
>>> +               FAKE_LINES=2 &&
>>> +               export FAKE_LINES &&
>>> +               test_must_fail git rebase -i HEAD^^
>>> +       ) &&
>>> +       echo resolved > foo &&
>>> +       git add foo &&
>>> +       git rebase --continue &&
>>> +       git log -1 --format=%at commit2 >expect &&
>>> +       git log -1 --format=%ct HEAD >actual &&
>>> +       test_cmp expect actual
>>> +'
>>> +
>>>    # Checking for +0000 in author time is enough since default
>>>    # timezone is UTC, but the timezone used while committing
>>>    # sets to +0530.
>>>
>>
