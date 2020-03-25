Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A6C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3520789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vF3Sr73w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCYPGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:06:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42722 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:06:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so891864plt.9
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oEvX9Lbtvr1lUIslPmYIFe2mDLguYVsZ3JOkfSatbLA=;
        b=vF3Sr73w45c3j7PQDt9rQLpM6UNUX0+1yeTYRkBKWuZrWKF/hERXY8eLTRjnFeDN2v
         MXpargKibdGtQtqL3MosjNmVU1+kGAjbw7sz5V4OQpjvIGRBgH1r6urQ2ecsKy7Y7DFc
         2cM7NntpwUOciyAU7VDeSLG+Z9NVBu0VtXTMdMtrLtB3ffsJPqQnuQxIPCtPqLQn9qRV
         A8AGcQGoJLN+KShwNrj2ZTFE2N2NEcGBrQ3abEuhjCepB/qOcCNkZ10Nm25hVSR5ddmQ
         AsWruK1RzkxWDGmiLo5WkbnIFeJBDhhjCokWRDmCb6PPPwf/5c64D6R5M4DktX8CYROs
         my+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oEvX9Lbtvr1lUIslPmYIFe2mDLguYVsZ3JOkfSatbLA=;
        b=jCwcL/zHZCwH99NnBs4ep+5+/TZPt3E648I2baU0NBuDPkpf5SGSHcQJrkrXj0wxi7
         57lZ55cWTpnapcZd4ojdZcIJKVSG9DmpRGVw0aZ5l0vBSY0UkimK6elb+/uKUfmNZSsy
         ly29mHEbkknVLyOXAvYe7+MQ1ibUtSEgWN+Wl8AgUcTHlu/k/QZ+0BW4uLfWle3zTlvQ
         NN05TXskbiQu0umXKiVFzHUsHAQNQFSHxqx1L4Jo9g9LsDhkBif7xN9YZdaUcytCYgMT
         yiijGA8pWl+XHau0zOdBG03e9M0TAiUueJUp/nQJpw1vvQV8KmVK4OV5AjwTu6868yxO
         A0Mw==
X-Gm-Message-State: ANhLgQ0IAO9GxviN68vpS4vF2gNXBaYmnehH0hofZfDVMoz5XTA6RKzm
        6LDiU8HQ4gVE/ilR/RkdGwVHv4Lptdw=
X-Google-Smtp-Source: ADFU+vvpKGYBBXyrmle0ZJi1kDi2yw5Cdi/jqAjfkXRa/HRisCLTXEOPw07JvzL5IIN4fWHP9jBj7g==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr3730173plo.18.1585148813419;
        Wed, 25 Mar 2020 08:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:06:52 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] fix test failure with busybox
Date:   Wed, 25 Mar 2020 22:06:13 +0700
Message-Id: <cover.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
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

Range-diff against v2:
1:  34f96548de = 1:  088905ab6f t4061: use POSIX compliant regex(7)
2:  50f46986a6 = 2:  691d9d47ba test-lib-functions: test_cmp: eval $GIT_TEST_CMP
3:  8719a07753 = 3:  759a589b83 t5003: drop the subshell in test_lazy_prereq
4:  457eecaf9b = 4:  e5b09c290c t5003: skip conversion test if unzip -a is unavailable
5:  d3bc855e17 = 5:  1b8740018c t5616: use rev-parse instead to get HEAD's object_id
6:  64472ec3bc ! 6:  abb21b9e51 t7063: drop non-POSIX argument "-ls" from find(1)
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
7:  51df6dd12d ! 7:  0502171f0f t4124: fix test for non-compliant diff(1)
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
     +		sed -e "/^+/s/+//" >fixed
     +	fi
8:  843c7f66d9 = 8:  8689e03400 t5703: feed raw data into test-tool unpack-sideband
-- 
2.26.0.rc2.357.g1e1ba0441d

