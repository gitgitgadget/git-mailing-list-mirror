Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EDC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814826109F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhKEVrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:47:03 -0400
Received: from avasout-peh-001.plus.net ([212.159.14.17]:41915 "EHLO
        avasout-peh-001.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhKEVrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:47:01 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id j70Rm3MpZCV4Tj70SmFu1f; Fri, 05 Nov 2021 21:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636148659; bh=hO/3DZV9a201YObsZlNtTm02fi4u0ODMmS5wwZtwGTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WAqk5Iq5zpnCVDd8YkiSsQnlFpCuOtpyrN6x6GpwSCrm/J70iDZ8d0vFuhfJqQ+U0
         MKm1F/0/XxmZVCLS9G/hp7deqqPGA9LST0HtORY0Bu2pZ9kynvjjdd0SjfAgQUdbsi
         kdl78DQJy89YE9ZVFGBjfx7LcONdrLpCVH8WQbAjf3aFE8GfMkexvhe7DWssdVNjDx
         2JXDlrD5nMPbTBljlqHglyklTU/u75cqgphk2jCnLyUUIM6lWuulL4taY2qTrE5Mk8
         Zj3i43IP5BViYKdJKTcFnj/IoAgM3PVJHfK9NeG2lVpPnlD/p268vONM7cYpk6TkAG
         eFj/Hgfk9oKpw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Yrts+6UX c=1 sm=1 tr=0 ts=6185a5b3
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=w3CZLQ03aI_gyvOlcIcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <6acb22bc-a90c-b8b6-2e7d-d7e17ba595ea@ramsayjones.plus.com>
 <20211105114747.GB25887@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <676553a5-2119-45bd-007d-40bb0802a263@ramsayjones.plus.com>
Date:   Fri, 5 Nov 2021 21:44:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105114747.GB25887@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM8xM/avEw6oGhLuTVFLtkoFO5CILrhH5ga9IoZO94WN2CAnZy8u9NbkD4e0KCPmkfv/xwbWI7c1CxQsP8Em6ipYkn1wVnejxahy/Jnszd4e63SAbThY
 cEd1G98e7ACVDV64sibVGwLOxR5JhnIZLQYe/ZgYf2vG+FJOxxOwg7BpcdVpkrMZalulY56bPx5VoKp5ShVQCeP3aih9eJfHjeE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/11/2021 11:47, Adam Dinwoodie wrote:
> On Thursday 04 November 2021 at 08:09 pm +0000, Ramsay Jones wrote:
>> Hi Adam,
>>
>> On 04/11/2021 19:25, Adam Dinwoodie wrote:
>>> SSH keys are expected to be created with very restrictive permissions,
>>> and SSH commands will fail if the permissions are not appropriate.  When
>>> creating a directory for SSH keys in test scripts, attempt to clear any
>>> ACLs that might otherwise cause the private key to inherit less
>>> restrictive permissions than it requires.
>>
>> I was somewhat surprised to see your report, since all these tests
>> passed without issue for me on '-rc0'! :D (64-bit cygwin only).
>>
>> So, the difference seems to be down to FS ACLs, Hmmm ...
>>
>> (BTW, I am on windows 10 21H1)

Just FYI, tests t4202, t5534 and t6200 all pass for me without issue
on both of the -rc0 and -rc1 builds.

> I'm running these tests in subdirectories in the temporary drive on
> Dv4-size Windows 11 Pro Gen2 Azure VMs.  I'm spinning up fresh VMs and
> using new Cygwin installations regularly, in the name of build
> reproducibility; I'm vaguely working on automating more and more of the
> Cygwin Git test and release processes.
> 
> (At some point now they're becoming available, I'll probably shift to
> Ddv5 Azure VMs for this work; I very much doubt that'll make a
> difference, but I note it for the sake of completeness.  Longer-term,
> I'm hoping to swap to using GitHub Actions to do most of the heavy
> lifting.)
> 
> This isn't the first time I've seen similar problems in this environment
> that haven't been spotted elsewhere: see a1e03535db (t4129: fix
> setfacl-related permissions failure, 2020-12-23).
> 
> The `getfacl` output for the temporary drive, from Cygwin's perspective,
> is as below; I'm `cd`ing into that directory and getting the Git
> repositories by running `git clone https://github.com/git/git` from
> there.

Heh, yeah, given the setup above, I'm not exactly shocked that you
are running into permission problems ... ;-)

> ```
> # file: /cygdrive/d
> # owner: NETWORK SERVICE
> # group: NETWORK SERVICE
> user::r-x
> group::r-x
> group:SYSTEM:rwx        #effective:r-x
> group:Administrators:rwx        #effective:r-x
> group:Users:r-x
> mask::r-x
> other::r-x
> default:user::rwx
> default:group::---
> default:group:SYSTEM:rwx
> default:group:Administrators:rwx
> default:group:Users:rwx
> default:mask::rwx
> default:other::r-x
> ```

I have been using cygwin since the 'beta-8' days (windows NT 3.51, so about
1997 or so) and have run into several permission problems over the years.
So, in order to finesse these issues, I find it best to keep it simple.
I do not move outside of my cygwin installation (at C:\cygwin64), which
even includes my home directory and all git repos.

So, for me:
  
  $ echo $HOME
  /home/ramsay
  $ cygpath -w /home/ramsay
  C:\cygwin64\home\ramsay
  $ 
  
  $ getfacl /cygdrive/c/cygwin64
  # file: /cygdrive/c/cygwin64
  # owner: ramsay
  # group: None
  user::rwx
  group::r-x
  other::r-x
  default:user::rwx
  default:group::r-x
  default:other::r-x
  
  $ id
  uid=1001(ramsay) gid=513(None) groups=513(None),545(Users),4(INTERACTIVE),66049(CONSOLE LOGON),11(Authenticated Users),15(This Organization),113(Local account),4095(CurrentSession),66048(LOCAL),262154(NTLM Authentication),401408(Medium Mandatory Level)
  $

> I'm honestly not sure what it is that means I keep hitting these
> problems with this setup.  I've managed to avoid needing anything but
> the most cursory knowledge of extended permissions handling,
> particularly for Cygwin where one has to contend with both the
> underlying OS's interpretation of file permissions and with the Cygwin
> layer's reinterpretations.  I can't say I'm keen to get a deep working
> knowledge of how all these pieces interact!

I'm definitely no expert, but even with my current setup, I have had
permission problems. I used to 'ssh' into cygwin from Linux so that
I could build/test git on Linux/cygwin at the same time - that worked
fine for many many years, until a test was added that failed when I
was remotely logged-in to cygwin, but passed when I was actually directly
logged-in on the windows laptop. I don't remember the details, but ever
since I have been having to run the tests locally.

[When remotely logged in:

  $ id
  uid=1001(ramsay) gid=513(None) groups=513(None),114(Local account and member of Administrators group),0(root),545(Users),2(NETWORK),11(Authenticated Users),15(This Organization),113(Local account),4095(CurrentSession),262154(NTLM Authentication),405504(High Mandatory Level)
  $ 

Yes, I am still using the 'privileged user' account for the 'sshd' service.
I suppose I should re-configure it to use the LOCAL ACCOUNT and test again,
but, well, if it ain't broke ... ;-)
]

ATB,
Ramsay Jones

