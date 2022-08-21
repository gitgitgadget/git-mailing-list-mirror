Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A77FC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiHUN7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiHUN7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00314D24
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so6426288wme.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CZ+1rJlcEOd3WDzfyKDS3w+DRVvtuvCcmVvyklN4ljs=;
        b=K+Wh8R3BOK/dQ/Ks1SgrxZlS2Wv+DulNTLaT9JDugdWUcBfn8DUBYongQHD5vxBCfC
         NNgB05Gf6P4/pFG2uyKhhH3g8vgZzQYntNJeW6gvb7kXZM8uffFy8Mb4SGmbogmJiukA
         DUyFP692/pCuGINaNN+MHi4sREsSOs1FAR/77rMkyezYzxu71wu8ah9mFq1tXbGDgBMh
         9t4X6UCXqBv8lda0WVmcr2+IAJzqtCRPPH3HuvhXNA8fRYtpPM9EXbWoXDUXsCY4WqmQ
         SXHxxr/gY6uPLQ5D6JND7KLfUlNt7Al/0FffJ5QPpj9PM89wKPTtbZlQUfTGJ53RxfQw
         R1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CZ+1rJlcEOd3WDzfyKDS3w+DRVvtuvCcmVvyklN4ljs=;
        b=swlLhzsaVQYr1oRlm9O6jBo/1V0p1PSl3pViXV6wVYjg3yNNapS6AaF83zzLYQWt2b
         vVUnF4OYIudmj7Im8FdbN5rZQPM50CMmiye3UX8ZZ7eu1HGCQc3K+USCJt73YllPeQ+n
         jRUrmRq4e0IKiwbVcDOp3iA4Fz+n/d77BJuEkuyU++TPYwbREYN3Yq+OVir3bupWbYqR
         m7kZxwyqjJFDPxu7HVgLPSa4GbNl5ZhoRNNCcS6p6OGga983wVEH97+6WSF7lgu8PIvH
         LmiPMqJbJXtn3LAyk5iblbUNe0kgHXe52yamWNf1FURiZ/A7OiksL5BNUX0bveDAJJ/C
         eFFA==
X-Gm-Message-State: ACgBeo2n4Znvt6JVqfeoIrIhtTDs+TBLuOqEZvyCnJ9tXJ0bMViJ7hPL
        hXb74FZJJaCIbJgCsVYZslFywfYuwImHaKEe
X-Google-Smtp-Source: AA6agR7UNj68AiDZHIKBc0F7B2367OMazhzRUJeXW9sLTYDM3WGBMmaWWDua/C35T2Ygmm+td9Cmtw==
X-Received: by 2002:a05:600c:35d0:b0:3a5:f7ee:82be with SMTP id r16-20020a05600c35d000b003a5f7ee82bemr9664325wmq.206.1661090324900;
        Sun, 21 Aug 2022 06:58:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/32] submodule--helper: return "ret", not "1" from update_submodule()
Date:   Sun, 21 Aug 2022 15:57:28 +0200
Message-Id: <patch-v3-19.32-92e17c37839-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index fed92585a02..61468237af2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2446,7 +2446,7 @@ static int update_submodule(struct update_data *update_data)
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
2.37.2.1279.g64dec4e13cf

