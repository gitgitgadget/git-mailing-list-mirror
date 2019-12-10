Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF997C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E84207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9oSSBCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJNvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:51:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38797 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 08:51:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id b8so9828796oiy.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UVlCf5MyzMQ5sVNKAnYPUwC63Z1JIIFJm6Oo86NOdAU=;
        b=p9oSSBCned0LbVP6WHBJUnlkzCotztMDkZTkdli6rLA1iXe+OfaiOLN4z76opMm0p6
         TOe2q2/KAvWh7ietFldN/UMnjoAdwAMSZ6bg2Gp5QSD3EogssS/msI4dWjDg7uyHRS0g
         43rgVpuEJw/SOrmXP6GEQjw5uxyroXgdYopL1VL0iB/g5cMPS2vlLO9vwbPhnUauKC0s
         XE3Gc25WYYjy5garL0+mFHnN5o5aFRNver4Mu/Gp6xq8ARPu/0ljjKljT+ublR7QMNFh
         gwJo0najooyGr8R4HM27aLNmqYG1OXDlbb6+vwfEagDzBk4kOZrFoBYSXZh3cGnPWPID
         VC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UVlCf5MyzMQ5sVNKAnYPUwC63Z1JIIFJm6Oo86NOdAU=;
        b=XUWOFbQGEsC4h+yA1WzMHaRhylMmQ0ByJASwVGp53R6L5VmpBlnkNKLo17MSPKWoYA
         arBrga+Bf/WylRxL2HKXhsEk8JiNLL2UQI+Yu9EaiS5KUwCm8lKgwslwsNySBUT7tg2K
         r9oNaa3liLddL5e9w1aEX0ZZUkUoIjIzv+g68YESWpMHR+6q45ylgTbP4haW7V71MGAL
         qwBCbVoDLMM65dcx76PqIROSBSoogkB8qr+5/iGPgarQz1QNKvr+POJQFfOphltagdMJ
         JTd34R4t+Hk2OU6elB5zBC8+UEw86QGWuU18GVgH4PZ4xkDBrpGTl06RJ3F1d0ry040b
         aQDw==
X-Gm-Message-State: APjAAAU9frD8XiG3iBmhWO+hoO8TWPo6i0raaUX39HC2lpOF8sROZJhJ
        vSdXHWRGQX26lRuY6WJaJL0=
X-Google-Smtp-Source: APXvYqxaZq29lDG3v5lE0lDEpbtWwVwYVGf4ZPeMPlziTYte+oIDmcZIVJo17uMAKViUdg+bJH9OuQ==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr3733983oic.37.1575985878988;
        Tue, 10 Dec 2019 05:51:18 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 47sm1410368otf.54.2019.12.10.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 05:51:18 -0800 (PST)
Subject: Re: [PATCH v2 8/8] test-lib: clear watchman watches at test
 completion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
 <xmqqwob5ru27.fsf@gitster-ct.c.googlers.com>
 <bfa73fab-ce2c-a05e-3568-cd406dd5c31f@gmail.com>
 <xmqqo8wgsqnn.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd8c14d3-21b6-731c-bd50-650d063d686f@gmail.com>
Date:   Tue, 10 Dec 2019 08:51:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8wgsqnn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/10/2019 12:20 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Hm. That is a good point. Can we assume that our version of grep has
>> a "-F" or "--fixed-strings" option? ([1] seems to say that "-F" would
>> work.)
> 
> $ git grep "grep -F" -- \*.sh
> 
> is your friend ;-) 

Yes, of course I should have just looked for examples.

> And never use https://www.gnu.org/ manual as a yardstick---you will
> end up using GNUism that is not unavailable elsewhere pretty easily.

I tried to focus on the part that said "this is part of POSIX", but
you are right that may not be the best place to look.

>> [1] https://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html#index-grep-programs
>>
>>> What are these stripping of ", and " about?  Could you tell readers
>>> how a typical output from the program we are reading from looks like
>>> perhaps in the log message or in-code comment around here?
>>
>> Watchman outputs its list of paths in JSON format. Luckily, it formats
>> the output so the path lines are on separate lines, each quoted.
>>
>> For example:
>>
>> {
>> 	"version": "4.9.0",
>> 	"roots": [
>> 		"<path1>",
>> 		"<path2>",
>> 		"<path3>"
>> 	]
>> }
> 
> Yeek; how is a dq in path represented?  by doubling?  by
> backslash-quoting (if so how is a backslash in path represented)?
> By something else?
> 
> It's OK at least for now to declare that our test repository does
> not contain any funny paths, but in the longer run does the above
> mean that we somehow need to be able to grok JSON reliably in our
> tests?  It may not be such a bad thing especially for longer term,
> as there are other parts of the system that may benefit from having
> JSON capable output readers in our tests (e.g. trace2 code can do
> JSON, right?)..

trace2 can _write_ JSON, not parse it. However, we have some parsing
code (using a package) in the performance tests. I could try
adapting that for this purpose. That package is not currently required
by the test suite, so it causes some dependency issues when first
running the perf suite. At least we wouldn't need the package
unless running with GIT_TEST_FSMONITOR.

My guess is that this patch is going to be trouble, so I'll eject
it in the next version and save the JSON parsing and everything
for its own series. We only really need it when we are getting
close to running watchman in CI on Windows.

Thanks,
-Stolee
