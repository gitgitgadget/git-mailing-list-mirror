Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79876C4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiD0RKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiD0RK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:10:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC042E9D9
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so2709870edo.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmxWRJ/YvRLDS1YB5l69ff0bY2MoMfMAgwlnikl2lEw=;
        b=MLfsC9ivax2pUEOcnACMXksR+iFu2IJullnK4fOWBgAWxqaOdfaPlr0NbquutlYZx/
         WR6YLEBPfQu3s5n8rwKrZ+yYF9rTzoMNMqV7tI2GKEnIDPfoYtwASsXCIceHC3wBmuXX
         rB0r5M4xpkzzSLxxK2IxVHYjRoDORg+Q6mygNqZCdrPJ8tkrPweW1p4JK02ptB347KVB
         WS37Y5NU8vnmsV1VZgKuNBNVbAB88gpm56iR+GZ/q24cYGp+HDMT0r/GkSFGMCXxxj7n
         U0IIBEX7VvG6UbQwwdvjdWhckfxW0YM/fpFVkzxCBTtPvuOzrLyFonBXxbv+BJ5cp4mN
         gBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmxWRJ/YvRLDS1YB5l69ff0bY2MoMfMAgwlnikl2lEw=;
        b=mcdRtEu0YYnoiICe1OiVzi1rDy31AJoE4lrHnGeyMHYejy0Dj+IcJWheEzhZ68BzwH
         ZyE74JIHlPHr4s/CXL/VF3OYmL/0f/CJcAqXE4DPo4MgwoEmqvwrmExQqt/29bcZc4pI
         0gHdpIzDxIKSSlxFRvbUVuyodKQf1y3AK1epzJ1sG4kmMTFpsK+B2pmROnD+h/Djr/S/
         nt8nxaNKTXxB8lo0zO0Eobguoi0o4EX8WX2FdhnQYy9Qkh067BS87ig5Eoli9Gt2KAeh
         swTLd+nm2DGkN0BIQMwDrJaEzhEaErmbhFWxrPgPc9n8J02+l/6GtTzBCfyz4ySmde9g
         NsLg==
X-Gm-Message-State: AOAM533rc5+I40xwLeJys+y/IeDy1sW0jVU80dhFcESV4ovm+oMx5AwD
        jpQNFPNvKLNfwVkkzp7AjmVRSeaHL3oOkA==
X-Google-Smtp-Source: ABdhPJyYrvYpCOsHDXgkukxecVPBPv2lYhuHR2tzEIVEEM/eujmz4qP101W8hvlSDCPsqghMyARdWQ==
X-Received: by 2002:a05:6402:6d9:b0:425:e968:725b with SMTP id n25-20020a05640206d900b00425e968725bmr16980451edy.213.1651079233557;
        Wed, 27 Apr 2022 10:07:13 -0700 (PDT)
Received: from buzz.local (62-165-236-195.pool.digikabel.hu. [62.165.236.195])
        by smtp.gmail.com with ESMTPSA id jl5-20020a17090775c500b006f3b76a87ffsm2748849ejc.51.2022.04.27.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:07:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is ignored
Date:   Wed, 27 Apr 2022 19:06:48 +0200
Message-Id: <20220427170649.4949-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.36.0.676.gf39b21ed98
In-Reply-To: <20220427170649.4949-1-szeder.dev@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the documentation 'safe.directory' "is only respected
when specified in a system or global config, not when it is specified
in a repository config or via the command line option -c
safe.directory=<path>".

Add tests to check that 'safe.directory' in the repository config or
on the command line is indeed ignored.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0033-safe-directory.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 6f9680e8b0..82dac0eb93 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -16,6 +16,19 @@ test_expect_success 'safe.directory is not set' '
 	expect_rejected_dir
 '
 
+test_expect_success 'ignoring safe.directory on the command line' '
+	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
+	grep "unsafe repository" err
+'
+
+test_expect_success 'ignoring safe.directory in repo config' '
+	(
+		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config safe.directory "$(pwd)"
+	) &&
+	expect_rejected_dir
+'
+
 test_expect_success 'safe.directory does not match' '
 	git config --global safe.directory bogus &&
 	expect_rejected_dir
-- 
2.36.0.676.gf39b21ed98

