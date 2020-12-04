Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F065C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DBA22597
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLDGR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE7C08E863
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:50 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b18so4240630ots.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=Zm3WKz1y3h9+xNlimzGdGLW41KyfPcwdE9f1bfcDSerRA3n6qoNXPk3EBm6w2IqsAY
         MfEvFw/mVsoEw5OQEOtbst8C1F2D4I7BCIIhqHlOIbWBmodYW6HTkwe1m3lruxShvaEM
         kJteXFxz2ugFnJfYubYRZPHv4BjvYB8LPF2SYTKTBIHlV7ZLpAozApbaZfW/ZTTNQmmy
         vlolQSfsOLqqg3RXN6DKwocTmdBWTzSb7aF3ZJa5DYhQYJiH2fn3b5q0wppEz1UfHkul
         pQ02F6iSlQBN6aeL6O0aSTMOVlURmbobfiBFyRhamiEdYuviriGcmlrMdhTaeZCYZTji
         xN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=AbWgBs3x19FWovGukPef4CvvDF2FBYw0fAXBrL7T8Wo/WuQzojLmI3HFfpOLQ43Vxb
         zjsbAlqqVGW5xkeUbQEFzMNuTtb7W+sG4rGFcLfKqyckxVNbbuAONOO1KOWX5yojfIs3
         7raCSFyf7fur6zIPQLCiZcltVPFNUuu2OHVbDBs789RvuzHeAQfbR5CNsvy3WRRP4teu
         8bd9OpCEHWT2WfnH/lJD4LNGbqITOtAVXOQn+JUtYIhAAG74JufarDBmDb6k6RCRg9A6
         lqWYi8RQGuGvQ2iYZi8d8TmeepGukk9RyduH+iLaa5H3hb5WcoQbYgWEnLqVGCaJPsSs
         kPNg==
X-Gm-Message-State: AOAM531KxJB3icZlY86F1PFjMBH1ZUTObWxukoiCw2By3U1ej0/+GCC+
        I5xhbT68gC0977ltpgsWarbdDVBe+byHPQ==
X-Google-Smtp-Source: ABdhPJy1tSzye5NPtXzCf9uB0kG0kK2F9453oMetg0c5Uw+hwufDEyKM/jo+mz1cMhPZ2pdxCwq2Lw==
X-Received: by 2002:a9d:6250:: with SMTP id i16mr2505661otk.49.1607062609623;
        Thu, 03 Dec 2020 22:16:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z77sm455769ooa.37.2020.12.03.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/14] test: merge-pull-config: trivial cleanup
Date:   Fri,  4 Dec 2020 00:16:22 -0600
Message-Id: <20201204061623.1170745-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e01ae2a4a7 introduced an extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t7601-merge-pull-config.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index d709799f8b..8a6aae564a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,7 +33,6 @@ test_expect_success 'pull.rebase not set' '
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
-
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
-- 
2.29.2

