Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B789C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhLUXWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:22:04 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:28891 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232112AbhLUXWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:22:03 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mzoSH-000Bdp-6p; Tue, 21 Dec 2021 23:22:02 +0000
Message-ID: <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
Date:   Tue, 21 Dec 2021 23:22:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer
 overflow
Content-Language: en-GB
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late comment..

On 10/12/2021 14:31, Johannes Schindelin wrote:
> Hi Ævar,
>
> On Thu, 9 Dec 2021, Ævar Arnfjörð Bjarmason wrote:
>
>> The difference between "master" and "git-for-windows/main" is large
>> enough that comparing the two will segfault on my system. This is
>> because the range-diff code does some expensive calculations and will
>> overflow the "int" type.
> You are holding this thing wrong.
>
> The `main` branch of Git for Windows uses merging rebases, therefore you
> need to use a commit range like
> `git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
> compare it to `git-for-windows/main..master`.

I'm not sure that a Git repo has an established way of indicating to how
it's branching/merging/releasing workflow is set up, especially for
projects with non-normative use cases, such as Git for Windows. We don't
have a git document for covering  the different workflows in common use
for easy reference and consistent terminology.

The merging rebase flow, with 'fake' merge does solve a problem that
git.git doesn't have but could easily be a common process for 'friendly
forks' that follow an upstream with local patches. The choice of
'{/^Start.the.merging}' is currently specific to the Git-for-Windows
case making it harder to discover this useful maintainer method.

I fully agree that the range-diff should probably have a patch limit at
some sensible value.

The 'confusion' between the types size_t, long and int, does ripple
through a lot of portable code, as shown in the series. Not an easy problem.

>
> Failing that, you will receive only bogus results.
>
> As to the patch series, it likely does the wrong thing. Just like we error
> out on insanely large input in libxdiff, `range-diff` should do the same.
>
> Ciao,
> Johannes
--
Philip
