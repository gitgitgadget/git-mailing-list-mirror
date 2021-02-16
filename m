Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA0C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A27D64D99
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBPTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:00:50 -0500
Received: from siwi.pair.com ([209.68.5.199]:59789 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhBPTAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:00:48 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 36FB73F4131;
        Tue, 16 Feb 2021 14:00:07 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC5063F413B;
        Tue, 16 Feb 2021 14:00:06 -0500 (EST)
Subject: Re: [PATCH v2 00/11] FSMonitor Preliminary Commits
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
 <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <42714a3b-cccc-d61b-1dc1-5f2f8fcaa0dd@jeffhostetler.com>
Date:   Tue, 16 Feb 2021 14:00:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/21 10:34 AM, Jeff Hostetler via GitGitGadget wrote:
> Here is version 2 of this series.

I didn't see this series in the "what's cooking" emails and
was wondering if there was something that I still needed to
attend to.

Thanks
Jeff


> 
> In version 1, I replaced the non-portable "xargs -d" with "xargs -0", but it
> turns out that that too is not universally available. In this version I
> replace the need for either one by filtering out the problematic paths (such
> as ones with LFs) and quoting paths to handle whitespace. The resulting
> paths can be passed to xargs without any arguments.
> 
> Also, I updated the test to use test-tool chmtime rather than touch to
> ensure that the files actually look dirty on low-resolution file systems.
> 
> Jeff Hostetler (10):
>    p7519: do not rely on "xargs -d" in test
>    p7519: fix watchman watch-list test on Windows
>    p7519: move watchman cleanup earlier in the test
>    p7519: add trace logging during perf test
>    preload-index: log the number of lstat calls to trace2
>    read-cache: log the number of lstat calls to trace2
>    read-cache: log the number of scanned files to trace2
>    fsmonitor: log invocation of FSMonitor hook to trace2
>    fsmonitor: log FSMN token when reading and writing the index
>    fsmonitor: refactor initialization of fsmonitor_last_update token
> 
> Kevin Willford (1):
>    fsmonitor: allow all entries for a folder to be invalidated
> 
>   fsmonitor.c               | 107 ++++++++++++++++++++++++++++++++++----
>   fsmonitor.h               |   5 ++
>   preload-index.c           |  10 ++++
>   read-cache.c              |  24 +++++++--
>   t/perf/.gitignore         |   1 +
>   t/perf/Makefile           |   4 +-
>   t/perf/p7519-fsmonitor.sh |  71 +++++++++++++++++++++----
>   7 files changed, 196 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-860%2Fjeffhostetler%2Ffsmonitor-prework-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-860/jeffhostetler/fsmonitor-prework-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/860
> 
> Range-diff vs v1:
> 
>    1:  cf252e24b8c !  1:  e570f7316cc p7519: use xargs -0 rather than -d in test
>       @@ Metadata
>        Author: Jeff Hostetler <jeffhost@microsoft.com>
>        
>         ## Commit message ##
>       -    p7519: use xargs -0 rather than -d in test
>       +    p7519: do not rely on "xargs -d" in test
>        
>       -    The Mac version of xargs does not support the "-d" option.  Convert the test
>       -    setup to pipe the data set thru `lf_to_nul | xargs -0` instead.
>       +    Convert the test to use a more portable method to update the mtime on a
>       +    large number of files under version control.
>       +
>       +    The Mac version of xargs does not support the "-d" option.
>       +    Likewise, the "-0" and "--null" options are not portable.
>       +
>       +    Furthermore, use `test-tool chmtime` rather than `touch` to update the
>       +    mtime to ensure that it is actually updated (especially on file systems
>       +    with only whole second resolution).
>        
>            Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>        
>         ## t/perf/p7519-fsmonitor.sh ##
>        @@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
>       + 		git status -uall
>         	'
>         
>       ++	# Update the mtimes on upto 100k files to make status think
>       ++	# that they are dirty.  For simplicity, omit any files with
>       ++	# LFs (i.e. anything that ls-files thinks it needs to dquote).
>       ++	# Then fully backslash-quote the paths to capture any
>       ++	# whitespace so that they pass thru xargs properly.
>       ++	#
>         	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>        -		git ls-files | head -100000 | xargs -d "\n" touch -h &&
>       -+		git ls-files | head -100000 | lf_to_nul | xargs -0 touch -h &&
>       ++		git ls-files | \
>       ++			head -100000 | \
>       ++			grep -v \" | \
>       ++			sed '\''s/\(.\)/\\\1/g'\'' | \
>       ++			xargs test-tool chmtime -300 &&
>         		git status
>         	'
>         
>    2:  a641f9e357c =  2:  3042fc92fe6 p7519: fix watchman watch-list test on Windows
>    3:  2af6858716f =  3:  9ceba5e6942 p7519: move watchman cleanup earlier in the test
>    4:  8de9985a706 =  4:  f6ea0a51f50 p7519: add trace logging during perf test
>    5:  cdd49f1fdb1 =  5:  3c5035e4649 preload-index: log the number of lstat calls to trace2
>    6:  65488f7a1bf =  6:  d150a2d4576 read-cache: log the number of lstat calls to trace2
>    7:  c84531f6244 =  7:  33cc0b838fa read-cache: log the number of scanned files to trace2
>    8:  ef64b60c7a0 =  8:  c043bccc8af fsmonitor: log invocation of FSMonitor hook to trace2
>    9:  edb88ffe39e =  9:  6ec4a4468f6 fsmonitor: log FSMN token when reading and writing the index
>   10:  384d2eff863 = 10:  2ac66f07a59 fsmonitor: allow all entries for a folder to be invalidated
>   11:  4686196bbc6 = 11:  5410d3ab61d fsmonitor: refactor initialization of fsmonitor_last_update token
> 
