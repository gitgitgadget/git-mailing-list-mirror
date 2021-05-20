Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D6C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057EB60FEE
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhETVsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhETVso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB207C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b12so14389044ljp.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJ1w7idvQFx2geKfGCvkNfGNY/IV3ti4dyZkMsKjReY=;
        b=Suw/O5GAYqQcHVkhwF0VYadVrZs41l22oKcTTATJFo6tl9mNPE0VFka8dT1LmZlK6E
         SSmwXRDUfde/b9OxImWAxUyi3Y/1Sw2+OTo4tcS3gqxdsBB1SSEXlDrYMICqIuPaPKhw
         vVlckPv+5hBjdt9gd/7UlnWnn/dSbg82msAgjVoilVLC+WGIcZSgfM+MB/IrgvboxGF7
         kUGS5JTjVZaQKEkRW2MDSo1pIAfDAEYYKxXHS7yl9Bd6G2PISa9zsmDuOZKiVvE3BWM5
         zVA9p6/yjf+iNtaDMbn/FVt9zptjxC3fDhk/kfAZer/19OPKode09Z4BiGzkzVbpmtPf
         L7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJ1w7idvQFx2geKfGCvkNfGNY/IV3ti4dyZkMsKjReY=;
        b=traMw/i5TzjXZMDdwy9tJA7v1td4ZGjPMGVPd5N5Pbe0k4uOQvVhhSEf42Y0czLZm0
         iXckuYMK5ylI7zCQZpNOhevVb6Q2ZsGmucTeXxlwl1DkvFbVBU2x2GEmx2xg5z+rxT/p
         7bDGqMlWMxbPsT35HOe7I6aYF4TzCJwvs2j0wJN1HsAZwnyf/erb58YWf8s/Q/Nd45dv
         +l9Z7+6j3x8aIRbju8CpbU2yQIctqy6n5gagXzq9SCqONkMq+wpUyqTbzXW3JCiG+Deh
         r5uHrrhRI73eeDDZbeEe0NunaZOG9SDXMte95qsYH5shUEg4G3ZbUMVTkcNffX1o1Hiv
         IM7g==
X-Gm-Message-State: AOAM533tRhKisYqR/hTdZVA2bDdrtwevR0RyVHWJ1U2xFVHaEQak6n/E
        asa7v1Pz3tDx5saCvNfmC/KhhCe1L3U=
X-Google-Smtp-Source: ABdhPJwKHHr+pFXYWc0PQiIteSZXidu3rFhFcq7/CQsvTpN15umUTYAvj+8F+s/uSBEeF8KZZHIMsA==
X-Received: by 2002:a05:651c:1408:: with SMTP id u8mr4388829lje.401.1621547241149;
        Thu, 20 May 2021 14:47:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 05/10] t4013: test "git diff-index -m"
Date:   Fri, 21 May 2021 00:46:58 +0300
Message-Id: <20210520214703.27323-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-m in "git diff-index" means "match missing", that differs
from its meaning in "git diff". Let's check it in diff-index.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index bdc23b1180b0..e561a8e48521 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -494,6 +494,19 @@ test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	test_cmp expected actual
 '
 
+# -m in "git diff-index" means "match missing", that differs
+# from its meaning in "git diff". Let's check it in diff-index.
+# The line in the output for removed file should disappear when
+# we provide -m in diff-index.
+test_expect_success 'git diff-index -m' '
+	rm -f file1 &&
+	git diff-index HEAD >without-m &&
+	lines_count=$(wc -l <without-m) &&
+	git diff-index -m HEAD >with-m &&
+	git restore file1 &&
+	test_line_count = $((lines_count - 1)) with-m
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

