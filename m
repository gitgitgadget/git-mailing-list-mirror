Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84778C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKUXNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKUXNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:13:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266EC6555
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:13:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g12so22158278wrs.10
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Xk7TykvfNoKlkAveAu6ZeeAcKdrlDAhB7OqdgImlY=;
        b=VxCmEgoT+t3pn69LHQEAT+emK9xdrYvgDUX8HWyx5zdYfg18mZ/P66im50t/Hux4NL
         d18kza5M2UbCiSvgV2AO7VVI5YGkuTsE0NpBW4jRP8qoiJQbT9ztHYU4t7EZ+WG0AAg2
         DcDmIsSWVe9qCivPYd6dgB3l11E5gKSu7aIeTypJ/YXpSq9yVM3fVgAIMNp/G255nIt+
         IQT2fv18qyCASc1WZTwgxHYEsuo1AkIdGLzdpYLkbp3hbAsVVv/g9G5iYPTwYuFh8fP8
         Xs2G9/FKvNpxFmd3JRYLYvXuBMrT5BEycp0laZzLGwBcrjwpzPrD9WjjLDxR6Ww92zrd
         hkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Xk7TykvfNoKlkAveAu6ZeeAcKdrlDAhB7OqdgImlY=;
        b=Am7nxcCEIXfkKMgGmdxBpJ9xWV8xxEGwXUFzdDAQ6Z+HwxTo9bfx2eCeGoykb6bJdX
         XHw60mCgV2QMH0Xg76tDUN4LgWSO+jojykEckFKWGLJbbIm0aIHTpKjCuz4sARsFF7wS
         OV0mTPIXkbRNkyHJNYu20/d2ytLM5woVZqk0O8mnMxxlL8ndIpoAW6lMnBWDML+BrLvH
         dyd35nWwJMATTIiw5eb97G6HSf1pJcmCYkPw3uiGfXgGMtfL9oihiLpUfZTVaONg+Jch
         pBRsjn8wQVM0BpNyRLoX7Is8NuZuye/k2QvDGWEr3gIgn24f0K41RmJ/rd++FqQOxW69
         BDzA==
X-Gm-Message-State: ANoB5pnlpMRjJ19gz3F917Odn97OKUWz4Xtkn41hd7VRBnP5yE6DGh4W
        /X2u+Ga+zQ3nSwBkIllcEig=
X-Google-Smtp-Source: AA0mqf6R/vZBU6wXbCvnkRdlvhzkSnZi03cEK4qvQ5sBP504sV5Q8NY8hLwBnkP2VylNyFG5wb5ADQ==
X-Received: by 2002:a05:6000:1288:b0:241:dfd0:e7e3 with SMTP id f8-20020a056000128800b00241dfd0e7e3mr1042278wrx.413.1669072414243;
        Mon, 21 Nov 2022 15:13:34 -0800 (PST)
Received: from [192.168.2.52] (14.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.14])
        by smtp.gmail.com with ESMTPSA id hg12-20020a05600c538c00b003cf7055c014sm15390552wmb.1.2022.11.21.15.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 15:13:33 -0800 (PST)
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
To:     Victoria Dye <vdye@github.com>, Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
 <8457ad4c-51c7-4c2d-8dbf-02a60045d288@github.com>
 <042c18df-deb6-6214-2d49-c214a872e1c1@gmail.com>
 <87a2a095-636a-61ce-e304-e3f1dbcd74b4@github.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <6338b2db-1dfe-9dcb-5511-f6ea66122ec3@gmail.com>
Date:   Tue, 22 Nov 2022 00:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87a2a095-636a-61ce-e304-e3f1dbcd74b4@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/22 23:10, Victoria Dye wrote:
 
