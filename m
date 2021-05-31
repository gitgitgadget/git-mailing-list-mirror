Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60815C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED26610FC
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhEaRQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:16:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:39123 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhEaROI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:14:08 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lnlSf-0003DL-Cl; Mon, 31 May 2021 18:12:22 +0100
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
 <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
 <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
 <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
 <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
 <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
 <e33bd72f-2095-f32d-5f4f-6137f6a12d22@iee.email>
 <580d858d-dcd3-9d62-ec97-2daa9d9e0f45@iee.email>
 <CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ead4ff2a-dfc0-ef8c-e2c5-477197ddded6@iee.email>
Date:   Mon, 31 May 2021 18:12:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2021 01:01, Matt Rogers wrote:

Thanks for the reply. Just hoping we aren't talking at cross purposes
here, filling out details where I can...
>>> My other consideration is that the build process should generate enough
>>> of the right artefacts (e.g. a .sln etc). This is so that other typical
>>> tools and extensions e.g. Sourcetrail which expects the .sln, but maybe
>>> they'll also cope with Ninja/Cmake builds soon...
>>>
> Something to keep in mind is that the generator is what decides what artifacts
> get produced.  

However, Visual Studio default install makes that decision for you (any
such user), and has changed that default in the last couple of years
(from Visual Studio generator to Ninja generator).

> As a consumer of the CMakeLists.txt it's on you to tell
> CMake what
> your tool needs

Here (this discussion), there are two different 'tools' being considered.
1) the Git for Windows build instructions for those hoping to build &
browse the code (using VS).
2) my hope that I can add Sourcetrail to that browse capability.

It's (1) that has broken at some point 'recently'.
(Our build detected MSVC as an indicator of being on Visual Studio, etc.
There is now no indicator for CMake, of being on Visual Studio, that
works across all releases)

I'm trying to un-break (1), and hopefully enable (2) while at it.

> , i.e. if it needs a compile_commands.json to run clang-tidy or a
> .sln file or a ninja.build that would be on the user to generate.  I
> think that's
> acceptable, if there are common tools in use that require a more
> complicated cmake
> invocation to get that generation, then it might pay to define a preset in our
> CMakePresets.json 

Noting: CMakePresets.json files are supported in Visual Studio 2019
version 16.10 or later. [1]

I'm not sure when Ninja became the default generator in Visual Studio
(esp. Community Ed).
A quick search didn't locate that info. I'm expecting there to be a gap
between the Ninja change and the CmakePresets support, that will need
documenting/advising for users hoping to browse the GfW code, so they
can ensure they have a recent enough version 'out of the box'.

> so that users can get those artifacts with a straightforward
> invocation like:
>
> cd contrib/buildsystems
> mkdir build
> cd build
> cmake --preset sourcetrail ..
>
> which I would still consider pretty "batteries included".

I'm targetting the user who will start from Visual Studio defaults and
open the git folder, rather than be in a terminal, so perhaps a bit of
divergence of approach here.

>
> I do think however is that there are a few problems you're
> encountering in this case:
>
> 1. Visual Studio build breaks because we don't install vcpkg here when we should

True

> 2. Visual Studio is no longer creating the .sln files, which some of
> your external tools
> were relying on.

It would/has but it's catch22 -- I had already installed the vcpkg files
in the past so that step didn't need to happen. I also, I think maybe
had an old VS version (it gets confused here), I tried various things,,
during which the (hidden folder) .vs/git.sln file was generated (Yay).

From then on I could use Sourcetrails integration extension, but I
wanted to go back and re-verify that a basic user could build, from
scratch, GfW as per instructions. So I unistalled Visual Studio and
CMake I's also installed, re-installed just 'Microsoft Visual Studio
Community 2019 Version 16.9.4' and tried the File->Open->Git directory
step, wherein CMakeLists.txt is detected, and run, and fails... sigh.
Starts digging holes.

>
> I think that the solution to 1. would be to add a knob for vcpkg
> installation, and either
> have that knob "on" by default and/or provide a configuration in a
> CMakePresets.json
> that Visual Studio (and other IDE's/tools) could use to build.

Knobs are difficult..

I'd agree, with the extra point that the instructions need to tell users
to inspect their VS version (>=16.10), and either, maybe fiddle with the
GfW CMakeLists.txt to switch generators to VS/MSVC (relative to the main
Git Cmake), or instruct users to run/rerun the build with additional
options (though more potential for finger trouble errors).

>
> I think the problem with 2. is that CMake is a build file generator
> rather than an actual
> build system itself, so it needs a user to tell it what kind of files
> that their tools expect.

True, and it can't ask for user input.

> And I don't think there's any way to make it guess what kind of files the
> user expects cmake to generate.  Depending on the complexity of the
> configuration
> it may be worth providing a CMakePresets.json file to make it easier to use, but
> I guess it would depend on what exactly you need it to do.

True.
Philip
>
[1]
https://docs.microsoft.com/en-us/cpp/build/cmake-presets-vs?view=msvc-160
