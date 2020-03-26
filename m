Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3723C2D0EC
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917FD20772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCl8getv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZEht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34267 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgCZEht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id d37so1757917pgl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjYPYW0Fbix6zDdbY1Y6y9U7pkT8FJbj7cnI5P1ZYcM=;
        b=hCl8getviQY9thqrcNDLm3HLYn+4dq+K+o/tWJbb1fUPzA89xNIW2Vj3dITYCDwHPC
         mbW/sVqzJZRZ97lQRlsviRSnYqZeK9etdpG0kU+n4kdn5EzY6ncgKtgxbxfzPjlJutjC
         1tiYYaFR7Bl5u1icAJAaTObFe4KgLSZnoOqOd4pqETUxqp+2UcaAdA3JWjVtmYWqO7we
         Exsr1KKq0GloVL0R01nA/yvrj8Q7TmQZksURX+WCUAPlnaVNV/A2qaweM42UX2GhlVTp
         t8/3zq5qD6pjpxiiuEPy6b3njq+/vQhJJTRwWpiq++hq+6GSSgZq810O5zSESzAt2nNb
         PDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjYPYW0Fbix6zDdbY1Y6y9U7pkT8FJbj7cnI5P1ZYcM=;
        b=Xkuzv8DAeXSwaiG168MM45bXVtmaeSwT/L18DJwdWqCTC9RmOMa1EmjnhzIrkb4j+4
         gc+h/O7FTyC55cJcxJbShGf89a4Avq3HyfiTSOU/1woZatiyZ30UQYInpcpDa986BnUe
         s2jVHAu5Ub9UWGpbI2t5QcYY0D70Gnbd+6sn2/W1NvQ2zvmOrQib6debzuVWqZWmoSJE
         H/avctUGS9LWtyCfyMm6d33vIIZ+AX9fWsFycAU4osJqM2ZIIEUyjE2OhsQDQt7Q3iye
         a2wTEAcDCvySl9nzHm+om0goXht8vQy78MtH8kWnhZPsgo8L+i2zwxFr43oEW4ltemd2
         P0Vg==
X-Gm-Message-State: ANhLgQ26IsWtDWS7noGLQEzA74+KdZ/pmI9STyO5M+txrm+dargrDGKz
        Z60WBtNN3rWR+XW/An/edM9KdQRSHZo=
X-Google-Smtp-Source: ADFU+vuU7tgy51COBK52BaYdhbiwDmMrLl6PUnX4rOQKD4Kw//d1FGo8aCkMlEJ4U1SFj9rP5F0cQw==
X-Received: by 2002:a62:6207:: with SMTP id w7mr7094045pfb.102.1585197467006;
        Wed, 25 Mar 2020 21:37:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/8] fix test failure with busybox
Date:   Thu, 26 Mar 2020 11:37:30 +0700
Message-Id: <cover.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore v3, there is an incorrect change in t4124.
I found it when working on travis for linux-musl

Despite non-compiance from busybox's sh(1), grep(1), diff(1), find(1)
Alpine Linux is still a popular choice for container these days.

Fix false-positive failure in testsuite when run in Alpine Linux.

Đoàn Trần Công Danh (8):
  t4061: use POSIX compliant regex(7)
  test-lib-functions: test_cmp: eval $GIT_TEST_CMP
  t5003: drop the subshell in test_lazy_prereq
  t5003: skip conversion test if unzip -a is unavailable
  t5616: use rev-parse instead to get HEAD's object_id
  t7063: drop non-POSIX argument "-ls" from find(1)
  t4124: fix test for non-compliant diff(1)
  t5703: feed raw data into test-tool unpack-sideband

 t/helper/test-pkt-line.c           |  2 +-
 t/t4061-diff-indent.sh             |  2 +-
 t/t4124-apply-ws-rule.sh           |  6 ++++++
 t/t5003-archive-zip.sh             | 24 ++++++++++++------------
 t/t5616-partial-clone.sh           |  2 +-
 t/t5703-upload-pack-ref-in-want.sh |  5 +----
 t/t7063-status-untracked-cache.sh  |  2 +-
 t/test-lib-functions.sh            |  2 +-
 8 files changed, 24 insertions(+), 21 deletions(-)

