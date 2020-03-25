Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B37C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09306207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWwOUBbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCYPHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:07 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36884 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgCYPHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id o12so1119089pjs.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t63/UhT/gtLGb/Ao3dygwoRGY5JKv05iSZs41QQOZMA=;
        b=aWwOUBbv71QrDdSlCwEIp7u+003QdjaRqsJxxlgxmYtUKmBagGo4uRHh8OLWKFFaM/
         3/76xzL458si/9qBQav01Ti2RFbuHPzJXVLwSAkD4rmwtrOdlqQiGQfM2dHle80GpsqF
         1qbNbZgN3C+UzhqZ8lpQPRLGGtEY9qS8HG686EpsZlX3iCBQ4FetRWtjILXV3/N2NHsC
         C1J+ug9lNzy08fMgi+QFDlemNWwPxVJoCTsAQacnBjGnct2OGvGc2M3BhgFqOVXp1Mk5
         ApYHBbyJxbKIxUFaRrB05pqieXDSxm0SUQJNzxH8f1uBmmn885OIb9Fb9Svcir2TX+ML
         P4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t63/UhT/gtLGb/Ao3dygwoRGY5JKv05iSZs41QQOZMA=;
        b=YSpsoHtRCEWX8y6oKz10gF9CCBc5dgVZf7VfBdA0GRuzt3RKpIV0uBwRcIX6k8h3gQ
         WbccIA/nrE8Z5VqrHtzQkQLZ+e1GRNPfbhOTUOosZrBqOb46QeDJhLTL5F9hUuJuLCS4
         JQblDUlmw0RpVcUsSFrkLKi3PmBSrhP0krmXHbkrDrCTT2prYAihB3WuVNV+sc8PdNUv
         TGWfV5ZEAe5AlnK+y4pKmxO+Hbjf0Qf/kRe4ZWBHc0K436++Nc67wn8ewozorByUGBg/
         KejD0q8xrBA1yDQx9p6AJbj3g09Bs5N35b/Ir1Uvr28drNq5rKyugSI2SaVeM+F7rl6k
         sZLA==
X-Gm-Message-State: ANhLgQ3LGfW9d3BADbc4qMYSTV0pIOvQj8RoHFJOuwpm8jU3QbwpNH+i
        MAvKvIkstHzkY6fUM5TiJ3fDYS5f
X-Google-Smtp-Source: ADFU+vs6OXFRVrPkQOkW0cEx+dciULS90sqs3b5vvlQvOeYgJXqBNdMRIAeIrD2aw/2O+e+5sLpmRQ==
X-Received: by 2002:a17:902:8542:: with SMTP id d2mr3727126plo.200.1585148825190;
        Wed, 25 Mar 2020 08:07:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:07:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 7/8] t4124: fix test for non-compliant diff(1)
Date:   Wed, 25 Mar 2020 22:06:20 +0700
Message-Id: <0502171f0fc25a44e865b5a435906ef1096546c5.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
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
index 971a5a7512..691f82da9f 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -52,6 +52,12 @@ test_fix () {
 
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	# busybox's diff(1) doesn't output normal format
+	if ! test -s fixed; then
+		$DIFF -u file target |
+		grep -v '^+++ target' |
+		sed -e "/^+/s/+//" >fixed
+	fi
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
-- 
2.26.0.rc2.357.g1e1ba0441d

