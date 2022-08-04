Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1201C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiHDSXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDSXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 14:23:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4D6C11C
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 11:23:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c3so238556qko.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2TGUv32RDY+E2zf623OYgsqyXNawsIRyK7sDjI0jII0=;
        b=pT3tlAYRoKt2hirZwzijeJyrlCY3VuxR93c71dNzWmon9s1KmQoYdRWGixD1iG79UF
         mnwTZYs1AS6w56PWO0jCJZQgtJjDu1U1XUpMoO8pHgajdKt9v/9QTNJm8WQ1Emz017KY
         fgsl0uRPywIXS5Ly9j0KWBr0LhIlfEh0IjnZyETJ7UIJy9mTEiwXXV+4++YyWta7sHLR
         1a5sTy9rgzItHBT4AWYfLAq4LSc8rz7h0toNKXu0E7AG9WdhrC4mIxMjTI7J+iStCclN
         vDfFvZxI7hxw4F+MPXKI1Nd+Nxb7utjEQSmhQhe4WSyr+oxV6oZtSFIzGiR0NXMHvvub
         1n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2TGUv32RDY+E2zf623OYgsqyXNawsIRyK7sDjI0jII0=;
        b=rQwU/FwAkdy3SHQQ2TMhsblwj/wEBq3c/JOQV9OI32rswXn423E0ImK2qwYU8P6jEp
         Q9luo/yipcgXLNlKLuYwRX+EigAId12CUz8gcYlwP8lU8HFLNSTXjHcvZL1UFJdGF4z0
         kD16JTALcK/4KlJure8RWTPb1pbn3x987zrYQfch4SuEl66jnU/pNCNE07H7VFzDdhD2
         ZE5rQ0FT9mZcy9nuhant96ACM3entUTrK1rIJ2hU1pyGYeW3Du3f+qX2JlHkkprMq80y
         p2n+967fRRXBASz869LrAZQOwj+agen6SrOEEXHmx4qwbCfULdWHoEvfa8OH7hcI8X7P
         RJ9g==
X-Gm-Message-State: ACgBeo1HwwvCN+klU3Mg+/fD9PbKcpE8Jf56SRsx8chVshoP1UktFnpp
        KMA/xT5vWfuUIKlEgVofV66RLtKSyRIK7g==
X-Google-Smtp-Source: AA6agR5KBECAqBSgaEEKqFF4q1nxls4CbB3GhAVyeXCGBBX0CPTPanZUspt+gRHsEN7yGPRZkPbMhQ==
X-Received: by 2002:a05:620a:284c:b0:6b8:6e70:cd95 with SMTP id h12-20020a05620a284c00b006b86e70cd95mr2350346qkp.247.1659637386561;
        Thu, 04 Aug 2022 11:23:06 -0700 (PDT)
Received: from [10.0.0.4] (ool-ae2c7b78.dyn.optonline.net. [174.44.123.120])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006a65c58db99sm1200504qko.64.2022.08.04.11.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 11:23:06 -0700 (PDT)
Message-ID: <ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com>
Date:   Thu, 4 Aug 2022 14:21:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: Bugreport: pack-objects died of signal 11
To:     Jeff King <peff@peff.net>, Paul Horn <git@knutwalker.engineer>
Cc:     git@vger.kernel.org
References: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
 <YtCMklbIoTAN/WRs@coredump.intra.peff.net>
Content-Language: en-US
From:   Emily Noneman <emily.noneman@gmail.com>
In-Reply-To: <YtCMklbIoTAN/WRs@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am seeing a similar issue with git on macos. git repack fails with 
signal 11. Other git commands seem to be working fine. My version info:
[System Info]
git version:
git version 2.37.1.311.g350dc9f0e8
cpu: x86_64
built from commit: 350dc9f0e8974b6fcbdeb3808186c5a79c3e7386
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:22 
PDT 2022; root:xnu-8020.121.3~4/RELEASE_X86_64 x86_64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


