Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 02:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F7864E15
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 02:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBRCtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 21:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBRCtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 21:49:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F35C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 18:48:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a132so1371271wmc.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=s1n0qQ/VuvhPmDhEuK52FIIpACuosAVWN/VC6xxse5I=;
        b=QNFNHruVNrSl3rsffekB7agZWUDgwFqP5ty9/I4V4hu52FbCxIbgY9ymuaJ1o/pqT7
         An2oaYHvzwS5NRhEyVZKzDkRw5aNAmGlz1QMeTkdiKmxuhibRKg4OzMSjElUmbGfct+L
         bNlHBkF9zSsRXuA1OEM1h0okHHvrW300xvpgm77l627+3HNhs+cjB0zHwKQ/XYizAtzh
         KGYtNIYUbIi58Dh7LMuYjTLbQFvS6QHB0dIC+Vhzt3zhOWGYguJtZyF05TiHvXCiv9vt
         qp4R3D+J/ZWBXKbmFiVMnToITSq4n4v2onTSZYfc0QglCKTrG4T+QS3xBbBRsfv6dmCg
         12mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s1n0qQ/VuvhPmDhEuK52FIIpACuosAVWN/VC6xxse5I=;
        b=FJuRVDm5IVyhL9O7bex3aMkE/DzBCrb2kTI5wu15/P79iZoM273pwyMaO8hjRLN8m0
         qOKeCUebmSRNoMVaAcC0QpA4GIWQy2M/rFhwMJZbYu/3uIQgKGzGPeHw+TRj0/E4fqLV
         9M2msYmPkTkmsdS+zPHTBHIlmvLP0mB6yHSPjG4I7iCHyF9NWUyMSbBgiFVOleJCDJgR
         4Z3JRWmy40XhX75VtOCW2U7BawLe5dId1ZyLEBXsNdoIJpFVrv6SK4UUvKEXS+avHwEJ
         G3wDkjQEZxn9fGIrdzU8HyUnsXF13M//F+JRC8VHp5ts6awfmjhYw1YvzLoaX9Y+mBLq
         Ez3w==
X-Gm-Message-State: AOAM533RPea/s0649x2O8AgbgNJFGYxXxe4oYS0T+Lx5dsGU14muPBUl
        YakrbZKjyU3G9f6ELeaXDuaGuPRn4p8=
X-Google-Smtp-Source: ABdhPJwyKfsjyMRdIIc6d3l6fZTN9gmSMIyQ9L6FLKMEwfgxqdXqJZBtidEqs0k9Yq0yGhjd0RNvMA==
X-Received: by 2002:a1c:1fce:: with SMTP id f197mr1491170wmf.110.1613616508121;
        Wed, 17 Feb 2021 18:48:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm5666365wmh.2.2021.02.17.18.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 18:48:27 -0800 (PST)
Message-Id: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 02:48:26 +0000
Subject: [PATCH] read-cache: make the index write buffer size 128K
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@ntdev.microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@ntdev.microsoft.com>

Writing an index 8K at a time invokes the OS filesystem and caching code
very frequently, introducing noticeable overhead while writing large
indexes. When experimenting with different write buffer sizes on Windows
writing the Windows OS repo index (260MB), most of the benefit came by
bumping the index write buffer size to 64K. I picked 128K to ensure that
we're past the knee of the curve.

With this change, the time under do_write_index for an index with 3M
files goes from ~1.02s to ~0.72s.

Signed-off-by: Neeraj Singh <neerajsi@ntdev.microsoft.com>
---
    read-cache: make the index write buffer size 128K
    
    Writing an index 8K at a time invokes the OS filesystem and caching code
    very frequently, introducing noticeable overhead while writing large
    indexes. When experimenting with different write buffer sizes on Windows
    writing the Windows OS repo index (260MB), most of the benefit came by
    bumping the index write buffer size to 64K. I picked 128K to ensure that
    we're past the knee of the curve.
    
    With this change, the time under do_write_index for an index with 3M
    files goes from ~1.02s to ~0.72s.
    
    Signed-off-by: Neeraj Singh neerajsi@ntdev.microsoft.com
    
    Note: This was previously discussed on the mailing list in 2016 at:
    https://lore.kernel.org/git/1458350341-12276-1-git-send-email-dturner@twopensource.com/.
    
    Since then, I believe we have a couple changes:
    
     * 'small' development platforms like raspberry pi have gotten larger
       (4GB RAM).
     * spectre and meltdown make individual system calls more expensive when
       mitigations are enabled
     * there have been many investments to make very large repos scale well
       in git, so huge repos are more common now.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-877%2Fneerajsi-msft%2Fneerajsi%2Findex-buffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-877/neerajsi-msft/neerajsi/index-buffer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/877

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 29144cf879e7..a5b2779b9586 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2447,7 +2447,7 @@ int repo_index_has_changes(struct repository *repo,
 	}
 }
 
-#define WRITE_BUFFER_SIZE 8192
+#define WRITE_BUFFER_SIZE (128 * 1024)
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 

base-commit: 45526154a57d15947cad7262230d0b935cedb9d3
-- 
gitgitgadget
