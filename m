Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE676C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 17:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiCMRke (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCMRkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 13:40:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282F1EAD1
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:39:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so10574415wms.3
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KpnMqio74vfQyIDeUJkIa4t8XycTwlTSK1lkJmzrR38=;
        b=dJHQOr/69C6OU/b1fyndUOB2fyGAvU4U4Fa/QUiPGLaskJ3DMKrhSrSuUft8FgHHEi
         q92RQbJaf2rszKdVLRp9oT4fy25OxOMi6Q7glpmYli+/InMbut0dW0paD0zn1LRFooWg
         E5WUfT7vOrASp4XgsqTychJuc6IUXbX+DEcKQB/fS9p/3gUosKTMoWRWgqfByVAQ5kiH
         uBTrH3sfdiTuWcroMHIid/1ITqq9ENcPEkSZ0P7tuKxPahQKor41ax9BwvmBIMLAgd97
         /AUa0BOImYec5K67btsss0AqAKKhB2fjJaJZhWrw7iA4YpwEmQ9w1npZO//dPDVq5U2t
         FWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpnMqio74vfQyIDeUJkIa4t8XycTwlTSK1lkJmzrR38=;
        b=fXZOylXY648IlBzlcJrCLmYxyZEHSchuoEyGcAyYHTgQyJAZf+ZA4iLlUk4lDoNJOg
         qkzw/i2r3i2XlVkDwkWSPRqJCVjBjGhmRzo9wzJ+TrVFBH7n14kMqNrnpru49B/Si5rT
         aSJVqv62H5dtIcvZB0ZdaPhpZs1bAvggzPt0bGkDwlloAgneH4+flVwJ+kDot85wQvx/
         cTQIZnY2kBMqWub9dhocQ8DtOaoHTr8UJdikCizEP6PegmsJHNC+SISHwapT3wUEblXs
         O3Eb0eBg1WhCWoG36TtjCM+8G9Xsu0xzzlLbVTY4HS/sj1q+LNpbhdJmGJKdUNlAesvR
         6kKg==
X-Gm-Message-State: AOAM531wRZAmBYHFQk738lQ2nFLEf1UeakakjqQ4NdJOLydGzkkIBt9r
        LRdYwDBZhVS0/hzcB43dGoD4cFJcrao=
X-Google-Smtp-Source: ABdhPJyDMBmx3eP3yN/Vm9vPiIBSy+Ou4s0wV6+O4mDqkQtjRien5uxUpAc3bvChg0vrAi9WUGPZZg==
X-Received: by 2002:a1c:f607:0:b0:381:1db:d767 with SMTP id w7-20020a1cf607000000b0038101dbd767mr14249741wmc.165.1647193163579;
        Sun, 13 Mar 2022 10:39:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm12801141wmj.34.2022.03.13.10.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 10:39:23 -0700 (PDT)
Message-Id: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Mar 2022 17:39:22 +0000
Subject: [PATCH] partial-clone: add a partial-clone test case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

In a blobless-cloned repo, `git log --follow -- <path>` (`<path>` have
an exact OID rename) doesn't download blob of the file from where the
new file is renamed.

Add a test case to verify it.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    partial-clone: add a partial-clone test case
    
    Fixes #827 [1]
    
    [1] https://github.com/gitgitgadget/git/issues/827

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1175%2FAbhra303%2Fcheck_partial_clone-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1175/Abhra303/check_partial_clone-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1175

 t/t0410-partial-clone.sh | 16 ++++++++++++++++
 t/test-lib-functions.sh  |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index f17abd298c8..1e54f4844fd 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -618,6 +618,22 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
 	git -C repo cherry-pick side1
 '
 
+test_expect_success 'git log --follow does not download blobs if an exact OID rename found (blobless clone)' '
+	rm -rf repo partial.git &&
+	test_create_repo repo &&
+	content="some dummy content" &&
+	test_commit -C repo create-a-file file.txt "$content" &&
+	git -C repo mv file.txt new-file.txt &&
+	git -C repo commit -m rename-the-file &&
+	test_config -C repo uploadpack.allowfilter 1 &&
+	test_config -C repo uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -C partial.git log --follow -- new-file.txt > "$(pwd)/trace.txt" &&
+	! test_subcommand_inexact fetch <trace.txt
+'
+
 test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	rm -rf full partial.git &&
 	test_create_repo full &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..07a2b60c103 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1811,7 +1811,7 @@ test_subcommand_inexact () {
 		shift
 	fi
 
-	local expr=$(printf '"%s".*' "$@")
+	local expr=$(printf '.*"%s".*' "$@")
 	expr="${expr%,}"
 
 	if test -n "$negate"

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget
