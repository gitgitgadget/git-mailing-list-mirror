Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317502013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdBNL5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:57:38 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34955 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdBNL41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:56:27 -0500
Received: by mail-wm0-f52.google.com with SMTP id v186so15849951wmd.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:mime-version:subject:message-id:date:to;
        bh=vaVeUWpbacO+IsthoNlzsck7jHa9K9zyu3UMfwQjeFI=;
        b=UxR0/U1DnAx0AsbzmqbWpKnnslt7ltCof8mxxuZNcqBXrqTtbit3nkbSqWIFwNAW8B
         RbqariubKMPlkUThejOKRHR21cusJHr6T4JJMdmr+I+TG92aVOnumUiWiWpNNjWTHkCy
         mOw2OHSklXNpdKI2IBKgMusS2pcMxukt8D8qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=vaVeUWpbacO+IsthoNlzsck7jHa9K9zyu3UMfwQjeFI=;
        b=bZms7BCPgzGK0XLIqmWB3W7XQ05SEOd7d2UuvjbMzZZgsMtOFpH7OCQJXHxtXIHiGt
         7hKnCvYP8WgE3Nwd2XVgFVtDkbzaEyMhQsyTzLIfMf5A4bZUl2Jgotjr9wkDse4cbrgL
         MjjpmOS2dvnSpRkMVbuOnNmo3tB5Y6iagweZoyvDGUEQs56eqSXaeLKRM4y7WkD0XLl/
         tFrUlzJI7NOojFiN+HL844e6aByOG4X/yUHV0Kal/Ng0J+pbQcGYFMA43dxTCLpAeWny
         bh4RXVIyZSYitdle8szTX8B3d6meOZnH2xN7i9Lk87ljqNnadUf7xeshQY1Cx9pE0o/H
         dBbA==
X-Gm-Message-State: AMke39kfsMVDf8wfe9YcMrARLms0hefvEWcuHtPHsj4mKiWGo2MokC6yhsv8bwEiwpT+BYDI
X-Received: by 10.28.96.130 with SMTP id u124mr3022006wmb.81.1487073385047;
        Tue, 14 Feb 2017 03:56:25 -0800 (PST)
Received: from [192.168.1.66] (ppp158-255-178-141.pppoe.spdop.ru. [158.255.178.141])
        by smtp.gmail.com with ESMTPSA id 40sm510648wry.22.2017.02.14.03.56.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 03:56:24 -0800 (PST)
From:   Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_EBDF1A4A-902A-4CBB-96A1-E4701E30219F"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [BUG] Memory corruption crash with "git bisect start"
Message-Id: <A7AEC719-6E15-4622-8E21-3E11BAF74A3C@linaro.org>
Date:   Tue, 14 Feb 2017 14:56:22 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_EBDF1A4A-902A-4CBB-96A1-E4701E30219F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I'm seeing the following memory corruption crash on a script-constructed =
repo when starting git bisect.  I'm seeing this crash both with system =
git of Ubuntu Xenial and with freshly-compiled git master from the =
official repo.

The log of the crash is attached.

It is possible that the bug is in Xenial glibc, in which case -- please =
let me know and I will take it up with the glibc developers.

To reproduce the crash:

<snip>
# Create a repo with 42 files, and change all of them.
rm -rf .git
git init
for i in `seq 1 42`; do echo 0 > f$i; git add f$i; echo 1 > f$i; done
git commit -m 0

# Download script to generate bisect history:
pushd ../
wget =
https://git.linaro.org/people/maxim.kuvyrkov/tree-bisect.git/plain/constru=
ct-tree.sh
popd

# Construct tree for bisect.  This script creates a history graph for =
all permutations of changed files up to "2" in depth.
# The goal of the script is to assist in reducing testcases for =
compiler/toolchain development.
../construct-tree.sh -d 2

# Trigger crash
git bisect start bottom top
</snip>

It is interesting that "42" number files is boundary.  The crash does =
not occur with history generated from 41 or fewer files, and only occurs =
with 42 or more files.  It appears that the contents of the files is not =
relevant for the crash.

--
Maxim Kuvyrkov
www.linaro.org



--Apple-Mail=_EBDF1A4A-902A-4CBB-96A1-E4701E30219F
Content-Disposition: attachment;
	filename=git-bisect-crash.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="git-bisect-crash.log"