> It does allude the _expected_ result, though ("[-C] uses the same underlying
> machinery as the --move (-m) option except the reflog and configuration is
> copied instead of being moved").
> 
>>
>> The design decisions in branch.c and config.c have brought us to this
>> unexpected result, which just need to be addressed. IMHO
> 
> It's helpful to reviewers and future readers to include relevant context in
> a commit message; a commit doesn't need to be responsible for a bug to help
> someone understand what you're trying to do and why. In this case, I needed
> to search through the commit history myself to gather that information (that
> is, how you decided clearing the destination first was the "correct"
> approach rather than, say, preserving the destination branch's config and
> not copying the source's), so I would consider the explanation in the
> current commit message incomplete. 
> 
> In general, it's often not enough to "just fix a bug" without elaborating on
> why something *is* a bug. This isn't an obvious thing like a 'BUG()' or
> segfault, so context like 52d59cc6452 is needed to convey the nuance of the
> issue.

OK. Clearly the message it's wrong.
 
>>>> +	test_when_finished git branch -D moved &&
>>>> +	git branch -t main-tracked main &&
>>>> +	git branch non-tracked &&
>>>> +	git branch -M main-tracked moved &&
>>>> +	git branch --unset-upstream moved &&
>>>> +	git branch -M non-tracked moved &&
>>>> +	test_must_fail git branch --unset-upstream moved
>>>
>>> If I'm reading this correctly, the test doesn't actually demonstrate that
>>> 'git branch -M' cleans up the tracking info, since 'moved' never has any
>>> tracking info immediately before 'git branch -M'. The test could also be
>>> more precise by verifying the upstream name matches. What about something
>>> like this?
>>>
>>> 	test_when_finished git branch -D moved &&
>>> 	git branch -t main-tracked main &&
>>> 	git branch non-tracked &&
>>>
>>> 	# `moved` doesn't exist, so it starts with no tracking info
>>> 	echo main >expect &&
>>> 	git branch -M main-tracked moved &&
>>> 	git rev-parse --abbrev-ref moved@{upstream} >actual &&
>>> 	test_cmp expect actual &&
>>>
>>> 	# At this point, `moved` is tracking `main`
>>> 	git branch -M non-tracked moved &&
>>> 	test_must_fail git rev-parse --abbrev-ref moved@{upstream}
>>
>> You are right, good eye.  Thanks.  That first '--unset-upstream'
>> eliminates the possible undesired inherited tracking info.  Removing it
>> is needed to make the test meaningful.  'rev-parse' is a good change,
>> but as the test is not testing that '-M' works as expected but doesn't
>> work in the unexpected way the message describes, I don't think we need
>> it here, imho.
> 
> But by always having the destination branch have no tracking info, this test
> doesn't verify that the unexpected behavior (that is, "mixing" the source
> and destination config) has been fixed. You still need a case where the
> destination config is non-empty and the source is empty (or some other
> non-empty value) to reproduce the issue.

OK, understood, that needs a test.
 
> As for the 'rev-parse' vs. '--unset-upstream': making the test more precise
> here doesn't increase its scope *and* makes the overall test suite more
> effective at detecting regressions. And, a read-only check like 'rev-parse'
> is more readable for other developers (especially if they need to debug the
> test in the future), rather than needing to understand that

OK, that makes sense.

> '--unset-upstream' is doing two things: throwing an error depending on the
> presence of an upstream *and* removing the upstream from the target branch). 
> 
> In other words, it helps to separate your assertions from your setup steps.
> If you still need to '--unset-upstream' for the rest of the test, you can do
> the 'rev-parse' then '--unset-upstream' as two separate steps. 
> 
>> --- >8 ---
>>
>> Thank you!
>>
>>  t/t3200-branch.sh | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index c3b3d11c28..ba959a82de 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -218,17 +218,16 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
>>  	)
>>  '
>>  
>> -test_expect_success 'git branch -M inherites clean tracking setup' '
>> +test_expect_success 'git branch -M inherits clean tracking setup' '
>>  	test_when_finished git branch -D moved &&
>>  	git branch -t main-tracked main &&
>>  	git branch non-tracked &&
>> -	git branch -M main-tracked moved &&
>>  	git branch --unset-upstream moved &&
>>  	git branch -M non-tracked moved &&
>>  	test_must_fail git branch --unset-upstream moved
> 
> This change makes the test less comprehensive (by removing the
> "tracked-overwrites-untracked" case) and does not solve the issue of 'moved'
> always having no tracking info before the 'git branch -M' (therefore not
> properly reproducing the error case fixed in this patch).

Sorry, I sent the wrong patch.  Removing the line 'git branch
--unset-upstream moved' is what makes the test meaningful.

>>  '
>>  
>> -test_expect_success 'git branch -C inherites clean tracking setup' '
>> +test_expect_success 'git branch -C inherits clean tracking setup' '
>>  	test_when_finished git branch -D copiable copied &&
>>  	git branch -t copiable main &&
>>  	git branch -C copiable copied &&
>>
> 

---

This needs more work and consensus.  I think we can reject this patch,
2/2, and let the other, 1/2, settle.

I'll try to address this again considering what we've discussed here,
improving the message with context as you suggested and trying to
use more a sense of completion than a fix or bug.  Maybe also covering
other options in branch that might be affected for this configuration
thing.

Thank you.
