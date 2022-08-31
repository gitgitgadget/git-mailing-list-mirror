Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F57ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiHaXTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHaXSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84109C8E5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso433500wmb.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0deIMqRssHJnhF+97Hb/RsRCpTEMFfSZNWXu0YUuhZU=;
        b=Fd1rJhcSbRbLda8BASBre+JVAvrucK2KdGRY4+R1R/3WLxhuaCEFmFLRTKMGfZxdRY
         VTLVctiBEAwEo3araidwFLqVC4v7AUzBqWdF6YC+SMgAgg4h/c7PUDfNPIz4QwhuCuRy
         +Or/JsbvMQqppTtCL1VLyykjF8nF7Tb5tOLyOLU2X5O5MzxoxZN3IBZksk9xF5pho9bG
         wTufHWaPzixcijzHLsEOOKMN2wL+EaJw1C8UEMfZ82HsvE7E8tm/0XF0wP80kAGrslqu
         VoU2n4J3P8uzHpNjFtpRtkh/2Z6TeXA6SB31q++R7JQcCGMThbPaAUi4oYmg+2OkF9aX
         j2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0deIMqRssHJnhF+97Hb/RsRCpTEMFfSZNWXu0YUuhZU=;
        b=0jlMQ3JVU8YY+bK/q00pvfGcG/xXtMToBLrQwDSlOf5J1MjIdFg+AKyEXS0rUhYpUp
         XvhZ73M1U1NMK4TZ5DMgLWBM/GcxgJzrbPIPlF2qYZDZ68+OChmFs+fu9uC9+7PsyNSq
         u+K2mcOrqO032tM7J0GAGbXx/BXmdqq81HaoOPTd40uUzT5gj27txztndxM8KvltezEc
         cPZH5cHAEjWNpwlPpD+Mpdx5UfvkLVfmc9luL5/D8RXTm0joTJWWMGTQJb40TpU4mlH2
         7YKfJb1nmRRRFYN8blvCYxwnhIAcrCIhflrdbtNE5lFy9RvvrvRSMmchx+dvTliOBweZ
         4h3A==
X-Gm-Message-State: ACgBeo0dDdurArxb2fDIiPYX9Qx88aEZP2URG++hR9xvvgstB5QMLT1u
        XA3/i4YzxLGZ82m2GVWo6L1PhFmP9A4O8w==
X-Google-Smtp-Source: AA6agR79DYJ9gHmS0jwNYPlwh5BgnPO4MDMppN6KzvpjO/D+JD8roE2845ljem078xZGe1NGQH+Jmg==
X-Received: by 2002:a05:600c:2f88:b0:3a5:4014:4b47 with SMTP id t8-20020a05600c2f8800b003a540144b47mr3302876wmn.96.1661987916337;
        Wed, 31 Aug 2022 16:18:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/33] submodule--helper: return "ret", not "1" from update_submodule()
Date:   Thu,  1 Sep 2022 01:18:02 +0200
Message-Id: <patch-v4-20.33-fdd9ef8b6f6-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index 4fbbffb4637..59c3a9afe6e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2448,7 +2448,7 @@ static int update_submodule(struct update_data *update_data)
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
2.37.3.1420.g76f8a3d556c

