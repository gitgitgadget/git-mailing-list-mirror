Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D96C388F2
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19A32224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZHab5Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbgJTRdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391109AbgJTRdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 13:33:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368EC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 10:33:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b8so4697408ioh.11
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut2RsDpSDAsMv66smQycxbb1pCCte+ahR8kQCOZEKss=;
        b=MZHab5Wpvp9dFc9Kxtk3Ah7osNMhUXzJZgJycwWQ60qxc762kZc0l40AL6yaX1T5d8
         HYKyQFkj5nHO0KDa94IOgETKHCx9tPhhqL0tnrMHBugozGowuI6tnq9KGiEWT4FuoVCV
         522fKqpuvdkFmy7vK5AeNb7ypREZ+PR1Q/o1/vLJhynxVqLj3kLyNaNBSTyd3inArWfY
         zpsuk1sI+6q1Tkcg0KMt86IsMXMtbJ5xI/LH8ehjkLnTarLjraBzkwv6RlD1KkTxJh76
         Kud3aEYNt26+qCWF29P3EA/d4Ogm0zZILAO2qH9QqGpUAi3fgHf4DAnMzvKtbFZhpn/X
         Vwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ut2RsDpSDAsMv66smQycxbb1pCCte+ahR8kQCOZEKss=;
        b=Oy7X/oH9vop1cz4Mfgs8WY5GkMNhgQm+v0RqiHAGWnUXbaUgl1oxkT8Ihny5LGem+C
         2fvk2wC0g/36VzIFJRIKa4a7J97mKADhgqd9gfYCus+9O6jmUMeetvdn6dqbo8cAiOvh
         26x7UDe1gm+HD6/LDwJztp+9BwuCNFC5Pq/4LZHtHtUviBqJ0JkrDv0gdge6GpFWGos+
         ZsWI9+roDCUgmL2ULI4fVhbj5vbiXfndVZdRW3bRPVtO1fAnBCvYYDOFfw+ZaaKazO4D
         76aZi7tA3EPCwnONGYljKSJo5I5q4ug4AIh8ByJ4cpK5g7eITzTND+SLAZIebIlfNbJN
         OX5A==
X-Gm-Message-State: AOAM532NfoGe3qGjgi5emwy3fVCxMMV/5yU70LNcijbacIOGZHWrYxGu
        AclmLZPI79XNZlo0cpboBlVUMxUZ94tmig==
X-Google-Smtp-Source: ABdhPJwls9f/Ax/3uf7R2mMZIyFnueWO1avb6riJQy19+jmsMgdX199oTiQQZYa7O960Z+dfI6CMBA==
X-Received: by 2002:a6b:1d8:: with SMTP id 207mr1092552iob.51.1603215198853;
        Tue, 20 Oct 2020 10:33:18 -0700 (PDT)
Received: from localhost.localdomain ([45.56.140.65])
        by smtp.gmail.com with ESMTPSA id t24sm1000730ilk.57.2020.10.20.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:33:18 -0700 (PDT)
From:   caleb.tillman@gmail.com
To:     git@vger.kernel.org
Cc:     Caleb Tillman <caleb.tillman@gmail.com>
Subject: [OUTREACHY] [PATCH v2] t0000: replace test -f with helper function
Date:   Tue, 20 Oct 2020 12:32:57 -0500
Message-Id: <20201020173257.80525-1-caleb.tillman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Caleb Tillman <caleb.tillman@gmail.com>

Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..eb99892a87 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
 test_expect_success 'git read-tree followed by write-tree should be idempotent' '
 	rm -f .git/index &&
 	git read-tree $tree &&
-	test -f .git/index &&
+	test_path_is_file .git/index &&
 	newtree=$(git write-tree) &&
 	test "$newtree" = "$tree"
 '
-- 
2.25.1

