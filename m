Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A2C43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B53B64F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCQVWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhCQVW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:22:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46CC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t9so3285708wrn.11
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JMp1bmmwlsn2ikqNcbnAac9oA+bMf7D+78DgGfLuKVo=;
        b=RiwI5pbyXGXCfNX436GF27wGIlro1J6pU4CAexC3XCnM3JBb1X7orcueOZ38R2OxwJ
         gD375Sk0F/mn0kKWaKyxur/+LPmozI6MdOpPqXls7MC1sChVpaL8Zfb+OCQaEWyJCXro
         0tpfufIt34LJ3STcl+sJPOcYrM6Jynx4s+AaSOCIk7vTMjNPNLa5Hp8xkr2x7klQ7Dq6
         EMtm6VNRvoQFU5R1l4+VegxDcbugTtr49kxsiTv6IveH/kaGDnIuef327TxD4VMhGzoQ
         kITrHJxlXesz2pGPbod4jnFAyGQU7ldXR4mgb9JdHSiLj5Ut7u1tP+IP6JwIl2lBeZIZ
         qAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JMp1bmmwlsn2ikqNcbnAac9oA+bMf7D+78DgGfLuKVo=;
        b=T1mWy6s8JdbwelhftkJihQgRwYd/fTyHZ6PxNRjvSobuHcVpL4ohJpRW9x1yVM4UOl
         qibsdJT9ZoUGr8xGvr5P2c/tu6u4l47bvM5OAcF6ttvteJ4CDOZqmAE1NdqrQed032+J
         Rme+1F5vHnANUXwQnpP/Ms4uiQ+nSihh1WhX+fpcuQ1TApM/3pogfRU92YW3hH98WVK1
         a5NVT2Ia+kukZpafrAD8/H6Cb8RtQS6fO4+8rLUbtNu0wm6eMha+xkflrwG4Wpk6eazz
         7JcaxD12FVyhomQVXaY6FG9wI0w8/L4EcoAkAMviMCaq7LKMuUEHMbj2rJvff8Om2PRL
         FglQ==
X-Gm-Message-State: AOAM5304lSPnTWzbZ2MH76uSGD5vCkeOAQNXf0U9ZUjaXHLElqxq9K9N
        iwxuBb3m4wNsXqJho3wkOTZpRO/3rqM=
X-Google-Smtp-Source: ABdhPJz5SrzVfXLVgaaENN1+YZ9q2f8GyLMiMOqmCSEHAPmVW+MQJ1/IagKMWe/zQTmaVNatRoNbAw==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr6280903wrv.10.1616016146324;
        Wed, 17 Mar 2021 14:22:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m132sm90986wmf.45.2021.03.17.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:22:26 -0700 (PDT)
Message-Id: <f9d0fd594fdb515e3a3cd4bd14b8b09532ccc483.1616016143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
        <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:22:23 +0000
Subject: [PATCH v2 3/3] fsmonitor: add perf test for git diff HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
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
 t/helper/test-chmtime.c   | 4 ++--
 t/perf/p7519-fsmonitor.sh | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index aa22af48c2a6..524b55ca496c 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -109,9 +109,9 @@ int cmd__chmtime(int argc, const char **argv)
 		uintmax_t mtime;
 
 		if (stat(argv[i], &sb) < 0) {
-			fprintf(stderr, "Failed to stat %s: %s\n",
+			fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
 			        argv[i], strerror(errno));
-			return 1;
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
