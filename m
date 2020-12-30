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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F95AC433E6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D22207AF
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgL3Xai (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 18:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgL3Xai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 18:30:38 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E72C06179B
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s2so20338006oij.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHfDTQko7xjogX2qIZ9vgKqkR01FLXLg1Z25DmZlx8U=;
        b=kjc7HkqsPTumoGuZiW8z6WRUBmP6ASQ8/ha0iLv1ixlbDqtIvgPOnyJB6RXrjYyMAj
         l0ULKenl7Hs+qCil6bqJL53k6gdc3+ZnuYZ7kqpar1F5mwh/2z+CqRm+u52kYdgeSEVK
         KQDqOVyCSk3q8wIHjv9S8cWbBwLbJXintZsZPXMFvmHX0+i878l52XH0zRx8n9LSXb5l
         JI9/f+zWefEAIMn8yOrWyGNAGPrWgcqHQ2ioYxFszyvTOL2uzh/giQUhLaajK+9cvl8m
         283eMrRnKxGhI7k8tDdOFcXvxfrIGn5XPqErKL4uJsThmxnepAktVbGo/X5s7ys87Uaq
         w1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHfDTQko7xjogX2qIZ9vgKqkR01FLXLg1Z25DmZlx8U=;
        b=J+7ZLNqcXBtnRKDp0674jmmyn3qbCEpCwsNGQsmcrHfGrZTjrr9qw14LD5yMEAPIx+
         itooF0OXtvMLAXCkzGvPJo0gdUlM+Cw6CVEJhBwDIkQJfYXPhh0MUJK8Zw+ABGVj+cJb
         iVav2+tBJuYxfdF975C4YasDVHKSDPFoLfo/8XXCMIrSy6oEZXfqZnnL+u53yG+ysz4w
         9phJfInlnkrDYbXH8D13b6ROPM0afJSq/IanE7cjn1p0yhS8n0i5y2SGzE+r+KL3CHg8
         dw1Uz2BGJrkCyW0+5ynnxE7hz4Vt5Y0H3waVarKN5JJFDxzOghCTnuzh5/jxYUKytpdl
         SZ+Q==
X-Gm-Message-State: AOAM532Luz43iq/ZKWgIFJ3yXNMcQgL7mwHrtMHjK345CffbX4ZYxP92
        yK2LzpGgA1+KAmHOSLtE4Ioyw41Kmp10pw==
X-Google-Smtp-Source: ABdhPJzqpY37FGl1dh3VoxovZtMDQ1EdQ2NELicGpOp1drDFeLUVRFRxUrVZIXGLnrduP7zXJ100uw==
X-Received: by 2002:aca:4c4f:: with SMTP id z76mr6652135oia.1.1609370997357;
        Wed, 30 Dec 2020 15:29:57 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i25sm10738032oto.56.2020.12.30.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 15:29:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/4] test: completion: add tests for __git_complete
Date:   Wed, 30 Dec 2020 17:29:49 -0600
Message-Id: <20201230232950.582152-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201230232950.582152-1-felipe.contreras@gmail.com>
References: <20201230232950.582152-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the function was marked as not public, it's already used in
the wild.

We should at least test basic functionality.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1c4f1f6d4..c0b4380eae 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2380,4 +2380,12 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 	verbose test -z "$__gitcomp_builtin_notes_edit"
 '
 
+test_expect_success '__git_complete' '
+	unset -f __git_wrap__git_main &&
+	__git_complete foo __git_main &&
+	__git_have_func __git_wrap__git_main &&
+	__git_complete gf _git_fetch &&
+	__git_have_func __git_wrap_git_fetch
+'
+
 test_done
-- 
2.30.0

