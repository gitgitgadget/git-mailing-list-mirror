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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DECC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3586108B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhGUWml (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhGUWmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B89C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso1882851wmm.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BD5ep6McKnqZh4kQK3eRMCFgv51sbPR9ow5DGY9a9KU=;
        b=aK1qliKpxAClGcSbVcdsJmoDexcq45Zg+JMpL4iuvvZaN/5qWuFbxb9uzxmpzeBan/
         v1GJPCDG8/wh24gt3xo3ITbQFI9wGqZ+tl9LyRe3BdRAOxRcZ7U/GisBp1n6IiXiOk8Y
         o4Nu9JfnB4keNlDvjg3ZqGp5KwO6XxKRPlNJZJaqeTsApoe1mtJQN9k3dejtp5FKxUuz
         DkBCjJGVJUWJs0X2OTWdVX5ER+v7LQimZc03j6byvaCQ1jn+Wub7s4q+CXd9VJn3g+9h
         f0tfP081OSfYWZW7uI1UpSWfXzs8zkT/F6IrXZrgz5GCWbOGDN9gPx4ZLt/rxL9hkf0T
         XklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD5ep6McKnqZh4kQK3eRMCFgv51sbPR9ow5DGY9a9KU=;
        b=WdXD+/busx5+wyKURaq0i0qJ33j6COK1ph1ygH+fUzLQG6r/J6psJMZ/1XKCrkSNZR
         /9RLbawYUuvRwT85Nn5PTwZPIMrjV6tx257L1OfdqE6eF0G2lz9FdtR9VF3RpGDcWJb/
         uJ2MZ7jn2SsID1Ii7R3XR+ZDk7+Juk4ZnKXosXsRLIE9rwUZCqGsBmOvIpfv1DB1ztRB
         GbSlsstLxzbrbU8ILTVl5cTdqV0Nk0ocdi3iTVYi/Ep1ohWl+fsa8fHYWwR0BiBSOxb8
         v9hixIgjQR6wmpkI+rCgZbpLLaKOMCps1vk3jakjKst7DvCVstOGSJEJ+a8y44H7x+bQ
         xNbQ==
X-Gm-Message-State: AOAM532SpwnMBNHMYxdq6mw5e1nryD9BXz4QaJT74GX3sUjlLgE3vIhm
        rwg04bHfcMVvsdwK/098ZqKwCkg/kDGiOw==
X-Google-Smtp-Source: ABdhPJxkKkYzxdNryTWDz+bY3a3p6NYDZzhevlKqHUGYm5Obyrt96AacGh2t3uccZ1DeweXS5BMzhw==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr6357642wme.61.1626909792662;
        Wed, 21 Jul 2021 16:23:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] Makefile: add QUIET_GEN to "cscope" target
Date:   Thu, 22 Jul 2021 01:23:03 +0200
Message-Id: <patch-2.5-d3d5d332e92-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com> <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't show the very verbose $(FIND_SOURCE_FILES) command on every
"make cscope" invocation.

See my recent 3c80fcb591 (Makefile: add QUIET_GEN to "tags" and "TAGS"
targets, 2021-03-28) for the same fix for the other adjacent targets.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7dd93ef4c3e..69410095949 100644
--- a/Makefile
+++ b/Makefile
@@ -2751,7 +2751,7 @@ tags: FORCE
 
 .PHONY: cscope
 cscope:
-	$(RM) cscope*
+	$(QUIET_GEN)$(RM) cscope* && \
 	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
-- 
2.32.0.955.ge7c5360f7e7