Range-diff against v3:
 -:  ---------- >  1:  780308d060 t3404: use test_cmp_rev
 -:  ---------- >  2:  5b7a64df40 cherry-pick: add test for `--skip` advice in `git commit`
 -:  ---------- >  3:  f028d661c7 cherry-pick: check commit error messages
 -:  ---------- >  4:  21b11c6d1d sequencer: write CHERRY_PICK_HEAD for reword and edit
 -:  ---------- >  5:  8d57f75749 commit: use enum value for multiple cherry-picks
 -:  ---------- >  6:  901ba7b1ef commit: encapsulate determine_whence() for sequencer
 -:  ---------- >  7:  430b75f720 commit: give correct advice for empty commit during a rebase
 -:  ---------- >  8:  0b4396f068 git-p4: make python2.7 the oldest supported version
 -:  ---------- >  9:  484d09c303 git-p4: change the expansion test from basestring to list
 -:  ---------- > 10:  1f8b46d0a4 git-p4: remove string type aliasing
 -:  ---------- > 11:  6cec21a82f git-p4: encode/decode communication with p4 for python3
 -:  ---------- > 12:  86dca24b7b git-p4: encode/decode communication with git for python3
 -:  ---------- > 13:  d38208a297 git-p4: convert path to unicode before processing them
 -:  ---------- > 14:  5a5577d808 git-p4: open .gitp4-usercache.txt in text mode
 -:  ---------- > 15:  50da1e7393 git-p4: use marshal format version 2 when sending to p4
 -:  ---------- > 16:  4294d741cc git-p4: fix freezing while waiting for fast-import progress
 -:  ---------- > 17:  a6b1306735 git-p4: use functools.reduce instead of reduce
 -:  ---------- > 18:  2e2aa8d903 git-p4: use dict.items() iteration for python3 compatibility
 -:  ---------- > 19:  ce425eb4e1 git-p4: simplify regex pattern generation for parsing diff-tree
 -:  ---------- > 20:  7575f4fdec git-p4: use python3's input() everywhere
 -:  ---------- > 21:  06ac2b3b6e advice: extract vadvise() from advise()
 -:  ---------- > 22:  fef0c76f18 advice: change "setupStreamFailure" to "setUpstreamFailure"
 -:  ---------- > 23:  b3b18d1621 advice: revamp advise API
 -:  ---------- > 24:  f665d63a91 tag: use new advice API to check visibility
 -:  ---------- > 25:  88238e02d5 http: add client cert support for HTTPS proxies
 -:  ---------- > 26:  af026519c9 http: add environment variable support for HTTPS proxies
 -:  ---------- > 27:  0915a5b4cd set_git_dir: fix crash when used with real_path()
 -:  ---------- > 28:  564956f358 update how-to-maintain-git
 -:  ---------- > 29:  6bb40ed20a ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
 -:  ---------- > 30:  3d7747e318 real_path: remove unsafe API
 -:  ---------- > 31:  4530a85b4c real_path_if_valid(): remove unsafe API
 -:  ---------- > 32:  49d3c4b481 get_superproject_working_tree(): return strbuf
 -:  ---------- > 33:  7422b2a0a1 commit-slab: clarify slabname##_peek()'s return value
 -:  ---------- > 34:  9c688735f6 pull: document more passthru options
 -:  ---------- > 35:  b739d971e5 connected.c: reprepare packs for corner cases
 -:  ---------- > 36:  757c2ba3e2 oidset: remove unnecessary include
 -:  ---------- > 37:  8312aa7d74 separate tar.* config to its own source file
 -:  ---------- > 38:  d00a5bdd50 submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
 -:  ---------- > 39:  a7d14a4428 The first batch post 2.26 cycle
 1:  34f96548de = 40:  08839cac15 t4061: use POSIX compliant regex(7)
 2:  50f46986a6 = 41:  31d4a9b2e8 test-lib-functions: test_cmp: eval $GIT_TEST_CMP
 3:  8719a07753 = 42:  f871a7f395 t5003: drop the subshell in test_lazy_prereq
 4:  457eecaf9b = 43:  bc6bcc786d t5003: skip conversion test if unzip -a is unavailable
 5:  d3bc855e17 = 44:  c6f7498d93 t5616: use rev-parse instead to get HEAD's object_id
 6:  64472ec3bc ! 45:  b3acf4adcf t7063: drop non-POSIX argument "-ls" from find(1)
    @@ Commit message
         However, `-ls` flag isn't required by POSIX's find(1), and
         busybox(1) doesn't implement it.
     
    -    From the original conversation, it seems like find(1) with "-type d"
    -    could trigger enough "lstat(2)" to ask FreeBSD update mtime.
    -
    -    Use only filter "-type d" for now.
    +    Use "-exec ls -ld {} +" instead.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ t/t7063-status-untracked-cache.sh: GIT_FORCE_UNTRACKED_CACHE=true
      
      sync_mtime () {
     -	find . -type d -ls >/dev/null
    -+	find . -type d >/dev/null
    ++	find . -type d -exec ls -ld {} + >/dev/null
      }
      
      avoid_racy() {
 7:  51df6dd12d ! 46:  02c115e93a t4124: fix test for non-compliant diff(1)
    @@ Commit message
         POSIX's diff(1) requires output in normal diff format.
         However, busybox's diff's output is written in unified format.
     
    -    POSIX requires no option for normal-diff format.
    +    HP-UX's diff(1) doesn't understand "-u" as of now.
     
    -    A hint in test-lib-functions::test_cmp said `diff -u` isn't available
    -    everywhere.
    -
    -    Workaround this problem by assuming `diff(1)` output is unified
    +    Workaround this problem by checking "diff -u" output,
         if we couldn't make anything from normal-diff format.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
    @@ t/t4124-apply-ws-rule.sh: test_fix () {
      
      	# find touched lines
      	$DIFF file target | sed -n -e "s/^> //p" >fixed
    -+	# busybox's diff(1) output unified format
    ++	# busybox's diff(1) doesn't output normal format
     +	if ! test -s fixed; then
    -+		$DIFF file target |
    ++		$DIFF -u file target |
     +		grep -v '^+++ target' |
    -+		sed -e "/^+/s/+//" >fixed
    ++		sed -ne "/^+/s/+//p" >fixed
     +	fi
      
      	# the changed lines are all expected to change
 8:  843c7f66d9 = 47:  2b8e75aaa5 t5703: feed raw data into test-tool unpack-sideband
-- 
2.26.0.rc2.357.g1e1ba0441d

