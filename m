Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3541C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeAXThA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:37:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:40613 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeAXTg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:36:59 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5917784516;
        Wed, 24 Jan 2018 14:36:59 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 27A8684515;
        Wed, 24 Jan 2018 14:36:59 -0500 (EST)
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <20180123001648.24260-1-isaachier@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
Date:   Wed, 24 Jan 2018 14:36:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180123001648.24260-1-isaachier@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/22/2018 7:16 PM, Isaac Hier wrote:
> This patch adds a mostly complete (aside from building tests, documentation,
> installation, etc.) CMake build to the git project. I am not sure how much
> interest there is in a CMake build, so please send me feedback one way or
> another. Personally, I believe CMake will help with Windows builds and is
> somewhat easier to read than a Makefile. I considered, adding this to the
> contrib directory, but CMakeLists.txt almost always reside in the original
> directories, and I'm not sure how wise it would be to do otherwise. If you are
> interested in a CMake build, I would be more than happy to finish up the work
> here. Decided to wait until I discussed the issue here to finish the final parts
> of the build.

On Windows, we use "bash" and "make" from the Git-for-Windows SDK installation
(which gives us a bash shell and most of the usual Unix command line tools) and
the main "Makefile".  We do need a special section in the "config.mak.uname" file
to set some platform compiler options and etc., but that is small enough.

Johannes and I recently added a few new options to let Windows build Git from
the command line with either GCC or MSVC and to synthesize MSVS solution (.sln)
and project (.vcxproj) files to allow you to work with the full MSVS IDE and
full intellisense.  And if necessary download and build third-party libraries
not normally present on a Windows machine.  Most of this work is Windows specific
and may not yet be upstream.   See GfW [1] and VCPKG [2].

The synthesized solution and project files are automatically generated, so we
do not have to separately track changes in the Makefile to the various file lists.
These should be treated as read-only and re-generated in response to changes in
the Makefile.  Using the solution/project files, we can completely build Git in
the IDE or a command prompt and without the SDK.  This further simplifies things
for Windows developers.

So given that, I don't see a need to replace the main Makefile on Windows.

Sorry,
Jeff

[1] https://github.com/git-for-windows/git
[2] https://github.com/Microsoft/vcpkg
