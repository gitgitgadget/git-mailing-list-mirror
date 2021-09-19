Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07DC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F195060232
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhISB7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhISB7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:59:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACBDC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 2so12348431qtw.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejMSf+qftt4yFNenbBF0xFEAOcAsqGiVPYO0OGTJgac=;
        b=Icdo4XjPRia3zrkPVC74OBA7AgtpRbbayjBfuJLDHq85pMMMn8Z44OuXN+5xsYKADS
         Vi3R0Lyq6YlMfisB52volTu4ZkWnlmkPfhNNZA2XmhHOOEgDU2DAiewE9hjASYY+RXPi
         Ig9O3eraC/CFqM4edHhA6LGh2q3+pGE8zPrwW0Ylj3VFdw2Cqn7zhxW3erHpCl/8lwAK
         dwpVbDwqolvFstkVTOZSbn8ztPEA0VKoQoKHy5/HFmC7fyX7XE53D13UC7v/n81cvceX
         iJBcRfEkuFOx0opTG0ZPIWUyW21F/j+bSl3j1+VnBd+3KfjHYh+3Hz8BvhUkkiLuWv8n
         vQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejMSf+qftt4yFNenbBF0xFEAOcAsqGiVPYO0OGTJgac=;
        b=bYyC8zqWSTnQC/OQSGbVKPFXxKK9mgShVf5a5BttxVttLJaQp1aKBcg3jlDxpNOJ73
         AfsmjuiF8oe54hTOIYNIv+QedUjIxN7RMM6XFkIvBd2MBHNMUf6/fqhhNrVcYeS5A8UW
         EL7pZnS7A8cVhu/EshJiXCTIsqIWHn74MNBdnpHl03Nw5eo7WL4BKswwLSB7Ol4nw7yn
         0M8ra1PkyKULT4EoQN/S5n0PPwa4rPfUB5/QfqadaOVrDISbHBhZTFHzJq5GVYdMvjRC
         bqpYteZPvSGeHEmMF45CVzcJDijZ2H19bnBPcXaCrs/sOEFLBXEmhTOFcZJv1J8xFl6j
         T9zA==
X-Gm-Message-State: AOAM5304GSuap5QkNA9MHYleA+FnNn7y8oPa37MEf0KNNBtOx/KKFN2/
        lmozqwfd+7Ed7ZwyFZKbt4U=
X-Google-Smtp-Source: ABdhPJwaHz5/1t9I+oHAkdZCi5h8LGK3jZkznjrJW46JF8dCI/SNiJSnLQQbBSygv2Z//busMDCqow==
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr17496773qtx.282.1632016652203;
        Sat, 18 Sep 2021 18:57:32 -0700 (PDT)
Received: from sarawiggum.attlocal.net ([2600:1700:5d80:a320:4412:822d:c222:aea8])
        by smtp.gmail.com with ESMTPSA id k10sm6759062qth.44.2021.09.18.18.57.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 18:57:31 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/4] t7800-difftool: cleanup temporary repositories used by tests
Date:   Sat, 18 Sep 2021 18:57:26 -0700
Message-Id: <20210919015729.98323-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "dirlinks" and "growing" repositories should not outlive the
tests that use them.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a173f564bc..a923f193da 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -414,6 +414,7 @@ test_expect_success 'setup change in subdirectory' '
 test_expect_success 'difftool -d with growing paths' '
 	a=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
 	git init growing &&
+	test_when_finished rm -rf growing &&
 	(
 		cd growing &&
 		echo "test -f \"\$2/b\"" | write_script .git/test-for-b.sh &&
@@ -646,6 +647,7 @@ test_expect_success 'difftool properly honors gitlink and core.worktree' '
 test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
 	test_when_finished git reset --hard &&
 	git init dirlinks &&
+	test_when_finished rm -rf dirlinks &&
 	(
 		cd dirlinks &&
 		git config diff.tool checktrees &&
-- 
2.30.1 (Apple Git-130)

