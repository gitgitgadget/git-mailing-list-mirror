Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A8C2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5920882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLUFQBOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0Nrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:51 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39505 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfL0Nrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:48 -0500
Received: by mail-qt1-f180.google.com with SMTP id e5so24592942qtm.6
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kPOpJyjIKUzUQI4LPwLVu83SnmiHvUZrpJR9Z+MuXqM=;
        b=WLUFQBOQnHrFtiyfqtBInaUWh1U0fJhu5oauN5byL04lVYGlGHlnpXUSjbDViD3mq6
         z4kB9OjEZlNcCqTNRFxROtyn/eH1ErHbQu9t99WJ3iG2ZkONYByddYE8r+B8UAXlcwDn
         SvFadntmY79z1DbGL8A/DK8AUorNWPXB+DwLzJiGLRdZaHOk5EKv27UlRHprkXMq4PCe
         42NAhK5TLqs085CoyO+GfetqUtCvU+6KrcVrwOsbpz89aJntrf8ezXXJMYI1iaJvRCsO
         AXdQxPRE48Me/jh7FnO/kI674uzs4/gvFVukd/XziL+ORBd3ua9SQe5CZyBmXpqQn2T7
         sgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPOpJyjIKUzUQI4LPwLVu83SnmiHvUZrpJR9Z+MuXqM=;
        b=tpUYmCr7pfyT1sSIcXowLo7Py85rClo3jJVal3xg7OjgL4vGxLHngtZzptFKwyMPTS
         1aKmeQIy4DiaPjTSJ0tYXLq5FGRSP5GJOdt9xC0mcYuCC1BUndB8y28gOB7tI05ueE6/
         OfOq+YnPyWFrpQyCDTAlCqGW64xMD9xCwH5fHxCeY2b8oLJwlbIwp2ZOW5poU06+ORfr
         6WXb1sWpKRENS0yS0PE7RGP8igJRYWK1smk2Wmwt38LwwbIzxkBvKlhij2ugU4Mk0WX9
         cB+wUNMBFlfETc/8Svlfqa2BLC0PI0Sv7GuZEfGTRlMecv5YA4rGA7+JIx+PHCjYACXU
         Xk/Q==
X-Gm-Message-State: APjAAAWNxeN+BVqIQMRQ8MvdxOXKScw4Gde8ioL5Bg5SubIQVGanGdEM
        7Q2nmRRC3PlxV0Tg2I0L3l6r6YQh
X-Google-Smtp-Source: APXvYqz+xFx0MwCkeXqDzAXGbPdLE/beTiw7a4k85mgIt2r629v5JwL1WrfmX6GWNUbdEzxpZcjeRQ==
X-Received: by 2002:ac8:5357:: with SMTP id d23mr31975640qto.76.1577454466909;
        Fri, 27 Dec 2019 05:47:46 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:46 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 13/16] t3507: fix indentation
Date:   Fri, 27 Dec 2019 08:47:22 -0500
Message-Id: <0cfc46c5fd0c2a391de9185fe215344720e4413e.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had some test cases which were indented 7-spaces instead of a tab.
Fix this by reindenting with a tab instead.

This patch should appear empty with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 9b9b4ca8d4..2a0d119c8a 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -381,23 +381,23 @@ test_expect_success 'failed commit does not clear REVERT_HEAD' '
 '
 
 test_expect_success 'successful final commit clears revert state' '
-       pristine_detach picked-signed &&
+	pristine_detach picked-signed &&
 
-       test_must_fail git revert picked-signed base &&
-       echo resolved >foo &&
-       test_path_is_file .git/sequencer/todo &&
-       git commit -a &&
-       test_must_fail test_path_exists .git/sequencer
+	test_must_fail git revert picked-signed base &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git commit -a &&
+	test_must_fail test_path_exists .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears revert state' '
-       pristine_detach picked-signed &&
+	pristine_detach picked-signed &&
 
-       test_must_fail git revert picked-signed base &&
-       echo resolved >foo &&
-       test_path_is_file .git/sequencer/todo &&
-       git reset &&
-       test_must_fail test_path_exists .git/sequencer
+	test_must_fail git revert picked-signed base &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git reset &&
+	test_must_fail test_path_exists .git/sequencer
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
-- 
2.24.1.810.g65a2f617f4

