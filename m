Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA6C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0C26128D
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhGMPOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:14:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:48269 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236978AbhGMPOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 11:14:06 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m3K42-0006xU-8q; Tue, 13 Jul 2021 16:11:15 +0100
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
 <87bl7i8ou8.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <32d1ae55-669a-c71f-95f9-345fcd42eb87@iee.email>
Date:   Tue, 13 Jul 2021 16:11:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2021 13:19, Johannes Schindelin wrote:
> Hi Ævar,
>
> On Sun, 4 Jul 2021, Ævar Arnfjörð Bjarmason wrote:
>
>> On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:
>>
>>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>>> index 0f7516c9ef..3b40c677ab 100644
>>> --- a/.github/workflows/main.yml
>>> +++ b/.github/workflows/main.yml
>>> @@ -159,7 +159,7 @@ jobs:
>>>        shell: bash
>>>        run: |
>>>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
>>> -        -DMSGFMT_EXE=C:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
>>> +        -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
>>>      - name: MSBuild
>>>        run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
>>>      - name: bundle artifact tar
>> To a first approximation isn't the point of CI to test a diversity of
>> setups?
> No, the point of CI is to find breakages.
>
> And in this instance, a careful analysis will reveal that the artifacts
> generated via `msgfmt` are not even used, let alone tested.
>
> Even more careful analysis will reveal that Git for Windows does not ship
> with translations. Therefore, it would be pointless to test the
> translations here. Doubly so because Git for Windows is not even built
> using MSVC, and this `vs-build` job is really about verifying that we can
> build with that compiler, and _iff_ we used `msgfmt` here, it would not be
> Visual Studio's (because it doesn't have any `msgfmt`) but the regular one
> from Git for Windows' SDK. Triply so because the regular one from Git for
> Windows' SDK _is actually used_ in the `windows-build` job, therefore we
> _really_ do not need to repeat the same exercise with the same gettext
> version and the same git/git revision in the same GitHub workflow run.
>
> In short: there is no diversity to be gained here. (Actually, that is not
> quite true: by using gentler language on a first-time contributor instead
> of immediately going into full critic mode without any fanfare, we could
> have invited more diversity onto this list. Maybe you could pay more
> attention to that in the future?)
>
> Back to the issue you pointed out: could this be described in the commit
> message? Sure. But I think there is no much worth in it, the surrounding
> code and parent commit makes it clear that the `.mo` files aren't used,
> and that it would therefore be a waste of electrons to generate them in
> each and every `vs-build` run.
>
> Ciao,
> Johannes
Folks,

This problem (vcpkg/VS/CI build breakage for the tar artifact) has also
just come up for me on
https://github.com/git-for-windows/git/pull/3306#issuecomment-879093798
"[RFC] making Git for Windows start buildins in modern Visual Studio
#3306" which is a similar build situation.

Hopefully we can chose a suitable solution regarding what, if any, extra
checks this part of the CI build ought to do with the (unused in this
build) `.mo` files.

--
Philip

