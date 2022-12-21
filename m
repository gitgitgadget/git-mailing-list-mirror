Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E703C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 13:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiLUNrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiLUNru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 08:47:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD21AA04
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:47:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so36919656eji.5
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=pAZUcqudpKoLx4Ze8zx1q2V1MtrwcNP3obmrRhZm0vNI9PdvPt3kBVQjzph6DHFuo1
         MJmhm1nEy+ubZ31dpVRY19Hqb+1K5Qv49GWYNESazVRuSYO25VlKH0+gPicvwEjhnlhX
         hDQGIkA9b9Xige2r/lO5uLCLWa8hG8IQY+wnBrKnWf2zdApbY99WtHen24sKOa5x3o+0
         seg77ZSny6TPSXeJgsJqNqIdOE/Qv3HThQKlnq0R/vmN5ahgGAk47h/XuhBmekUNwVRZ
         svjxwk6GU0sWQMzbl9CO8HFi39HtR1/HLf7ycgyd+5JTSbrZ1Zrv1DlqfCVmoJwqokG6
         s1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=5PGeuC328/etfIGg5w44Y1KG01MVdCubQnm+jIA4NNWzzlATu7YL/SLMh8sLmF14B8
         1c5O/xT9RKHH/WthC4BJ59a3gEdh9CNz4U3QK4JbYMibJWRduQh7a0ONmq9HtKHzdTYI
         5zT2rm1ReCmk0EsP6m1YY/+u6vVPHm5RdDFfSYoz1XKKAC+8PJtsrmIvd5WrVkWeT6FM
         SqFFir0LiQuXqQPKFcq2uwx4a2OnMfqtvLh+4efYFHqpoG+QNPzlsoJRLbgj65jwNEQ1
         6UgVKW1DzTjLSccx7Cx62XjNcCS44F+n8t1EyS/G5dTRfRjWDjg2U/hg7yENKwKS2FX4
         Djzg==
X-Gm-Message-State: AFqh2krF32X26WNQB0vca8qmyyDbc9DpdQNzpOhCyLnHaSP2D3Jiaeqq
        HxJaeP2qNOWrktYVN2JRTOd7lHs9t20mVNT+p5A=
X-Google-Smtp-Source: AMrXdXtuBUnNbN+vFZlUw+IjU3JKFqlf+K5NoUVAzyElmlOV1ALr/izL+Ug87kC6oNtagstsDyrWqA==
X-Received: by 2002:a17:906:a842:b0:816:ef2a:631a with SMTP id dx2-20020a170906a84200b00816ef2a631amr1443333ejb.31.1671630467641;
        Wed, 21 Dec 2022 05:47:47 -0800 (PST)
Received: from localhost.localdomain ([79.140.126.226])
        by smtp.gmail.com with ESMTPSA id la7-20020a170907780700b007815ca7ae57sm7186254ejc.212.2022.12.21.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:47:47 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com
Subject: [PATCH v4 1/2] t0003: move setup for `--all` into new block
Date:   Wed, 21 Dec 2022 14:47:31 +0100
Message-Id: <622475417916cf48b8fb48e3587f6c87750d43ed.1671630304.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671630304.git.karthik.188@gmail.com>
References: <https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/> <cover.1671630304.git.karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.39.0

