Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF7CC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00548208CA
	for <git@archiver.kernel.org>; Fri,  8 May 2020 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqv6MsZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHHFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgEHHFR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 03:05:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA9C05BD43
        for <git@vger.kernel.org>; Fri,  8 May 2020 00:05:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so575880wrt.9
        for <git@vger.kernel.org>; Fri, 08 May 2020 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UWGfZzOIlFzaqjO6JrY4ehlDtqZTMMAaVS11hg0hJY0=;
        b=Rqv6MsZQeSnnyfgcrraPexAUChZCjVWoYo8hOmEvbn+xvawK1ox6TVPpkdXB5LI/kX
         iZeqq7Uq4oLoc5h7wQ7z79ud9f9e3zAEPPS1A0lo07HLpMVNW4UQXVGy8uXNRg7G5bVC
         JWMvRVPiwiwXfOr5nU2Iiz8Zr8os1du07JQJ61xlSlg6kehGUTucAQTVyDk8u6eBmRwd
         7TNP1YW37OCZk4Olzax0HWMbvnvArr7q2kYG5Jf85zh6HswOfQVwNGnBkq8K8LQkjU95
         iRNeZYiw8LIhXjRgaqbuIOUGE8h+pPFpOnR1EJDvP4Yc+0wnL7s/cYCp5CUul/3q7Iq/
         6iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWGfZzOIlFzaqjO6JrY4ehlDtqZTMMAaVS11hg0hJY0=;
        b=MkqSvOalg3xJVyZg2rOsGoUGdrPFZPzaLO1+C1YnVYgh1Tn8GJ32nKZsQPHorWSKgD
         rbz7dRAnbyfUP78zG9KtlVzw0TFwOG4rDAJ1xX2MApEGDH+DtmFIRlut7fGJk7wHCKtI
         0dElrIB9LbaSLOSsj2sDpKNV4ftCOCg3UM86nEaxFNKcYHdCDn3pCi4ccDPZq03IIob2
         tT24/zvf3XL9w4hh5immNdx9VeuFd6K3HvkAqGK4q+GarGiE/RQAtt/YGAQ0MubF8vIJ
         Ft7E2naeWH5cgYemKV3M3dJ9HsyMYZiMIEYfsqu71dsGLxMvNcGuUoxHo+xmezek0gDF
         6fFA==
X-Gm-Message-State: AGi0Pubh//EjsZAvrqCAsBjXAmFfJL9h6HRvvq5YXV9K1QymZT5wfIqN
        vA+VMH7vOOCubwOfyxGRpJ5alIjO
X-Google-Smtp-Source: APiQypKLpDsFo40AvXeEMEKdABrUsudrqiLYHT9m5a0T+YPV+ULu/YFVjJSj7bPBPsdRG4ShD1AxkA==
X-Received: by 2002:adf:e802:: with SMTP id o2mr1192189wrm.110.1588921515554;
        Fri, 08 May 2020 00:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm1432368wrp.47.2020.05.08.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:05:14 -0700 (PDT)
Message-Id: <pull.630.git.1588921514146.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 07:05:13 +0000
Subject: [PATCH] Correctly initialize 'installed_handlers'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Force Charlie <charlieio@outlook.com>,
        Force Charlie <charlieio@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Force Charlie <charlieio@outlook.com>

Because static variables are not initialized properly,
temporary files may not be deleted when receive-pack receives a signal.

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
    Correctly initialize 'installed_handlers'
    
    Because static variables are not initialized properly, temporary files
    may not be deleted when receive-pack receives a signal.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-630%2Ffcharlie%2Fincoming_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-630/fcharlie/incoming_fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/630

 tmp-objdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 91c00567f4d..c1ccf78e5ed 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -123,7 +123,7 @@ static int setup_tmp_objdir(const char *root)
 
 struct tmp_objdir *tmp_objdir_create(void)
 {
-	static int installed_handlers;
+	static int installed_handlers = 0;
 	struct tmp_objdir *t;
 
 	if (the_tmp_objdir)

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