Content-Transfer-Encoding: 7bit

maxim.kuvyrkov@2492b3a161d0:~/tmp/test-bisect$ git bisect start bottom top
Previous HEAD position was 0520f90... 9
Switched to branch '42/1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_34_35_36_37_38_39_40_41_42'
*** buffer overflow detected ***: git terminated
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f86df8017e5]
/lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x5c)[0x7f86df8a256c]
/lib/x86_64-linux-gnu/libc.so.6(+0x116570)[0x7f86df8a0570]
git[0x474d21]
git[0x406365]
git[0x4066a8]
git[0x40584d]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f86df7aa830]
git[0x405899]
======= Memory map: ========
00400000-005e1000 r-xp 00000000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007e0000-007e1000 r--p 001e0000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007e1000-007ea000 rw-p 001e1000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007ea000-00830000 rw-p 00000000 00:00 0 
00b0c000-00b2d000 rw-p 00000000 00:00 0                                  [heap]
7f86df2f0000-7f86df306000 r-xp 00000000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f86df306000-7f86df505000 ---p 00016000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f86df505000-7f86df506000 rw-p 00015000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f86df506000-7f86df586000 rw-p 00000000 00:00 0 
7f86df586000-7f86df589000 r-xp 00000000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f86df589000-7f86df788000 ---p 00003000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f86df788000-7f86df789000 r--p 00002000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f86df789000-7f86df78a000 rw-p 00003000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f86df78a000-7f86df949000 r-xp 00000000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f86df949000-7f86dfb49000 ---p 001bf000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f86dfb49000-7f86dfb4d000 r--p 001bf000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f86dfb4d000-7f86dfb4f000 rw-p 001c3000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f86dfb4f000-7f86dfb53000 rw-p 00000000 00:00 0 
7f86dfb53000-7f86dfb5a000 r-xp 00000000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f86dfb5a000-7f86dfd59000 ---p 00007000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f86dfd59000-7f86dfd5a000 r--p 00006000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f86dfd5a000-7f86dfd5b000 rw-p 00007000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f86dfd5b000-7f86dfd73000 r-xp 00000000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f86dfd73000-7f86dff72000 ---p 00018000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f86dff72000-7f86dff73000 r--p 00017000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f86dff73000-7f86dff74000 rw-p 00018000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f86dff74000-7f86dff78000 rw-p 00000000 00:00 0 
7f86dff78000-7f86e0192000 r-xp 00000000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f86e0192000-7f86e0391000 ---p 0021a000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f86e0391000-7f86e03ad000 r--p 00219000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f86e03ad000-7f86e03b9000 rw-p 00235000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f86e03b9000-7f86e03bc000 rw-p 00000000 00:00 0 
7f86e03bc000-7f86e03d5000 r-xp 00000000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f86e03d5000-7f86e05d4000 ---p 00019000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f86e05d4000-7f86e05d5000 r--p 00018000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f86e05d5000-7f86e05d6000 rw-p 00019000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f86e05d6000-7f86e05fc000 r-xp 00000000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f86e0641000-7f86e07d9000 r--p 00000000 00:25 156                        /usr/lib/locale/locale-archive
7f86e07d9000-7f86e07de000 rw-p 00000000 00:00 0 
7f86e07f8000-7f86e07fb000 rw-p 00000000 00:00 0 
7f86e07fb000-7f86e07fc000 r--p 00025000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f86e07fc000-7f86e07fd000 rw-p 00026000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f86e07fd000-7f86e07fe000 rw-p 00000000 00:00 0 
7ffd4fa11000-7ffd4fa32000 rw-p 00000000 00:00 0                          [stack]
7ffd4fbed000-7ffd4fbef000 r-xp 00000000 00:00 0                          [vdso]
7ffd4fbef000-7ffd4fbf1000 r--p 00000000 00:00 0                          [vvar]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
Aborted (core dumped)
*** buffer overflow detected ***: git terminated
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f9515a267e5]
/lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x5c)[0x7f9515ac756c]
/lib/x86_64-linux-gnu/libc.so.6(+0x116570)[0x7f9515ac5570]
git[0x474d21]
git[0x406365]
git[0x4066a8]
git[0x40584d]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f95159cf830]
git[0x405899]
======= Memory map: ========
00400000-005e1000 r-xp 00000000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007e0000-007e1000 r--p 001e0000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007e1000-007ea000 rw-p 001e1000 08:05 2192298551                         /home/maxim.kuvyrkov/git-install/libexec/git-core/git
007ea000-00830000 rw-p 00000000 00:00 0 
01059000-0107a000 rw-p 00000000 00:00 0                                  [heap]
7f9515515000-7f951552b000 r-xp 00000000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f951552b000-7f951572a000 ---p 00016000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f951572a000-7f951572b000 rw-p 00015000 00:25 3394                       /lib/x86_64-linux-gnu/libgcc_s.so.1
7f951572b000-7f95157ab000 rw-p 00000000 00:00 0 
7f95157ab000-7f95157ae000 r-xp 00000000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f95157ae000-7f95159ad000 ---p 00003000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f95159ad000-7f95159ae000 r--p 00002000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f95159ae000-7f95159af000 rw-p 00003000 00:25 36                         /lib/x86_64-linux-gnu/libdl-2.23.so
7f95159af000-7f9515b6e000 r-xp 00000000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f9515b6e000-7f9515d6e000 ---p 001bf000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f9515d6e000-7f9515d72000 r--p 001bf000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f9515d72000-7f9515d74000 rw-p 001c3000 00:25 38                         /lib/x86_64-linux-gnu/libc-2.23.so
7f9515d74000-7f9515d78000 rw-p 00000000 00:00 0 
7f9515d78000-7f9515d7f000 r-xp 00000000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f9515d7f000-7f9515f7e000 ---p 00007000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f9515f7e000-7f9515f7f000 r--p 00006000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f9515f7f000-7f9515f80000 rw-p 00007000 00:25 147                        /lib/x86_64-linux-gnu/librt-2.23.so
7f9515f80000-7f9515f98000 r-xp 00000000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f9515f98000-7f9516197000 ---p 00018000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f9516197000-7f9516198000 r--p 00017000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f9516198000-7f9516199000 rw-p 00018000 00:25 80                         /lib/x86_64-linux-gnu/libpthread-2.23.so
7f9516199000-7f951619d000 rw-p 00000000 00:00 0 
7f951619d000-7f95163b7000 r-xp 00000000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f95163b7000-7f95165b6000 ---p 0021a000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f95165b6000-7f95165d2000 r--p 00219000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f95165d2000-7f95165de000 rw-p 00235000 00:25 172                        /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
7f95165de000-7f95165e1000 rw-p 00000000 00:00 0 
7f95165e1000-7f95165fa000 r-xp 00000000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f95165fa000-7f95167f9000 ---p 00019000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f95167f9000-7f95167fa000 r--p 00018000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f95167fa000-7f95167fb000 rw-p 00019000 00:25 174                        /lib/x86_64-linux-gnu/libz.so.1.2.8
7f95167fb000-7f9516821000 r-xp 00000000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f9516866000-7f95169fe000 r--p 00000000 00:25 156                        /usr/lib/locale/locale-archive
7f95169fe000-7f9516a03000 rw-p 00000000 00:00 0 
7f9516a1d000-7f9516a20000 rw-p 00000000 00:00 0 
7f9516a20000-7f9516a21000 r--p 00025000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f9516a21000-7f9516a22000 rw-p 00026000 00:25 31                         /lib/x86_64-linux-gnu/ld-2.23.so
7f9516a22000-7f9516a23000 rw-p 00000000 00:00 0 
7fff47216000-7fff47237000 rw-p 00000000 00:00 0                          [stack]
7fff4731e000-7fff47320000 r-xp 00000000 00:00 0                          [vdso]
7fff47320000-7fff47322000 r--p 00000000 00:00 0                          [vvar]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
Aborted (core dumped)
Bisecting: 41 revisions left to test after this (roughly 5 steps)
[0520f903823d04d139111c3d379806d6c4895586] 9
maxim.kuvyrkov@2492b3a161d0:~/tmp/test-bisect$ echo $?
0

--Apple-Mail=_EBDF1A4A-902A-4CBB-96A1-E4701E30219F--
