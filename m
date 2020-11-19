Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCEC6369E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2384322256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQYOy1Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgKSPw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgKSPw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:28 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E59C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r17so7006026wrw.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qMTWhMN+LLjYiLcXeHd4DHknZxr/m76sFg4Y83A66QQ=;
        b=qQYOy1WjcCeLxJ04TrsvpBAJGB1CfSqgf/x7bWCtTZTrQpPezGbp2U2Vtem1Q/7q7w
         osEkQRSwGpBlVwgBikNuaFCATqmeAFUsDKQhFn0HLz00GW6oOBd3rrcHocanCtAjGJ2G
         H+EcYmzNmvKXOsgHY18rQr+73isYrJKhAu3ACHg5gNBYRQIzB0Lc886bCwAl0CI6ezrG
         isnBYNGFyZsiha400SfNKRmT+XGJnIruPPlTcrVkFyp2BRqfGhK0d3d3hsEGlHKPVa8c
         qK2u9/VFXPcFiCpFAxrpsVPu05748nhezGnz//dmAsDUZW1ovPbuzQqJmK+v1SiQ55TC
         ffWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qMTWhMN+LLjYiLcXeHd4DHknZxr/m76sFg4Y83A66QQ=;
        b=uOnHfitz9UwgroyUpMCgc93SElpM2kIUWu0qScWqHsCdWMk0jU+Yxvu98vYBoLNfDl
         R9K8B5rHli7MYlxqWGxX4d6vEXfooEapP2j2MBkfCrY8iPF9Uosmrr6gbN4z/pZH16iz
         KPVFVcnxfTcIObDTgzEiUdD4k7m1YYt7VzxLYmCZ7qLvPdWtGLjQv5jBD2wdlr5IVpML
         FWCWQ7XXlYEfx+8PjJ2Wx15YRFbyLjKsiu4xRArwuO3CchSxVtnyJ+Tjplts2yzr+ZMY
         MYHaYXZ25VZdApNbx8sbphUpKEQlnyT7CKCpik4sGky1HZd+6LTeDzyq4co6uQ2MxsDL
         ozsA==
X-Gm-Message-State: AOAM530TT71btj4uZA+XAgoJotyYcsSPjVfgcjr0EgnUByubMk0KfEgO
        yvA2rXiuAD2djxeSVJGMKUC29o/3TdY=
X-Google-Smtp-Source: ABdhPJwWVr2iggx4F++45IOwJhCUHU9ZrgOV9B7A1LriIUWuVo76QNRv/qHmzGMkI/yiNvdLw0dMOA==
X-Received: by 2002:adf:a40c:: with SMTP id d12mr11101361wra.154.1605801145840;
        Thu, 19 Nov 2020 07:52:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u81sm464661wmb.27.2020.11.19.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:25 -0800 (PST)
Message-Id: <1237289706d3786b332c8f5930402088a6382258.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:18 +0000
Subject: [PATCH 2/7] t1300: add test for --replace-all with value_regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --replace-all option was added in 4ddba79d (git-config-set: add more
options) but was not tested along with the 'value_regex' parameter.
Since we will be updating this option to optionally treat 'value_regex'
as a fixed string, let's add a test here that documents the current
behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index ef56b08070..74e0f84c0a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1949,4 +1949,20 @@ test_expect_success 'set all config with value_regex' '
 	test_cmp expect .git/config
 '
 
+test_expect_success '--replace-all and value_regex' '
+	q_to_tab >.git/config <<-\EOF &&
+	[abc]
+	Qkey = one
+	Qkey = two
+	Qkey = three
+	EOF
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	Qkey = four
+	Qkey = three
+	EOF
+	git config --replace-all abc.key four "o+" &&
+	test_cmp expect .git/config
+'
+
 test_done
-- 
gitgitgadget

