Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D24C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9CF613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhFXT1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhFXT0m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9BC061766
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so4337817wma.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcR4S0bmrYDHflYEXmIuhAEzhmiO/w0jsnU94iDLut0=;
        b=MbjtjCxMrPLaKnL0gdDM7vQVQJxOLghcA7pxTzHjnjlauKBmdUhDmVFTYOSiwjzg/m
         SbHBt8rrsQulgklqRoMal5YEDTUhlVJEQfW5V0PM0Dl6k3K95zTerf/UnK5bPrxhAS59
         Qsf5EL5nrfnjsBJiTy+mGFtYUCQ1jpAcrS8v7sIY+YjSgAkVT/ufBCiwesIEJXborLaL
         w2e73Umd43ucB9BOSd4MlWBntGMgsrM0FgP5TV8qRwK6GEZaCfp2BEQ8J6XB282HKBXg
         I+Uwxnd07Y0kYyxa6eSiWIyweuAVc7I34J/RtN0GLcRH0u2kLflaXua61dlrsA6Af98F
         oetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcR4S0bmrYDHflYEXmIuhAEzhmiO/w0jsnU94iDLut0=;
        b=LN8NJ8zgIih91nJGXU3RnNmHnVGTnZNLI2JY/hYQEst4vnrsw/Q9Ti1L+b5m8sFP5Q
         2FsS+D3ioJLTlnzTSIQkhbY092Z9yya3IvGjbOIJiMKeAGFZ0B/avA8UVmSAKdviSHXI
         vGxnwRDyTjPBJByCFCreWARrT59ext+4kaDwRycXxMOFpYs1b6MCT60VCEIPI+W2fvbl
         mqHkv0nRDjivU/ofbdxht4Y55qvM3qOdcQAExH2DRsZUf98hXiVEtLAst5Wrx6VgNcgQ
         +m/eJjKTRxl+d162pKVnz4MTQ1xWb5nrJndbsyj0EqmBxvnAOv7nxMc02IN76U8YsxzA
         yP8A==
X-Gm-Message-State: AOAM533tn1BETY11DCoSKsyxi5n999ABCBwmn4RrGbVAOPy7GFlta+vL
        AcWzAXBPlybsfogW3rU6KuASL9HLIxHOlw==
X-Google-Smtp-Source: ABdhPJzzY9r7Cf7AF2roHjfqXRBWY2ZENofzEpVmAZGly2ANRojjF5jAi/mevEThSqkmWRzrkO5uWg==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr6135882wmb.118.1624562658233;
        Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/21] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Thu, 24 Jun 2021 21:23:54 +0200
Message-Id: <patch-16.21-050cfc7808c-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index d41f444e6cc..956ca260518 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1229,7 +1229,7 @@ int unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
-- 
2.32.0.606.g2e440ee2c94

