Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E96EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF1SSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1SSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 14:18:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175D19B9
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 11:18:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5440e98616cso912759a12.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687976298; x=1690568298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJtAoMNDGNl6NxOxtd1ktQiPJP/98NMMtdxoBl5Lb+A=;
        b=NP0AJcu0UoQEnGvUfeomoUhULbR+Eg+II68HjISMp+8SunANXq0JLrKWf7AVc348Xa
         AxfnFWzE0IeMNhwYzaLYEP4qkWYc5rb/McbKCgbP1KoncN4uug9xB00RqfCjm44MhhIF
         sOGqUc+yb283TcjC7eqcKT2oMT32el7V6lsCan4uMxSEttpYkOiv56EW/37EuhIxnmgY
         Pqw78rejqDBQkCmdl8Aqs1hCVqNcPThR6UK/mEZA0ppLEO9csnCWPKWFERxVFpEdwV3q
         5EVPbXXkN1cPbRm82gAKtmoGPP5TDZz4hyXnzgmVyUMEfNbxJth+uhpFVJvnplA6vsCD
         qY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976298; x=1690568298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJtAoMNDGNl6NxOxtd1ktQiPJP/98NMMtdxoBl5Lb+A=;
        b=XZHsMfuSFygDCCKDOTXdgtXOPdbymzLtdQraXvll4MhHbLZav9tV/4bdBrLm5ncdvp
         mNG/1vqtuy9W54FCJ8Eb4HFCJfMQC0n1ZGEIQQaD/LFe4S+NRpFnTJvnwUs40Fdc3HM2
         sSx5bF0ca7iOpiD0v6VsBbuPo1tdOhLDxZrqo7fIi35A+19jPEWhIEQnzwkDjrUyqP4/
         R0dHe4uLywxT38Pbg1ws0vwPTObyjKCqE5bbikCIMbMs8xVMg9wQ3MiYeAOAgijls9fh
         iPYsD8rkmvxQd/cEehtJSViM2TJm050QU3oZSitselpG85eQCy9Ejb/DQpHnXG/b5K+f
         +sZQ==
X-Gm-Message-State: AC+VfDxlQA6L12JDi4PbckIxvwWkV/j4Q3+q3H7j6E2dxFmXY37QWKuN
        vwWybKV1FUQrB1wAuCAoDe9fQ4eLHpaCqw==
X-Google-Smtp-Source: ACHHUZ6Hxx4iTcOQyrrCBTQ1xJpx8CEwwDCv8ShXUIhEYAkKeIHcDHtM0DpNE3kDs/lLwez/8alskA==
X-Received: by 2002:a17:90a:4e08:b0:262:e2ed:d847 with SMTP id n8-20020a17090a4e0800b00262e2edd847mr2793016pjh.10.1687976298326;
        Wed, 28 Jun 2023 11:18:18 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.157])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a018600b0025bd4db25f0sm8648178pjc.53.2023.06.28.11.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 11:18:17 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Eli Schwartz <eschwartz@archlinux.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH] t4205: correctly test %(describe:abbrev=...)
Date:   Wed, 28 Jun 2023 23:46:59 +0530
Message-ID: <20230628181753.10384-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pretty format %(describe:abbrev=<number>) tells describe to use only
<number> characters of the oid to generate the human-readable format of
the commit-ish.

This is not apparent in the test for %(describe:abbrev=...) because we
directly tag HEAD and use that, in which case the human-readable format
is just the tag name. So, create a new commit and use that instead.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4cf8a77667..b631b5a142 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1011,8 +1011,7 @@ test_expect_success '%(describe:tags) vs git describe --tags' '
 '
 
 test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
-	test_when_finished "git tag -d tagname" &&
-	git tag -a -m tagged tagname &&
+	test_commit --no-tag file &&
 	git describe --abbrev=15 >expect &&
 	git log -1 --format="%(describe:abbrev=15)" >actual &&
 	test_cmp expect actual
-- 
2.41.0.29.g8148156d44.dirty

