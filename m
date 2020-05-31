Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F87AC433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B18207D0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 10:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=UhdeJc.com header.i=@UhdeJc.com header.b="tkuSs1Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgEaKwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 06:52:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:34304 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgEaKwp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 06:52:45 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2020 06:52:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1590922355;
        s=strato-dkim-0002; d=UhdeJc.com;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=qoh5YiwvkiMm889cwUGh+nHmTtDqiBzc3ncJ9WH4DN8=;
        b=tkuSs1Er7Pg7LmrWDqCr5m5NIrRbeACWX182NXHfEd6/ebd71Il72T8pQW2of/IzSz
        PsU6z2e41wO7zAkA2T3wfMFUH/2GsiPD7/sOkQXop/bB/hLF4cMnp3qoaBeogEk55ORp
        lzrvyYf2g3f4uOIcXDHcBPud9vP3fJD/DxpaA0mLwNVBiQejz2gSKOcG6PWmk6SDnMB0
        +0RL3wexXyRV90UBwydLZjRaw7eDOZ66YS+3eM2V2Wu8i4PX+z/eDxPWR7TgBJTFTJI0
        xR3uwcmq+djPkOaM62kW4ABmf0MAC+FoHVqWWzYEhfzVFuTT3QwEWNcd0SEEfpnSUeyR
        8NVg==
X-RZG-AUTH: ":Jm0KVVWgf/qsp6yYkPuIAWpZc5/7d/LUhoNVUVqyWOFyRWTQkVPqo1kX8GA="
X-RZG-CLASS-ID: mo00
Received: from edward.obiwahn.org
        by smtp.strato.com (RZmta 46.9.0 DYNA|AUTH)
        with ESMTPSA id z07ea6w4VAkVE9A
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Sun, 31 May 2020 12:46:31 +0200 (CEST)
To:     git@vger.kernel.org
From:   Jan Christoph Uhde <Jan@UhdeJc.com>
Subject: mmap failure in master 1aa69c73577df21f5e37e47cc40cf44fc049121e
Message-ID: <54a3a798-0387-64df-be20-af69db124042@UhdeJc.com>
Date:   Sun, 31 May 2020 12:46:30 +0200
User-Agent: Why are you interested in my client, Sir?
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8F034D7835AAEFE6D004582B"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F034D7835AAEFE6D004582B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

when calling `git diff --quiet` on the gcc git repository
my system fails reproducible with a failed mmap. I have
noticed this possible bug with git in debian unstable and
then build git from source. But I am not able to get a core
or backtrace when gdb is attached.

The command I have used to build git is:

make clean; CFLAGS="-O0 -g -fsanitize=address" DEBUG=1 make -j24


Maybe you can give me some advice how to further debug this.

Jan

--------------------------------------------------------------

The output below was created with the system git not
the self-compiled version (that behaves in the same way).

» ulimit -a; git --version; git diff --quiet; git remote -v
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 514868
max locked memory       (kbytes, -l) unlimited
max memory size         (kbytes, -m) unlimited
open files                      (-n) 20000
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 2000
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
git version 2.27.0.rc2
fatal: mmap failed: Cannot allocate memory
origin  git://gcc.gnu.org/git/gcc.git (fetch)
origin  git://gcc.gnu.org/git/gcc.git (push)

--------------------------------------------------------------

