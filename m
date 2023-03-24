Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C1C77B61
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCXUyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCXUym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7948E83FB
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so12703859edd.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JITnsuY6OWNihaQQx6852KQnHdY75qS3xQLdiSqOTf0=;
        b=Kqo+n56KfzRIba/AwrG1cMJp096iof07lJn/Zz8pfuiA2Gp8Vs8LjSIxkTu3tTLe0J
         LvvJjn02P09+czNuPak53EYipvufyFYRBTRpbEX4xL8ZC9PcRYxECuTLr2ilqY9Rf8Id
         7Aw2CSt4lNgHroHR8ZhYFXkL2C1Xq1JXZ525kRafF8WdP09m6pmMMnkGBrTbxOCpUUIA
         lmHPw29Q/dFEmNM3Bc5bDqe8kSs2sOMfMRAAwM8qujp0F73tH9Mt/Ogq9Cx0EBKovvB6
         3PCfMSu0ZsJ32BZ8E7Q4fVVyISwDxOJkBUWrGlsSNrACmqpvtUCjiJ6DZ4d21w1rOm2u
         eRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JITnsuY6OWNihaQQx6852KQnHdY75qS3xQLdiSqOTf0=;
        b=Pb2bN0o9CXX7aZglRUw1ZXVXQCBS3TIShBHd1FCCjDyBbYYAyBaWZUpuFDQS3/htkL
         K4GfVT5uuPy+U7CLhYioCDX8g2ZYJSZjgDn9WdPl38FsTIw0T0rwqvdT27Fdi0tyagAG
         PJsd712WqJBs0aOb9inFMJ2tOrhb3jhdTWLOkRW7PQLkNMe5zhnOcb6UyURWS+Ah1Xzh
         FSkSoNhEucr6rYVLyj2m9RCuu2Dq/KIjGffJdF2HWNo/1F/D4AYI9pX06/vynNrijJoA
         RfWuHjFiAvqWD/lIN7MY7B0CKIkh6i6GgkMHPyDjVf7xvwMSxXDnJBdqO0yuXjrE5uI7
         vfWw==
X-Gm-Message-State: AAQBX9dmIsUCNx1y8vwn43WGJNDX24Ig0iwP9e3jT2DRgsZo5UtTNTqJ
        psfIXAxThZvITeBjpLf1i0ozl+wQjrzymIEV
X-Google-Smtp-Source: AKy350b049V4V0qMVINaTMLuHD1gc+/NdjY+nYZboe3AuWioxYhcsGDJtX7wfaxxCE943E5mblYl0A==
X-Received: by 2002:a05:6402:114b:b0:4fa:57bf:1416 with SMTP id g11-20020a056402114b00b004fa57bf1416mr3964187edw.35.1679691278865;
        Fri, 24 Mar 2023 13:54:38 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:38 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/7] t1006: assert error output of cat-file
Date:   Fri, 24 Mar 2023 21:54:29 +0100
Message-Id: <20230324205434.93754-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test "cat-file $arg1 $arg2 error on missing full OID" in
t1006-cat-file.sh compares files "expect.err" and "err.actual" to assert
the expected error output of "git cat-file".  A similar test in the same
file named "cat-file $arg1 $arg2 error on missing short OID" also
creates these two files, but doesn't use them in assertions.

Assert error output of "git cat-file" in test "cat-file $arg1 $arg2
error on missing short OID" of t1006-cat-file.sh to improve test
coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1006-cat-file.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2d875b17d8..8eac74b59c 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -603,7 +603,8 @@ do
 			fatal: Not a valid object name $(test_oid deadbeef_short)
 			EOF
 			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef_short) >out 2>err.actual &&
-			test_must_be_empty out
+			test_must_be_empty out &&
+			test_cmp expect.err err.actual
 		'
 
 		test_expect_success "cat-file $arg1 $arg2 error on missing full OID" '
-- 
2.40.0

