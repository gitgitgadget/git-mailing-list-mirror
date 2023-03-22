Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5139C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 19:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVTw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 15:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVTwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 15:52:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09650991
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:52:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so77674711edc.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679514741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7uS0b6rEgVM3Qd2G3u+NVrZQAF26NOU0Vm+AUtXiTg=;
        b=L9NZKaRQ8vBA4ZDyYmtFDWtdSkx7CPcZ3Yih2vaxiwLxhun+5LjkivNQH7N+BjyttT
         jRaE/uxn9+Fwp1VmM7gpi13hqlnkic3hxfK2ZWA1EIokQZVAGsZ823zDxA5t4o9kf/Lj
         MoUBAssMgED+I0QLfRdF4vCdpHAM3LtzxrDdxzQ6XlzuzvIhPRfz34gEZLX7RcZzN3pS
         1VHnv1xwpk2KtUdhuCkrkw7R0x7DXKb5diSFxw2bsNrmJvpistettDFYzNmSxmFW2+w5
         0rcwU/wH1F7Yj/Q1aR8Dnw1/o01uxxNlsHDDrzyt7xrFpaEd/KWDr4apEGwJPXxoAkMz
         7GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7uS0b6rEgVM3Qd2G3u+NVrZQAF26NOU0Vm+AUtXiTg=;
        b=DFCqFijnewnjmxH+cylzLggVW25u61QSXwVOFluvC2b6jsjlmjZV5hSi/VPgZpcfZG
         kumzQ+f+HU5Cn9jj99RjeN1KgPTSbfcCvBaLNvB5cNISqy8FUr2T3PnX1flhlCt8mVV8
         EAWiF0wLsJafHhz/YyERk2pkQc9I1IFgyL5FwS0j6Jruu/GpyyCYtxwniFGIe/y2EsJY
         66dpssYfen9+FPAuj2/0JnfG52sAFNUA1Xr7W796gRgoWnRt2JKdsLyHvnUC6/GmauhF
         IpEvTZI3X9NjIYyHdMHdGKzDHT6EkLhmypXvIpoLBOaOAW66W/uq0MHqXNbh+wgB+Nu2
         9c9A==
X-Gm-Message-State: AO0yUKV3A2Fc2ij04cN9TBsgM4QWmxlzA0tMI4NOoIJAw3RQQzPqi7Sb
        sIOg0gnnrb1QbQSYcwXA1DWxVw==
X-Google-Smtp-Source: AK7set+P1INePwHGx4RYYvqA1eojFMw2fG2Vm2RXVwX1/SEsWKyAwQ/KN2au7GJq5lfHQ6Te7a88nA==
X-Received: by 2002:a17:906:a193:b0:878:6b39:6d2a with SMTP id s19-20020a170906a19300b008786b396d2amr8113833ejy.46.1679514741559;
        Wed, 22 Mar 2023 12:52:21 -0700 (PDT)
Received: from ?IPV6:2003:f6:af46:bf00:c0c2:695b:730f:946e? (p200300f6af46bf00c0c2695b730f946e.dip0.t-ipconnect.de. [2003:f6:af46:bf00:c0c2:695b:730f:946e])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906858f00b0093229e527cdsm7191779ejx.42.2023.03.22.12.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 12:52:21 -0700 (PDT)
Message-ID: <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
Date:   Wed, 22 Mar 2023 20:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Suspected git grep regression in git 2.40.0
Content-Language: en-US, de-DE
To:     Stephane Odul <stephane@clumio.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
 <xmqqttyejc7y.fsf@gitster.g>
 <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
 <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.03.23 21:46, Stephane Odul wrote:
> Thank you for looking into this so quickly.
> 
> I’m unable to reproduce locally reliably but I created a custom pipeline to reproduce more quickly.
> 
> Here are the things I found out.
> 
> * With the NO_JIT flag and limited to only python files (in our case we only want to grep on py files anyways):
>   - git grep -c -P '(*NO_JIT)^[[:alnum:]_]+ = json.load' -- '*.py’
>   This is snappy and works, no more error.
> 
> * Without the flag and the *.py restriction:
>   - git grep -c -P '^[^ #][^#]+sys[.]argv’
>     This did not fail but took almost 3m, big performance regression.
>   - git grep -c -P '^[[:alnum:]_]+ = json.load’
>     Crashed and returned -11. Stderr was empty so I have no idea on what file it failed.
> 
>  * With NO_JIT on all the files:
>   - git grep -c -P '(*NO_JIT)^[[:alnum:]_]+ = json.load’
>    This worked, that pattern is snappy but other patterns are very slow:
>   - git grep -c -P '(*NO_JIT)^[^ #][^#]+sys[.]argv’
>     Took 8m to complete.
> 
>  * Without the flag but only *.py.
>     - git grep -c -P '^[[:alnum:]_]+ = json.load' -- '*.py’
>      All the patterns run fast (under 1s), and no errors.
> 
> 
> Note that I was trying -E and replaced \w with [[:alnum:]_] … I’ll need to revert that, but I don’t thing \w is the issue.