The stack trace:
Thread 2 received signal SIGSEGV, Segmentation fault.
git_config_check_init (repo=0x0) at config.c:2538
2538        if (repo->config && repo->config->hash_initialized)
(gdb) bt
#0  git_config_check_init (repo=0x0) at config.c:2538
#1  0x00000001001197a8 in repo_config_get_string (repo=0x0, 
key=0x1002a3c49 "status.showuntrackedfiles", dest=0x0, 
dest@entry=0x7ff7bfefc1f0) at config.c:2574
#2  0x000000010014a85b in new_untracked_cache_flags (istate=0x0) at 
dir.c:2781
#3  new_untracked_cache (istate=0x0, flags=-1) at dir.c:2797
#4  0x00000001001d68f1 in tweak_untracked_cache (istate=0x7ff7bfefc7e0) 
at read-cache.c:1996
#5  post_read_index_from (istate=0x7ff7bfefc7e0, 
istate@entry=0x600003b02920) at read-cache.c:2028
#6  0x00000001001d6599 in read_index_from (istate=0x600003b02920, 
istate@entry=0x0, path=path@entry=0xffffffff <error: Cannot access 
memory at address 0xffffffff>,
     gitdir=0x600002c08080 
"/Users/emily.noneman/workspace/webdev/.NetLedger_LocalBranchData.git") 
at read-cache.c:2457
#7  0x00000001001fcb2d in add_index_objects_to_pending 
(revs=0x600003b02920, revs@entry=0x7ff7bfefe9a0, flags=flags@entry=0) at 
revision.c:1783
#8  0x00000001002001e4 in handle_revision_pseudo_opt 
(revs=0x7ff7bfefe9a0, argv=0x600003700020, flags=<optimized out>) at 
revision.c:2717
#9  setup_revisions (argc=61876512, argv=0x600003700000, revs=<optimized 
out>, revs@entry=0x1002a3c49, opt=<optimized out>, 
opt@entry=0x7ff7bfefca50) at revision.c:2806
#10 0x0000000100084092 in get_object_list (revs=0x1002a3c49, 
revs@entry=0x0, ac=0, av=0x1002a3c49) at builtin/pack-objects.c:3993
#11 0x0000000100080a07 in cmd_pack_objects (argc=<optimized out>, 
argv=<optimized out>, prefix=<optimized out>) at builtin/pack-objects.c:4466
#12 0x0000000100005313 in run_builtin (p=0x600003b02920, 
p@entry=0xffffffff, argc=11, argc@entry=0, argv=<optimized out>, 
argv@entry=0x1002a3c49) at git.c:466
#13 0x0000000100004566 in handle_builtin (argc=0, argv=0x1002a3c49) at 
git.c:720
#14 0x0000000100003b59 in run_argv (argcp=0x7ff7bfeff7a4, 
argv=0x7ff7bfeff798) at git.c:787
#15 cmd_main (argc=11, argc@entry=0, argv=0x7ff7bfeff968, 
argv@entry=0x1002a3c49) at git.c:920
#16 0x00000001000d49a5 in main (argc=0, argv=0x1002a3c49) at 
common-main.c:56

On 7/14/22 5:37 PM, Jeff King wrote:
> On Tue, Jul 12, 2022 at 10:51:29AM +0200, Paul Horn wrote:
>
>> ultimately, `git repack` segfaults:
>>
>>      $ git repack
>>      error: pack-objects died of signal 11
> Can you provide a backtrace that shows where we segfaulted?  If you can
> build Git from source and have access to a debugger like gdb, that
> should be enough.
>
> One option is to make sure core dumps are enabled (probably "ulimit -c
> unlimited"), then run the failing repack, then find the core file
> (usually in the current directory, but I'm not sure offhand about
> macOS), and then open the debugger on it ("gdb /path/to/your/git
> /path/to/core").
>
> But perhaps easier may be to directly run the buggy pack-objects
> invocation. I pulled the options here from your trace file. Something
> like:
>
>    gdb -ex 'set args pack-objects \
>        --delta-base-offset tmp-pack \
>        --keep-true-parents --honor-pack-keep --non-empty \
>        --all --reflog --indexed-objects --unpacked --incremental \
>        </dev/null' \
>      /path/to/your/git
>
> Then "r" to run inside the debugger, which will stop if we segfault. And
> then "bt" will show the backtrace.
>
> Alternatively, is it possible to make the offending repository available
> (even off-list)?
>
> -Peff
>
>
