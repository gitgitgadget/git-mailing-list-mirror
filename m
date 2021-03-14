Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD4C43381
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494A664E86
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCNWRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhCNWRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:17:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40841C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g20so7047717wmk.3
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z8vwt4Zyxh9BzSX1a5zsk4FdOOJt01pZmeEEHzdNk8Q=;
        b=gPfYOwjWP5RDOUW63iuybzb69BgmfZMfbDoPkx0Uu3kJ+OGTgRRmI1Fz3aqwzbyUU6
         tiHyR+pGwVyhY7M3UMS28yaRP5CsR4sKRhVr6WRnba9BukjFlvtZvkJJAMv0cKrWSRwj
         LIJsmi8uisQsQmaUO1fLs1060Z+4YmnVdQEfMyjvzvNGNdVCXJ+kVnVIvU8pANzAhjQE
         dvEhkDQqPA0zSAGn17B47yk079/WbZel1QlPtj5/pIwXb4k6Iq/d124WakC4uMNI996m
         VSZzI81zCVVcaeo9R4zRjKeOXC+O39EQX7fJeDTqqcDzP9OQJiy3T0iYL9X7GWX9MD3i
         6XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z8vwt4Zyxh9BzSX1a5zsk4FdOOJt01pZmeEEHzdNk8Q=;
        b=eLFxu3piTgVgOA+TYRhkH/rv/syV2sTV35YMBPLORC0wcUr3Pmox6JoEvFzz7CKK88
         bykrz0h+iVm8YUHU1AC1QXdtQNbNH+hjO7NXOXE8/ls7sktC4NRC7Z2naUiDmov38irE
         0ySWMu77zXLQ5OmyeStuy0kNQoc9DBa7L6+dej0TcJN5Y2XRk7p1+Fniw5K+yZjfKAOC
         LcolQPTXjLV4hqjT97mwrKMcpWkLGaA06kksk90o0X0xhgYfECuMrmnfzhhc2blkEJzb
         IFUivSCEOQf5v7Jm0S0oW4vzogxfTmFcFKZpc6wCWQME8FjasE9fs4czGya7mJtZEptN
         DLxg==
X-Gm-Message-State: AOAM532NyYYF4nxJdyObPUq4U8LsfIkJHbDE/3UP3QdhteUY6sQlth8w
        feQuijxN563MtcSA3lfg/KpYZT7WMJw=
X-Google-Smtp-Source: ABdhPJyERzfvzWtUbxD+/AnlcBTAXpauQegcAM/gEEjW5/x1tGAub6pSgxNHNunsPs6j0bAnL8JV7A==
X-Received: by 2002:a1c:804e:: with SMTP id b75mr23510247wmd.113.1615760260991;
        Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm18542717wrj.62.2021.03.14.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
Message-Id: <740302586dd8902c46567fc2de9b7296cce4eda2.1615760258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.git.1615760258.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 22:17:37 +0000
Subject: [PATCH 3/3] fsmonitor: add perf test for git diff HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Update the xargs call so that if your large repo contains
symlinks, test-tool chmtime failure does not end the script.

