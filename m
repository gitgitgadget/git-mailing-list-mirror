Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8AC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F90E611CD
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhECJr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhECJr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 05:47:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E4C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 02:47:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so5424597wmq.4
        for <git@vger.kernel.org>; Mon, 03 May 2021 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G8bsh73YlBglmH5HGHWX+CbmYJkBgUqD4PHqKILdCvc=;
        b=BC0poc5yh/xGdMNjacw1ddg4aOsJSaHBCk3NevDue5utjCLkQIzK9DCVjXR3eKaUN7
         Kj8WOrXTjnlEWK4X/349vybjLt1+AD9iTeYcTdbtzawA9rxPYOo9Bq2YQbLXQ/i9wxQ3
         nG641MRQdX4nw1uDiJ4TwhIcIbpg1qNW48dTKeHhmLcOi3w9QPfjEjKGedwFFYkzHSnK
         FKoio5IoCiK7dNSEgBtXrHHY0lM+pgUbn+DcIulGFMjOQ83yQ23kmV+M9PP+uXkI+Bwo
         ND0YrYd+UaAk0DnyBkpVFxw0wv5Mnb2Hoz0fPmvfa3jQY928HbI4ZtiAjYyt7vI11nfz
         hB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G8bsh73YlBglmH5HGHWX+CbmYJkBgUqD4PHqKILdCvc=;
        b=CfYBPkNgltxz6ITT/Es3LhV/QJD/uexneSxec5S2vlX2TQi1pY1Ncj3BgnUdLTo0Pc
         U5VM/AxYVtYvkJCc5klchBoeZ6gnCJOliDQlxw4vPb9oaX/e9gSfNdA3wiCcldk1tXXu
         Yxa05bGOvw9xSDDC4VlKPg1TVupEkNG99nx2r+pxOqCLq/efqgNuiPMWP7qDEWBd0wj/
         9EHkRnTGDfxhmfwhnK53b74l8zReFstSaK76oCM3bHkPJIJd2DnmidUchIoJ/7/I3ais
         rIVv78Q45lXM+sO+bbroOlN0uQNtosaA6Pum2bNhMquK+7IJ25eZ5t5dodW1v4CutFU0
         HsnQ==
X-Gm-Message-State: AOAM533p+wpJdtIS8E6lpzU/wM38+Sso3585HA6TF98Es4mOe8dqWlHC
        Ah88dA202pRVMSYDE5hoAun/YURlw28=
X-Google-Smtp-Source: ABdhPJxunphGGWLmrS3Yna807J8boPQrfnc1weXLZjmkbTB0MLZxrtlzb9lGKD76YZ/PeJc15Lwq5Q==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr20551613wmf.178.1620035223345;
        Mon, 03 May 2021 02:47:03 -0700 (PDT)
Received: from [192.168.1.240] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.gmail.com with ESMTPSA id o1sm12223094wrm.66.2021.05.03.02.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 02:47:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git diff word diff bug??
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Cc:     Count of San Francisco <countofsanfrancisco@gmail.com>,
        git <git@vger.kernel.org>
References: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
 <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
 <87o8e14b6a.fsf@evledraar.gmail.com>
 <c8e51afa-ec67-fd8a-09e5-2111020a5c55@gmail.com>
