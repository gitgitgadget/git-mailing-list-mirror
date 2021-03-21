Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C7EC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 23:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D9961926
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCUXOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 19:14:50 -0400
Received: from mx.99rst.org ([52.22.122.190]:39234 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhCUXOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 19:14:17 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 78D3142328;
        Sun, 21 Mar 2021 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616368454;
        bh=yUV3m7YaBIfTrYrtG3edbZqgXqKeRmaNwwbS68fTqvc=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=cTydFLPpCu7sF1OP9ej2U5mIa3xhHHQJmjg/2rHlu967zYuafswDTD9atn/Kd5aCt
         g/Tytafvr8Oo/DVpzom2YLgw1AtEp05HKnWR14t1v4UMqFqsNtAtlJKziEdEIALzOR
         3Oa4VQUaAYm0jjHZr+/GQWtZ6K2CYhRK3S9cDd5uGIGa5k+lUMT8t3wrlsVkk5QwGi
         3NAfMyjfQvdeMmcIyc92OTv9ei/tV1p3TsoeDLvKPxLYWexD5iKeQaUlj4oYdpRaVc
         FK+papTUT3l/WCXcKxYF4VpVQ0rU/ntIw0Vcnu363Tw5UmBpgiD/WdTjKdGI218gIp
         DzwqfO86O2gXQ==
Received: by mail.kodaksys.org with HTTP;
        Sun, 21 Mar 2021 23:14:14 -0000
Message-ID: <14d3cda766b0212ca9d8204eba35aa4d.squirrel@mail.kodaksys.org>
In-Reply-To: <xmqqmtuw884f.fsf@gitster.g>
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
    <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
    <xmqqzgyw9wn3.fsf@gitster.g>
    <dfb1fe6cdf78788250009abe8e1489c8.squirrel@mail.kodaksys.org>
    <xmqqmtuw884f.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 23:14:14 -0000
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Georgios Kontaxis" <geko1702+commits@99rst.org> writes:
>
>>> ... so I doubt
>>> the wisdom of munging the patch part at all.
>>>
>>> I may be sympathetic to the cause of the patch, but, I do not agree
>>> with its execution in this iteration of the patch.
>>>
>> I see your point.
>>
>> It seems hiding e-mail addresses should be limited to the commit
>> message,
>> i.e., stop at the "---" line.
>
> I doubt it makes sense to redact anything in the 'patch' view at
> all, actually.  What kind of URL does the crawler need to formulate
> and what pieces of information (like commit object names or branch
> names) does it need to fill in the URL to get a series of patches
> out of gitweb?  As long as it takes more effort than running "git
> clone" against the repository, the crawler would not have much
> incentive to crawl and harvest addresses from the 'patch' pages, and
> even in the log message part, the downsides of butchering the
> payload would outweigh the "privacy benefit", I would have to say.
>
No effort at all I would say.
E..g, somehow the web crawler gets to git.kernel.org.
It then follows every link, eventually arriving at a commitdiff page.
It then follows every link, which includes the URL for the patch output.
See how "wget --mirror" behaves for instance.

Just to clarify, my goal is not to stop someone who wants to extract
e-mail address from git.kernel.org specifically.
They can just "git clone" the repositories and grep through the logs.
My goal is to stop generic crawlers (pretty much "wget --mirror | grep"
scripts) from making their way to the logs.

> Quite honestly, if a site claims to offer a 'patch' download UI but
> returns corrupt data back, I would say it is much worse than not
> offering the service at all.  Perhaps disabling the 'patch' feature
> in repositories that enable 'privacy' feature may be a much better
> approach.
>
Good point. I think I'll try that.