Thank you for testing! But nothing of this gives a real clue. So I did
bite the bullet and set up a Ubuntu 20.04 VM, added the git PPA and
could mirror your observations of git crashing on the mentioned pattern:

  root@ubuntu-2004:~/git# git grep --threads=1 -cP '^\w+ = json.load'
  Segmentation fault (core dumped)

I changed the command slightly to run single-threaded to exclude *that*
can of worms ;) But as you can see, I could simply run the command on
the git.git tree and trigger the bug as well.

Anyhow, trying to look where git dies gave me no clue. The Ubuntu PPA,
unfortunately, lacks debug symbols, so I build my own package and ended
up with the same faulty behaviour:

  root@ubuntu-2004:~/git# gdb -q --args ~/git_pkg/git-2.40.0/git grep --threads=1 -cP '^\w+ = json.load'
  Reading symbols from /root/git_pkg/git-2.40.0/git...
  (gdb) run
  Starting program: /root/git_pkg/git-2.40.0/git grep --threads=1 -cP \^\\w+\ =\ json.load
  [Thread debugging using libthread_db enabled]

  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [Detaching after fork from child process 812657]

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7a149d3 in ?? ()
  (gdb) bt
  #0  0x00007ffff7a149d3 in ?? ()
  #1  0x0000000000000000 in ?? ()

First thing to note is that there are no symbols in the backtrace and
that it's rather short (like, where's main()?). But maybe that's just
how the JIT stack works? I don't know, maybe Carlo does?

Looking at the mappings gives (highlighting the one with the current
instruction pointer):

  (gdb) info proc mappings
  process 812654
  Mapped address spaces:

            Start Addr           End Addr       Size     Offset  Perms  objfile
        0x555555554000     0x555555572000    0x1e000        0x0  r--p   /root/git_pkg/git-2.40.0/git
        0x555555572000     0x5555558b3000   0x341000    0x1e000  r-xp   /root/git_pkg/git-2.40.0/git
        0x5555558b3000     0x5555559ae000    0xfb000   0x35f000  r--p   /root/git_pkg/git-2.40.0/git
        0x5555559af000     0x5555559b2000     0x3000   0x45a000  r--p   /root/git_pkg/git-2.40.0/git
        0x5555559b2000     0x5555559c8000    0x16000   0x45d000  rw-p   /root/git_pkg/git-2.40.0/git
        0x5555559c8000     0x555555a50000    0x88000        0x0  rw-p   [heap]
        0x7ffff7810000     0x7ffff79a0000   0x190000        0x0  rw-p

        0x7ffff7a05000     0x7ffff7a15000    0x10000        0x0  rwxp

