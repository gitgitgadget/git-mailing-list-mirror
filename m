Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBAC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF86E613B4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFRNHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:07:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:20659 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFRNHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:07:51 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1luEBo-0009hw-4F; Fri, 18 Jun 2021 14:05:40 +0100
Subject: Re: [PATCH 0/3] Make CMake work out of the box
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
 <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b52d7c45-06dd-a9eb-bc86-e04d2ee16c5e@iee.email>
Date:   Fri, 18 Jun 2021 14:05:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 10:43, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 5 Jun 2021, Bagas Sanjaya wrote:
>
>> On 05/06/21 00.43, Matthew Rogers via GitGitGadget wrote:
>>> This pull request comes from our discussion here[1], and I think these
>>> patches provide a good compromise around the concerns discussed there
>>>
>>> 1:
>>> https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
>>>
>>> CCing the people involved in the original discussion.
Matt,
Thanks for picking this up and the approach to working around the
updated build approach of recent Visual Studio versions.
 
It looks good to me, but the CI should also be tweaked (see below) so
that it is tested.
>> This focused on improving CMake support, especially on Visual Studio, right?
>>
>> Then so we have three ways to build Git:
>> 1. plain Makefile
>> 2. ./configure (really just wrapper on top of Makefile)
>> 3. generate build file with CMake
>>
>> If we want to support all of them, it may makes sense to have CI jobs that
>> perform build with each options above.
> We already exercise the plain Makefile plenty, and the CMake-based build
> using Windows (in the `vs-build` job in `.github/workflows/main.yml`).

There is one 'gotcha' in the yml (probably historical) in that it
doesn't actually test the approach/changes that Matt addresses regarding
my [1].

That is, I'm looking at the 'out of the box' view, while the yml test
_preloads_ the vcpkg artefacts.

There is also the (on Windows) issue that the ARM support has recently
been developed which also fudges the CmakeLists.txt file but forgot
about the assumption in the vcpkg install batch file that the default is
the x86 setup.
>
> I do not see that it is worth spending many electrons exercising the
> `./configure` way, seeing as the preferred way to build Git is by using
> the `Makefile` directly.
>
> And our CMake configuration only really works on Windows, the attempts to
> get it to work on Linux were met with less enthusiasm, seeing as the
> `Makefile` approach is the recommended (and supported) one.
>
> tl;dr I don't think we need to augment our CI jobs as suggested.
I'd agree that there's no need to augment the CI job to expressly check
the other flags, but the existing test should reflect the intent of the
patches (i.e. no preloading of the vcpkg artefacts).

I haven't had much time to catch up on Git, and I'm off-line again from
Sat night for another week.
