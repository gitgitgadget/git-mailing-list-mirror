Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172151F462
	for <e@80x24.org>; Wed, 29 May 2019 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfE2N4G (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 09:56:06 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20433 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfE2N4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 09:56:06 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Vz3jhjIGEniZTVz3jh5amx; Wed, 29 May 2019 14:56:03 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8 a=NEAV23lmAAAA:8
 a=0JDDp5sXxsUPfCRc0GYA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22
Subject: Re: Need help merging unrelated histories
To:     Robert Dailey <rcdailey.lists@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git <git@vger.kernel.org>
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
 <87ftp3lqvw.fsf@igel.home>
 <CAHd499BQO8E99Y4=T9V6xXDuDyHdqMJ_sQM4DTraAxLzKf+Z-Q@mail.gmail.com>
 <CAHd499CZnhzw+sKM_Nx4_SvUT5YWaLWr9SmBKCkOcH4=wSdaqA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <4e1ab4ad-f883-263a-2826-5a79bf75494b@iee.org>
Date:   Wed, 29 May 2019 14:56:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHd499CZnhzw+sKM_Nx4_SvUT5YWaLWr9SmBKCkOcH4=wSdaqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNpv4BmRtj3erXwa7QWaagF1VEHKmtFWXJlSNA1wg/m8Ey6oiT/pwurBgtcHgtxet4z+SvhB5xTPXNk3+/qaBgkKbjHfFHnxLcKuMlb2xmNzz/vAtwvP
 ok6AHOMEAMJ89JUCOuVF1NCqSi/4qteOJn6YIczEVb7uVyhPUlJ+dqi7H6Y4eyNlWnofhT8Imj5t/qN3HCJO0pAe5Rlc4ndOHkqieLsD73wmjGAB93KdTZeL
 oUI1vIwhD3+LP2rI1gaEPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,
A few comments to look at, which may help.
On 28/05/2019 19:26, Robert Dailey wrote:
> On Tue, May 28, 2019 at 8:35 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> On Fri, May 24, 2019 at 12:11 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>> On Mai 24 2019, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>>
>>>> Can anyone provide some advice on how to properly restructure this
>>>> repository to create some ancestry, as if all along a `master` existed
>>>> and all release branches were based on this in a linear fashion?
>>> How about using git replace --graft, then git filter-branch to make it
>>> permanent?
>> I unfortunately have little-to-no experience with low level plumbing
>> commands. Could you provide an example of a series of commands to run?
>> It will help me to figure out how to do it on my own for my specific
>> use case. Thanks in advance.
> Toyed around with it a bit, and tried with the script below. There
> were no errors, but I noticed that it erased my `.gitattributes` file
> on master that I committed before performing the graft. Why did it
> remove the file? I assume I'm not doing this correctly. Please advise.
> Thank you.
>
> ```sh
> #!/usr/bin/env bash
> set -ex
>
> if [[ ! -d Native_SDK.git ]]; then
>      git clone --bare git@github.com:powervr-graphics/Native_SDK.git
> else
>      cd Native_SDK.git
>      git fetch
>      cd -
> fi
>
> rm -rf test_repo
> git clone Native_SDK.git test_repo
> cd test_repo
>
> git checkout -f --orphan new_master
Check here what is in the files system and index - see the caveat in the 
man page for the --orphan start point and potential use of `git rm -rf .`
> echo '* text=auto' > .gitattributes
Maybe also add some mega comment line to really see it..
> git add .gitattributes
> git commit -m 'Add gitattributes file'
Check what is actually committed, in case you have more/less than expected.
> c=$(git log --oneline origin/3.4 | tail -1 | cut -d ' ' -f 1)
Is this the one you expected (maybe gitk viewer )
> git replace --graft $c new_master
Typing "git replace" without arguments, also lists all replace refs. - 
check what the new one is. Investigate.
> git filter-branch HEAD..origin/3.4
Hmm is this the right range for re-write (not checked, just feels as if 
it's wrong). Maybe also need a local branch name for origin/3.4, just 
for comparing.
> git merge --no-edit --no-ff origin/3.4
> ```
same again

Hopefully the random thoughts may prompt something.
Philip
