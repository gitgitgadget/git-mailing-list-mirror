Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C6C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCLUQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCLUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0E252B4
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r15so13634321edq.11
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzNH/lDBlykWYTnnxsAXBgRpj+TTxcLofsgIfF2z0o0=;
        b=K9oZByQGjGY+YZHqWfM/ZOCoeFGSV4PeiMS+La9V7EY3QeMi8Uvy4CTpkWmN1FGjWh
         PRM/VaDLmyN71NhC4z3fqkE6+aDtXwxnVFZ/shpP3niUYAf5ndEemIZq+hI7/y732jC1
         UY4wLKKtVNRdDenn5urmlp7/cblsj1kTGWam7bn2cTLlBvPpWOppxvJsne5zP9Qsef4k
         dZxVjRnlj7PG4ys2E0BQVO+KEg2lkh761epMz2sCG3qS7eO8XM2dpUTvvzL+SZ7VksSU
         xO/8t9bO1dfRsQaDyz8DisRdOfOLbQvdOqQKnex5N26uDWnq8XhmPtJ2GXgsDd+WGrhS
         t06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzNH/lDBlykWYTnnxsAXBgRpj+TTxcLofsgIfF2z0o0=;
        b=I5g7UkLgrbGjRZMwbE0QxQsZvcVm6Wz2ckPIKehobbEJ8RdyAA4p3F2aluJhSohl6j
         x5lnT9fakzBTvxVZWgn1XTwG3D9jAoHNAJ1ycv19HJyLRl4g6Ty1e0NNBwKz3WnDXMuy
         PjNKNj/uQMkuOA5N/usG0K+pJy8K2EJuh6JpV3R98Sk2KvYcIHgmfhMaLIY0N3jSdtx6
         WsCvBhWxRc+piV5Ku5/IFnMcdU1ZESlbUAwQNuVGuJWbe3aaYFcsuOb1xEbv6AsQJLbW
         vOQ4AUwVMYxjJYQjrUSwxRMCn5ZXNPi6aAERS4WCW6jayCNg+DS3150Yeabkgs5+33m3
         ARcA==
X-Gm-Message-State: AO0yUKXKOZAMN4oUSdzAtctxujIxivmRVL4nIyVpQcXCvQpOmtgFfdJG
        z1u4E+OO4F77YoENI/I9FOqvXTikwRLw0w==
X-Google-Smtp-Source: AK7set+HIQlSehvM1wLN1o9zbY9Jl/X82TX5VkG154Z1LinE8s6zt1pATwgLAOY6/HktaUNjokOA7g==
X-Received: by 2002:a17:907:9485:b0:922:1826:8275 with SMTP id dm5-20020a170907948500b0092218268275mr6367432ejc.11.1678652128640;
        Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:28 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 2/7] t1006: assert error output of cat-file
Date:   Sun, 12 Mar 2023 21:15:15 +0100
Message-Id: <20230312201520.370234-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
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
2.39.2

