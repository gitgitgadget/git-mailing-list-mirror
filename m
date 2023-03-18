Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B83C7618B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCRPrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCRPrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30247113FB
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x13so31374485edd.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JITnsuY6OWNihaQQx6852KQnHdY75qS3xQLdiSqOTf0=;
        b=NXp24FAajill0vpyFO7YkDnUQ/nLhUWejcoKN3vNoCe962xvnETKA5A8vTZU4quQO0
         kVtn9DyBgW/ifCsP0PdoGchrPM97oGETzbvQ06Z30zE7RXxnvCASiZaoQVekDNRua+Xx
         k6s0MhFUPPLAJWE6Uw3PgCMiHNw+Oijnks46N2JlJGo5ZbzwfvgGBLv5LIsEUbYr7sKw
         HOGk/RgEfvJmBwM7fWygJP/vMt4OGRVCthCR/5nuv/BHbJxS4x/aHSdGjZWKNk05JN/F
         U6ra3giygUTqSeea92QP7LlXJucYM0mgMUBZh4wAG/mLduHQt2dM3xspSf8aXc7JJs/B
         dabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JITnsuY6OWNihaQQx6852KQnHdY75qS3xQLdiSqOTf0=;
        b=b1g9UN75nh+T8a/+mebz9jLWZot0WAo1Tqtf34SB7Gz4e3V0Re+l6JfSCx7WTZJFWs
         st+zZMSD4zl0GLk2biBPAOKCV85zz5sbUSbkX/nYybw1qSAOklY8EeNaXHXzNRJ1aBpJ
         0rMlB5ftJhjCGhOinLF2i/aisTk2T6+PuDbOwuHdcf1po/cOJ3fLaoCYY1iZxE3MKqKD
         WDOt4mi7QX+RJXd/pSLk8JHuHiCIifl21vmSLQBBItjhyJ3Y/COO6Cuwd0z3jrMuJBP5
         jEIReoDvl0Ijp4CF+JkwLNlMBePhNjNVNjbIrFfxW5V3YUSciy+D67QEUMMe5ZZStLFG
         S0bg==
X-Gm-Message-State: AO0yUKV7SQgvkClxuQzXPOnF7z+emQEher9bkgXQTtbQSO1xVKZTGZO5
        QiiU80PqaLyHMEmJsfpVw+J+1xdqOJx5F2ta8hc=
X-Google-Smtp-Source: AK7set+Ce8EupeG9FP8cUmR89GoLUU7KIH41mGtpEJizgCV6HeLdG5HVCpT1fZVA8HLXluFk0ZDT5g==
X-Received: by 2002:a17:906:b1d6:b0:8b1:3467:d71b with SMTP id bv22-20020a170906b1d600b008b13467d71bmr3354451ejb.48.1679154413316;
        Sat, 18 Mar 2023 08:46:53 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:53 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/7] t1006: assert error output of cat-file
Date:   Sat, 18 Mar 2023 16:46:41 +0100
Message-Id: <20230318154646.131344-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
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

