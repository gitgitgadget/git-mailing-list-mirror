From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Possibly solved invalid free() in git-remote-http from Git 1.7.2.1
Date: Mon, 1 Aug 2011 17:22:47 +0200
Message-ID: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnuKU-0000PU-HL
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1HAPWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 11:22:50 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:39452 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab1HAPWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 11:22:49 -0400
Received: by eye22 with SMTP id 22so4635346eye.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=EkwAuW3jKgrfQArbgWoJTK5UMC0ooocWxRbC/7exbNo=;
        b=kYjLEliUVtjiNgyH10WV3/tU2sveryXyzn5xvx9x8EHjIOC/U8b8WSKDkWFOBFAobk
         ppSvtMxoP9/SG4dMA6wFg4YLdm7rQkyfvVQgwm8rWcfxfZo98NK4VJD2TAPTCJ9+1WJw
         rm2JqBXqzAwcf+a2ctYTD9whZmIPj5u1asIow=
Received: by 10.205.64.206 with SMTP id xj14mr1381293bkb.85.1312212167543;
 Mon, 01 Aug 2011 08:22:47 -0700 (PDT)
Received: by 10.204.123.66 with HTTP; Mon, 1 Aug 2011 08:22:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178348>

In case anyone would like to look into this I had this undiagnosed
free() error from git-remote-http in git version 1.7.2.1:

    error: Couldn't create temporary file
/tmp/clone/main.git/.git/objects/e3/2a06e85053d958f78a20f37c9604e40b8282ad.temp:
No such file or directory
    *** glibc detected *** git-remote-http: free(): invalid pointer:
