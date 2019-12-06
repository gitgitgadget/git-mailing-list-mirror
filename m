Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CFC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF44206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYfgD8Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFTfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:35:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55212 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFTfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 14:35:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so8984990wmj.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 11:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LU/58jqq+eqCJEua027k3aMMKCl+6yQm1BbUjgTR4kM=;
        b=kYfgD8NqLpeLrHFJ7PM4jT8NBkN3BVzM1F3E5RlffBYUjHAqFfuwDpnra3wkOgXoqO
         ajFRLpxh3mDmnKdD5ZW74qh0Bkd709x01daMdgJWD8NHWmqBBEuH9ejtzHeeZLmSGfOV
         jcl6oAOFrRnDaXQ/7lFZPYhvEiLKnaCpswXZVb0zymFmPZPU4WWy8yUCBP4ig3f+7j6F
         i19vDCgk8WBse14kvgdJ26xbOIbbPgBmJ3+1wUWCnlIC7QNqWz06TZS6qVyJbhz+BeAj
         s2a1PZxmc+qpCy4FWndJUSMqEeWPC2x0RKx07Q/kcAdV548MeJCMN+zuLQU/H8A4eUQr
         4quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LU/58jqq+eqCJEua027k3aMMKCl+6yQm1BbUjgTR4kM=;
        b=NoSIqJJmKAisf4GB2MTzwG5CPePZQbnWSs/Cft7RTuBVPhHbNVZLTnkGI6H7Aty1y1
         gBfAIShF3aS4QwQeqWwg3tmFtb3n9zmMOrrle0JGcEaNeNwF1aBqCdnthSOWGmO9RckT
         3RCX87o8V8EiPsQOczqCyiNcMFB4BaWRJH9UMOk/aLBWU//6VSV1Ac7rDaaiU9+GwUj+
         8KOUBfAsgidrjXXzmsRKgbnqN8IskS3dmmZcI0p25AjLOngVt7RK9ONIc/PY/vmbS8wy
         SSBhkWO4yZa7OMkqIZzvmwtmZUrx0GqUuFCjsNHSy5KQUYRT6wYzVWxXAmnnWRjFpR07
         TmpQ==
X-Gm-Message-State: APjAAAWGN+xSqp6qY4qo0Dy/DP5PeGMBtED/+M4gVBnaXBMAb87uHqeS
        FDskw2vteYf8LsxxYgDaNA/UTG5D
X-Google-Smtp-Source: APXvYqzG6CpP5luMI28ifiKr75g5EWqs0i948Z1LXTC6VaKWGQSeW9lECztIdz8WGfvaigtwAgu3yg==
X-Received: by 2002:a1c:4f:: with SMTP id 76mr9168575wma.69.1575660934721;
        Fri, 06 Dec 2019 11:35:34 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id o15sm18294836wra.83.2019.12.06.11.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 11:35:34 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: find --fork-point with full refgg
To:     Denton Liu <liu.denton@gmail.com>, Alex Torok <alext9@gmail.com>,
        g@generichostname
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-3-alext9@gmail.com>
 <20191206014828.GB16183@generichostname>
 <e898ad43-5649-8f4c-7c93-fab09197fc92@gmail.com>
 <CANmPhj38UqZiePEPbPJBwUTOEJrfA6j3aP8KBHvAY6EA-J7Nsw@mail.gmail.com>
 <20191206191147.GA16379@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <117ce276-f37b-057c-849f-909852a6dd2c@gmail.com>
Date:   Fri, 6 Dec 2019 19:35:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191206191147.GA16379@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2019 19:11, Denton Liu wrote:
> Hi Alex,
> 
> On Fri, Dec 06, 2019 at 08:46:29AM -0500, Alex Torok wrote:
>> Thank you for the feedback Denton & Phillip!
>>
>> On Fri, Dec 6, 2019 at 5:52 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> On 06/12/2019 01:48, Denton Liu wrote:
>>>> nit: * should be attached to the variable name.
>>>
>>> I think you also need to free it once you've called get_fork_point() as
>>> well.
>>
>> Yup. Got it.
>>
>>> On 06/12/2019 01:48, Denton Liu wrote:
>>>>
>>>>> +            dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
>>>>
>>>> Also, thinking about this more, would it be possible to put the dwim_ref
>>>> logic into get_fork_point() directly? There are currently only these two
>>>> callers so I suspect it should be fine and it'll result in cleaner
>>>> logic.
>>>
>>> If you do that then it would be better to use error() rather than die()
>>> in get_fork_point() and return an error to the caller as we try to avoid
>>> adding code to libgit that dies. This lets the caller handle any cleanup
>>> that they need to before exiting.
>>
>> Would the signature of get_fork_point change to be something like:
>> int get_fork_point(const char *refname, struct commit *commit,
>>     struct commit **fork_point, struct strbuf *err)
> 
> I would drop the last parameter. If an error is detected, you could just
> do
> 
> 	return error(_("oh no, something bad happened"));
> 
> Even though we try and avoid dying in the middle of libgit, we print
> errors out very often so it should be fine here.

Yes that was what I was thinking of

Best Wishes

Phillip


> 
>>>> Also, I'm not why this test case in particular that was duplicated (and
>>>> not the one above) given that the first three `--fork-point` test cases
>>>> fail without the change to rebase. Perhaps we want to duplicate all
>>>> "refs/heads/master" tests with a corresponding "master" test?
>>
>> I only duplicated one so that there would only be one test case that
>> would fail if a regression around getting the fork point with a short
>> ref name was introduced.
>>
>> I just happened to pick that one because it was closest to the rebase
>> command I was running when I found the bug :)
>>
>> I can include some of the above reasoning in the commit message.
>> Alternatively:
>> * I could duplicate all of tests
>> * I could change all of the tests to use the short ref name
>>
>> I'm leaning towards just leaving one test (maybe with a comment?)
>> for the short ref name --fork-point so that there is more resolution
>> around where a bug could be on test failure.
> 
> I would just duplicate all of the tests. When the tests are pretty cheap
> to run (as they are in this case), I tend to err on the side of adding
> more tests since they might catch more odd edge-cases but, in this case,
> all of the fork point logic goes through one common block so the
> duplicate logic doesn't really buy us anything.
> 
> I'm pretty impartial so I'll leave it up to you ;)
> 
> Thanks,
> 
> Denton
> 
>>
>> Let me know what you think,
>> Alex
