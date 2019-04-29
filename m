Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418371F462
	for <e@80x24.org>; Mon, 29 Apr 2019 20:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfD2UWC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:22:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:23792 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2UWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:22:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 308673F4928;
        Mon, 29 Apr 2019 16:22:01 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6436:1a0f:5a09:117b] (unknown [IPv6:2001:4898:8010:0:4d6c:1a0f:5a09:117b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B19E23F48E9;
        Mon, 29 Apr 2019 16:22:00 -0400 (EDT)
Subject: Re: [PATCH v5 00/11] trace2: load trace2 settings from system config
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com
References: <pull.169.v4.git.gitgitgadget@gmail.com>
 <pull.169.v5.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <da481a55-a363-9eb9-6cde-59468f18947d@jeffhostetler.com>
Date:   Mon, 29 Apr 2019 16:21:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I forgot to update the cover letter for V5.
V5 adds a commit to fix the permission problem in /etc/gitconfig
reported by SZEDER.

This commit could/should be squashed into commit 5 if wanted.
I left it on top for review purposes.

Jeff


On 4/29/2019 4:14 PM, Jeff Hostetler via GitGitGadget wrote:
> Version 4 fixes a few clang-format warnings and simplifies the PID field in
> the SID.
> 
> Jeff Hostetler (11):
>    config: initialize opts structure in repo_read_config()
>    trace2: refactor setting process starting time
>    trace2: add absolute elapsed time to start event
>    trace2: find exec-dir before trace2 initialization
>    config: add read_very_early_config()
>    trace2: use system/global config for default trace2 settings
>    trace2: report peak memory usage of the process
>    trace2: clarify UTC datetime formatting
>    trace2: make SIDs more unique
>    trace2: update docs to describe system/global config settings
>    trace2: fixup access problem on /etc/gitconfig in
>      read_very_early_config
> 
>   Documentation/config.txt                 |   2 +
>   Documentation/config/trace2.txt          |  56 ++++++++
>   Documentation/technical/api-trace2.txt   | 176 +++++++++++++----------
>   Documentation/trace2-target-values.txt   |  10 ++
>   Makefile                                 |   1 +
>   common-main.c                            |   8 +-
>   compat/mingw.c                           |   2 +
>   compat/win32/trace2_win32_process_info.c |  50 ++++++-
>   config.c                                 |  30 +++-
>   config.h                                 |   5 +
>   t/t0210-trace2-normal.sh                 |  49 ++++++-
>   t/t0211-trace2-perf.sh                   |  43 ++++--
>   t/t0212-trace2-event.sh                  |  42 +++++-
>   trace2.c                                 |  21 ++-
>   trace2.h                                 |  43 ++++--
>   trace2/tr2_cfg.c                         |   7 +-
>   trace2/tr2_dst.c                         |  26 ++--
>   trace2/tr2_dst.h                         |   3 +-
>   trace2/tr2_sid.c                         |  53 ++++++-
>   trace2/tr2_sysenv.c                      | 127 ++++++++++++++++
>   trace2/tr2_sysenv.h                      |  36 +++++
>   trace2/tr2_tbuf.c                        |  19 ++-
>   trace2/tr2_tbuf.h                        |   5 +-
>   trace2/tr2_tgt.h                         |   1 +
>   trace2/tr2_tgt_event.c                   |  53 +++----
>   trace2/tr2_tgt_normal.c                  |  19 +--
>   trace2/tr2_tgt_perf.c                    |  23 +--
>   trace2/tr2_tls.c                         |  38 +++--
>   trace2/tr2_tls.h                         |   8 +-
>   29 files changed, 752 insertions(+), 204 deletions(-)
>   create mode 100644 Documentation/config/trace2.txt
>   create mode 100644 Documentation/trace2-target-values.txt
>   create mode 100644 trace2/tr2_sysenv.c
>   create mode 100644 trace2/tr2_sysenv.h
> 
> 
> base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/169
> 
> Range-diff vs v4:
> 
>    1:  f6653f1c59 =  1:  f6653f1c59 config: initialize opts structure in repo_read_config()
>    2:  48e34834b6 =  2:  48e34834b6 trace2: refactor setting process starting time
>    3:  175371fb54 =  3:  175371fb54 trace2: add absolute elapsed time to start event
>    4:  94729b284c =  4:  94729b284c trace2: find exec-dir before trace2 initialization
>    5:  b0fe1385f1 =  5:  b0fe1385f1 config: add read_very_early_config()
>    6:  550cad6189 =  6:  550cad6189 trace2: use system/global config for default trace2 settings
>    7:  56d8ce3fd6 =  7:  56d8ce3fd6 trace2: report peak memory usage of the process
>    8:  196a9d2c85 =  8:  196a9d2c85 trace2: clarify UTC datetime formatting
>    9:  9fdcb50140 =  9:  9fdcb50140 trace2: make SIDs more unique
>   10:  3414016d04 = 10:  3414016d04 trace2: update docs to describe system/global config settings
>    -:  ---------- > 11:  18ce795360 trace2: fixup access problem on /etc/gitconfig in read_very_early_config
> 
