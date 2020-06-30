Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406AC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F68520675
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjT1dmIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbgF3PDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgF3PDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5EC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so15768973qth.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=SjT1dmIevSojNC+BmBXPjmimQ5kXDT/P0PTGDjlwl3I9mEleBi5jXmLDE6OMyqQKoo
         9MPqgufThJmRRu7mBbGuiX03ZrQWMIpPonFCjOTphHcvq8aThYhKquZkOjTmbwohQDMj
         Fd4hVt1IExjDVhD0oSJZuPuzDX3MjNX0kz8G08/ZR3eKWBN1+gNVXxhe08+eQFCXNrU2
         HkHxy5MyeJ3ehE9MfCxClUYyCgjcjaK4FR8GvPxAlOy4MLN7x/DR2ZTS0HeV2gVzB+Aj
         ENZs+seEPD3jn0kOFDJylUh1jY3Vtz5K7bVoP3WfmMXim+aLkXtqGlBeC5qOCvJjbjvv
         JnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=cZO6vhwABAyCG5IrEsVvpGqIEgrXenHNKE1iNA81UblKQCz4DPtHvX/fywMdiRXYW3
         z/5P3+U8cBdJbCigCzb527vSFQwF7N1jNU8vUXH2UXfLeUVFBClljI3CSN9d1zeEL3nN
         tAegt1vy5SrN+8B3vi1ByBzL428LwtWMmX00EekxRAVRUUQ+/fFFq6tRCRXIR5TxDm+F
         Na/tkfTJCp8M/UG9O0TLrECYdBoSz+VWiKw/M1229h/cZ/BBJ/b+uzH6T2MYcO4rEWd1
         S94Ladow3om61B8Fsm/glWRah4TIwOvjQaguMFJwQ3D2+IRAUcBBBhsXs9okHKbq8aMU
         o4pA==
X-Gm-Message-State: AOAM530kHiX8qROr7CuPE+mqJ8NQ1oopcH3f53ekmbaULDmg5jOnR0Gi
        lreMH09UR46HG9QUBqztwdbZ2hVI3s8=
X-Google-Smtp-Source: ABdhPJyj6ryd+0xNfEc9SldGDbDcxrW/vemZK5jzzF8NagkB0ImFvGc0mJdkECJLTKeQ97woyenFjw==
X-Received: by 2002:ac8:1a12:: with SMTP id v18mr21648430qtj.347.1593529413316;
        Tue, 30 Jun 2020 08:03:33 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:32 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/5] t9834: remove use of `test_might_fail p4`
Date:   Tue, 30 Jun 2020 11:03:18 -0400
Message-Id: <1287798e691bd3be1ac094bacae5149560c9e6df.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
a compound command wrapping the old p4 invocation that always returns 0.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9834-git-p4-file-dir-bug.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index 031e1f8668..dac67e89d7 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -10,7 +10,7 @@ repository.'
 
 test_expect_success 'start p4d' '
 	start_p4d &&
-	test_might_fail p4 configure set submit.collision.check=0
+	{ p4 configure set submit.collision.check=0 || :; }
 '
 
 test_expect_success 'init depot' '
-- 
2.27.0.383.g050319c2ae

