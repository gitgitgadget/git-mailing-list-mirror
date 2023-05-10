Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37DAC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjEJVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjEJVhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:37:47 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EAE3C02
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:46 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1929818d7faso47261103fac.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754665; x=1686346665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KXdjw0PgEHcPlTXUiCk1KHMUozzOt/ma348ZDoKqHc=;
        b=eTlI4nu/BDqYaOfGcJOOv6FfZCwFxYf0Bn30gHqQRNPKhpydBRcnKvNrZiaLB3l3Hn
         kMAzRmrUqKWdxaLcl5KoNO9DU9BNkFAo1IiinyN62SV9dwTMKlSsTHs+7nUGdVRLXnen
         T+mWH0Asz6HeHuCzblZhdF9FQmORRIC3sU08zESu1q5GvCBaB40OdASQ2WFPCgwt+sv1
         7TWQi+1B+oZxhdzvM6WuEBJACD2wz8l0UZcRFUdAKnSNJpG+9Z1gOPUINhVx29Gn+Q/x
         LcLQ5b/9qXnnF//Z+EZhixJBJ+/pNZMzsssixaaDesRtMCYssOep8ofKRTcJlIxqY0l9
         dDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754665; x=1686346665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KXdjw0PgEHcPlTXUiCk1KHMUozzOt/ma348ZDoKqHc=;
        b=FO2QNT+NTjaQiWAEslwo7kS3U4eynYOFpakRCcba/N+QUJ7FaXHoqEB5rdWC4EgqHz
         w5ty61nuKcP/93q6lAJLO2ti6CYeMWOEBGBE7oN0sD+HR9l2WLPA+EVzY+nzt5btb9Z7
         07+gLqC3B4ERN2/v2bFA2+mCZYITweE76NLBQiY0fJd/XRVQJYy4tcl4XAazK+za40cs
         QIGIomF07AfIKGkg4IsbdNYOGPtWoZ2tfvzLhB0EL1Bk+zt7NKouvZlh2FWP8bumPjrQ
         oPYheIy5jLU+cY1ZxH/x2Y3Bcrp2+jUdNVM1frE6sJOTNd1PeOTRwvKFyzvq/UwnDA87
         Ix0g==
X-Gm-Message-State: AC+VfDwdGQwayF2Vw1eZ4LtIvn2pxi5Gl/xudEuinesqOikOKUJhwHj1
        v+4HhyQptlFL5D77RkbX5jDHo6SC0OI=
X-Google-Smtp-Source: ACHHUZ6kJJjgGRuFyw2RGKFTdrxvNfYHFE1CZlAS1NBsGfCpB6SSK+Lbynzu5Qtec8SL4cMu9PNukA==
X-Received: by 2002:aca:d987:0:b0:390:5cee:53e0 with SMTP id q129-20020acad987000000b003905cee53e0mr3630295oig.23.1683754665733;
        Wed, 10 May 2023 14:37:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f2-20020a4abb02000000b0054f5b9290ffsm4200740oop.34.2023.05.10.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:37:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/4] test: document broken merge.conflictStyle handling
Date:   Wed, 10 May 2023 15:37:38 -0600
Message-Id: <20230510213738.505241-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230510213738.505241-1-felipe.contreras@gmail.com>
References: <20230510213738.505241-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently both merge.conflictStyle and --conflict=diff3 don't work
together for `git commit --merge`, since the former wrongly overrides
the later.

There is no easy way to fix this, so mark it as broken for now.

Signee-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6440-config-conflict-markers.sh | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index c51512ced6..3ba993a6a8 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -82,4 +82,35 @@ test_expect_success 'notes' '
 	)
 '
 
+test_expect_failure 'checkout' '
+	test_create_repo checkout &&
+	(
+		test_commit checkout &&
+
+		test_write_lines a b c d e >content &&
+		git add content &&
+		git commit -m initial &&
+
+		git checkout -b simple master &&
+		test_write_lines a c e >content &&
+		git commit -a -m simple &&
+
+		test_write_lines b d >content &&
+		git checkout --merge master &&
+		! grep "^|||||||" content &&
+
+		git config merge.conflictstyle merge &&
+
+		git checkout -f simple &&
+		test_write_lines b d >content &&
+		git checkout --merge --conflict=diff3 master &&
+		grep "^|||||||" content &&
+
+		git checkout -f simple &&
+		test_write_lines b d >content &&
+		git checkout --merge --conflict=merge master &&
+		! grep "^|||||||" content
+	)
+'
+
 test_done
-- 
2.40.0+fc1

