Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFADC433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3322207
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWTsX2nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIKS6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:58:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9CC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:58:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so8689625qtr.8
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2efNNMn8632sD5wnAAQAeApVS+ZA5q3qLYJIQrO7fA=;
        b=RWTsX2nfX07GDpo7Bfy1SZlaBacJ60Xit7hEH9HeNUJoGxlVOs1C7eK+Q7/oL+kPiT
         HEIaOAIPogXQYhxbtPqJxRiuz3bg7jkOzBo0s/DrsPWZvXWM98XqK8xvnymIiLye6TkX
         swypsVaUP+q/UCEnIjM4Nqn3vHsMpiFnK8SidKbu72USIx9ZC+QMAkF1PaCQkJL/D6Vn
         MAr9Mj2UxJFSZsHUPDjDE2Q43YYDwPh5adD09LXGty1+GYQpynZCEGK0mLuVlAokZEPr
         cfsMqgXp8RSu6cItJpynJGfWqg/P2zvYqBcWW7h2R6L5VMymj0jEHerizXLzIk8lP5Np
         8RuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2efNNMn8632sD5wnAAQAeApVS+ZA5q3qLYJIQrO7fA=;
        b=lOLqdi7TZGH3sB+QnN3MqxYMECuUeDLd5FJTE0bYXTIdFH0OdrfwblgUS/rXAb5+Xj
         kNnQa21iOl0uerIuTF1QRsFZHLyTCRzjxWmRl2sSKi3oJpPwwEa4C625NbsL8PJZREtV
         NxFHVwDc52EE1Uv6DiXQpkMHx9W0/QwGK/jthdxR61E2VdI8QVWei5niDirX/PqPymIm
         o3/c3ZuasNhG9zfOukf2CWm5BfDgatc7e1nus0bq4+JO0E4M7f8gqSFLJksQm+YfysDE
         G8G/eB4XA40RluxM6znsCMMq9ypsunbXpg050f2JliwVhNdYuv6ts/OnVSu3AIRFJj0m
         iAVw==
X-Gm-Message-State: AOAM5320eaTJQmA6L8km+dkXKr6Xhmo2AAzWYzuy1D8JSE4Ek55G27ln
        gMCi3gzPxqRNTqPgFc6ZXCm1Vh4qsckJLw==
X-Google-Smtp-Source: ABdhPJxKYeM2Kk4IwbQ8JpxaKHcKMzgE+kAc7vUw79ul91DvjlytjOYSzFUFBhCM7p3FR2QHTnRlzA==
X-Received: by 2002:ac8:f57:: with SMTP id l23mr3377421qtk.166.1599850697094;
        Fri, 11 Sep 2020 11:58:17 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id u46sm2181008qth.31.2020.09.11.11.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:58:16 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 1/2] t3201: test multiple branch filter combinations
Date:   Fri, 11 Sep 2020 14:57:53 -0400
Message-Id: <20200911185754.64173-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200911185754.64173-1-alipman88@gmail.com>
References: <20200908153759.36504-1-alipman88@gmail.com>
 <20200911185754.64173-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests covering the behavior of passing multiple contains/no-contains
filters to git branch, e.g.:

$ git branch --contains feature_a --contains feature_b
$ git branch --no-contains feature_a --no-contains feature_b

When passed more than one contains (or no-contains) filter, the tips of
the branches returned must be reachable from any of the contains commits
and from none of the the no-contains commits. (This logic is useful to
describe prior to enabling multiple merged/no-merged filters, so that
future tests will demonstrate consistent behavior between
merged/no-merged and contains/no-contains filters.)

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 t/t3201-branch-contains.sh | 44 ++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 40251c9f8f..cd205b5560 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -200,15 +200,51 @@ test_expect_success 'branch --merged with --verbose' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'branch --contains combined with --no-contains' '
-	git branch --contains zzz --no-contains topic >actual &&
+# The next series of tests covers multiple filter combinations
+test_expect_success 'set up repo for multiple filter combination tests' '
+	git checkout master &&
+	git branch | grep -v master | xargs git branch -D &&
+	git checkout -b feature_a master &&
+	>feature_a &&
+	git add feature_a &&
+	git commit -m "add feature a" &&
+	git checkout -b feature_b master &&
+	>feature_b &&
+	git add feature_b &&
+	git commit -m "add feature b"
+'
+
+test_expect_success 'multiple branch --contains' '
+	git checkout -b next master &&
+	git merge feature_a &&
+	git branch --contains feature_a --contains feature_b >actual &&
+	cat >expect <<-\EOF &&
+	  feature_a
+	  feature_b
+	* next
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple branch --no-contains' '
+	git branch --no-contains feature_a --no-contains feature_b >actual &&
 	cat >expect <<-\EOF &&
 	  master
-	  side
-	  zzz
 	EOF
 	test_cmp expect actual
+'
 
+test_expect_success 'branch --contains combined with --no-contains' '
+	git checkout master &&
+	git merge feature_a &&
+	git checkout next &&
+	git merge feature_b &&
+	git branch --contains feature_a --no-contains feature_b >actual &&
+	cat >expect <<-\EOF &&
+	  feature_a
+	  master
+	EOF
+	test_cmp expect actual
 '
 
 test_done
-- 
2.24.3 (Apple Git-128)

