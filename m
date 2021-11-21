Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B0EC433FE
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKUAuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbhKUAuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1778C06173E
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so25347383wrb.6
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WUJYX8Jwxtngb9Y6+X6CK5tzG2PUQkACmxWU1cVCOcQ=;
        b=o5Yi4PtK5fNY3aDVGtEI2fMZppS/OJLN17unydySRB8ycWzSoHi6yhqPhgOsYGmjWI
         d33lTBRsxy7jxxkHRTX4WziQaWlBvdsOzzWnhA5s3/fp43sPxyfzUCNUnWPj5DKUGFL4
         o+Q/KMG4WaEC9tcRm+YBjunwQBLyqq3WZ5Lr+BcWJA62hqjaGSg5FJoDULKiEQdpKkmj
         HUcidkghvlATpeEZZkfLrDzH454XqStblC2zQW0nWzrkETytAGUBRBw30t5W1O9o6i3t
         F1lG83QXLC8/A4hcDmBOh+wF3CYmMubR8cJSl8/8IGv7ZUH/6a1gSi4otA/j01uVv1+4
         FBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WUJYX8Jwxtngb9Y6+X6CK5tzG2PUQkACmxWU1cVCOcQ=;
        b=UwOKjVkQ1BEFNS9+4ds2+jzpLnRvWl4XCinBbvtAy1PbQ1dEcO55WsOu44HSj51O2u
         VNHPjT76DBHWW+PFzzqjNq5HBwDqHbuITWld0vh8mGgq4UwLQT45k7FjPpvlDVTNoDFm
         PzBXL8Q5ShuFgABH870a5DKjzL5X1owtMSggq+ViG9I2ovVpwSY2Ib/75NQKNkmQOQHD
         PXassOO7oJXfhWulbS1e+4qpqogDzkVARPf1Ma56PBjPsKDcqCzAVZ3xmN3KfcS6pVPC
         /L5T0NLCSo2AdVaQXAvR2D/8h7swob6XECW0HvwXRO9C01+b0rZkFgftYapqrt6bd71C
         GsFg==
X-Gm-Message-State: AOAM531Fi59nUIABh/FtW4ShA5IcwJBckmKgCWNhEV8060dprMeS5Z21
        dqzb7t5aAQcEtd37o4ckHX3TWx0ZMxs=
X-Google-Smtp-Source: ABdhPJzd4rXxJq3PVHM1t1S3XFWMGMNSuU0pjEJEne4qJMEIvlFInTEyU22iby9xTm57rYT8D3Wayw==
X-Received: by 2002:adf:fe8e:: with SMTP id l14mr22832048wrr.177.1637455624246;
        Sat, 20 Nov 2021 16:47:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm15851573wmc.14.2021.11.20.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Message-Id: <39830fffd45e103b608e2ac7869a509fcd5dc7db.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:56 +0000
Subject: [PATCH 4/8] unpack-trees: add special cwd handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When running commands such as `git reset --hard` from a subdirectory, if
that subdirectory is in the way of adding needed files, bail with an
error message.

Note that this change looks kind of like it duplicates the new lines of
code from the previous commit in verify_clean_subdirectory().  However,
when we are preserving untracked files, we would rather any error
messages about untracked files being in the way take precedence over
error messages about a subdirectory that happens to be the current
working directory being in the way.  But in the
UNPACK_RESET_OVERWRITE_UNTRACKED case, there is no untracked checking to
be done, so we simply add a special case near the top of
verify_absent_1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh |  2 +-
 unpack-trees.c       | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 212676d71c3..526d8ec2ee3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -67,7 +67,7 @@ test_expect_failure 'reset --hard does not clean cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'reset --hard fails if cwd needs to be removed' '
+test_expect_success 'reset --hard fails if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8879b8d6c8c..d1ce4f4a35b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2260,10 +2260,18 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || !o->update ||
-	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
+	if (o->index_only || !o->update)
 		return 0;
 
+	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
+		/* Avoid nuking cwd... */
+		if (the_cwd && !strcmp(the_cwd, ce->name))
+			return add_rejected_path(o, ERROR_CWD_IN_THE_WAY,
+						 ce->name);
+		/* ...but nuke anything else. */
+		return 0;
+	}
+
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
 	if (!len)
 		return 0;
-- 
gitgitgadget

