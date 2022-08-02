Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FEC19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiHBPzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiHBPyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FF19C28
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv3so4528260wrb.5
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xL9jLTby/Z54BDd5pyHMDutjBk8wq5//YIfyDaZwy/I=;
        b=SbKFgrV0guB3aYfL8XlCi8yohMHhQLe6gbak4Fiqr3zny1OEXVz8kObe3BJHjEMx7d
         DGjOPqDsbbKs1Dxd6GkgHWbbEXLgQutXAqxDV0p71ozybCL7kKON8p/OMTRPB28pbmBT
         fQziw+bX+mgVoEhoBEfUUM2nBIV/WkYl3UDB9TC97iF6rVZaJ86WEpyO1a53wLxOy+8d
         4wNa2chjuqpORakvtDfO7jajqO9+wzKOGTpHMq22WcP/HyvIxadVFpnWryUPlJifbuV1
         sNUsU3PpiTTRACXQHO7bc8bcwqIGNwm8Kg2dZBwbqYSFJYuNKWk4r0ZjTD/Kt2EfxlKF
         6SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xL9jLTby/Z54BDd5pyHMDutjBk8wq5//YIfyDaZwy/I=;
        b=HxMGvBw7Qcytz6KgpHjUmfxNSQyJY17A1Hp+9FjP0RvQmWy2/02MN80u5iTwcFolem
         +DZrrOpio1piovGuz2i/bwx1bcLvKyMVUk8hMzO76hrI/wHv4h9jpkoIfXJlvWtQUw30
         lLTcTqiLUTTGNCkBU+MkL3E9ojGL3T/JXr7ktqLYrnajBKaBOmCUSs7gljgkVYCPa2H9
         yACbqSHzKbj3FULvQS4karBnZUZ0x0Pn2CHTetydSOdQmVQorKDnlYyHaeMLF4SB6SbR
         tZKmyOa4B1QqjJcQWjyBwHrznof+30OGGqoRsa27q/QQ2O1BMMktRlysFfZ6jFiMGZ1L
         Jiog==
X-Gm-Message-State: ACgBeo1J3aWm+IW1uKP/0hbRmUzFy5hYQlDyoDfD/qYFfCpz6QvrmrGK
        VQfIPmS6DU1FPAmvzx92EET29tL7smZ7Hg==
X-Google-Smtp-Source: AA6agR6KOAyfztB3/VhsVCf+1yCeaDQrM/CE03/8YvgUsMGdsdRLfQYyqg4HqcITqhFzkZhpMRczbA==
X-Received: by 2002:a5d:59aa:0:b0:21f:57a:77cc with SMTP id p10-20020a5d59aa000000b0021f057a77ccmr13356016wrr.384.1659455692267;
        Tue, 02 Aug 2022 08:54:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/17] submodule--helper: fix "errmsg_str" memory leak
Date:   Tue,  2 Aug 2022 17:54:31 +0200
Message-Id: <patch-v5-07.17-1a85057cd0c-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13), we sometimes append
to the "errmsg", and need to free the "struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8e9ef58f8be..68bf0f9178f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -980,6 +980,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.1.1233.ge8b09efaedc

