Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBAC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E30206D6
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 18:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLGSEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:04:48 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:58098 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfLGSEs (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Dec 2019 13:04:48 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ideRi-0002ZC-7Z; Sat, 07 Dec 2019 19:04:46 +0100
Subject: Re: Git as data archive
To:     Philip Oakley <philipoakley@iee.email>,
        Andreas Kalz <andreas-kalz@gmx.de>, git@vger.kernel.org
References: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
 <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <1c81112d-5a1b-a791-b43f-d6a67d5b2e04@virtuell-zuhause.de>
Date:   Sat, 7 Dec 2019 19:04:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1575741887;969885e3;
X-HE-SMSGID: 1ideRi-0002ZC-7Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.12.2019 17:54, Philip Oakley wrote:
> Hi Andreas,
> 
> On 06/12/2019 18:54, Andreas Kalz wrote:
>> Hello,
>> I am using git as archive and versioning also for photos. Apart from
>> performance issues, I wanted to ask if there are hard limits and
>> configurable limits (how to configure?) for maximum single file size and
>> maximum .git archive size (Windows 64 Bit system)?
>> Thanks in advance for your answer.
>> All the best,
>> Andreas
> 
> On Git the file size is currently limited to size of `long`, rather than
> `size_t`. Hence on Git-for Windows the size limit is 32bit ~4GiB
> 
> Any change will be a big change as it ripples through many places in the
> code base and, for some, will feel 'wrong'. I did some work [1-4] on top
> of those of many others that was almost there, but...

Adding to what Philip said. On Windows the size of exported archives
(git archive) is currently also limited to 4GB. The reason being also
the long vs size_t issue (which is not present on linux though).

So if you can switch to Linux or even MacOSX these issues are gone.

The number of files in .git, only the number packfiles would be of
interest here I guess, do not have the long vs size_t issue. So
packfiles can be larger than 4GB on 64bit Windows (with 64bit git of
course).

But depending on how large the biggest files are, it might be worth
tweaking some of the settings, so that the created packfiles are
readable on all platforms. I once created a repo on linux which could
not be checked on windows, and that is a bit annoying.

So the questions are how large is each file? And what repository size do
you expect? Are we talking about 20MB files and 10GB repository? Or a
factor 100 more? And are you just adding files or are you modifying the
added files? Depending on the file sizes it might then also be
beneficial to tweak the delta compression settings and/or the big file
threshold limits.

Thomas

> The alternative is git-lfs, which I don't personally use (see [4]).
> 
> Philip
> 
> [1] https://github.com/git-for-windows/git/pull/2179
> [2] https://github.com/gitgitgadget/git/pull/115
> [3] https://github.com/git-for-windows/git/issues/1063
> [4] https://github.com/git-lfs/git-lfs/issues/2434
> 
> 

