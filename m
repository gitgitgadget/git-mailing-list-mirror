Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763CC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138282087C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAEs0OMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHLT2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLT17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:27:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D08CC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so1533768plk.13
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnkeBFn0/X4+bdWVmRgOycuxQRZnmkU8s6cdQqnTQ4w=;
        b=bAEs0OMIxBWP+14nfZp1lcFUf/OWaV+VEQZIlXodNprbuK4BpJ1EktV/fxOx3cy7Pp
         3oiYyq1XnvN6f+xLdgmgTzl3cw4t1nTdVMGX1bGN/893nWDi63nzKx5BzNUyfVfaL+C6
         8wzi70SIP74x5Q0c5Gi5wJBqXRlJee24vC4HChSHHbwhmAMr0i9EzVv78qNt0mJLOYIw
         90zFvavvBuchFcE2vUA+9Y8CTeYHhZLtZEGwoZjd5m0Y8A5QrqIQIzHJfikPhVnOU9at
         qIliCiKILbnBN/5BKJxQTRNwMeWp3GYZuLFQth4QwXvW6kj1hMOWTlqKxLJ8Yh5YYDvS
         yI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnkeBFn0/X4+bdWVmRgOycuxQRZnmkU8s6cdQqnTQ4w=;
        b=MSHN5pA53HmrcVcG3sgAhf/4VCVlCNV1zBJdPFWGZoyKeOwgazBzX7ssK1A+NAVc3B
         77pwxzpljxIRmoMnsOQiVfDsbja7f1QLY8SjUDBiwy+9fzjc+XL8G0iiqjZD9Ti89BE3
         QzSrKNCP9kI3dh8WCRkPlcLrXnuPAPcWQedf1hlmNSEeREKnnKyTHf2uImPZmYavrL47
         rEvjC+Ko1+a7RfpK5o6KOmhCRGuP6bdppidMqy9g8H4c3El0/ooZ3R3wM0QyX+45MaTt
         fEFt7qWdAVeh5Dw5lVxKTRBveZPkHD39nyeYiggcStgCTtWJsaLGzccO48T4thsBlKB7
         J0+A==
X-Gm-Message-State: AOAM53233ENR09gUVPsaLxMyq7M8nTgW7ZP6FNBnWK8NLyYeokr0YuV4
        CM9ixUQnnhQdkDOOT2VAl6g=
X-Google-Smtp-Source: ABdhPJxaiMtfYn5HmoxN5uRl5+xnvM8qNa5NNdARLGyRe+wAGcJ95TgfsjXG0w0aXAM+iEEglYwKjQ==
X-Received: by 2002:a17:90b:14b:: with SMTP id em11mr1593480pjb.47.1597260479183;
        Wed, 12 Aug 2020 12:27:59 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id f3sm3463334pfj.206.2020.08.12.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:27:58 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] t7401: change test_i18ncmp syntax for clarity
Date:   Thu, 13 Aug 2020 00:57:35 +0530
Message-Id: <20200812192737.13971-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812192737.13971-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
'test_i18ncmp expected actual' to align it with the convention followed
by other tests in the test script.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 8ee78bcb69..53943c9cc9 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -183,7 +183,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
   < Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
@@ -193,7 +193,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
   > Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -rf sm1 &&
@@ -204,7 +204,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 * sm1 $head4(submodule)->$head5(blob):
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -f sm1 &&
@@ -217,7 +217,7 @@ test_expect_success 'nonexistent commit' "
   Warn: sm1 doesn't contain commit $head4_full
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 commit_file
@@ -285,7 +285,7 @@ EOF
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
+	test_i18ncmp - actual <<-EOF
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
-- 
2.28.0

