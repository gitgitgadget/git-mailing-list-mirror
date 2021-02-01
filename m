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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B46C4332D
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA45E64ED2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBAWDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBAWDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED67C061788
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c12so18284964wrc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Frnu9dWaKlmfKQihAMvHEZiZRPFqefcONv9mu4Qbx8c=;
        b=vdNf6+jpTo8e1KwGuu7U2ogWmUYlPTnl5ow5QQav0JbKTEe9zgNHBAe9GguKQqxA6O
         m9Weysa6L/h4Kd8kDnCwhg3QSzxU7QZmXUKu656IUBcewt7p0jELaF/0rOJ5qs/iigs8
         zFE+N5hq0oaij7aT1ZHZWPjra9ImBqOJ2iXYk7OXzlpBr7Va/sB2dkkCkvKEtuARgZjk
         XNicte5BczciZFxAs2mnNWnJ+DHq3xsvTeTa84SuFkCbQEr00CL+dthXeeNMT1RtzaKU
         N07m1ZAi995FmpuE9oOdvJp7Ls8kF9fKR/iZ/80V93gmuRLhj5oZSYBeUaVV5qLJm/9F
         RADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Frnu9dWaKlmfKQihAMvHEZiZRPFqefcONv9mu4Qbx8c=;
        b=HxcxmMqHBDuG5Y85sEpoLeFDaXCKdN2aZ4IIsLqPqA3Das+FgWqTTu+yKEsgWeXvgF
         ymEy14kLuat2fa2xA4lOiIRD9mzuqM7CI9FmESJ8ywqdYdPHvllqHbuo5ex8q9aj0iSO
         wuH3A5EvpfmwKV3AZNRGcSOfo4LwIudzbKHobk5ppwFocqX9vXoDdmB4PN05HglxacHn
         ejgW13d1KX3h8FHwteP1wsC9QiLOlhQqg9mTuO2bvqbcz5WgtdIUthhnjNGvAxb6j1kU
         dgGkBIuGlnPCUT8sN5fg9T7P1f3Xitep5Vq2gu2SsH19fNqSh16C3NBRFS573ahpk0Nm
         2chw==
X-Gm-Message-State: AOAM533F/fmS100JWH7TtDyoCGrXCfB315NlvuLR8yhEKNRAnpA2tT3C
        ngpo4Ap2Db52NY7vmCqWvset5zIf+V4=
X-Google-Smtp-Source: ABdhPJyN4xNwdBUGzm/WrDl46Np07M2oNokOktxGBA/4XUB5TOPsiwQAkjZ44lJiRhp7wKxPFn//Hg==
X-Received: by 2002:adf:f68e:: with SMTP id v14mr13544549wrp.273.1612216945424;
        Mon, 01 Feb 2021 14:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm28547050wrn.12.2021.02.01.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:24 -0800 (PST)
Message-Id: <a641f9e357c60a31176d85e14f2a7d7bc9006744.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:11 +0000
Subject: [PATCH 02/11] p7519: fix watchman watch-list test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Only use the final portion of the test trash directory file name
when verifying that Watchman was started.

On Windows and under the SDK, $GIT_WORKTREE is a cygwin-style
path with forward slashes and a "/c/" drive name.  However
`watchman watch-list` reports a proper Windows-style pathname
with drive letters and backslashes.  This causes the grep to
fail.  Since we don't really care about the full pathname (and
we really don't want to bother with normalizaing them), just see
if the test-name portion of the path is found.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 7bb37e9a6c1..e5a4b0582fb 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -101,7 +101,7 @@ test_expect_success "one time repo setup" '
 	# If Watchman exists, watch the work tree and attempt a query.
 	if test_have_prereq WATCHMAN; then
 		watchman watch "$GIT_WORK_TREE" &&
-		watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+		watchman watch-list | grep -q -F "p7519-fsmonitor"
 	fi
 '
 
-- 
gitgitgadget

