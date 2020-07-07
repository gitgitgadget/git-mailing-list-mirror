Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B513C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3EF20771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBRR73K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgGGTX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGTX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:23:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12768C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 12:23:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z2so24172405wrp.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LWymT1UxS7Geei2Lb4usYh+gmTylkBIZHgDyp++OeVU=;
        b=gBRR73K0vqDL3nlrRKAV+BBX19MJPSqEf+aKMfkIRMuylpAjR/k/2+OnnykLIfV+P5
         +ubRWF8vWnjZXuWAs6IfAGnRrud5zOC/QKpzRWs+TXctApuvcxwMQfJLULZcLUks+XYZ
         JWuwfVjW4EmNcIgiZ1kalixnGY++PAErwW0YwL3o/OlB8V50dQDUBwqN6UqD1THJK3ag
         h2o1LhsPGxreaUl0Vn23Urr5CwxbhphHbRt1sbsrnNc5S9qPar/mBeALmc3ABcerKky6
         MgXo9EXcR5C2lEBRP2ILusUgXdpnru+NumM0jqSJ4zerVVrba++AgR/QIuVqxFy9FWXP
         WzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LWymT1UxS7Geei2Lb4usYh+gmTylkBIZHgDyp++OeVU=;
        b=ewkpQ/XuXP9rt2wvO8nYT1iV+mnKZph4w/Pk4nRrlmnYvBbYqOWpZgtbfK53re+JFE
         8hZYwYtzfpmvIFTslg+4pW343MFPL+94+Jsnkx2E5zUiF34K/AdZbdaKGSgHgaAQP9y1
         J+QB2bqwu66YY+88YRoPGeLBCUTRlO6nGWFG1YSZ7StVF2lqP0ZLPw1DdktbMDa/vLWi
         QkAeQ5JSIczItyMx2OFVKZpkUh0NtzlrVtGKT6ATKPuFw9SGev5ojk9xPl6jjMfj93N7
         hK1NT9oCsQ1JD+Rbh0NGQXfgJ7in5CStIY0zYEK8Ik6WjKZ20XSXjX8TzkMEti6dnDKi
         u0Vw==
X-Gm-Message-State: AOAM532TSIURfHHBgKNwJZmXhPvX8zPAAZDqJhB5iR8nFMqS/MTCNYI5
        kV1CaHuk8/n7mRzbXijVyZ5xAk+M
X-Google-Smtp-Source: ABdhPJwNWqgr61PWWNanPDR1MaMFjYBe5+eznMsDeyh8+qv5CW3ha6CCsbO+lOm+w2hUnO/JI2xLmw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr54232276wrw.405.1594149805493;
        Tue, 07 Jul 2020 12:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm2238912wrm.21.2020.07.07.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 12:23:25 -0700 (PDT)
Message-Id: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 19:23:24 +0000
Subject: [PATCH] Make some commit hashes in tests reproducible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Adds test_tick to t5801-remote-helpers.sh and t3203-branch-output.sh

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    Make commit hashes in test t3203-branch-output.sh reproducible
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-816%2Fhanwen%2Frepro-hash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-816/hanwen/repro-hash-v1
Pull-Request: https://github.com/git/git/pull/816

 t/t3203-branch-output.sh  | 2 ++
 t/t5801-remote-helpers.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 71818b90f0..6b614739af 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -4,6 +4,8 @@ test_description='git branch display tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+test_tick
+
 test_expect_success 'make commits' '
 	echo content >file &&
 	git add file &&
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 0f04b6cddb..de51584173 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -22,6 +22,8 @@ compare_refs() {
 	eval $fail test_cmp expect actual
 }
 
+test_tick
+
 test_expect_success 'setup repository' '
 	git init server &&
 	(cd server &&

base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
-- 
gitgitgadget
