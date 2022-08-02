Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14BC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHBPrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiHBPq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977342409A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v5so7419370wmj.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ce+LJROouwkf2KY92Re5adtsYmwqJXTyEVtA+mPalT0=;
        b=jLTAvrlYeubHhVzbkWNyamn7QeTr4v8dNqazrztsQnfulMO0bbLjkQR/q5p9yfaFxb
         y7EKW7UkukjRQezmGhPwduaaLo5MmEuLJa5LkccNF/tohaFDlr5o5dFjvsxZpiAYtYK3
         yjBmk0z5BZEFDCTn43GdKW4rxMlMJumpw76eCHMXmcqHEZ2vuhQecVI/dUK/0no4a97Z
         XVb+caK4uxIAZLWzPh30GA0Ef+MmiJihJe6F0emVkBHOTEhvMZHU+k63F5yPk7FuJ9Af
         a5AW8wObQLpxamzB4BQeOrQMLRZ2NAbeHy81h+DRs+En/kGTVyPts7G9dK6orbTtO8xj
         mwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ce+LJROouwkf2KY92Re5adtsYmwqJXTyEVtA+mPalT0=;
        b=24v6Ti6Wx2k++P6uNjEj91kDcscErC0efhJYENVsx2GaGjKlHIcn10nFQKY/JysQJc
         jINvl9Dm+7Q0o8Ma65jBeyTw/g/rhcwHipOV0qVfKSbWltaUq+3x116joAy22hXTRztS
         hSTi57fpilI2fyfif4KTSf48hJGJFEdD7M7v8r107vanHmMgrK6RNrB3jlz6Z64S/Rxj
         uga/dmmLuZazhVq9C1/+0DI64DoL12LzTkoJ+1DKyMMpFImHjs52mg4bQuDR/63s52fK
         Zukvs009QirDi7b2dehjJ4anCidYCV12PAis9PQvvkbtD/Wf63y8haP+K5ilK2RKsNEu
         SxiA==
X-Gm-Message-State: ACgBeo0WyhfsVd4FvZH11/xtNRJDOFY/zkPf4n/JBF7sTrLK0dg5TWJP
        VObS5MziAoFUgJBGQK2DUEdto3WCWtWYIw==
X-Google-Smtp-Source: AA6agR7/r6biLsrm/fX544C8kXTVA2/6oLq083AVDYUJoCw1gTLHDn1qpY7l039r9vXogwL6ZMNIpQ==
X-Received: by 2002:a05:600c:41c6:b0:3a3:4cab:74c1 with SMTP id t6-20020a05600c41c600b003a34cab74c1mr40356wmh.175.1659455195814;
        Tue, 02 Aug 2022 08:46:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/28] submodule--helper: return "ret", not "1" from update_submodule()
Date:   Tue,  2 Aug 2022 17:46:03 +0200
Message-Id: <patch-v2-19.28-f0258e37ebe-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the update_submodule() function to return the failing "ret" on
error, instead of overriding it with "1".

This code was added in b3c5f5cb048 (submodule: move core cmd_update()
logic to C, 2022-03-15), and this change ends up not making a
difference as this function is only called in update_submodules(). If
we return non-zero here we'll always in turn return "1" in
module_update().

But if we didn't do that and returned any other non-zero exit code in
update_submodules() we'd fail the test that's being amended
here. We're still testing the status quo here.

This change makes subsequent refactoring of update_submodule() easier,
as we'll no longer need to worry about clobbering the "ret" we get
from the run_command().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 29f3e1dd8c8..0fb780a724c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2443,7 +2443,7 @@ static int update_submodule(struct update_data *update_data)
 			    update_data->displaypath);
 		if (ret == 128)
 			exit(ret);
-		return 1;
+		return ret;
 	}
 
 	return 0;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 6cc07460dd2..c5f5dbe55e0 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -769,7 +769,7 @@ test_expect_success 'submodule update continues after recursive checkout error'
 	   echo "" > file
 	  )
 	 ) &&
-	 test_must_fail git submodule update --recursive &&
+	 test_expect_code 1 git submodule update --recursive &&
 	 (cd submodule2 &&
 	  git rev-parse --verify HEAD >../actual
 	 ) &&
-- 
2.37.1.1233.ge8b09efaedc

