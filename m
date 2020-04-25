Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824FC55186
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C542071E
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDYLiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:38:00 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63527 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYLiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 07:38:00 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSJ89-0004z5-7Z; Sat, 25 Apr 2020 12:37:57 +0100
From:   Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 6/8] cmake: support for building git on windows with mingw
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <d6c630028bf43ea74ef1ac3b60d49aea252b3f4b.1587700897.git.gitgitgadget@gmail.com>
 <3fd87ba7-654c-ff5e-2951-7bbbe3c5d119@iee.email>
 <CAKiG+9V9N5zV=dxZwVmAaEFYQbswnSNLVqKMx5ti=zaPatZdkg@mail.gmail.com>
Message-ID: <cb5f658b-f63d-1a67-fd10-be7762930612@iee.email>
Date:   Sat, 25 Apr 2020 12:37:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKiG+9V9N5zV=dxZwVmAaEFYQbswnSNLVqKMx5ti=zaPatZdkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 24/04/2020 21:29, Sibi Siddharthan wrote:
> Hi Philip,
>
> On Fri, Apr 24, 2020 at 11:09 PM Philip Oakley <philipoakley@iee.email> wrote:
>> Hi Sibi,
>>
>> On 24/04/2020 05:01, Sibi Siddharthan via GitGitGadget wrote:
>>> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>>>
>>> This patch facilitates building git on Windows with CMake using MinGW
>>>
>>> NOTE: The funtions unsetenv and hstrerror are not checked in Windows
>>> builds.
>>> Reasons
>>> NO_UNSETENV is not compatible with Windows builds.
>>> lines 262-264 compat/mingw.h
>>>
>>> compat/mingw.h(line 25) provides a definition of hstrerror which
>>> conflicts with the definition provided in
>>> git-compat-util.h(lines 733-736).
>>>
>>> To use CMake on Windows with MinGW do this:
>>> cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
>>>
>>> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>>> ---
>>>  CMakeLists.txt | 120 +++++++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 97 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/CMakeLists.txt b/CMakeLists.txt
>>> index 29a23eb11f7..d9eb1060390 100644
>>> [snip..]
>>>  find_program(SH_EXE sh)
>>> +if(NOT SH_EXE)
>>> +     message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
>> Either the error message or the web page it points to need to coordinate
>> on the 'sh interpreter' reference to help the script kiddies follow the
>> thread. At the moment there is no 'interp..' on the gitforwindows web
>> page. Would someone attempting to use cmake need to use the Download or
>> the Contribute buttons, or some other route to acquire the missing SH_EXE?
>>
> On Windows, if you are using Git Bash, then you don't have a problem.
> This message was for people trying to Git on Windows without a bash shell.
>
> I can rephrase the message saying
> "On Windows go to https://gitforwindows.org/ and download the Git
> installer which ships with a sh interpreter(bash)."
>
> Would you suggest something else?

Filling the message out a little, I'm thinking of:

"sh: shell interpreter was not found in your path, please install one.
On Windows, you can get it as part of 'Git for Windows' install at
https://gitforwindows.org/"

The second 'install' could be dropped, but may be needed to fully
qualify the instructions for some readers.

The key feature I was checking was the clarity of the 'install' action,
as opposed to the way sh is integrated within Git for Windows (which is
a whole new topic of conversation for some users!)
>
>> (this is also a context line in the next patch)
>>
[snip..]

--
Philip