On Linux
Test                                                          this tree           upstream/master
---------------------------------------------------------------------------------------------------------
7519.4: status (fsmonitor=fsmonitor-watchman)                 0.52(0.43+0.10)     0.53(0.49+0.05) +1.9%
7519.5: status -uno (fsmonitor=fsmonitor-watchman)            0.21(0.15+0.07)     0.22(0.13+0.09) +4.8%
7519.6: status -uall (fsmonitor=fsmonitor-watchman)           1.65(0.93+0.71)     1.69(1.03+0.65) +2.4%
7519.7: status (dirty) (fsmonitor=fsmonitor-watchman)         11.99(11.34+1.58)   11.95(11.02+1.79) -0.3%
7519.8: diff (fsmonitor=fsmonitor-watchman)                   0.25(0.17+0.26)     0.25(0.18+0.26) +0.0%
7519.9: diff HEAD (fsmonitor=fsmonitor-watchman)              0.39(0.25+0.34)     0.89(0.35+0.74) +128.2%
7519.10: diff -- 0_files (fsmonitor=fsmonitor-watchman)       0.16(0.13+0.04)     0.16(0.12+0.05) +0.0%
7519.11: diff -- 10_files (fsmonitor=fsmonitor-watchman)      0.16(0.12+0.05)     0.16(0.12+0.05) +0.0%
7519.12: diff -- 100_files (fsmonitor=fsmonitor-watchman)     0.16(0.12+0.05)     0.16(0.12+0.05) +0.0%
7519.13: diff -- 1000_files (fsmonitor=fsmonitor-watchman)    0.16(0.11+0.06)     0.16(0.12+0.05) +0.0%
7519.14: diff -- 10000_files (fsmonitor=fsmonitor-watchman)   0.18(0.13+0.06)     0.17(0.10+0.08) -5.6%
7519.15: add (fsmonitor=fsmonitor-watchman)                   2.25(1.53+0.68)     2.25(1.47+0.74) +0.0%
7519.18: status (fsmonitor=disabled)                          0.88(0.73+1.03)     0.89(0.67+1.08) +1.1%
7519.19: status -uno (fsmonitor=disabled)                     0.45(0.43+0.89)     0.45(0.34+0.98) +0.0%
7519.20: status -uall (fsmonitor=disabled)                    1.88(1.16+1.58)     1.88(1.22+1.51) +0.0%
7519.21: status (dirty) (fsmonitor=disabled)                  7.53(7.05+2.11)     7.53(6.98+2.04) +0.0%
7519.22: diff (fsmonitor=disabled)                            0.42(0.37+0.92)     0.42(0.38+0.91) +0.0%
7519.23: diff HEAD (fsmonitor=disabled)                       0.44(0.41+0.90)     0.44(0.40+0.91) +0.0%
7519.24: diff -- 0_files (fsmonitor=disabled)                 0.13(0.09+0.05)     0.13(0.09+0.05) +0.0%
7519.25: diff -- 10_files (fsmonitor=disabled)                0.13(0.10+0.04)     0.13(0.10+0.04) +0.0%
7519.26: diff -- 100_files (fsmonitor=disabled)               0.13(0.09+0.05)     0.13(0.10+0.04) +0.0%
7519.27: diff -- 1000_files (fsmonitor=disabled)              0.13(0.09+0.06)     0.13(0.09+0.05) +0.0%
7519.28: diff -- 10000_files (fsmonitor=disabled)             0.14(0.11+0.05)     0.14(0.10+0.05) +0.0%
7519.29: add (fsmonitor=disabled)                             2.43(1.61+1.64)     2.43(1.69+1.57) +0.0%

On linux (2.29.2 vs w/ this patch):
nipunn@nipunn-dbx:~/src/server3$ strace -f -c git diff 2>&1 | grep lstat
  0.04    0.000063           3        20         6 lstat
nipunn@nipunn-dbx:~/src/server3$ strace -f -c git diff HEAD 2>&1 | grep lstat
 94.98    5.242262          10    523783        13 lstat
nipunn@nipunn-dbx:~/src/server3$ strace -f -c ../git/bin-wrappers/git diff 2>&1 | grep lstat
  0.38    0.000032           5         7         3 lstat
nipunn@nipunn-dbx:~/src/server3$ strace -f -c ../git/bin-wrappers/git diff HEAD 2>&1 | grep lstat
 99.44    0.741892           9     81634        10 lstat

On mac (2.29.2 vs w/ this patch):
nipunn-mbp:server nipunn$ sudo dtruss -L -f -c git diff 2>&1 | grep "^lstat64 "
lstat64                                         8
nipunn-mbp:server nipunn$ sudo dtruss -L -f -c git diff HEAD 2>&1 | grep "^lstat64 "
lstat64                                    120242
nipunn-mbp:server nipunn$ sudo dtruss -L -f -c ../git/bin-wrappers/git diff 2>&1 | grep "^lstat64 "
lstat64                                         4
nipunn-mbp:server nipunn$ sudo dtruss -L -f -c ../git/bin-wrappers/git diff HEAD 2>&1 | grep "^lstat64 "
lstat64                                      4497

There are still a bunch of lstats - on directories, but not every file. Progress!

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/helper/test-chmtime.c   | 3 ++-
 t/perf/p7519-fsmonitor.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index aa22af48c2a6..a8b143d11ab7 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -111,7 +111,8 @@ int cmd__chmtime(int argc, const char **argv)
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s\n",
 			        argv[i], strerror(errno));
-			return 1;
+			// Skip and move on - eg if it's a broken symlink
+			continue;
 		}
 
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index b657564aed60..5eb5044a103c 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -216,6 +216,10 @@ test_fsmonitor_suite() {
 		git diff
 	'
 
+	test_perf_w_drop_caches "diff HEAD ($DESC)" '
+		git diff HEAD
+	'
+
 	test_perf_w_drop_caches "diff -- 0_files ($DESC)" '
 		git diff -- 1_file
 	'
-- 
gitgitgadget
