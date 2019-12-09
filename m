Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC709C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 01:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A857320663
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 01:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfLIBSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 20:18:42 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:60476 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbfLIBSm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Dec 2019 20:18:42 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ie7h9-00007l-Lx; Mon, 09 Dec 2019 02:18:39 +0100
Subject: Re: Git as data archive
To:     Andreas Kalz <andreas-kalz@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
References: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
 <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
 <1c81112d-5a1b-a791-b43f-d6a67d5b2e04@virtuell-zuhause.de>
 <76f7d2f5-45fe-a43f-2121-954e1a497b4f@gmx.de>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <d4e34fa6-e92c-5178-c61e-e4b87dab7e09@virtuell-zuhause.de>
Date:   Mon, 9 Dec 2019 02:18:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <76f7d2f5-45fe-a43f-2121-954e1a497b4f@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1575854321;f8df8dd1;
X-HE-SMSGID: 1ie7h9-00007l-Lx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.12.2019 19:44, Andreas Kalz wrote:

Hi Andreas,

> @Thomas: are you Thomas Braun who studied at FH Regensburg?

nope, sorry.

> Well, currently the .git repository is 715GB and the maximum file size
> is 9.5GB, but I did not get error messages due to that even if the
> performance is quite low. The biggest pack* file is 24GB. There are some
> files which are modified, but most are not modified.

Okay that is kind-of-large. How did you add the 9.5GB file? AFAIK this
could not have be done on windows.

Do you push that to a remote repository as well?

> My question came up as I did not find a documentation about limits of
> git, only a lot of entries about github and forum users who are
> discussing about old bugs of git. I read about git-lfs and also that it
> is not working very stable, due to that I did not use it yet.

Although I'm not using git-lfs myself, from what I know it works well.
But it does have the same limitation as stock git for windows as Philip
pointed out already.

> How can the delta compression settings and/or the big filethreshold
> limits be modified?

These are plain git config settings. Have a look at [1]. The attributes
are explained in [2-3]. Basically you can set in .gitattributes

*.bin -delta, -diff

which would tell git that files with suffix bin should not be delta
compressed and are always binary.

You could also play around with turning compression completely off via
core.compression or pack.compression.

Hope that helps,
Thomas

PS: If you have resources to help fixing that long-standing bug in git
for windows, there is a PR open [4] which has a WIP version. But beware
you need good C skills and better-than-average git skills, or a
Santa-Claus-style bag with monetary resources.

[1]:
https://git-scm.com/docs/git-config#Documentation/git-config.txt-corebigFileThreshold
[2]: https://git-scm.com/docs/gitattributes#_code_delta_code
[3]: https://git-scm.com/docs/gitattributes#_marking_files_as_binary
[4]: https://github.com/git-for-windows/git/pull/2179

> Am 07.12.2019 um 19:04 schrieb Thomas Braun:
>> On 07.12.2019 17:54, Philip Oakley wrote:
>>> Hi Andreas,
>>>
>>> On 06/12/2019 18:54, Andreas Kalz wrote:
>>>> Hello,
>>>> I am using git as archive and versioning also for photos. Apart from
>>>> performance issues, I wanted to ask if there are hard limits and
>>>> configurable limits (how to configure?) for maximum single file size
>>>> and
>>>> maximum .git archive size (Windows 64 Bit system)?
>>>> Thanks in advance for your answer.
>>>> All the best,
>>>> Andreas
>>> On Git the file size is currently limited to size of `long`, rather than
>>> `size_t`. Hence on Git-for Windows the size limit is 32bit ~4GiB
>>>
>>> Any change will be a big change as it ripples through many places in the
>>> code base and, for some, will feel 'wrong'. I did some work [1-4] on top
>>> of those of many others that was almost there, but...
>> Adding to what Philip said. On Windows the size of exported archives
>> (git archive) is currently also limited to 4GB. The reason being also
>> the long vs size_t issue (which is not present on linux though).
>>
>> So if you can switch to Linux or even MacOSX these issues are gone.
>>
>> The number of files in .git, only the number packfiles would be of
>> interest here I guess, do not have the long vs size_t issue. So
>> packfiles can be larger than 4GB on 64bit Windows (with 64bit git of
>> course).
>>
>> But depending on how large the biggest files are, it might be worth
>> tweaking some of the settings, so that the created packfiles are
>> readable on all platforms. I once created a repo on linux which could
>> not be checked on windows, and that is a bit annoying.
>>
>> So the questions are how large is each file? And what repository size do
>> you expect? Are we talking about 20MB files and 10GB repository? Or a
>> factor 100 more? And are you just adding files or are you modifying the
>> added files? Depending on the file sizes it might then also be
>> beneficial to tweak the delta compression settings and/or the big file
>> threshold limits.
>>
>> Thomas
>>
>>> The alternative is git-lfs, which I don't personally use (see [4]).
>>>
>>> Philip
>>>
>>> [1] https://github.com/git-for-windows/git/pull/2179
>>> [2] https://github.com/gitgitgadget/git/pull/115
>>> [3] https://github.com/git-for-windows/git/issues/1063
>>> [4] https://github.com/git-lfs/git-lfs/issues/2434
>>>
>>>
> 
> 

