Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB1C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE8720692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOLIjy96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgAHREt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:04:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36815 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgAHREs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 12:04:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so3008514lfe.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJCkd/wXQ90Zh4TmtrRkiyx0kCTbe4O6coUgS0Xi97U=;
        b=KOLIjy96LuXsAwA9AI2AlrxRLJhoGW1MoY4OKzRjX/OpmLJa7KOF7W4HFflhrT1Qq0
         ien+vnwEZfvfh/L+7Ce9VFyba6ia8R8sEokWm1g03en3vy6iGJ4Mb9PBXtioJZPvtd0B
         ywhn8Cn7C3VOv4Dgmkb5FwxL8gIVNVbwgSSBb9eKSTcU/WDXEtL3K3DLVtMNxqWaOmcb
         mwxl7voMC2ROwQkZ1gvMhIFRB7RCghOfWKcpQzWiHw16AaPN0DxDbNJJrC80IAUlGPDv
         uXAvCJ5qcnXEfZQYAY2a4v+QpdZdtmuh7HubVH8vltYrc6amTtFc+nlJ5i8xmJKN4mtt
         hN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJCkd/wXQ90Zh4TmtrRkiyx0kCTbe4O6coUgS0Xi97U=;
        b=f+uzxPjDU7V+AXIBQpLWYFTkHq/koQ7QZvDlhIX+I4wut2e3bLAaHrfCxPXpytz0Ha
         iAi0RW+igmETIMBH6NOca9yRCw3S2tT1rx+38DRl0ZBsiCLJbejhNgItHA4zCoD+C7Y4
         wnBDgxEr4B/v1HLuF1Ws6F/aS3hINvHOQmB4uJsP0/2CAOUKCF8f5hvuHsVr/VEWPS28
         SVfIAtgonaRiCYsAgwrLkwPu79/j50EODaSwyeS77LN7iT5cqeI5WVjM39djkRTjoLhU
         mhMY6n1fh8KLWr6VjVrzEuqKohd33v/JLsZfRxwrn88bFhns0mHpXvcvFQhFYZZyfxV5
         VvWA==
X-Gm-Message-State: APjAAAUy2xHxqO4bMM/Sx011QiUGBfoulZ7TnuV7FmLun0e8hBuGYmsb
        y8VaO0LKPgNKYbfu4PckLX2ia1Tuu+iIc09N
X-Google-Smtp-Source: APXvYqy5IiQAW/WEDn6bh2V+ru3w7Kgf3tIHv2sM9ma+QTmEXZ06fdyXua9Y2upiFJNzmGgjJdsxRg==
X-Received: by 2002:ac2:59dc:: with SMTP id x28mr3478080lfn.38.1578503080856;
        Wed, 08 Jan 2020 09:04:40 -0800 (PST)
Received: from [192.168.0.104] (broadband-90-154-72-234.ip.moscow.rt.ru. [90.154.72.234])
        by smtp.gmail.com with ESMTPSA id v26sm1699540lfq.73.2020.01.08.09.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:04:40 -0800 (PST)
Subject: Re: [PATCH 0/1] Preserve topological ordering after merges
To:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2001071308290.46@tvgsbejvaqbjf.bet>
 <fa570dcf-b19b-f658-456e-b4174d767ba1@gmail.com>
 <222602fc-68a9-0671-e6b9-1aa727d830ea@gmail.com>
From:   Sergey Rudyshin <540555@gmail.com>
Message-ID: <077aeb22-ad9c-a9c4-9ee5-21405f85cade@gmail.com>
Date:   Wed, 8 Jan 2020 20:04:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <222602fc-68a9-0671-e6b9-1aa727d830ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Thank you for your comments!

08.01.2020 16:37, Derrick Stolee wrote:
> On 1/8/2020 7:50 AM, Sergey Rudyshin wrote:
>> let me explain in more detail why I thought it would make sense to stop using "--topo-order".
>> in case if a user specifies a single commit, like this
>> git rev-list E
>> with a new algorithm the options "--date-order", "--author-date-order", "--topo-order" do not change the ordering. Because there is only one way to sort any git graph with a single tip.
> 
> This is false, unless your history is always linear (no merge commits).

