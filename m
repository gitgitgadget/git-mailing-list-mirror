Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD8C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D95D64F2C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBCVeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhBCVes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:34:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA27C0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:34:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d16so930071wro.11
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LAHotV5jxBt7MkoclI6019VDqfZoV/mWCIlD2mBS1hY=;
        b=smTaRqrNkrOpEUDgDWesfLjGExrhFj32jq60rf1oC4Tko+Jc7JWs1gzye382Dqtbep
         JFxGp1GqMf9rT+Hu88Nuwi4sSgfyPj0R8ywETpJdzwE+RZaDNEeJwx0pqm6sSAHdqv0w
         1SgQk0EBdeLVkvO9bdnCL2SY7iOWprNuwnfeQFDvcOVRg23Y5Y2S5mB4E5z6AgDE0cqc
         HzOK7FXK5hw9a9wMv97zG1sNXxIA6NVZt1oZ+dk2cMdc9ezAV/YIqu/AzALgFIjkMty7
         VAH9St4nixhQh/XhYAuyPkl63oBU/eBgesPvxvJpuN86IyDXVoMuGUGYdc5ygxRYPDrA
         eqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LAHotV5jxBt7MkoclI6019VDqfZoV/mWCIlD2mBS1hY=;
        b=PM8CAoJy3UuTIaNisFCnkTYWTHBHwPnv47muwEvbnjjIqvjpaUs3gq5C4bN9tccgei
         Vppbph7tfJXdQZhieTgNJlI4xy1th6WeX6FqoG0Dzrv004S7CbsxRokbaSPOi9TwUTZ7
         uS+/+4Ne2ODwiv0L851buVJXbG4NHCgDErtrzt35d1Pzyp3MDchPbItcR/reJnE4KC4i
         Uc0Fkhs03T+TAV/knn8StYnmmCFF1WXEecsPDR07qPJooxmSw6Kb4/tPJ/lPK7cPU3rh
         FX6q4mraSJjKsFKmK0zsfETH/Jalku+L9YcKPAtDyPpW+LnJESoAtzkwzi+c3TPAI8zF
         MQag==
X-Gm-Message-State: AOAM530cot+tjuuuWFJBTaMD9rjJGEoPrISEh72Pr0gsaGnROZcLI60j
        nO4W0pPhCDYMEl2yKQNE7HsU+eI/ro8=
X-Google-Smtp-Source: ABdhPJy5ysK++fVm0dsjvkLMoDyIQqXuTScqyCfprXIy+8d9XQWgEL+0qV5WZ8jdQrRV8/71WXLXPQ==
X-Received: by 2002:a5d:40c5:: with SMTP id b5mr5791527wrq.121.1612388045299;
        Wed, 03 Feb 2021 13:34:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm5026429wrt.85.2021.02.03.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:34:04 -0800 (PST)
Message-Id: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com>
From:   "Lance Ward via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 21:34:03 +0000
Subject: [PATCH] status: fix verbose status coloring inconsistency
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lance Ward <ljward10@gmail.com>, Lance Ward <ljward10@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lance Ward <ljward10@gmail.com>

Currently setting color.status=always results in a colored diff when
going stdout, but an uncolored diff when going to other files or piping
to other commands such as less or more.  This patch fixes this and now
color.status=always implies color.diff=always regardless of the output
location.

Signed-off-by: Lance Ward <ljward10@gmail.com>
---
    status: fix verbose status coloring inconsistency
    
    Currently setting color.status=always results in a colored diff when
    going stdout, but an uncolored diff when going to other files or piping
    to other commands such as less or more. This patch fixes this and now
    color.status=always implies color.diff=always regardless of the output
    location.
    
    Signed-off-by: Lance Ward ljward10@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-954%2Fljward10%2Flw-fix-status-coloring-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-954/ljward10/lw-fix-status-coloring-v1
Pull-Request: https://github.com/git/git/pull/954

 t/t7527-status-color-pipe.sh | 55 ++++++++++++++++++++++++++++++++++++
 wt-status.c                  |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 t/t7527-status-color-pipe.sh

diff --git a/t/t7527-status-color-pipe.sh b/t/t7527-status-color-pipe.sh
new file mode 100755
index 00000000000..88df03ae066
--- /dev/null
+++ b/t/t7527-status-color-pipe.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git status color option'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo 1 >original &&
+	git add .
+'
+
+# Normal git status does not pipe colors
+test_expect_success 'git status' '
+	git status >raw &&
+	test_decode_color <raw >out &&
+	grep "original$" out
+'
+
+# Test color.status=never (expect same as above)
+test_expect_success 'git -c color.status=never status' '
+	git -c color.status=never status >raw &&
+	test_decode_color <raw >out &&
+	grep "original$" out
+'
+
+# Test color.status=always
+test_expect_success 'git -c color.status=always status' '
+	git -c color.status=always status >raw &&
+	test_decode_color <raw >out &&
+	grep "original<RESET>$" out
+'
+
+# Test verbose (default)
+test_expect_success 'git status -v' '
+	git status -v >raw &&
+	test_decode_color <raw >out &&
+	grep "+1" out
+'
+
+# Test verbose color.status=never
+test_expect_success 'git -c color.status=never status -v' '
+	git -c color.status=never status -v >raw &&
+	test_decode_color <raw >out &&
+	grep "+1" out
+'
+
+# Test verbose color.status=always
+test_expect_success 'git -c color.status=always status -v' '
+	git -c color.status=always status -v >raw &&
+	test_decode_color <raw >out &&
+	grep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
+	grep "GREEN>+<RESET><GREEN>1<RESET>" out
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 0c8287a023e..1e9c899a7b2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1064,6 +1064,8 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	if (s->fp != stdout) {
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
+	} else {
+		rev.diffopt.use_color = s->use_color;
 	}
 	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
