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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE08C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B745120789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnyYFsVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCYPHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCYPHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so1160339pfn.6
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igWZKJLHsdQCZWYAe97MD1rG+bYewy+UxY4h6xDz/cs=;
        b=gnyYFsVHnGd8IfwuE0T5jipMk6SfsB5km/d9b2bV/6VNIaO9GKf2R9CHFv76PQTkEj
         0ZxwR2uzqvW/k5nYVRpp+W3CW47oKI3N1JSsi1tehZEFu15XPWwHnvZnbNSkE+r62ejg
         gafsPtSoeI0skBm3wEXUzhtVxybcZEXBN0aqTnkTS8gVuFaQZ7nTdqvttdkvV8M0/3tx
         eQeMr25/lwdWqCC/nNh7/5TY0jWTXCDPvvdAiP9t3IyQkEqW0aO65Arwdrx1NNGek8vO
         xwb+Yh/gC7ciZY45qIwAMqT4M7hWk6+FOUzi/zmnVH9YAqf1sU7iXBX0WvQjkZTOPYks
         zUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igWZKJLHsdQCZWYAe97MD1rG+bYewy+UxY4h6xDz/cs=;
        b=Koa/4pkOL0dD2sHLgSJGbwbOCpnRa3yGFIpgnAeFXSQZFz6yOxl2vS/GXPoITxMfOH
         MD0o3waOviA9Ler2fXpSvw80ucrfw1sG7kzWsQea4m6M5YNxgt1b5Qfuf4KUov5nJgvu
         Lw5QDmdkaJzJUyEnVdHYwHGTedyF8lvuCNQj8XLzwBqPuAIGcsUeoENPqmGdfmxgz4jI
         /Sm3QF980avjvhMuO1Z81K0EtWbmIu1xDoNvyzfadnv30qAAbm9vALoA6x9EIxaQ6p0g
         py4fwRJyBbZ5NUEZRPs01n4ECudgb94CPyJqq1FGImpTAzwW4X3B9UMFhtCCxns9ne3Z
         rUYQ==
X-Gm-Message-State: ANhLgQ2LH9bKkD7nbediTdusrlMtptbYgjkJncf0iiuU265+/DhOlVtg
        ugUDhXJyu53VTgY8YVYe1bMFt4Gk
X-Google-Smtp-Source: ADFU+vvEiSFijC1kMVwswQCjjpwJGI+89z1UEUoT/CbMfHy3NUA0RsiDs1srpFQy+j02SUH5OyoDtA==
X-Received: by 2002:a62:7b84:: with SMTP id w126mr3963873pfc.202.1585148821656;
        Wed, 25 Mar 2020 08:07:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:07:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 5/8] t5616: use rev-parse instead to get HEAD's object_id
Date:   Wed, 25 Mar 2020 22:06:18 +0700
Message-Id: <1b8740018c411dec2813d03c34c56dfa5d1d8845.1585148327.git.congdanhqx@gmail.com>
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

Only HEAD's object_id is necessary, rev-list is an overkill.

Despite POSIX requires grep(1) treat single pattern with <newline>
as multiple patterns.
busybox's grep(1) (as of v1.31.1) haven't implemented it yet.

Use rev-parse to simplify the test and avoid busybox unimplemented
features.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e976..09e640cae4 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	git -C srv.bare rev-list HEAD >headhash &&
+	git -C srv.bare rev-parse --verify HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
 	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
 '
-- 
2.26.0.rc2.357.g1e1ba0441d

