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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BC2C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBD9613CD
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhE2HrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhE2Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59283C061763
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z3so6678271oib.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q04OwyB+XP5puy2u1B8ZlN0ZHYZHOkCgfq6VrMZprVs=;
        b=iSGCywm6rSweCzm/aaDYtZclDL5QAchaC+Gd+9KvYJ9OPKeiY8D32bu5HEPK6qqVNM
         TyFSYn20c1Vm/h5ZrqIw+HQF/PTvO+nH6XreQ1EaqhCvMdFNMuBMf3HzQd9u00B5Y0fA
         e0xHS0CNQyN/WQyotchY3D+Q3VpB3yk0tVqBX1ZQCQo1U+r9GNMukup+jGs/Js0eDl2P
         B7jEJjOyXJuhALQftg6MGt94TiBRwmyo5WsHQLg2jx6avk+OJSkm3rSiL4BITZ2EZqa/
         GUtTmNI9HSD0gUbpGOMnoXQV6oJP+4LftP4kX+AAzKx1C6fG3wUvlDJNTz4774tTrSWd
         WzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q04OwyB+XP5puy2u1B8ZlN0ZHYZHOkCgfq6VrMZprVs=;
        b=RtiHhViVF94wgqHR213KXYJtOLc0Xmxp4q7eFgUE4LrljgIRs4wHcW6M8QHa6Ntfh2
         ty0i6Nw2yrELVYGLT10ia95MYKvf1kn2gW0Mfj2F7Ypt1VpxCSD29sqp21haKtaYreHX
         LHsc8R3XbgCCaqEljN1zkx1J0+68SSewQF9t93QgQ0Ly/UKlQMIYKvfvUS7NSSM9fzBw
         sDec6/pHngNiktm2HPbECxlJbTkA9mEuwfjipawzQT9GLlAtCTtMM0KkvyNykBNt6SfZ
         7IzGyBDAyc5ixdEA3J+i52fkyKnaCVIlYgElYE+gf+nUMSpGpv7SS+L6AKVMqH9p++fV
         YxbA==
X-Gm-Message-State: AOAM531gzQ/8IRnEbTr6irtOlgA8Ldpa9wmZ4yR1hW9iaBOwgdmSRaLa
        +sJKxQdzU5Ed/GSP9/ybCf1G6Vh1xLMUig==
X-Google-Smtp-Source: ABdhPJxCvMNDXQhHZwy/ILvwTptVvWIq9/LDNXmGlbEZDWnzpZEHRfjNUIYinsz0FaFukFsgfxXycg==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr11713524oiw.161.1622274319589;
        Sat, 29 May 2021 00:45:19 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u201sm1621940oia.10.2021.05.29.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/15] push: only get triangular when needed
Date:   Sat, 29 May 2021 02:44:56 -0500
Message-Id: <20210529074458.1916817-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index c220f70795..818ca4c5c9 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -205,8 +205,8 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
-	int triangular = remote != remote_get(NULL);
 	const char *dst;
+	int triangular;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -225,6 +225,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		die(_(message_detached_head_die), remote->name);
 
 	dst = branch->refname;
+	triangular = remote != remote_get(NULL);
 
 	switch (push_default) {
 	default:
-- 
2.32.0.rc0

