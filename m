Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD6C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiG1Qau (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiG1Qak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DFA193E3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so2878549wrr.10
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=b3ToLErw8PA2w00NMfhGeGmunYegTqzi6gghmbJDE84=;
        b=cttxuWyufPU5ePHY9pB8y4E3Qi0KOAZcoYOpK+MdBMaBrOXrfrNTnIn+v9wNuSsNfA
         up70fJARFPh8TNiXcpEt+/pK8TkWmCZ2/XqcsnuqfiQDZLviUgQCdzVs+WHv+LJ97ag6
         xGKT62cTq4NVO9y3/jc6G6Ejs3GdOwqM9qKq1r2YdLpr+HXBJuDeHsr/fJ0Yu4KiCACN
         is4WkbBgJ+wTR2c5KgHNTb8RRW2iMwdO6oxn4ESEhSbNSdoTBXUK8zo70og6cqtW0v4D
         gj8S/2+aCTOy+VCblJ3M6FOIbiCo4qTvav1mSbyx7FXq2ns6mHizbbouvDsD+Bx5PC13
         DdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=b3ToLErw8PA2w00NMfhGeGmunYegTqzi6gghmbJDE84=;
        b=Bh+mgkAD/dtKOGNxNxzgBTFiC8N18p4vSEUemJC1wTPYskT33EjtoIPJ2umL6yPDBk
         wUfHv6E1lfa6sELyslhJPOtPdDlhupPCyFtS1l8K3BznleHwgjGHUag4/Tvs5pfOAbo1
         1LBX1vW20w7HCf3HdPRRd71jT2jX8+4AAhAaw183vzFC0KKN9IV1oe9TMfKEhUSe8rHV
         sdVVftbR0DrEwHIG4iWW6wy7v803Lf2HYQn788+Xs8oa8sAg619rVvEtgYhRkz++NOcy
         xXMvuG3JtWcar5rPqmjUjNcSvS4ljG6l73zbsozwVJY6+NZoSlU22knshfsL73Oiejj7
         xIqg==
X-Gm-Message-State: AJIora/4E6Ax/fU4j4nXlUydLkCSDjIAu6t2NbB6Ma1ghF8WWkq44rav
        w1mf42gk12Xgv53bSi3JzNvzTdbjU4wBFg==
X-Google-Smtp-Source: AGRyM1v+6FPMI8Bfy63GWvbwWC1RAzfvMpbxui/MOyR8Rkm7WE1dhpCnI3SuLBdhahK2tUh2/IPN2Q==
X-Received: by 2002:a5d:60cc:0:b0:21e:5844:578a with SMTP id x12-20020a5d60cc000000b0021e5844578amr17509581wrt.505.1659025827804;
        Thu, 28 Jul 2022 09:30:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/17] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Thu, 28 Jul 2022 18:30:04 +0200
Message-Id: <patch-v4-10.17-dae2a6f8e07-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the get_default_remote_submodule() function added
in a77c3fcb5ec (submodule--helper: get remote names from any
repository, 2022-03-04), we need to repo_clear() the submodule we
initialize.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dbeafd9787d..f8a92ecf86d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -62,9 +62,13 @@ static char *repo_get_default_remote(struct repository *repo)
 static char *get_default_remote_submodule(const char *module_path)
 {
 	struct repository subrepo;
+	char *ret;
 
 	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
-	return repo_get_default_remote(&subrepo);
+	ret = repo_get_default_remote(&subrepo);
+	repo_clear(&subrepo);
+
+	return ret;
 }
 
 static char *get_default_remote(void)
-- 
2.37.1.1197.g7ed548b7807

