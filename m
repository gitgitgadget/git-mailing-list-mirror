Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F0C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCLUQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjCLUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14F2B2A5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so11364808edo.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRLzc/FxLRIAmy2YZ+bEuB1merOAPMakqVgnb04WRFo=;
        b=R2VsncTCW9S3Z91jaV8PFVmxXRSdKU6j4LK5TIbbAvC7y72fbrWFiO1hqgZnmpC2pE
         q8MxMvTOsAF53Im8Ds8g61EQlSgUUGyBmTp8sfadG7mfytq0lwJI8Y7n5psmz3vYQHUM
         sWFvXT48MlYdrsgb1ZcBG3vSViR23MGgi+yAUMuFZjv0UOKyNOlQrQnbiCZ97OdCVJpM
         Ct5NOwJf3g0Yja0fMlQo50PqlHMKyRbSS6zrkK/s+35zju/Fn9ciWorpB9R5KPiGspno
         HSA1c1z9Q/5E4qPPGg8xzbeo3QqXmsLcc6RC3mkh1DCXDVSH1i08tqtf6dzqrjYum5Jb
         P0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRLzc/FxLRIAmy2YZ+bEuB1merOAPMakqVgnb04WRFo=;
        b=Id5NRVRNRITg7YMIp3rsiVCAeCnO9FhX/bRUCuMKGtGCUS9kAOj+z911A/e6kt+VDh
         eFqSswhQ6V7iPhKl/X5Gt7hSZdP3HJK2zK+S9JdTWDMFggFVgX6Rywn14nCUCXlaKnMc
         LCFoo97la5hLNC9awyGs3+JknwGpiJxRvtnVFjkU/nXzaxbYpLVhHXzbphoURerx6lgt
         2S+0O7DhexuZl9/XbqPTjQDDDfGH6Ksl1YhFWcFx5avRANeic+n6dkthdD7RHJw2HTQi
         TUgpBdzdwpyW+122cR7qvsx1c2n6UFgbzMUkq6mCE22fkvPgftuT4bWwMWiJ3L0M1E08
         6SjA==
X-Gm-Message-State: AO0yUKVkbwIv5u6Ip27EsZ0QYJALIB2kiNGh4iksDFhAvtRF7eMiKwSq
        v022QCgX6JSN48MKjlAqH+bpqLXf5tD0mg==
X-Google-Smtp-Source: AK7set/MbSoEurBGeIihk9B2oqgRJKQOtX6tJpQdhii8W5efQheutILDRvDXxM1NE5ozYE1jBpczog==
X-Received: by 2002:a17:906:885:b0:8af:5403:992d with SMTP id n5-20020a170906088500b008af5403992dmr32979088eje.28.1678652131413;
        Sun, 12 Mar 2023 13:15:31 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:31 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 4/7] t1302: don't create unused file
Date:   Sun, 12 Mar 2023 21:15:17 +0100
Message-Id: <20230312201520.370234-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'gitdir selection on unsupported repo' in t1302-repo-version.sh
writes output of a "git config" invocation to file "actual".  However,
the test doesn't have any assertions for the file.  The file was used by
this test until commit b9605bc4f2 (config: only read .git/config from
configured repos, 2016-09-12), before which "git config" was expected to
print the bogus value of "core.repositoryformatversion" to standard
output.

Don't redirect output of "git config" to file "actual" in test 'gitdir
selection on unsupported repo'.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1302-repo-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 70389fa2eb..179474fa65 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -37,7 +37,7 @@ test_expect_success 'gitdir selection on normal repos' '
 
 test_expect_success 'gitdir selection on unsupported repo' '
 	# Make sure it would stop at test2, not trash
-	test_expect_code 1 git -C test2 config core.repositoryformatversion >actual
+	test_expect_code 1 git -C test2 config core.repositoryformatversion
 '
 
 test_expect_success 'gitdir not required mode' '
-- 
2.39.2

