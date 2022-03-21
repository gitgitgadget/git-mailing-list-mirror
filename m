Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D40C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiCUXLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCUXIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543267D24
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d7so22651534wrb.7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okufmd3g37lt7+seSZmuGXonNGuxuUQkpeUSvUifxAE=;
        b=diXBsEcFOh5qLN3tT4YCLxpdZwhtjd4RyvrIbmXjtqrmNGpiMfuLnyPjr8Hg+sPUKH
         lwRiCjKizy3eLbIgtFuUI1ZW9HmmZXVpsoOaLWdXNPV9hSwjA2yI4zocHhGP5oubGNyQ
         Cv8sS4fqGzEAKyGgsfdTP1VptpmFLFN2urfapqqjdbFfxGP4U8M3FHQFYeMDIpnfYHNi
         iH1/c30BhK3s8VBHrQlDmRSTZy5UipDW7CvGEEeBLwCCUgU1PAMgwXZAILFCyukT4MjQ
         U3fNxs7jFi8ZsrPUme+mdL5FIL+wo6VX+yS3ZI4nK/qtqQt7BTxMHLvDzx4Dk8S3hKAr
         tqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okufmd3g37lt7+seSZmuGXonNGuxuUQkpeUSvUifxAE=;
        b=hMrpvJnyYAAepDFOIfoWJCPn9M+nHNGdUOk/H8e+NSoi5H4aUF4BRunKUEB0a5SoLc
         tsMC8OVvGJaTWP+spLkNQA3WgQxiO9bJw3pDIW9t4XMeq7eoylLsx64Uq4GoAHMFyQJb
         puzw9zFFtdS0W7RRmD1KDsxicqoN2dCtJF0f0YyzV1h/IUoJUFB8zByCZRlF5CZbCsL9
         1Nwg1nTzKjSrTjAFuQ9orWTrgSsTqS3lEvafBT22LXOq7ya2JYreniZgTTj0v1XRZI+g
         pSuXbKVxLsZEXrZP6UhbdbhF8a7n2OKMgtjb01q3rZ8GLBuJJ6hlrYWrHEYqLwdO/PKn
         ygCg==
X-Gm-Message-State: AOAM5316EkORBzfKuYL/Y+Wy8eKGVNnNLfBEx9rBB6vRH3IftiuQBm9o
        ytd/aFDT8qh0TimAXT5l30gePrtpjrE=
X-Google-Smtp-Source: ABdhPJwGkE4UcGzoUAMTmK9VBfOkDKJvotsU195hCwgmNZXccLpSXe9JmOuO9Z7s21t0qT0zx0wiag==
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr6177230wri.569.1647903370781;
        Mon, 21 Mar 2022 15:56:10 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:10 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 31/41] path.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:13 +0000
Message-Id: <20220321225523.724509-32-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 2c895471d9..6639bab7b4 100644
--- a/path.c
+++ b/path.c
@@ -915,7 +915,7 @@ void safe_create_dir(const char *dir, int share)
 	if (mkdir(dir, 0777) < 0) {
 		if (errno != EEXIST) {
 			perror(dir);
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 	}
 	else if (share && adjust_shared_perm(dir))
-- 
2.35.1

