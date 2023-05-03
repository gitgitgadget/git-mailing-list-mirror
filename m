Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A4C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjECNlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjECNli (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 09:41:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A71A5
        for <git@vger.kernel.org>; Wed,  3 May 2023 06:41:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac7561c0feso6595201fa.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683121293; x=1685713293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYZxO/ia62rusuqegXv3lhzhUTFPhAHqg9mIq+c85/0=;
        b=D2ccPapvEO0V30wwnoevnK9YI3mAGhILwj6Vd8S42qrkJv9vJPkJ0+kSAo9mAN0Lxs
         l+KA/EhabckJutAuanIowV1RPoeib3YwF1q6dvmlOuE0neaDLCWP8XZk7/JbkIPtwNoc
         L0wW33lY9ljwsP6uL/k54OQAGbaI9Yvq9+I9L5485dYgnFheP36VdcD2kBHXvKLbW+5T
         UqynKTJKUyyIPstJqU6Nnqkfo7e7hY9lfn72nNU9j/xaJ0rcFxdsdb+xmv/iZZqOWXF4
         U2X/Hiym4Ndv1+6meAE1gTOQhobMJe9Ra+dn+P5ZgLDBbH/HSz5reEFWt6Wtxm6MAmj5
         yHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121293; x=1685713293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYZxO/ia62rusuqegXv3lhzhUTFPhAHqg9mIq+c85/0=;
        b=XkZlaeWIUFLbZn4ZB3lF+6ZXIac6gP/MsaYiFRbjxTgfHVIGZGu5cscUp5GgEmUoGf
         zUulOwcmK0o8FcpnX9D1dSGneVoUv8CAWfsmmT8Xc2ZtA4oUO7gXnWd8l78FJsXpwrkX
         S6uFqGvzC54Uki6BwqUsstH2WP4o9OGlhQHAuITZTFY9+9SXBqmECVwfjYq70nktktmD
         YYiTFtddIqeoxCIzbKl2zXWyQ7zgM4q2804FDpFIMDU9J9f+jTLMJYdZsgUgg6IGIxPh
         ZuOlP/gcS0yHt9U50iuCm/2qRtXxsn0tFLWdSk52Ic/NP8cIIrhR/qLQaL5+goZyufG3
         rVcA==
X-Gm-Message-State: AC+VfDwTbX/ncHN4oP1T2mVqkFQZG5z2/IFwOEtAZ4pe0z9AQ8osEFN2
        z8U1XpC8YzfA6sZyTuR/t+w=
X-Google-Smtp-Source: ACHHUZ6JHjD0Ya8I73VZzNOstfdfhwS1+fNHLN1kbAPU9yDkx2tUa0D1itlh0NDubQ0N8UT0xKz8pA==
X-Received: by 2002:a2e:8896:0:b0:2a9:f640:2032 with SMTP id k22-20020a2e8896000000b002a9f6402032mr55252lji.5.1683121293139;
        Wed, 03 May 2023 06:41:33 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j25-20020a2e8519000000b002a76c16ad65sm6022680lji.87.2023.05.03.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:41:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Date:   Wed,  3 May 2023 16:41:18 +0300
Message-Id: <20230503134118.73504-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--patch followed by --no-patch is to be a no-op according to the "git
log" manual page. In reality this sequence breaks --raw output
though (and who knows what else?)

Add a test_expected_failure case for the issue.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..f876b0cc8ec3 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -457,6 +457,17 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+# This should succeed as --patch followed by --no-patch sequence is to
+# be a no-op according to the manual page. In reality it breaks --raw
+# though. Needs to be fixed.
+test_expect_failure '--no-patch cancels --patch only' '
+	git log --raw master >result &&
+	process_diffs result >expected &&
+	git log --patch --no-patch --raw >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
-- 
2.25.1

