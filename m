Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B92C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiCUXKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiCUXI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1CD3480D9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so4689969wrc.13
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMJHN4hCuvbjypg9z1wj7Ld/HIu+BU8m4JtznGX15ys=;
        b=N8GYbi/aFMvVgiC+W6f6lMKwpI/+a+1jkEem7wVJX7qH1BwQMW/wVyprfjfdAiVVYJ
         sD8WNbAz57lknmc6LG688bsiX9jyTIKFvP/sGsP6W8LJK4vy72H/zz5qWW1Tp3a/iLzw
         G/2BQaZJNJ7Yzd/slI+NOtNQhCx0Gf1PlBL21IKycMXpYHncMzO2OzkPWadbQciwynBN
         n4y18N9rIP5fjM5JZRQJUp+ZeqmFaH8XTH2GZYOKTWcyenQVWNmTzQ/3X5dKS9BAMoZv
         CN8SEddT8ySg/9QWsIAU2bRx29hueerQVNZXl0W8TlpCKYrlb1LMGdwhCCJcCCCGeRM9
         UELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMJHN4hCuvbjypg9z1wj7Ld/HIu+BU8m4JtznGX15ys=;
        b=e9R5CXTx8bOuPBNk4xz0TUVuTKV76Fx0n6Ew5OiXCGi/m1tdr5u8BJ6udNZ94gY3n3
         yX5XTDN2u4bk+XeXBbRPK76AyfbgJkOWwGvvOo6VPDXCgiUIcbclbGPEKPf7d+WZsV1g
         b9KlITrYye2lFsLw7rANMETLMWOR66vI8akvAIbghaHbQqoQr8YzRRapathdj/bcANlw
         Bpdbj5tIkyn8wC+4FzyImoBrUCeQ3So0fb4cwj6SHYNTLNhiKTzvf+1v4RBsLqlAqSBc
         6+RYHhZkzYcJpkYl28Cl8xVS+gbl7BKGCfMyUd69aPel0MqcUlZL1Jk4v7pQI2J3TI0j
         4KkQ==
X-Gm-Message-State: AOAM530hoV66z0XkwshiOmv5Gij3YQ8IglesvNF7WV9YWaHcU6qkkoZd
        jxCNOUF+ny43XRd8yvXINuhPvwV7uRU=
X-Google-Smtp-Source: ABdhPJxUzxNU5k2sOQVwgqADEV/M5LvP4SquRVIklivWUS227BPC79fsFIApXT4sYlcL8MVRF4z86A==
X-Received: by 2002:adf:d1cc:0:b0:203:e857:85b4 with SMTP id b12-20020adfd1cc000000b00203e85785b4mr18390040wrd.666.1647903342308;
        Mon, 21 Mar 2022 15:55:42 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:41 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/41] archive.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:43 +0000
Message-Id: <20220321225523.724509-2-gitter.spiros@gmail.com>
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
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index e29d0e00f6..c8c1df59de 100644
--- a/archive.c
+++ b/archive.c
@@ -590,7 +590,7 @@ static int parse_archive_args(int argc, const char **argv,
 		for (i = 0; i < nr_archivers; i++)
 			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
 				printf("%s\n", archivers[i]->name);
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	if (!format && name_hint)
-- 
2.35.1

