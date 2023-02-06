Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF1C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBFXIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFXI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CF30B39
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so9426462ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELbiXgPE1CdT32ShCWrt2/TVzy5K3bEoaY37yU/KgfE=;
        b=Prq05Kxz1E+UWzS0qrFQ4OM/l9EkAIyEasSN2knIU7GWhAeZro+kPZOfUnNAf4KMt2
         bGoyaooO39yClOd15fMyx9Tbu/JmiIkSHPPWgSh8IwfUsozS127W6Zcwqih8XCwcsYLj
         urp8mli9wJXnqlYPQuJlZV+ZdxZTcYFUIx91FR35B9Cy3t0fMqa5TVWX216YLnH+XUG9
         pfHNfDC6lE8QYdshU34iTCE2jXyEywT/3LSBKW/J/zps/+nUkutERdchUH9twG45x/1x
         96aa5HNm6jmsVmzF7xE8sAAcgiLY64UpHGvXb5w+Csn0y/jhP/0R8f/fSM1Vgp318SUA
         04yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELbiXgPE1CdT32ShCWrt2/TVzy5K3bEoaY37yU/KgfE=;
        b=58YKsUs9LNffkP2AtqXxJ5weV7Hy8PQv+ewIzTTS2iBeqJ0N1UMETUVA5BjZplWQIR
         +VsTqhzL4eMIT5ZXNy9A7VvPl2lsS0es/7ZvfG5vVbHIAjMZLx0FtHQr5EmLHJpW3pim
         /czQmaL66rKMLs3/0sukaf+Nv4MOwE0ePeRk5UE2SoYhdlgsXCQhcyYBKa4hu9fM4zuF
         1B+svDjBlHhw8HQP0LBwDuseNpi2dAb5BzyqbfuXTK3+Ynvh/z3DjNodQNznixO92hya
         5Sqa9qH3oEzNwnNBapth8/oCNihDeneC2ubMyqFEks3Zbadlg1CpSjhIv5O7R/qHHQDf
         ypzA==
X-Gm-Message-State: AO0yUKWuz4t7QiI2RG2iD1eoUVZIcbJohU2V9S8OFyHTAJJTO96mu3v8
        Ku5VmchS/ZYos7hnqiOMTPogW9JPReIHBP0l
X-Google-Smtp-Source: AK7set8z/fGADo86pk0N6sZh1eRbRr/aiLRVaEx4rcoEU2pHyvNeGNob3e1XwhZJHCR1iOMmyYjIUg==
X-Received: by 2002:a17:906:d051:b0:86f:3dfa:4016 with SMTP id bo17-20020a170906d05100b0086f3dfa4016mr1095299ejb.7.1675724901205;
        Mon, 06 Feb 2023 15:08:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 12/19] show-branch: free() allocated "head" before return
Date:   Tue,  7 Feb 2023 00:07:47 +0100
Message-Id: <patch-v7-12.19-b8536257029-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop leaking the "head" variable, which we've been leaking since it
was originally added in [1], and in its current form since [2]

1. ed378ec7e85 (Make ref resolution saner, 2006-09-11)
2. d9e557a320b (show-branch: store resolved head in heap buffer,
   2017-02-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..358ac3e519a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -956,5 +956,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+	free(head);
 	return 0;
 }
-- 
2.39.1.1425.gac85d95d48c

