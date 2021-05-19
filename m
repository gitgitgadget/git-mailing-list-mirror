Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A784C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4703D610CB
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbhESLtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhESLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:49:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F39C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b26so2650968lfq.4
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dkgZsX2HyqQXzwicqV1ASn7xJG4Xe9wKAEfsARmcx0=;
        b=TkI2C9reK0tFJy1mj5AjuX+fbR8BQsgkDyCEuGmpdlPUAV63qtd/4h6nB7cb8bv23j
         33TWv558i4KWosfDGEopbLg48GaBfN9NkWc/TYbE3aDhrgU/8Svor7feQu13lb20Q+nr
         +ydEYffp8Ob/Yd4wNNx85FfieMJCtjMass7xW8gki3p03cSp9JGoYPqKE5ACX5PnC6vz
         jo32Y0ggOQBVJaMJH+TRx0tSzamBbVFF6+vqEcMJVZFYzCd6ylJa/o1ZKRO08vjjiemd
         uJSGZ0J2r637jft3wX53CMSfOHqP+GUu/nlp6N/17jwij+/QHsVtH/uK5Brl/BtfmJol
         qjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dkgZsX2HyqQXzwicqV1ASn7xJG4Xe9wKAEfsARmcx0=;
        b=NOH5uwi3TPREJ87HQ19z5V9dki4WSPkpSZl34iqUA0RC6wWDnfz27LahbhVJb2zYn1
         T9NH5gJECtBGEFlDcPNjpbCTLlhUtREdXYzlYVkuyy0Ssa0T8sH5WjsJjIiMWb13/eZj
         Yd0imNH29hin6sFPZiBBijZ0A/yjW3eKqNamnQZMv2ijUoNDD3NzSIhWwGBTIpGvadDY
         cvtQoOB90RQ6fsCtfQUnfga3jMQaMldRStDtaaOCtVhm9S6198I/avR9cc4VFoA5z/6R
         NRB2deXyj16SSjTbzIYeSPVAi5e+cWQInjW9yjalxg4qQKPsX3sUD3R6PLZhsHxydx91
         EWfA==
X-Gm-Message-State: AOAM531eGU0EZrOhxTJc9OoFHTMvY8EWjRVunBdtrPn2bi/jhMZGQcIa
        JRxo0NWGz2ZVjVwl+IgHEN4=
X-Google-Smtp-Source: ABdhPJwX2KqZTBTDlDRLuCYcu8YiVUbJ3gzrUcTjoPoRR0JM03PBGcv1urKEGFbDjRj2TmTE0smC9w==
X-Received: by 2002:a05:6512:139e:: with SMTP id p30mr8274570lfa.489.1621424914275;
        Wed, 19 May 2021 04:48:34 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:33 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 1/9] t4013: test that "-m" alone has no effect in "git log"
Date:   Wed, 19 May 2021 14:45:44 +0300
Message-Id: <20210519114552.4180-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to notice current behavior that we are going to change when
when we start to imply "-p" by "-m".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87def81699bf..e9f67cd24351 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log -m matches pure log' '
+	git log master >result &&
+	process_diffs result >expected &&
+	git log -m >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	git log -p --diff-merges=separate master >result &&
 	process_diffs result >expected &&
-- 
2.25.1

