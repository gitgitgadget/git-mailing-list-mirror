Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44166C77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 15:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbjEMP1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMP1j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 11:27:39 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9D2D74
        for <git@vger.kernel.org>; Sat, 13 May 2023 08:27:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1925ad4953dso5183722fac.2
        for <git@vger.kernel.org>; Sat, 13 May 2023 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683991656; x=1686583656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifVG5sW1x7mZmAs1kXDI/l9wb7Se3z+VgoqewE0P+hQ=;
        b=F2EUQprl4QlV3ww9ao6oCXBRPWfdSxW73KDt4Aj1Pwo3cZ0Sw8c/19Vlx7WCne7ds3
         8jqf/qo3D9IPRbSeGfP3dUCIugyrberro8R7SYSE96I7SrtDMITpbB+sM3xZXIHs8XBc
         6fTf//EGFhC+cpElTcT8Fv4C0CypgtBnZ844CYlJDk0m9isnAXlWlnPMxmB9vTDhkwTI
         Qaiw7D1xfZBUZygdgKCft2pvJrt7Xm0WZKakkNm4+J+ox7EX29t9DAcVsPMVdx8IBRYd
         w5RKb9HpnnKCSyIT6Q30uXu63Vl+RA9xXJ7WT51f0vZyr4tjkbyIMOKkmh5V0IOa29NC
         qV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683991656; x=1686583656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifVG5sW1x7mZmAs1kXDI/l9wb7Se3z+VgoqewE0P+hQ=;
        b=fE+vCYnLn4LKUeZT66rBioobxpeWiQX6xQRU65qdGmu91YMVy574jjPYNi7vWJEkV4
         CSpJgkkCNKZWabs3c6fWynvxt9LJ1LHqvHHdAunBVo422xJTeQ0ClLvAnJFYbtciukoE
         yUdj2ry7Q/Cv1xPuUP6aZ/SSr2SqqBMMx1JyWMGpgVco+ErsNwoIMBxhlgKk2ecOYj0c
         n8mZh/KLcPrMI9QP+vA96U4FqX6zoxRUbdBlN63xykcf5c99Vq/hl3fAbxuwxb7EoB7t
         iYe3yrkAq6ACJu3B1Du5Q+Nb6w+ihufqsH1SFm+tBmGps/vOEetlkdpTB8nE5QLoJr+K
         S4HA==
X-Gm-Message-State: AC+VfDxqEJnl6oo7rCvcxFp2oGW4dzdhivrshlZZv212nIx31dFrxkvp
        qZlXSrDAuwK1C+bB29AKUV2B9HIh998=
X-Google-Smtp-Source: ACHHUZ7Lrqmj3yy384cMHRJJmgWCLIDzaHLXh7CT2qpNoADDMpJosuH9QKWwmZ1+nXSUTibbpbP/WA==
X-Received: by 2002:aca:2112:0:b0:394:d4d:d09a with SMTP id 18-20020aca2112000000b003940d4dd09amr8975821oiz.20.1683991655951;
        Sat, 13 May 2023 08:27:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c15-20020a056808138f00b003874e6dfeefsm5456054oiw.37.2023.05.13.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 08:27:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: mergetool: unset environment variable
Date:   Sat, 13 May 2023 09:27:34 -0600
Message-Id: <20230513152734.3275192-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since a regression in vimdiff I wrote my own tool and set
MERGE_TOOLS_DIR to use that tool, and ever since then these tests fail.

I've been manually unsetting this variable to run the test suite, but
this is something the testing framework should do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t7610-mergetool.sh | 2 ++
 t/t7800-difftool.sh  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e..cc99c29c81 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -12,6 +12,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+unset MERGE_TOOLS_DIR
+
 # All the mergetool test work by checking out a temporary branch based
 # off 'branch1' and then merging in main and checking the results of
 # running mergetool
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 59d3847bf8..d78a7ee90b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -13,6 +13,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+unset MERGE_TOOLS_DIR
+
 difftool_test_setup ()
 {
 	test_config diff.tool test-tool &&
-- 
2.40.0+fc1

