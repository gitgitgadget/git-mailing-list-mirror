Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1572C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3262067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKq5kDOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgAHMuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:50:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41961 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgAHMuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 07:50:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so3166570ljc.8
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7KeguzBvN8UtmyX5pnIeXGkRAAL98wShYmOIkaMWFOo=;
        b=BKq5kDOVsM1FfPp6I4765MuoC3NkmyMRR9T3x4Q9Yf1DDPVjCQczsZbwvTrCsDw7ev
         GSDt039UHWr8FJBfGgoyn32BuWYJRng1Rp6arHaFy24ElmSiHt10TJJ/tQJ9agwpWX6F
         SlXSD33lvKJEgvoghl7Ojxq1vqvJBSCG8VE5dgvMmPGw4Afuu8XS/ah9x6W66jwU2y5J
         6sPQ6rqSrzO4qM1IOtxi6Oyl21DEPyhG4ONFwtQuNDoARTC6Yow0VRenpaROnpka7xh8
         HeZDRbFlwrz7CO782sGD7qb3zS7R3DromXSOJ1/IDoOnbxW2WSCXCt0xnzJQMc9wCzf9
         StEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7KeguzBvN8UtmyX5pnIeXGkRAAL98wShYmOIkaMWFOo=;
        b=HUSfSNlcf7cQYu9ZijyhrWXIkUVpDLUM5R/C7K6nY6VOL7a+M6O2DE+RZwz/+9mPfT
         X07g3Z9l/HlaUMbQcxM+6qT3lk1Xz4F7qE5G5sfPAZfKhDKCiKg4WZ7McPFRaqdmlFCw
         6WGz8fYaAgj7VUZWHhmjzCNzWrbnaB3N0eHRBaWv28NVch9QPfCjgjfA1rgONoaKB1E1
         6y9QZpfvRoQAqARiz1FKPghFTTnLHCnXenrwg49xQuNY4hdskYLekhyx9MmPumDgpaMs
         Qj014mUox4FlCmZZzn5FNamSf4hsJlIxAZY9Fa6AOouV7AdbZiWTWld5azY8GNlOvT8q
         mj0g==
X-Gm-Message-State: APjAAAWINXjuxHNoX/9H9k+MdnZf9/oZNtp+yDxbKfb+9dKylVx2J8Sx
        U1t2957MWRJuLH/PhkdSrB8=
X-Google-Smtp-Source: APXvYqyTXHStj5Bmjbi4VYkemmNvG/4oNP78bn4FQG1zctsJ9QzH/hbOgipAxl4X31/Ule8d9iclAA==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr2864573ljk.159.1578487844646;
        Wed, 08 Jan 2020 04:50:44 -0800 (PST)
Received: from [192.168.0.104] (broadband-90-154-72-234.ip.moscow.rt.ru. [90.154.72.234])
        by smtp.gmail.com with ESMTPSA id i5sm1229652ljj.29.2020.01.08.04.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 04:50:44 -0800 (PST)
Subject: Re: [PATCH 0/1] Preserve topological ordering after merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2001071308290.46@tvgsbejvaqbjf.bet>
From:   Sergey Rudyshin <540555@gmail.com>
Message-ID: <fa570dcf-b19b-f658-456e-b4174d767ba1@gmail.com>
Date:   Wed, 8 Jan 2020 15:50:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001071308290.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,
thanks for you comments!
please find my replies below


07.01.2020 15:11, Johannes Schindelin wrote:
> Hi Sergey,
> 
> On Tue, 7 Jan 2020, Sergey Rudyshin via GitGitGadget wrote:
> 
>> This modifies the algoritm of topopological ordering. The problem with the
>> current algoritm is that it displays the graph below as following
>>
>> * E
>> |\
>> | * D
>> | |\
>> | |/
>> |/|
>> * | C
>> | * B
>> |/
>> * A
>>
>> commit B is placed between A and C, which is wrong because E stays that D
>> and B comes after C
>>
>> the only correct solution here is
>>
>> * E
>> |\
>> | * D
>> | |\
>> | |/
>> |/|
>> | * B
>> * | C
>> |/
>> * A
>>
>> while it seems that it contradicts to D staiting that C shoud be between D
>> and B The new algorithm solves this issue
>>
>> Here is an example: walk to to the root via "first" parents go E -> C -> A
>> print A because it has no parents step back to C print C because it has no
>> other parents then step back to E go D -> B -> A do not print A becase A is
>> already printed step back to B print B so on
>>
>> This change makes option "--topo-order" obsolete, because for a single
>> commit there is only one way to order parents. "--date-order" and
>> "--author-date-order" are preserved and make sence only for the case when
>> multiple commits are given to be able to sort those commits.
> 
> I have to admit that I am not a fan of this change, as I find that there
> are legitimate use cases where I want to order the commits by commit
> topology, and other use cases where I want to order them by date.
> 
> Maybe other reviewers agree with your reasoning, though, in that case you
> still will need to address the test failures in t4202, t4215 and t6012:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=25867&view=ms.vss-test-web.build-test-results-tab
> 
> Ciao,
> Johannes

let me explain in more detail why I thought it would make sense to stop 
using "--topo-order".
in case if a user specifies a single commit, like this
git rev-list E
with a new algorithm the options "--date-order", "--author-date-order", 
"--topo-order" do not change the ordering. Because there is only one way 
to sort any git graph with a single tip.

in case if a user specifies multiple tips, like this
git rev-list --topo-order C B ^A
current version of git displays commits ordered by commit timestamp
which does not seem like a topological ordering.

so I decided to change the documentation so that "--topo-order" and 
"--date-order" be the same. And since "--topo-order" does not add 
anything new decided to deprecate it.

Form my point of view there should be no options to sort at all.
The topology should be derived from the order provided by the user
git rev-list --topo-order C B ^A
should result in C, B
git rev-list --topo-order B C ^A
should result in B, C

Regarding the failed test
I'll try to find the reason but what puzzles me is why those tests 
(t4202, t4215 and t6012) succeeded on all other platforms (linux32, 
osx-clang, windows, ...) and only failed on linux-gcc.
In my machine those tests do not fail either (gcc (Ubuntu 
5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609)

