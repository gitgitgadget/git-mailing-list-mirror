Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D8DC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4E820719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Hn8MM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgDBNRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44213 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgDBNRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so1311031plr.11
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaXsE6HfC8ZzKL2659ahPmPTXknfweBAs1BcSEUi2Mo=;
        b=B+Hn8MM3CxkJDKcvEHRsPiskB61A4+tzSYa/32ZHoYgp1Fqs+UHAWZEyeAm9NaE+42
         BISMydmWmQlh55Lkmwy4i8ARLil6kuM0Hi+/ND88x4ZtQ03bacpqQzSWw/egoxfaYBdO
         uxc+puhNDWSfKgDikjunApulIUBT7HxZqTrfISGlyR5uVBlY61yySEbH92JgtjUTQ/tP
         /mlsdi9HMYW9sjUTambjP8SAKbt9M+P2sSr6prtGJYKf7amX4dEjxii4APJGvbX+jgHn
         zC9EjNj427BaNBSyLUlZMjb3znNOsVTmrQzwoJ4CBQJrQmM2+imH34o1b9040G4c7Zp/
         9aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaXsE6HfC8ZzKL2659ahPmPTXknfweBAs1BcSEUi2Mo=;
        b=pkwdraEld8sckt13rvDKeaKMourEdWjNNS8LLDknC1Jqx4zrXAHaZXrWoEAxM+dPBL
         NBRGmRRSA5xKrVlLuxanNLKySM+xz4ddZFATS2ZYr2kEpflhy63Sbvd9zbjRwHmmbXeC
         xcs6lfSKFmW8IR3O7m0wyHoqFKkhiGl+3ZULbgGqZwXKFYJ5awTfdxTdBIjKfJBuiDdK
         nZAq/qeSA1d8FP13nxRGnTr593AIqT38/4YLhkWVsWsufS0gks/fTLhZNzE0B7vvsQcV
         8dHoVtJ346CHTRF4Y65HGQarBwQH7B0ECBSBEBZ5ppEJbVBJDlSLd9u3ypqBl4fWA+az
         6nvg==
X-Gm-Message-State: AGi0Puao7vBW5RYkiNDiGgi1o4TiNHCySkvbJydUXYMzRRm7lOhvKFl/
        b+BKJ+rhqdWoBLXMJOsT3gNorSQs
X-Google-Smtp-Source: APiQypJqskmsVZ9xMBXLTJ4W/8ctBJnqgYLQq6sBNNYCPGAjiB+gD5JcQXrIZf8X1YfHN5v9IEo90g==
X-Received: by 2002:a17:90b:430f:: with SMTP id ih15mr3774385pjb.56.1585833450713;
        Thu, 02 Apr 2020 06:17:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 3/6] ci/lib: set TERM environment variable if not exist
Date:   Thu,  2 Apr 2020 20:16:57 +0700
Message-Id: <9a03c0844cf0595d611a0df32c8777ca51ab6fe2.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832999.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com> <cover.1585832999.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub Action doesn't set TERM environment variable, which is required
by "tput".

Fallback to dumb if it's not set.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index f92e3a5211..40b159e24d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# GitHub Action doesn't set TERM, which is required by tput
+export TERM=${TERM:-dumb}
+
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-- 
2.26.0.334.g6536db25bb

