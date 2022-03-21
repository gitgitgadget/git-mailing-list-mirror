Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB60C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiCUXRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiCUXRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:17:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA03A147E
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:05:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h7so9549965lfl.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++9Mr/az46tAJ1JYgBP0tAtKLRT3b3iaweT67q26lGU=;
        b=UtnLro8SMWT/2YgI1CCbNywSZESfbXaZEu25XGKNzAJsrlSSYPF2Qcc0InsdXYykUJ
         A29qZjGwQuPhGsKwK1uQmdHs7SO32DL4nvA3MUz/EvUnL8wLMds0z5M+RgGJ1wTYk836
         nxqznMt+PwDVKkE7Q00IQMp1/XQtP9+2ecaxnarwGawYzVY6MTDgyGiz4jGZMgk0bCqB
         T2F713R6EL3NmSyh8ty3zrz5L6WTTlk8NYtQOT6Dz0A7QFWTtMbyMBwO8xnxXQzuXP3i
         2R13jlrBmbySeq+dGvFS+5PHp+UXqCsneNSKSlLHQwLgwngY9GDidnP1Mj5jRHxgmATi
         39ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++9Mr/az46tAJ1JYgBP0tAtKLRT3b3iaweT67q26lGU=;
        b=uY4PbWMITWmT6EEaYyiqxocwSOzHYuCHtDegS8hHI4gRkKQznaxyIWotOfgmsvrhPP
         +ZdRUeu5Ups3u9LenR2NdYOZSTa4FbmLtqz8ijUey7WbvapWg6O0P7yxkBzwYEKMWJyK
         pKtmHSrWH77jrY6W21G+vNbEAvYdh4XIDGiIBOC3MgyKLtOzLuKLDCZiLZj9q/UzNmO/
         JEX30izdC00DZYg2eKHUXyirjfDZEpjhcf7GFbggbIWtRGSUHlqntX4n33VdA5q2uIMZ
         luKF7GLKZACKLyARNbta0+woh4Cqm/2cAf/COldWA1f0NMYNOOitLGjMm/d1fnedD8Xq
         3LHw==
X-Gm-Message-State: AOAM530ie+1T7CL+EE4ll11lC+zptvaeAtoGCWtpCyiM9FWK5PyIlQNF
        eKP8Syhe/41serCg542oj5RJFNp/HP0=
X-Google-Smtp-Source: ABdhPJwG/PLif0MsEv05EhckPlaYzxMF+5srvX6Al8L4ZQBGdTtASHjYdfnRrA/uMYYVR/8l6sH+Dw==
X-Received: by 2002:adf:d1cc:0:b0:203:e857:85b4 with SMTP id b12-20020adfd1cc000000b00203e85785b4mr18390723wrd.666.1647903362536;
        Mon, 21 Mar 2022 15:56:02 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:02 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 23/41] obstack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:05 +0000
Message-Id: <20220321225523.724509-24-gitter.spiros@gmail.com>
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
 compat/obstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 27cd5c1ea1..e8641816f7 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -407,7 +407,7 @@ print_and_abort (void)
 # else
   fprintf (stderr, "%s\n", _("memory exhausted"));
 # endif
-  exit (1);
+  exit(EXIT_FAILURE);
 }
 
 #endif	/* !ELIDE_CODE */
-- 
2.35.1