Message-ID: <da3d3f5b-5e26-333d-6111-4634d8d70e04@gmail.com>
Date:   Mon, 3 May 2021 10:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c8e51afa-ec67-fd8a-09e5-2111020a5c55@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05/2021 19:00, Phillip Wood wrote:
> On 26/04/2021 10:45, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Sun, Apr 25 2021, Atharva Raykar wrote:
>>
>>> On 20-Apr-2021, at 22:08, Count of San Francisco 
>>> <countofsanfrancisco@gmail.com> wrote:
>>>> [...]
>>>> The diff above does not make it clear that the "{+river+}" is really 
>>>> to be appended (or related) to the first line.
>>>> I expected the first diff line to look like this:
>>>> The fox jumped over the [-wall.-]{+river+} and the rest of the lines 
>>>> are delete lines.
>>>>
>>>> git diff --word-diff=porcelain file0.txt file1.txt produced this:
>>>> diff --git a/file0.txt b/file1.txt
>>>> index c8756ba..3413f10 100644
>>>> --- a/file0.txt
>>>> +++ b/file1.txt
>>>> @@ -1,11 +1,2 @@
>>>>   The fox jumped over the
>>>> -wall.
>>>> ~
>>>> -Blah1e32
>>>> ~
>>>> -q432423
>>>> ~
>>>> -qe23234
>>>> ~
>>>> - 233
>>>> ~
>>>> -253
>>>> ~
>>>> -345235
>>>> ~
>>>> ~
>>>> -53243
>>>> ~
>>>> -afsfffas
>>>> +river.
>>>> ~
>>>> +  He made it over.
>>>> ~
>>>>
>>>> This is more non-discernable. The git diff --help documentation says
>>>> that "Newlines in the input are represented by a tilde ~ on a line
>>>> of its own". So a script would see the '~' character and interpret
>>>> that as a new line. The script would have mistaken the "+river" for
>>>> a different line. The git diff --help documentation does not explain
>>>> what to do in this scenario.
>>>>
>>>> I expected this:
>>>>   The fox jumped over the
>>>> -wall.
>>>> +river.
>>>> ~
>>>
>>> This is also consistent with the behaviour I mentioned above.
>>> A script would need to interpret this as:
>>> delete "wall"        (this starts the streak of deletions)
>>> go to next line
>>> delete "Blah1e32"
>>> ...
>>>
>>> and as soon as it sees a '+', that is, an addition, it knows
>>> the series of deletions are done with, so it will add "river"
>>> to the last line that was common to both, that is,
>>> "the fox jumped over the".
>>>
>>>> Is this a bug? If not, how do I make the distinction that the 
>>>> {+river+} (in the first case) and the +river (in the 2nd case) is 
>>>> really for the first line?
>>>
>>> I do not think this is a bug, because it does not really
>>> deviate from any specified behaviour. But I do see the source
>>> of confusion.
>>>
>>> I hope I could explain that well enough.
>>
>> I do think it's somewhere between a "bug" and a "missing feature"
>> though.
>>
>> The core issue here is that in diff.c we "fake up" the whole word-diff
>> mode by essentially taking both sides, splitting them on whitespace, and
>> then diffing that. So for A/B like:
>>
>>      A: foo bar
>>         baz
>>      B: foo baz
>>         boo
>>
>> We diff:
>>
>>      A: foo\nbar\nbaz
>>      B: foo\nbaz\nboo
>>
>> If you insert an extra newline into that stream you'll get different
>> results, which is closer to what the Count is expecting here.
>>
>> In this case using --word-diff-regex='[^\n]' will produce: >
>>      The fox jumped over the [-wall-]{+river+}.
>>
>> But the rest of the output isn't ideal, exercise for the user and all
>> that.
> 
> Yes it's a complete mess as we're matching a character at a time rather 
> than words, the only reason it works for the first line is that there 
> happens to be some context at the end of the line.
> 
>> The bug is arguably that we should be doing this by default, i.e. we
>> split up our output into "\n" internally, and arguably confuse that with
>> what the user wanted from their input.
>>
>> But see bf82940dbf1 (color-words: enable REG_NEWLINE to help user,
>> 2009-01-17) which is probably the source of the "bug" here (if any) for
>> a trade-off related to that.
> 
> Reverting that commit has no effect on the output, looking at 
> find_word_boundaries() it has always terminated the match at a newline 
> so I'm not sure what the commit message for bf82940dbf1 means when it 
> says "Of course newlines can still be matched explicitly.".

Having thought about it some more I think it is saying "REG_NEWLINE is 
an incomplete fix for the problem of words being silently truncated at 
newlines as it does not stop words being truncated when the regex 
contains an explicit match for a newline"

> To me the problem is not with how the word diff is calculated but how it 
> is presented. At the moment it just prints all the deletions followed by 
> all the insertions. I think that if following some context it just 
> printed the deletions and insertions up to the end of that line and then 
> dumped the rest of the deletions and insertions following the line break 
> that would give a more readable result. It would need to do something 
> similar for deletions and insertions at the beginning of a line that are 
> followed by some context before the end of the line.
> 
> In general I find it useful that --word-diff ignores the line structure 
> of the input, this enables it to show changes to the words in re-flowed 
> text without the clutter one sees in a line-by-line diff from moving the 
> line breaks. I think the changes above would probably be compatible with 
> that.
> 
> Best Wishes
> 
> Phillip
> 
