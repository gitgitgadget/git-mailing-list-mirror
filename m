Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472EC4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A090720754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9zlwIep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgCVAzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:55:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42937 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:55:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so5166616pgs.9
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNUwlj8nUe+j4FRvZ6/Po7oswigulKwRNDkruegb7o0=;
        b=P9zlwIepb+rYyeUvCuf/FuyJ0/JE9jOnUgJe6P3TWkrE3Jx1Ce7qvOtj0wHFH1NvmY
         y3UON6uj/x4AkA8MdswQHUuEMf/Fb6u2Yn5iJpJsvHZ/PAZZyZI3crmAxC2g7bkvnjLZ
         fI1YO96dwGdVaIDuCJJv6Guzv7ETY6sUbEsd3BO29VhgF/+HUEJ+wagMczDCSOwA71Og
         xYJP37Nz+g/4+XXd8hP7SldvQX8Im4yRGlvn4OZTis1CudHl4xFVtSdUmZXiqqblMGud
         lEObojk6BIZcNEsjpY7FHpJvu1Bfuc7bZXNZVSVWxpsR7jTsnjL0uU6whjDdYueexEQn
         rP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNUwlj8nUe+j4FRvZ6/Po7oswigulKwRNDkruegb7o0=;
        b=WWl2z1SeLjZ9lzdg0aAYzYXsX/aSSYabCOfwhgjMVVFRyg4nwJLavTMUoyXKVRDTOg
         3iNjoayW/HJQTAyH54oL3YZzDvmON/9sPbi09CJgw7RUvhGRpIKE0LuIkubcatwmtRSb
         fjn/DlVJsuBhrfOfyCMLnZ4QJSGQuDOj+VDKOYARp3UniYEnoTffbjfOQftnF52ZmKdA
         J+3Lc3xGcjzIsF96CpdAq5Bs0B440Qo6tWhIvRgOJzeIbJYKZYsCcQY1iG4MRdJ2VuRK
         4zNZbWZ/16Jewpk//yMPi3UqFyXmilLHyWQoop8K1wzfGXDxt62A0ukWfdhTWTStBT1J
         59rg==
X-Gm-Message-State: ANhLgQ1+YZJiLXd8NrqYvtmyA0d+qi+pcfaXk5yIhJmIPWZMNqSJwwEd
        pQmUqcv5mIGitQSExzjAWXu0Ocn7
X-Google-Smtp-Source: ADFU+vvZk4ydduT5GSUUXgXYHyd76f6GnroXe6/I8LMNN8yriL9a3pjGPC4nyxNmsZX/D/AAJjLZDQ==
X-Received: by 2002:aa7:87ca:: with SMTP id i10mr17597572pfo.169.1584838550914;
        Sat, 21 Mar 2020 17:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:55:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v2 0/8] fix test failure with busybox
Date:   Sun, 22 Mar 2020 07:55:09 +0700
Message-Id: <cover.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Range-diff against v1:
1:  4830bd3aaf ! 1:  288e343d09 t4061: use POSIX compliance regex(7)
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    t4061: use POSIX compliance regex(7)
    +    t4061: use POSIX compliant regex(7)
     
         BRE interprets `+` literally, and
         `\+` is undefined for POSIX BRE, from:
    @@ Commit message
     
         This test is failing with busybox sed, the default sed of Alpine Linux
     
    -    Fix it by using literal `+` instead.
    +    We have 2 options here:
    +
    +    - Using literal `+` because BRE will interpret it as-is, or
    +    - Using character class `[+]` to defend against a sed that expects ERE
    +
    +    ERE-expected sed is theoretical at this point,
    +    but we haven't found it, yet.
    +    And, we may run into other problems with that sed.
    +    Let's go with first option and fix it later if that sed could be found.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
2:  d3fafd61ec ! 2:  9d3823e849 test-lib-functions: test_cmp: eval $GIT_TEST_CMP
    @@ Commit message
         test-lib-functions: test_cmp: eval $GIT_TEST_CMP
     
         Shell recognises first non-assignment token as command name.
    -    Thus, ` cd t/perf; ./p0000-perf-lib-sanity.sh -d -i -v` reports:
    +    With /bin/sh linked to either /bin/bash or /bin/dash,
    +    `cd t/perf && ./p0000-perf-lib-sanity.sh -d -i -v` reports:
     
         > test_cmp:1: command not found: diff -u
     
-:  ---------- > 3:  8e85b5c15c t5003: drop the subshell in test_lazy_prereq
3:  ddeeefeae2 ! 4:  4f0ac0867c t5003: skip conversion test if unzip -a is unavailable
    @@ Commit message
     
      ## t/t5003-archive-zip.sh ##
     @@ t/t5003-archive-zip.sh: test_lazy_prereq UNZIP_SYMLINKS '
    - 	)
    + 	test -h symlink
      '
      
     +test_lazy_prereq UNZIP_CONVERT '
    -+	(
    -+		mkdir unzip-convert &&
    -+		cd unzip-convert &&
    -+		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
    -+	)
    ++	"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
     +'
     +
      check_zip() {
4:  ce976e850c ! 5:  ee7ef352a7 t5616: use rev-parse instead to get HEAD's object_id
    @@ t/t5616-partial-clone.sh: test_expect_success 'do partial clone 1' '
      	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
      	test_line_count = 1 promisorlist &&
     -	git -C srv.bare rev-list HEAD >headhash &&
    -+	git -C srv.bare rev-parse HEAD >headhash &&
    ++	git -C srv.bare rev-parse --verify HEAD >headhash &&
      	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
      	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
      '
5:  1993b28a12 ! 6:  59e3f73784 t7063: use POSIX find(1) syntax
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    t7063: use POSIX find(1) syntax
    +    t7063: drop non-POSIX argument "-ls" from find(1)
     
         Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
         update feature, 2016-08-03), we started to use ls as a trick to update
    @@ Commit message
         However, `-ls` flag isn't required by POSIX's find(1), and
         busybox(1) doesn't implement it.
     
    -    Use an equivalence `-exec ls -dils {} +` instead.
    +    From the original conversation, it seems like find(1) with "-type d"
    +    could trigger enough "lstat(2)" to ask FreeBSD update mtime.
    +
    +    Use only filter "-type d" for now.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ t/t7063-status-untracked-cache.sh: GIT_FORCE_UNTRACKED_CACHE=true
      
      sync_mtime () {
     -	find . -type d -ls >/dev/null
    -+	find . -type d -exec ls -dils {} + >/dev/null
    ++	find . -type d >/dev/null
      }
      
      avoid_racy() {
6:  cd86febed9 ! 7:  10f39c3d30 t4124: fix test for non-compliance diff
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    t4124: fix test for non-compliance diff
    +    t4124: fix test for non-compliant diff(1)
     
         POSIX's diff(1) requires output in normal diff format.
         However, busybox's diff's output is written in unified format.
    @@ t/t4124-apply-ws-rule.sh: test_fix () {
      
      	# find touched lines
      	$DIFF file target | sed -n -e "s/^> //p" >fixed
    ++	# busybox's diff(1) output unified format
     +	if ! test -s fixed; then
     +		$DIFF file target |
    -+		grep '^+' |
    -+		grep -v '^+++' |
    -+		sed -e "s/+//" >fixed
    ++		grep -v '^+++ target' |
    ++		sed -e "/^+/s/+//" >fixed
     +	fi
      
      	# the changed lines are all expected to change
-:  ---------- > 8:  d4507d381e t5703: feed raw data into test-tool unpack-sideband
-- 
2.26.0.rc2.310.g2932bb562d