lstat("gcc/testsuite/gdc.test/fail_compilation/b19717a.d", {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b19717a.d", {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b19717a.d", {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b19717a.d", {st_mode=S_IFREG|0644, st_size=494, ...}) = 0
openat(AT_FDCWD, "gcc/testsuite/gdc.test/fail_compilation/b19717a.d", O_RDONLY) = 3
mmap(NULL, 494, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f4a81a58000
close(3)                                = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
lstat("gcc/testsuite/gdc.test/fail_compilation/b3841.d", {st_mode=S_IFREG|0644, st_size=2643, ...}) = 0
openat(AT_FDCWD, "gcc/testsuite/gdc.test/fail_compilation/b3841.d", O_RDONLY) = 3
mmap(NULL, 2643, PROT_READ, MAP_PRIVATE, 3, 0) = -1 ENOMEM (Cannot allocate memory)
openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "fatal: mmap failed: Cannot alloc"..., 43fatal: mmap failed: Cannot allocate memory
) = 43
exit_group(128)                         = ?
+++ exited with 128 +++

--------------------------------------------------------------

» uname -a; free -m
Linux edward 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64 GNU/Linux
               total        used        free      shared  buff/cache   available
Mem:         128842        6279       86976        1084       35586      120439
Swap:        122067           0      122067



--------------8F034D7835AAEFE6D004582B
Content-Type: text/x-log; charset=UTF-8;
 name="heaptrack.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="heaptrack.log"

reading file "/opt/gcc_repo/heaptrack.git.1558791.gz" - please wait, this might take some time...
Debuggee command was: git diff --quiet
finished reading file, now analyzing data:

MOST CALLS TO ALLOCATION FUNCTIONS
729067 calls to allocation functions with 484.95MB peak consumption from
0x55ed4a44de70
  in /usr/bin/git
66811 calls with 310.23MB peak consumption from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a3b122e
      in /usr/bin/git
    0x55ed4a3acc72
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
66811 calls with 0B peak consumption from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a3aaf4c
      in /usr/bin/git
    0x55ed4a3acc4c
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
66811 calls with 2.54MB peak consumption from:
    0x55ed4a3accc0
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
65357 calls with 1.57MB peak consumption from:
    0x55ed4a351cce
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
65357 calls with 8.61MB peak consumption from:
    0x55ed4a34ffad
      in /usr/bin/git
    0x55ed4a351c50
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 397920 from 210 other places

152095 calls to allocation functions with 7.16KB peak consumption from
inflateInit2_
  in /lib/x86_64-linux-gnu/libz.so.1
66811 calls with 0B peak consumption from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3aaf93
      in /usr/bin/git
    0x55ed4a3acc4c
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
50269 calls with 7.16KB peak consumption from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3aaf93
      in /usr/bin/git
    0x55ed4a3ad084
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
35015 calls with 0B peak consumption from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3abe9d
      in /usr/bin/git
    0x55ed4a3ad369
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502b2
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

22747 calls to allocation functions with 0B peak consumption from
inflate
  in /lib/x86_64-linux-gnu/libz.so.1
22747 calls with 0B peak consumption from:
    0x55ed4a458ebc
      in /usr/bin/git
    0x55ed4a3abeac
      in /usr/bin/git
    0x55ed4a3ad369
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502b2
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

668 calls to allocation functions with 3.13KB peak consumption from
__strdup
  in /lib/x86_64-linux-gnu/libc.so.6
573 calls with 75B peak consumption from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a30ff1c
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
29 calls with 504B peak consumption from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a330abb
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
29 calls with 2.12KB peak consumption from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a3309a5
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
8 calls with 109B peak consumption from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a3309a5
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a333219
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
8 calls with 154B peak consumption from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a330abb
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a333219
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 21 from 19 other places

630 calls to allocation functions with 13.37KB peak consumption from
0x7f5839fd679e
  in /lib/x86_64-linux-gnu/libc.so.6
573 calls with 0B peak consumption from:
    0x55ed4a4604fb
      in /usr/bin/git
    0x55ed4a44e53e
      in /usr/bin/git
    0x55ed4a30fa95
      in /usr/bin/git
    0x55ed4a30fca2
      in /usr/bin/git
    0x55ed4a30feda
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
12 calls with 3.73KB peak consumption from:
    0x7f5839fd4bc4
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd3dba
      in /lib/x86_64-linux-gnu/libc.so.6
    setlocale
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a371396
      in /usr/bin/git
    0x55ed4a24afbf
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
12 calls with 3.73KB peak consumption from:
    0x7f5839fd4bc4
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd3dba
      in /lib/x86_64-linux-gnu/libc.so.6
    setlocale
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3713a7
      in /usr/bin/git
    0x55ed4a24afbf
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
2 calls with 0B peak consumption from:
    0x7f5839fd83c2
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
2 calls with 2.05KB peak consumption from:
    0x7f5839fda263
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd8497
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 29 from 29 other places

20 calls to allocation functions with 1.28KB peak consumption from
0x7f583a275661
  in /lib64/ld-linux-x86-64.so.2
20 calls with 1.28KB peak consumption from:
    _dl_allocate_tls
      in /lib64/ld-linux-x86-64.so.2
    pthread_create@@GLIBC_2.2.5
      in /lib/x86_64-linux-gnu/libpthread.so.0
    0x55ed4a3b8240
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

7 calls to allocation functions with 0B peak consumption from
_IO_file_doallocate
  in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 0B peak consumption from:
    _IO_doallocbuf
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_file_underflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_default_uflow
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a32dd71
      in /usr/bin/git
    0x55ed4a32ef94
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333523
      in /usr/bin/git
    0x55ed4a429fb1
      in /usr/bin/git
    0x55ed4a24afda
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 0B peak consumption from:
    _IO_doallocbuf
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_file_underflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_default_uflow
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a32dd71
      in /usr/bin/git
    0x55ed4a32ef94
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a40b9c2
      in /usr/bin/git
    0x55ed4a40bb8c
      in /usr/bin/git
    0x55ed4a40d14c
      in /usr/bin/git
    0x55ed4a277c94
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 0B peak consumption from:
    _IO_doallocbuf
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_file_underflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_default_uflow
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a32dd71
      in /usr/bin/git
    0x55ed4a32ef94
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 0B peak consumption from:
    _IO_doallocbuf
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_file_underflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_default_uflow
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a32dd71
      in /usr/bin/git
    0x55ed4a32ef94
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a333219
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 0B peak consumption from:
    _IO_doallocbuf
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_file_underflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_default_uflow
      in /lib/x86_64-linux-gnu/libc.so.6
    _IO_getline_info
      in /lib/x86_64-linux-gnu/libc.so.6
    fgets_unlocked
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd9d57
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fda263
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd8497
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 2 from 2 other places

3 calls to allocation functions with 72B peak consumption from
tsearch
  in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 24B peak consumption from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a36605a
      in /usr/bin/git
    0x55ed4a24c4e8
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 24B peak consumption from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a366091
      in /usr/bin/git
    0x55ed4a24c4e8
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 calls with 24B peak consumption from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a40d2f2
      in /usr/bin/git
    0x55ed4a277c94
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

1 calls to allocation functions with 24B peak consumption from
pcre2_general_context_create_8
  in /lib/x86_64-linux-gnu/libpcre2-8.so.0
1 calls with 24B peak consumption from:
    0x55ed4a377ba4
      in /usr/bin/git
    0x55ed4a3eefe7
      in /usr/bin/git
    0x55ed4a277d92
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

1 calls to allocation functions with 72.70KB peak consumption from
0x7f5839e53565
  in /lib/x86_64-linux-gnu/libstdc++.so.6
1 calls with 72.70KB peak consumption from:
    0x7f583a273369
      in /lib64/ld-linux-x86-64.so.2
    0x7f583a273468
      in /lib64/ld-linux-x86-64.so.2
    0x7f583a2650c9
      in /lib64/ld-linux-x86-64.so.2


PEAK MEMORY CONSUMERS
484.95MB peak memory consumed over 729067 calls from
0x55ed4a44de70
  in /usr/bin/git
310.23MB consumed over 66811 calls from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a3b122e
      in /usr/bin/git
    0x55ed4a3acc72
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
104.67MB consumed over 50269 calls from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a3aaf4c
      in /usr/bin/git
    0x55ed4a3ad084
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
30.16MB consumed over 4672 calls from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a44ddef
      in /usr/bin/git
    0x55ed4a3ad13c
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
14.58MB consumed over 1 calls from:
    0x55ed4a467ff6
      in /usr/bin/git
    0x55ed4a4680a8
      in /usr/bin/git
    0x55ed4a3c3662
      in /usr/bin/git
    0x55ed4a3c78ac
      in /usr/bin/git
    0x55ed4a3b83e7
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
8.61MB consumed over 65357 calls from:
    0x55ed4a34ffad
      in /usr/bin/git
    0x55ed4a351c50
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 16.68MB from 210 other places

72.70KB peak memory consumed over 1 calls from
0x7f5839e53565
  in /lib/x86_64-linux-gnu/libstdc++.so.6
72.70KB consumed over 1 calls from:
    0x7f583a273369
      in /lib64/ld-linux-x86-64.so.2
    0x7f583a273468
      in /lib64/ld-linux-x86-64.so.2
    0x7f583a2650c9
      in /lib64/ld-linux-x86-64.so.2

13.37KB peak memory consumed over 630 calls from
0x7f5839fd679e
  in /lib/x86_64-linux-gnu/libc.so.6
3.73KB consumed over 12 calls from:
    0x7f5839fd4bc4
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd3dba
      in /lib/x86_64-linux-gnu/libc.so.6
    setlocale
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a371396
      in /usr/bin/git
    0x55ed4a24afbf
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
3.73KB consumed over 12 calls from:
    0x7f5839fd4bc4
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd3dba
      in /lib/x86_64-linux-gnu/libc.so.6
    setlocale
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3713a7
      in /usr/bin/git
    0x55ed4a24afbf
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
2.05KB consumed over 2 calls from:
    0x7f5839fda263
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd8497
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1.60KB consumed over 1 calls from:
    0x7f5839fda263
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd8497
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1.18KB consumed over 1 calls from:
    0x55ed4a40d2f2
      in /usr/bin/git
    0x55ed4a277c94
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 1.09KB from 29 other places

7.16KB peak memory consumed over 152095 calls from
inflateInit2_
  in /lib/x86_64-linux-gnu/libz.so.1
7.16KB consumed over 50269 calls from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3aaf93
      in /usr/bin/git
    0x55ed4a3ad084
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

3.13KB peak memory consumed over 668 calls from
__strdup
  in /lib/x86_64-linux-gnu/libc.so.6
2.12KB consumed over 29 calls from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a3309a5
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
504B consumed over 29 calls from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a330abb
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
154B consumed over 8 calls from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a330abb
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a333219
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
109B consumed over 8 calls from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a3309a5
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a333219
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
75B consumed over 573 calls from:
    0x55ed4a44dd38
      in /usr/bin/git
    0x55ed4a30ff1c
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 168B from 19 other places

1.28KB peak memory consumed over 20 calls from
0x7f583a275661
  in /lib64/ld-linux-x86-64.so.2
1.28KB consumed over 20 calls from:
    _dl_allocate_tls
      in /lib64/ld-linux-x86-64.so.2
    pthread_create@@GLIBC_2.2.5
      in /lib/x86_64-linux-gnu/libpthread.so.0
    0x55ed4a3b8240
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

72B peak memory consumed over 3 calls from
tsearch
  in /lib/x86_64-linux-gnu/libc.so.6
24B consumed over 1 calls from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a36605a
      in /usr/bin/git
    0x55ed4a24c4e8
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
24B consumed over 1 calls from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a366091
      in /usr/bin/git
    0x55ed4a24c4e8
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
24B consumed over 1 calls from:
    0x7f5839fdf96d
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a40d2f2
      in /usr/bin/git
    0x55ed4a277c94
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

24B peak memory consumed over 1 calls from
pcre2_general_context_create_8
  in /lib/x86_64-linux-gnu/libpcre2-8.so.0
24B consumed over 1 calls from:
    0x55ed4a377ba4
      in /usr/bin/git
    0x55ed4a3eefe7
      in /usr/bin/git
    0x55ed4a277d92
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6


MOST TEMPORARY ALLOCATIONS
261461 temporary allocations of 729067 allocations in total (35.86%) from
0x55ed4a44de70
  in /usr/bin/git
65356 temporary allocations of 65356 allocations in total (100.00%) from:
    0x55ed4a41ac66
      in /usr/bin/git
    0x55ed4a41b434
      in /usr/bin/git
    0x55ed4a30fe5a
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
65344 temporary allocations of 65344 allocations in total (100.00%) from:
    0x55ed4a41ac66
      in /usr/bin/git
    0x55ed4a41b434
      in /usr/bin/git
    0x55ed4a30fe5a
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a350217
      in /usr/bin/git
    0x55ed4a350b20
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
65344 temporary allocations of 65344 allocations in total (100.00%) from:
    0x55ed4a41ac66
      in /usr/bin/git
    0x55ed4a41b434
      in /usr/bin/git
    0x55ed4a30fe5a
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35044a
      in /usr/bin/git
    0x55ed4a350acc
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
65342 temporary allocations of 65357 allocations in total (99.98%) from:
    0x55ed4a41ac66
      in /usr/bin/git
    0x55ed4a41b434
      in /usr/bin/git
    0x55ed4a30fe5a
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
29 temporary allocations of 29 allocations in total (100.00%) from:
    0x55ed4a44dcdc
      in /usr/bin/git
    0x55ed4a3306fb
      in /usr/bin/git
    0x55ed4a3308fd
      in /usr/bin/git
    0x55ed4a330988
      in /usr/bin/git
    0x55ed4a3350ee
      in /usr/bin/git
    0x55ed4a32f251
      in /usr/bin/git
    0x55ed4a3327ad
      in /usr/bin/git
    0x55ed4a3330bf
      in /usr/bin/git
    0x55ed4a333354
      in /usr/bin/git
    0x55ed4a333e7b
      in /usr/bin/git
    0x55ed4a277d73
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 46B from 210 other places

129348 temporary allocations of 152095 allocations in total (85.04%) from
inflateInit2_
  in /lib/x86_64-linux-gnu/libz.so.1
66811 temporary allocations of 66811 allocations in total (100.00%) from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3aaf93
      in /usr/bin/git
    0x55ed4a3acc4c
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
50269 temporary allocations of 50269 allocations in total (100.00%) from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3aaf93
      in /usr/bin/git
    0x55ed4a3ad084
      in /usr/bin/git
    0x55ed4a3ad395
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502d0
      in /usr/bin/git
    0x55ed4a350b09
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
12268 temporary allocations of 35015 allocations in total (35.04%) from:
    0x55ed4a458b9c
      in /usr/bin/git
    0x55ed4a3abe9d
      in /usr/bin/git
    0x55ed4a3ad369
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502b2
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

22747 temporary allocations of 22747 allocations in total (100.00%) from
inflate
  in /lib/x86_64-linux-gnu/libz.so.1
22747 temporary allocations of 22747 allocations in total (100.00%) from:
    0x55ed4a458ebc
      in /usr/bin/git
    0x55ed4a3abeac
      in /usr/bin/git
    0x55ed4a3ad369
      in /usr/bin/git
    0x55ed4a412692
      in /usr/bin/git
    0x55ed4a41271a
      in /usr/bin/git
    0x55ed4a3502b2
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6

580 temporary allocations of 630 allocations in total (92.06%) from
0x7f5839fd679e
  in /lib/x86_64-linux-gnu/libc.so.6
572 temporary allocations of 573 allocations in total (99.83%) from:
    0x55ed4a4604fb
      in /usr/bin/git
    0x55ed4a44e53e
      in /usr/bin/git
    0x55ed4a30fa95
      in /usr/bin/git
    0x55ed4a30fca2
      in /usr/bin/git
    0x55ed4a30feda
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
2 temporary allocations of 2 allocations in total (100.00%) from:
    0x7f5839fd83c2
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 temporary allocations of 1 allocations in total (100.00%) from:
    0x55ed4a4604fb
      in /usr/bin/git
    0x55ed4a44e53e
      in /usr/bin/git
    0x55ed4a30fa95
      in /usr/bin/git
    0x55ed4a310474
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 temporary allocations of 2 allocations in total (50.00%) from:
    0x7f5839fda263
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd8497
      in /lib/x86_64-linux-gnu/libc.so.6
    0x7f5839fd7cdf
      in /lib/x86_64-linux-gnu/libc.so.6
    0x55ed4a3bd6da
      in /usr/bin/git
    0x55ed4a3b827c
      in /usr/bin/git
    0x55ed4a3b83fc
      in /usr/bin/git
    0x55ed4a278626
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
1 temporary allocations of 1 allocations in total (100.00%) from:
    0x55ed4a4604fb
      in /usr/bin/git
    0x55ed4a44e53e
      in /usr/bin/git
    0x55ed4a30fa95
      in /usr/bin/git
    0x55ed4a3103ec
      in /usr/bin/git
    0x55ed4a310b28
      in /usr/bin/git
    0x55ed4a338cc1
      in /usr/bin/git
    0x55ed4a33ba3d
      in /usr/bin/git
    0x55ed4a35010c
      in /usr/bin/git
    0x55ed4a350ab7
      in /usr/bin/git
    0x55ed4a351ede
      in /usr/bin/git
    0x55ed4a345bae
      in /usr/bin/git
    0x55ed4a27863b
      in /usr/bin/git
    0x55ed4a24b464
      in /usr/bin/git
    0x55ed4a24c523
      in /usr/bin/git
    0x55ed4a24aff9
      in /usr/bin/git
    __libc_start_main
      in /lib/x86_64-linux-gnu/libc.so.6
  and 3B from 29 other places


total runtime: 2.67s.
bytes allocated in total (ignoring deallocations): 3.51GB (1.32GB/s)
calls to allocation functions: 905239 (339294/s)
temporary memory allocations: 414136 (155223/s)
peak heap memory consumption: 485.04MB
peak RSS (including heaptrack overhead): 11.14GB
total memory leaked: 485.04MB

--------------8F034D7835AAEFE6D004582B--
