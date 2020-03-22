Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B0AC43333
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066DF20767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB300qT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgCVA4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:20 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55420 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgCVA4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:19 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so4306072pjb.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Puwg0Ffwrrpv5BPlU/cmylL09IypWqP0r6DXOCzzGvo=;
        b=EB300qT4p4H1vsTw8pL4BOPy/RSeg47YAfMp/VtY3YWeZngYsgCO2f8guxXwn+yvsy
         wfWKeVgBOJD0rRwQntdOUwqfan+00g92yGEr+9//CAaXz+9XRXUxmayqmuH3hFD4Gk8b
         bO9VWzhPyMbiYkPQTMzjkJbz5mnGK7ECLg/Wm1ZDjs7X4zyKtBvtzm5BpxPBdM/7GSaH
         r+EYShOjz7rUjzFVF+YF38qU5Lp+71a0DdDCiGbfsvR9FIlpbqWClkTSBUNvQzgOZwWa
         UlIjpw2mFk5jtcrEIW1mGu4//DfKGvVz5R8U/dFU8wLTe2DOUwApNjoleMKrxRhYqDL9
         ImKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Puwg0Ffwrrpv5BPlU/cmylL09IypWqP0r6DXOCzzGvo=;
        b=hN1SfGvT2FgH9Gxqb6HJRUZDE7qT5Wy2+tqrBTbYBWeJL2IGoJ0856Ir1j6slFKlBU
         I3wcNVckf9oV2A3QGOH2fRH/khzbmSKVfv4JGnx59VbamRWDhAzcKiUvos7s9hyubVhH
         HrXLHsRwe6BNGMz5yJLrw32+xgZgZqocsHbIXa7yfbE6HHa+y0dR1cXC62RszhjkHNzA
         0gLSOu57zItm1/0oGojDaOQMZ4hHHooOdDbCYESmQJw9dK9X1w0rSSkxz/OdvAzEJ/Rs
         4sjsLW+Qbrm8cCGvg5xns9DXDWL/6icemUSwgFmL5o53EXpubafD9zCSi/0FTVhsUHye
         1wyg==
X-Gm-Message-State: ANhLgQ3vkr2zSvAEDbBO++l7YZib6Kms8lIo7rX7qGNQIkgTmOGm1pFg
        Ip0LfYgHuHpDyo+8NwHIVq7iElFq
X-Google-Smtp-Source: ADFU+vuCrbR43n/LP+2KCiHAiBkvyRFSzSoA4VzWdcVl4Avfr1PVYxcESTOvMF96x5J5khpgQ+QDHQ==
X-Received: by 2002:a17:90a:757:: with SMTP id s23mr17356454pje.166.1584838577998;
        Sat, 21 Mar 2020 17:56:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:17 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
Date:   Sun, 22 Mar 2020 07:55:21 +0700
Message-Id: <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX's diff(1) requires output in normal diff format.
However, busybox's diff's output is written in unified format.

POSIX requires no option for normal-diff format.

A hint in test-lib-functions::test_cmp said `diff -u` isn't available
everywhere.

Workaround this problem by assuming `diff(1)` output is unified
if we couldn't make anything from normal-diff format.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512..075b1912be 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -52,6 +52,12 @@ test_fix () {
 
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	# busybox's diff(1) output unified format
+	if ! test -s fixed; then
+		$DIFF file target |
+		grep -v '^+++ target' |
+		sed -e "/^+/s/+//" >fixed
+	fi
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
-- 
2.26.0.rc2.310.g2932bb562d

