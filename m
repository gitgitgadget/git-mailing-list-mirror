Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FEC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0A207F9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc+rfLXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgEUXFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgEUXFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 19:05:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64EDC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 16:05:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so3602431plq.12
        for <git@vger.kernel.org>; Thu, 21 May 2020 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOCDwH3MCd2fD2cgy+WOgq84CDIQ0ZiREVf0kfMRlcY=;
        b=cc+rfLXIo1UzM45Bfn9QSXFpJSTGAKBnGrjjiuYdZPNUwNSrXsMiryW0PVhZtPuf7z
         corlte8oOL0gdX6MwZN17mx4kHUJjqEuDoxWni4voM2yV84/oeh3Ut4hbbgUAp0coAuR
         aWnWZ8C9dbQfUJ8AODordACQejtdeNtpFQllkqMutfmFQBvaLHFilF+j8k5t1ngyoX4D
         /U4w4HDoOXCUF3XG8aeLdISwPRrsWyIcJJO8AptKveKGhoa3ehJ+bex9aT2jVHxfiYlv
         2xVPAOGEdePEPMVWLsUSskdIk2mLb5aeCVs0KFGWV2Hdyif2p40ndeSI2D3MeOntQvF4
         LbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOCDwH3MCd2fD2cgy+WOgq84CDIQ0ZiREVf0kfMRlcY=;
        b=sG4RToQ7zs7I6rKqAKSJPs70FXp8qi/mbjjEZ04KLyR7XagycmVc9fmq+H1SBnVn45
         Gp7oLmTFUW6lquATtl8kfkQMv0gEtk1TWKlFS3pyfAiHT8HR1FLF6eE0mzDSlCu2fP2c
         Rl4dOz9gGaLBu/wWSDnGvTQBlHPJhvj9rVRLihxcO3tvwe7NBak+DhGl4IHdrxttgD46
         fC9rrhqULJVKjix9MPQwdgKCbIl8FwHHTnUE+6koVg40SmGuAP3bxKH3OyhAwQOSloL2
         vs5jaC2zTFAqVQJjc8xgV2q5j1c5ucnOvAUhk6DhilFdxuYVnuZWONuD6QJwn9lIUXW2
         6l5w==
X-Gm-Message-State: AOAM5321LM4KiuhE6bHexkwJHvIupN0BjaEugLJmM7hUVQYiW6sEam78
        L+8lkp1Lc48dj7IamdqdMN4eTzW5
X-Google-Smtp-Source: ABdhPJyNyfG5qBrJfXF01n40p2Rnd6Tsz0nErWWSwpNtcxgXkdes+uy10lJwerTn1xhV45GGxzHGZA==
X-Received: by 2002:a17:90b:b0e:: with SMTP id bf14mr938623pjb.98.1590102329790;
        Thu, 21 May 2020 16:05:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id p19sm4722849pfn.216.2020.05.21.16.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 16:05:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t5608: avoid say and use skip_all for consistency
Date:   Thu, 21 May 2020 16:05:10 -0700
Message-Id: <20200521230510.13077-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.181.g8d5cacc8d1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Printing a message directly to stdout could affect TAP processing
and is not really needed, as there is a standard way to skip all
tests that could be used instead (including a message).

While at it, update the message to better reflect the use of
booleans and get rid of the prerequisite.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5608-clone-2gb.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index eee0842888..4c476d2fa1 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -5,12 +5,11 @@ test_description='Test cloning a repository larger than 2 gigabyte'
 
 if ! test_bool_env GIT_TEST_CLONE_2GB false
 then
-	say 'Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE_2GB=t'
-else
-	test_set_prereq CLONE_2GB
+	skip_all='expensive 2GB clone test; enable with GIT_TEST_CLONE_2GB=true'
+	test_done
 fi
 
-test_expect_success CLONE_2GB 'setup' '
+test_expect_success 'setup' '
 
 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
@@ -38,13 +37,13 @@ test_expect_success CLONE_2GB 'setup' '
 
 '
 
-test_expect_success CLONE_2GB 'clone - bare' '
+test_expect_success 'clone - bare' '
 
 	git clone --bare --no-hardlinks . clone-bare
 
 '
 
-test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol' '
+test_expect_success 'clone - with worktree, file:// protocol' '
 
 	git clone "file://$(pwd)" clone-wt
 
-- 
2.27.0.rc1.181.g8d5cacc8d1