Would it be possible to provide some test script which would prove you 
point? We could run it against the binary created based from 
https://github.com/gitgitgadget/git/pull/514/commits/542a02020c8578d0e004cb9c929bced8719b902a


> 
>> in case if a user specifies multiple tips, like this
>> git rev-list --topo-order C B ^A
>> current version of git displays commits ordered by commit timestamp
>> which does not seem like a topological ordering.
> 
> Are you talking about which of C and B are shown first? They are shown in an order based on your input. If C and B are independent (neither can reach the other), then they will swap order if you write "git rev-list --topo-order B C ^A".
> 

Please find a script showing that commits are always sorted by commit 
timestamp no matter how they appear in the input.

$ cat ./test.sh
#!/bin/bash
export LANGUAGE=en
GIT=/usr/bin/git
$GIT --version
rm -rf .git
$GIT init
export GIT_COMMITTER_DATE="2000-01-01T00:00:00 +0000"
$GIT commit -m "0" --allow-empty
$GIT tag 0
export GIT_COMMITTER_DATE="2001-01-01T00:00:00 +0000"
$GIT checkout --orphan b1
$GIT commit -m "1" --allow-empty
$GIT tag 1
export GIT_COMMITTER_DATE="2002-01-01T00:00:00 +0000"
$GIT checkout --orphan b2
$GIT commit -m "2" --allow-empty
$GIT tag 2

fnc () {
	echo "$@"
	$GIT log --graph --pretty=tformat:"%D %ci" "$@" | sed 's/-01-01 
00:00:00 +0000//'
}
fnc --topo-order 0 1
fnc --topo-order 1 0

fnc --date-order 0 1
fnc --date-order 1 0

fnc --topo-order 1 2
fnc --topo-order 2 1

fnc --date-order 1 2
fnc --date-order 2 1

fnc --topo-order 0 1 2
fnc --topo-order 2 1 0

$ ./test.sh
git version 2.7.4
Initialized empty Git repository in /tmp/git_test_case_ordering/.git/
[master (root-commit) 0a449fc] 0
Switched to a new branch 'b1'
[b1 (root-commit) 070d07f] 1
Switched to a new branch 'b2'
[b2 (root-commit) c751327] 2
--topo-order 0 1
* tag: 1, b1 2001
* tag: 0, master 2000
--topo-order 1 0
* tag: 1, b1 2001
* tag: 0, master 2000
--date-order 0 1
* tag: 1, b1 2001
* tag: 0, master 2000
--date-order 1 0
* tag: 1, b1 2001
* tag: 0, master 2000
--topo-order 1 2
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
--topo-order 2 1
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
--date-order 1 2
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
--date-order 2 1
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
--topo-order 0 1 2
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
* tag: 0, master 2000
--topo-order 2 1 0
* HEAD -> b2, tag: 2 2002
* tag: 1, b1 2001
* tag: 0, master 2000



>> so I decided to change the documentation so that "--topo-order" and "--date-order" be the same. And since "--topo-order" does not add anything new decided to deprecate it.
> 
> Based on this sentence, it is clear that you do not understand the difference between --topo-order and --date-order. Please take time to examine the output difference for the Git repo with the following commands:
> 
> 	git log --oneline --graph --topo-order
> 	git log --oneline --graph --date-order
> 

Hope that the script above will clarify what i meant.

>> Regarding the failed test
>> I'll try to find the reason but what puzzles me is why those tests (t4202, t4215 and t6012) succeeded on all other platforms (linux32, osx-clang, windows, ...) and only failed on linux-gcc.
>> In my machine those tests do not fail either (gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609)
> 
> Try running the tests with GIT_TEST_COMMIT_GRAPH=1.
> 

Yes it helped. With that option the tests starts to fail.
I'll try to find out how COMMIT_GRAPH works and fix it.

> -Stolee
>   
> 

PS
excluded Junio from the loop per his request.