That's where we're currently fetching instructions from. As it's a rwx
mapping (and the only one), I presume it's JIT-generated code.

        0x7ffff7a15000     0x7ffff7cfb000   0x2e6000        0x0  r--p   /usr/lib/locale/locale-archive
        0x7ffff7cfb000     0x7ffff7cfd000     0x2000        0x0  rw-p
        0x7ffff7cfd000     0x7ffff7d1f000    0x22000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libc-2.31.so
        0x7ffff7d1f000     0x7ffff7e97000   0x178000    0x22000  r-xp   /usr/lib/x86_64-linux-gnu/libc-2.31.so
        0x7ffff7e97000     0x7ffff7ee5000    0x4e000   0x19a000  r--p   /usr/lib/x86_64-linux-gnu/libc-2.31.so
        0x7ffff7ee5000     0x7ffff7ee9000     0x4000   0x1e7000  r--p   /usr/lib/x86_64-linux-gnu/libc-2.31.so
        0x7ffff7ee9000     0x7ffff7eeb000     0x2000   0x1eb000  rw-p   /usr/lib/x86_64-linux-gnu/libc-2.31.so
        0x7ffff7eeb000     0x7ffff7eef000     0x4000        0x0  rw-p
        0x7ffff7eef000     0x7ffff7ef5000     0x6000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libpthread-2.31.so
        0x7ffff7ef5000     0x7ffff7f06000    0x11000     0x6000  r-xp   /usr/lib/x86_64-linux-gnu/libpthread-2.31.so
        0x7ffff7f06000     0x7ffff7f0c000     0x6000    0x17000  r--p   /usr/lib/x86_64-linux-gnu/libpthread-2.31.so
        0x7ffff7f0c000     0x7ffff7f0d000     0x1000    0x1c000  r--p   /usr/lib/x86_64-linux-gnu/libpthread-2.31.so
        0x7ffff7f0d000     0x7ffff7f0e000     0x1000    0x1d000  rw-p   /usr/lib/x86_64-linux-gnu/libpthread-2.31.so
        0x7ffff7f0e000     0x7ffff7f12000     0x4000        0x0  rw-p
        0x7ffff7f12000     0x7ffff7f14000     0x2000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f14000     0x7ffff7f25000    0x11000     0x2000  r-xp   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f25000     0x7ffff7f2b000     0x6000    0x13000  r--p   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f2b000     0x7ffff7f2c000     0x1000    0x19000  ---p   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f2c000     0x7ffff7f2d000     0x1000    0x19000  r--p   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f2d000     0x7ffff7f2e000     0x1000    0x1a000  rw-p   /usr/lib/x86_64-linux-gnu/libz.so.1.2.11
        0x7ffff7f2e000     0x7ffff7f30000     0x2000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0
        0x7ffff7f30000     0x7ffff7f95000    0x65000     0x2000  r-xp   /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0
        0x7ffff7f95000     0x7ffff7fbd000    0x28000    0x67000  r--p   /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0
        0x7ffff7fbd000     0x7ffff7fbe000     0x1000    0x8e000  r--p   /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0
        0x7ffff7fbe000     0x7ffff7fbf000     0x1000    0x8f000  rw-p   /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.9.0
        0x7ffff7fbf000     0x7ffff7fc1000     0x2000        0x0  rw-p
        0x7ffff7fcb000     0x7ffff7fce000     0x3000        0x0  r--p   [vvar]
        0x7ffff7fce000     0x7ffff7fcf000     0x1000        0x0  r-xp   [vdso]
        0x7ffff7fcf000     0x7ffff7fd0000     0x1000        0x0  r--p   /usr/lib/x86_64-linux-gnu/ld-2.31.so
        0x7ffff7fd0000     0x7ffff7ff3000    0x23000     0x1000  r-xp   /usr/lib/x86_64-linux-gnu/ld-2.31.so
        0x7ffff7ff3000     0x7ffff7ffb000     0x8000    0x24000  r--p   /usr/lib/x86_64-linux-gnu/ld-2.31.so
        0x7ffff7ffc000     0x7ffff7ffd000     0x1000    0x2c000  r--p   /usr/lib/x86_64-linux-gnu/ld-2.31.so
        0x7ffff7ffd000     0x7ffff7ffe000     0x1000    0x2d000  rw-p   /usr/lib/x86_64-linux-gnu/ld-2.31.so
        0x7ffff7ffe000     0x7ffff7fff000     0x1000        0x0  rw-p
        0x7ffffffde000     0x7ffffffff000    0x21000        0x0  rw-p   [stack]
    0xffffffffff600000 0xffffffffff601000     0x1000        0x0  --xp   [vsyscall]

The faulting instruction is:

  (gdb) x/i $pc
  => 0x7ffff7a149d3:	movzwq (%rcx,%r9,1),%rcx
  (gdb) info registers rcx r9
  rcx            0x3fffffffffffffe   288230376151711742
  r9             0x7ffff7fae680      140737353803392

It tries to read from the non-canonical address 0x04007ffff7fae67e.
Both, the base value of the instruction and the index look way off,
which makes me suspect, what we see here is a JIT compiler bug. :/

Carlo, does that ring a bell? The libpcre2 version I'm using here is
10.34-7ubuntu0.1 (default version in Ubuntu 20.04).

Further testing also let me confirm my prior suspicion that it is,
indeed, commit acabd2048ee0 ("grep: correctly identify utf-8 characters
with \{b,w} in -P") that is causing the faulty behaviour. Reverting
that commit and rebuilding the package leads to a working git binary.

Carlo or any other more familiar with the PCRE2 library, does that ring
a bell? Did PCRE2 had a bug related to JIT and PCRE2_UCP?

> 
> Overall I would say that the issue is likely because the patterns are run against a non ASCII file somewhere in the repo.
> Our repo is fairly large with files in various formats, including potentially some binaries that would definitely not be proper UTF-8.
> 
> For now I have a good workaround which is to only check for *.py files, which we should have done in the first place. The NO_JIT flag slows down things significantly so we will not use it here.
> 
> Do you have any recommendation on how to identify which file(s) is causing the crash considering there is nothing in stderr?

strace ;) But as I could reproduce the issue too, it's no longer needed.

Thanks,
Mathias

> 
> Thanks!
