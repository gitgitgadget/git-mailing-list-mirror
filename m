Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F4C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A781020715
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0S7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:59:11 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:32132 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0S7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:59:11 -0500
Received: from [84.175.189.198] (helo=[192.168.2.6])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ia2Wo-0006bj-Lh; Wed, 27 Nov 2019 19:59:06 +0100
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
To:     Philip Oakley <philipoakley@iee.email>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.348.git.gitgitgadget@gmail.com>
 <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
 <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <8e7ff0b2-9f62-8ec6-5316-eb9cee25024e@syntevo.com>
Date:   Wed, 27 Nov 2019 19:59:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.11.2019 18:56, Philip Oakley wrote:
> I just bumped against a potential issue like this. I was test compiling 
> [1a,b] the `vs/master` branch from Git-For-Windows and got the LINK 
> error that the 'libcurl-d.lib' was not found (4 places).
> 
> Error    LNK1104    cannot open file 'libcurl-d.lib' git-imap-send 
> C:\git-sdk-64\usr\src\git\git-imap-send\ LINK    1
> 
> Having just located this email, I changed the build type to 'Release' 
> and the errors disappeared.
> 
> Do we also need to identify where the libcurl-d.lib will be found? i.e. 
> is it something that needs including via the sdk pacman list (I think 
> I'm up to date but maybe not..)
> 
> A quick web search didn't show any hits for `libcurl-d.lib` (with the 
> dash `-`), though did find a few for `libcurld.lib`.

If you clone `git-for-windows` and build in VS using `git.sln`, it will 
automatically clone `git-for-windows\compat\vcbuild\vcpkg` and build 
various things there, resulting in

`git-for-windows\compat\vcbuild\vcpkg\buildtrees\curl\x64-windows-dbg\lib\libcurl-d.dll`

`git-for-windows\compat\vcbuild\vcpkg\installed\x64-windows\debug\bin\libcurl-d.dll`

`git-for-windows\compat\vcbuild\vcpkg\packages\curl_x64-windows\debug\bin\libcurl-d.dll`

Which will be picked up by solution to build git.

I have built Debug many times now and didn't have any issues. If you do, 
I would suggest to clone a new copy and build it.
