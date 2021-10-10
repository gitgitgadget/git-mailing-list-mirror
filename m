Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C9C433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A1860F5B
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhJJRaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhJJRaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:30:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E085C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:28:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ec8so8252530edb.6
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au5RX/YZAnT05mHuqJM4Jd8a2imKl/8LWIBHXdiVqwE=;
        b=DW4HJr6qV6la7jScxKH+1tBUAmW5M7HqdbTwEpw/aa0PhqWoUCZOa+Mxies4uIVRFA
         DDqPWYY2CK8/ZeMicemE8eRS3huV8HsYnQEEMv33copzaSukALaZ1MygOw0RVIgTw+Xt
         CcWEgmNZI/aEK3NxOD5JYcz3BduhxAznm+Xfhbft6HRCfSEMWXbRl2IMPOkZ+C9MwHUo
         HPqPCzzfcO+hIwhK2h81H9hCcZtMxtEEYn+I0qjoFXDPAekQvQc242CjGrDKot+MOhag
         lx5x8sjZhrmA0KmPFouE4ZzOuvJJNxhY8M/D56PxjebDzCMe+GTdkAuNqK5rT7EnsWPd
         l65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au5RX/YZAnT05mHuqJM4Jd8a2imKl/8LWIBHXdiVqwE=;
        b=7Q/Agj6t2gwzraVI8QABD6IAQe+5Lv687SK0YQzj/0MT5lzAV2NoOBGze9X97v8IvL
         W5QRYjYYlJ6tiSmHnVpCzO65wQcsRUBSr+oADPJVu2HfBCh6Z0GQdmHobZk81xl1yQ/O
         5a1W6OIeAGSRPe6mMgAgpaelFqO3LGgAhoKMtcFb6L9agIOOncLApZ03VEhZoPvIhJMB
         2Zy2+yTSnY+RFkiQGaKdLSeD2WUD/uBlKr1A0D/8PL/WxxoddebgDGQpoOij9PrP83qe
         znwLfOJeA71JQIbT2FcIH6GqMDbd/suJE+BqppzyDoFCSbBrV1zsHnk9OTdwy+UMGzLL
         BTSQ==
X-Gm-Message-State: AOAM530hRt6XHHwLE5kRMY0BDYHHOx409qE9PTPrbCYSpnVhJOmSe1LL
        hr0XcdkFWoeg3mEvi1FRYZtFOkPPKPc=
X-Google-Smtp-Source: ABdhPJx0KMrRgNOe/Qh+Zee7sJQAqGzb5USKfbq/CZTKa4yZGmhkGY9U67uv6rbf4LHqgaqx7/dKhw==
X-Received: by 2002:a05:6402:3586:: with SMTP id y6mr1410674edc.292.1633886898028;
        Sun, 10 Oct 2021 10:28:18 -0700 (PDT)
Received: from localhost.localdomain (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id r3sm2353070ejr.79.2021.10.10.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:28:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t3420-rebase-autostash: don't try to grep non-existing files
Date:   Sun, 10 Oct 2021 19:28:09 +0200
Message-Id: <20211010172809.1472914-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.1279.g1a260bf8c2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several tests in 't3420-rebase-autostash.sh' start various rebase
processes that are expected to fail because of merge conflicts.  The
tests [1] checking that 'git rebase --quit' and autostash work
together as expected after such a failure then run '! grep ...' to
ensure that the dirty contents of the file is gone.  However, due to
the test repo's history and the choice of upstream branch that file
shouldn't exist in the conflicted state at all, and thus it shouldn't
exist after the subsequent 'git rebase --quit' either.  Consequently,
this 'grep' doesn't fail as expected, i.e. because it can't find the
dirty content, but instead it fails, because it can't open the file.

Thighten this check by using 'test_path_is_missing' instead, thereby
avoiding unexpected errors from 'grep' as well.

Previously 2745817028 (t3420-rebase-autostash: don't try to grep
non-existing files, 2018-08-22) fixed a couple of similar issues; this
one was added later in 9b2df3e8d0 (rebase: save autostash entry into
stash reflog on --quit, 2020-04-28).

[1] This patch modifies only a single test, but that test is run
    several times with different strategies ('--apply', '--merge', and
    '--interactive'), hence the plural "tests".

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3420-rebase-autostash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 43fcb68f27..bbe82d2c0c 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -200,7 +200,7 @@ testrebase () {
 		git rebase --quit &&
 		test_when_finished git stash drop &&
 		test_path_is_missing $dotest/autostash &&
-		! grep dirty file3 &&
+		test_path_is_missing file3 &&
 		git stash show -p >actual &&
 		test_cmp expect actual &&
 		git reset --hard &&
-- 
2.33.0.1279.g1a260bf8c2