0x00000000006848c0 ***
    ======= Backtrace: =========
    /lib64/libc.so.6[0x3c9b6722ef]
    /lib64/libc.so.6(cfree+0x4b)[0x3c9b67273b]
    git-remote-http[0x406e2d]
    git-remote-http[0x407671]
    git-remote-http[0x407abe]
    git-remote-http[0x429044]
    git-remote-http[0x404a9a]
    /lib64/libc.so.6(__libc_start_main+0xf4)[0x3c9b61d994]
    git-remote-http(fwrite+0x129)[0x4034e9]
    ======= Memory map: ========
    00400000-00474000 r-xp 00000000 fd:00 12260242
      /usr/libexec/git-core/git-remote-http
    00674000-00676000 rw-p 00074000 fd:00 12260242
      /usr/libexec/git-core/git-remote-http
    00676000-00696000 rw-p 00676000 00:00 0
    00875000-00877000 rw-p 00075000 fd:00 12260242
      /usr/libexec/git-core/git-remote-http
    021e9000-027a2000 rw-p 021e9000 00:00 0
      [heap]
    369c200000-369c215000 r-xp 00000000 fd:00 6193169
      /lib64/libselinux.so.1
    369c215000-369c415000 ---p 00015000 fd:00 6193169
      /lib64/libselinux.so.1
    369c415000-369c417000 rw-p 00015000 fd:00 6193169
      /lib64/libselinux.so.1
    369c417000-369c418000 rw-p 369c417000 00:00 0
    369d200000-369d20d000 r-xp 00000000 fd:00 6193154
      /lib64/libgcc_s-4.1.2-20080825.so.1
    369d20d000-369d40d000 ---p 0000d000 fd:00 6193154
      /lib64/libgcc_s-4.1.2-20080825.so.1
    369d40d000-369d40e000 rw-p 0000d000 fd:00 6193154
      /lib64/libgcc_s-4.1.2-20080825.so.1
    369de00000-369de3b000 r-xp 00000000 fd:00 6193167
      /lib64/libsepol.so.1
    369de3b000-369e03b000 ---p 0003b000 fd:00 6193167
      /lib64/libsepol.so.1
    369e03b000-369e03c000 rw-p 0003b000 fd:00 6193167
      /lib64/libsepol.so.1
    369e03c000-369e046000 rw-p 369e03c000 00:00 0
    369e200000-369e211000 r-xp 00000000 fd:00 6193165
      /lib64/libresolv-2.5.so
    369e211000-369e411000 ---p 00011000 fd:00 6193165
      /lib64/libresolv-2.5.so
    369e411000-369e412000 r--p 00011000 fd:00 6193165
      /lib64/libresolv-2.5.so
    369e412000-369e413000 rw-p 00012000 fd:00 6193165
      /lib64/libresolv-2.5.so
    369e413000-369e415000 rw-p 369e413000 00:00 0
    3a17800000-3a1783b000 r-xp 00000000 fd:00 11842620
      /usr/lib64/libcurl.so.3.0.0
    3a1783b000-3a17a3b000 ---p 0003b000 fd:00 11842620
      /usr/lib64/libcurl.so.3.0.0
    3a17a3b000-3a17a3d000 rw-p 0003b000 fd:00 11842620
      /usr/lib64/libcurl.so.3.0.0
    3c46e00000-3c46e31000 r-xp 00000000 fd:00 11840244
      /usr/lib64/libidn.so.11.5.19
    3c46e31000-3c47030000 ---p 00031000 fd:00 11840244
      /usr/lib64/libidn.so.11.5.19
    3c47030000-3c47031000 rw-p 00030000 fd:00 11840244
      /usr/lib64/libidn.so.11.5.19
    3c9b200000-3c9b21c000 r-xp 00000000 fd:00 6193446
      /lib64/ld-2.5.so
    3c9b41b000-3c9b41c000 r--p 0001b000 fd:00 6193446
      /lib64/ld-2.5.so
    3c9b41c000-3c9b41d000 rw-p 0001c000 fd:00 6193446
      /lib64/ld-2.5.so
    3c9b600000-3c9b74d000 r-xp 00000000 fd:00 6193447
      /lib64/libc-2.5.so
    3c9b74d000-3c9b94d000 ---p 0014d000 fd:00 6193447
      /lib64/libc-2.5.so
    3c9b94d000-3c9b951000 r--p 0014d000 fd:00 6193447
      /lib64/libc-2.5.so
    3c9b951000-3c9b952000 rw-p 00151000 fd:00 6193447
      /lib64/libc-2.5.so
    3c9b952000-3c9b957000 rw-p 3c9b952000 00:00 0
    3c9ba00000-3c9ba02000 r-xp 00000000 fd:00 6193448
      /lib64/libdl-2.5.so
    3c9ba02000-3c9bc02000 ---p 00002000 fd:00 6193448
      /lib64/libdl-2.5.so
    3c9bc02000-3c9bc03000 r--p 00002000 fd:00 6193448
      /lib64/libdl-2.5.so
    3c9bc03000-3c9bc04000 rw-p 00003000 fd:00 6193448
      /lib64/libdl-2.5.so
    3c9be00000-3c9be16000 r-xp 00000000 fd:00 6193452
      /lib64/libpthread-2.5.so
    3c9be16000-3c9c015000 ---p 00016000 fd:00 6193452
      /lib64/libpthread-2.5.so
    3c9c015000-3c9c016000 r--p 00015000 fd:00 6193452
      /lib64/libpthread-2.5.so
    3c9c016000-3c9c017000 rw-p 00016000 fd:00 6193452
      /lib64/libpthread-2.5.so
    3c9c017000-3c9c01b000 rw-p 3c9c017000 00:00 0
    3c9ce00000-3c9ce14000 r-xp 00000000 fd:00 11835868
      /usr/lib64/libz.so.1.2.3
    3c9ce14000-3c9d013000 ---p 00014000 fd:00 11835868
      /usr/lib64/libz.so.1.2.3
    3c9d013000-3c9d014000 rw-p 00013000 fd:00 11835868
      /usr/lib64/libz.so.1.2.3
    3c9ea00000-3c9ea02000 r-xp 00000000 fd:00 6193461
      /lib64/libcom_err.so.2.1
    3c9ea02000-3c9ec01000 ---p 00002000 fd:00 6193461
      /lib64/libcom_err.so.2.1
    3c9ec01000-3c9ec02000 rw-p 00001000 fd:00 6193461
      /lib64/libcom_err.so.2.1
    3c9f600000-3c9f620000 r-xp 00000000 fd:00 6193466
      /lib64/libexpat.so.0.5.0
    3c9f620000-3c9f81f000 ---p 00020000 fd:00 6193466
      /lib64/libexpat.so.0.5.0
    3c9f81f000-3c9f822000 rw-p 0001f000 fd:00 6193466
      /lib64/libexpat.so.0.5.0
    3ec6e00000-3ec6e45000 r-xp 00000000 fd:00 6193218
      /lib64/libssl.so.0.9.8e
    3ec6e45000-3ec7044000 ---p 00045000 fd:00 6193218
      /lib64/libssl.so.0.9.8e
    3ec7044000-3ec704a000 rw-p 00044000 fd:00 6193218
      /lib64/libssl.so.0.9.8e
    3ec7200000-3ec7208000 r-xp 00000000 fd:00 11841734
      /usr/lib64/libkrb5support.so.0.1
    3ec7208000-3ec7407000 ---p 00008000 fd:00 11841734
      /usr/lib64/libkrb5support.so.0.1
    3ec7407000-3ec7408000 rw-p 00007000 fd:00 11841734
      /usr/lib64/libkrb5support.so.0.1
    3ec7600000-3ec7602000 r-xp 00000000 fd:00 6193214
      /lib64/libkeyutils-1.2.so
    3ec7602000-3ec7801000 ---p 00002000 fd:00 6193214
      /lib64/libkeyutils-1.2.so
    3ec7801000-3ec7802000 rw-p 00001000 fd:00 6193214
      /lib64/libkeyutils-1.2.so
    3ec8a00000-3ec8a91000 r-xp 00000000 fd:00 11842706
      /usr/lib64/libkrb5.so.3.3
    3ec8a91000-3ec8c91000 ---p 00091000 fd:00 11842706
      /usr/lib64/libkrb5.so.3.3
    3ec8c91000-3ec8c95000 rw-p 00091000 fd:00 11842706
      /usr/lib64/libkrb5.so.3.3
    3ec8e00000-3ec8e2c000 r-xp 00000000 fd:00 11843236
      /usr/lib64/libgssapi_krb5.so.2.2
    3ec8e2c000-3ec902c000 ---p 0002c000 fd:00 11843236
      /usr/lib64/libgssapi_krb5.so.2.2
    3ec902c000-3ec902e000 rw-p 0002c000 fd:00 11843236
      /usr/lib64/libgssapi_krb5.so.2.2
    3ec9200000-3ec9224000 r-xp 00000000 fd:00 11841735
      /usr/lib64/libk5crypto.so.3.1
    3ec9224000-3ec9423000 ---p 00024000 fd:00 11841735
      /usr/lib64/libk5crypto.so.3.1
    3ec9423000-3ec9425000 rw-p 00023000 fd:00 11841735
      /usr/lib64/libk5crypto.so.3.1
    3ec9a00000-3ec9b2d000 r-xp 00000000 fd:00 6193209
      /lib64/libcrypto.so.0.9.8e
    3ec9b2d000-3ec9d2c000 ---p 0012d000 fd:00 6193209
      /lib64/libcrypto.so.0.9.8e
    3ec9d2c000-3ec9d4d000 rw-p 0012c000 fd:00 6193209
      /lib64/libcrypto.so.0.9.8e
    3ec9d4d000-3ec9d51000 rw-p 3ec9d4d000 00:00 0
    2afc5e15e000-2afc5e161000 rw-p 2afc5e15e000 00:00 0
    2afc5e16a000-2afc5e172000 rw-p 2afc5e16a000 00:00 0
    2afc5e17d000-2afc5e187000 r-xp 00000000 fd:00 6193177
      /lib64/libnss_files-2.5.so
    2afc5e187000-2afc5e386000 ---p 0000a000 fd:00 6193177
      /lib64/libnss_files-2.5.so
    2afc5e386000-2afc5e387000 r--p 00009000 fd:00 6193177
      /lib64/libnss_files-2.5.so
    2afc5e387000-2afc5e388000 rw-p 0000a000 fd:00 6193177
      /lib64/libnss_files-2.5.so
    2afc5e388000-2afc5e38c000 r-xp 00000000 fd:00 6193175
      /lib64/libnss_dns-2.5.so
    2afc5e38c000-2afc5e58b000 ---p 00004000 fd:00 6193175
      /lib64/libnss_dns-2.5.so
    2afc5e58b000-2afc5e58c000 r--p 00003000 fd:00 6193175
      /lib64/libnss_dns-2.5.so
    2afc5e58c000-2afc5e58d000 rw-p 00004000 fd:00 6193175
      /lib64/libnss_dns-2.5.so
    2afc5e58d000-2afc5e86b000 rw-p 2afc5e58d000 00:00 0
    7fff9f4e1000-7fff9f4f6000 rw-p 7ffffffe9000 00:00 0
      [stack]
    ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0
      [vdso]

It happened when I rm -rf'd the /tmp/clone directory that
git-remote-http was working on. It's possibly fixed in later versions
of git, I didn't check.

Just posting it here in case someone has time to write a test for this
/ track it down. I don't at the moment.q
