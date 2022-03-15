Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4AC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351984AbiCOVc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiCOVcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B95BE44
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so371565wrc.6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xznHAbPb1YXa3RvOdPcCMBklNaMgBGuf4+t5joBYEHc=;
        b=ohBTAnggQ6aMve0hdyqr7O9DO/rDt27rCitsYj6+cF3q2CDw/A9dalYfodUtXf+cpp
         gnd1afcN+/acYbd/WO/O7RWsuz27QDTXt43E1qijmR6irevKxTy7YI5t+35+tKO9MKRP
         TfQpOp+pAMo6wwTnR+WJtwonYVi90rX/Tfa2K1oqd8EhD2CcJjuYDP1T2P0XMKxvocfT
         FXo9jI4ZRjViIkzGD9g9QAtOgwmZ8YOWytRfsu7DeB98AGSeFrZiPm1Fw59IEba2CS/I
         RpVaJapgueEX8mVxClFThyfJhcNFx7FWPZnOus/E6E4F1E249rZLDXcrpAiZtWf6yzc1
         x1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xznHAbPb1YXa3RvOdPcCMBklNaMgBGuf4+t5joBYEHc=;
        b=2a7l+T/RyUlryMRB9HveKsICPfcHib0TJGKbZmPX8TI7dKh3C6M/e+Qh8+T6vE8JOr
         ZrXnwAljfp/IIRzIEH5Omf+DgZ7eLWFFlZ3KRr+gTShEk+tAWfpE1SNk2eooizy1ZUi0
         H8MhlwHXPBdOoDC4uaPUUsUiqs4pj1E2fK8e4yybla8+ynpgzjwvzIHHBXmfhKtyb8U3
         UrheBMmToxbfvuMwHAzXhwwL5P60pw/0y5x5crykZlidJwyK3KRThsILBIR6DiWB4/9n
         nloocmOYnwUeIYFZlP7brm/alRzn8TkPhWhBtm9yRDQMrweC2r2NfruLC2dXHfp2ZBaf
         5FbA==
X-Gm-Message-State: AOAM532eDCBjgQ12kacl6VkD4RUfFGDLZTIFGdPXGcvPVa3n7VPA7YNp
        2x/0X11MX6no8NSs7yg811UmzsD9NPw=
X-Google-Smtp-Source: ABdhPJzuJ5vut6oJkxlIPzJmC5WrSzGEbIMeQT8rnMCJ7mx7ZnMLgy5a/xDLtdwNMjK63xWSAFv0Nw==
X-Received: by 2002:adf:fe8d:0:b0:203:de3d:7f93 with SMTP id l13-20020adffe8d000000b00203de3d7f93mr426276wrr.55.1647379864993;
        Tue, 15 Mar 2022 14:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adffbc1000000b00203de0fff63sm91360wrs.70.2022.03.15.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:04 -0700 (PDT)
Message-Id: <4e56c58c8cb812b244feaf814b43b7dc28879f9a.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:57 +0000
Subject: [PATCH 5/7] core.fsync: use batch mode and sync loose objects by
 default on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Git for Windows has defaulted to core.fsyncObjectFiles=true since
September 2017. We turn on syncing of loose object files with batch mode
in upstream Git so that we can get broad coverage of the new code
upstream.

We don't actually do fsyncs in the test suite, since GIT_TEST_FSYNC is
set to 0. However, we do exercise all of the surrounding batch mode code
since GIT_TEST_FSYNC merely makes the maybe_fsync wrapper always appear
to succeed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>

change fsyncmethod to batch as well
---
 cache.h           | 4 ++++
 compat/mingw.h    | 3 +++
 config.c          | 2 +-
 git-compat-util.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 4d07691e791..04193d87246 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,6 +1031,10 @@ enum fsync_component {
 			      FSYNC_COMPONENT_INDEX | \
 			      FSYNC_COMPONENT_REFERENCE)
 
+#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
+#endif
+
 /*
  * A bitmask indicating which components of the repo should be fsynced.
  */
diff --git a/compat/mingw.h b/compat/mingw.h
index 6074a3d3ced..afe30868c04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -332,6 +332,9 @@ int mingw_getpagesize(void);
 int win32_fsync_no_flush(int fd);
 #define fsync_no_flush win32_fsync_no_flush
 
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
+#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/config.c b/config.c
index 0b28f90de8b..c76443dc556 100644
--- a/config.c
+++ b/config.c
@@ -1342,7 +1342,7 @@ static const struct fsync_component_name {
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
 {
-	enum fsync_component current = FSYNC_COMPONENTS_DEFAULT;
+	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 0892e209a2f..fffe42ce7c1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1257,11 +1257,13 @@ __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
 
+#ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
 #else
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
 #endif
+#endif
 
 enum fsync_action {
 	FSYNC_WRITEOUT_ONLY,
-- 
gitgitgadget

