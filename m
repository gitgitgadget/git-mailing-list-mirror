Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B20AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5F20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1RgA5fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZEiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:38:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38015 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZEiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:38:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so1677091plz.5
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXFkQCxgV67GKYUGkCOuFj5VYf9wtYc8izZaL3zZ1H8=;
        b=d1RgA5fjUZ5T28ZPMuJ5PRthQmgL8jTt5s7cbDKYxA2TyQV2ob4g9S/TH+3qHXN/Hd
         XHkETEGCl+nqsW6VpLcFCT02Qr2+kHjLM40TNbsoRud+UUTrPofVxbHL7FqRoYeYgKYR
         V5FV3QF334lBKTTxp/UIs+seWw6NSUFqc4zyLNwlWnTScsWkmW+Q/Las9Om6MrN98Rjk
         RHDx65I+JJiN7Jsb/kHN4B39kYaKnRaG4Zq11cD7qg+Is3/kzbOJ9ddC1rMg8ezZVXEv
         PI36SKraQBLW/VpW3+rUOsIb6EH4eGwKk01JAzEJr6O/cbQUjad11HA9TB7lD+ThWwzK
         kdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXFkQCxgV67GKYUGkCOuFj5VYf9wtYc8izZaL3zZ1H8=;
        b=StDF9pxkSHnU4kwKadfGJbjx+Z+jgbIVzvQEs2sCy4P8pjUKbY1gVIsPWjW2s2I9re
         xHdWM/7x6C1ClxGAh+cYLvJJ0IaHdHzf9niKNHRNRURRgph1enscQGza3sc+Q3lCc9yI
         q2ZsAFE6m0NW9yNs84txjHMgIxbL00KC06ytN8rObTwtemy8k4ugLYzvB/Hr8UWMA85E
         /9ObF1patbMcJTAhnUOU6T5VHWImOH4bKhHTeiFAO+KXIRVCR6HJ27Kg78xwjmrSNUap
         FS3MWd7GUY6EoLP90urvCx3GbDGn4bK16FIB1eRD4CuresnukxY43JTAjEQG9iG0y99n
         RL3w==
X-Gm-Message-State: ANhLgQ2kC8jCyhPB1BTqD6Ghl0QNY3ayZbZ6Muw8A/v3RkQ7SW07mXY2
        vdbAeJpPrZX1spDsDVWhmMok9YJM
X-Google-Smtp-Source: ADFU+vvoJvf1a/Y41r38d6tcHF4gVwTm9rY2F6PNwfapBgEhxOe/BNpZxFm24xf7UjxnAdpDoLVV5A==
X-Received: by 2002:a17:90a:1a51:: with SMTP id 17mr1056171pjl.118.1585197478892;
        Wed, 25 Mar 2020 21:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:58 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 7/8] t4124: fix test for non-compliant diff(1)
Date:   Thu, 26 Mar 2020 11:37:37 +0700
Message-Id: <02c115e93aa27bb0a8ebfb65a69d12b4cd26fc9b.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX's diff(1) requires output in normal diff format.
However, busybox's diff's output is written in unified format.

HP-UX's diff(1) doesn't understand "-u" as of now.

Workaround this problem by checking "diff -u" output,
if we couldn't make anything from normal-diff format.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512..4a1bb141d9 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -52,6 +52,12 @@ test_fix () {
 
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	# busybox's diff(1) doesn't output normal format
+	if ! test -s fixed; then
+		$DIFF -u file target |
+		grep -v '^+++ target' |
+		sed -ne "/^+/s/+//p" >fixed
+	fi
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
-- 
2.26.0.rc2.357.g1e1ba0441d

