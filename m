Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B00C77B61
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 01:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjDZBep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 21:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjDZBeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 21:34:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C64C02
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 18:34:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso5198421b3a.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 18:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682472882; x=1685064882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YSgyUtbRC6hbuVEczE2c5/DzMYFAbh4wPVcHPXU5yc=;
        b=dsv4hTJMumWFwRS5M37DvxOM/tl0eOCCdfRljz6NwiH3M7s+DthXrRwqMcBMYzSYwD
         s5nF+4Ot8BHcxPvHYppL3AhVa0g6RfKPcwHSJ/GS4sHabyY1ybIFoSW+nbeIM4+Rvxxt
         oL4nlv7zhxXYeDwpKHlDiMS62az9kqGpIpa4DhvO0azTCRNpfDtZuc+jkL9SIPpa/J6d
         twBSvZUgcI7AJHsfRyaR2u7M3DPwDySamJVEQaoj0B0o3N37qgYaJKOGyPMcCa9IpLGW
         kHORUJW/eNUOkp/WcY1ZnGCVtc+gr4bVwaJqhvLDhw2h9lFtHCyOEEcQ9XYJWufO6zNc
         EskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682472882; x=1685064882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YSgyUtbRC6hbuVEczE2c5/DzMYFAbh4wPVcHPXU5yc=;
        b=XV77HsoSsOBhev0fdPrNduOzUCMMZ1G+f23mW/jSZoVKuTMxJWyaCOx7KBiV4LhyLb
         1sTJQ9hvWpf3TdpZDsJ5q3v215gfR3jPmuX5sAUIw6M8KnXfm+GR67Fxs1Qydypk9dGN
         CCHSKnzTP82mjRfV78n77bSh6RxVWdtK0MStd9hq/oTJMv873DgVE1GmNBbc6PrcMhOm
         mo3lNrEvDULk7FjfA9y8S7dgcgHdMFsePd34f3DsAtJrwyxrdy1UvjBD+pjK+M3lQWPA
         lcsMFCk4U4QGG4mMNRUZvG0CimxsARN4CMMaLLhiHrNehkgLUmRv7jrZGeypBL+dHlX8
         swWg==
X-Gm-Message-State: AAQBX9c4psXn9SJD0/0Cdh+o3T/1AUIt5JHe42rk+pkp8NbPDJSMmguX
        8vjv7vdNcdtZs6DKU26UaprSrpREC64=
X-Google-Smtp-Source: AKy350aDamDXhxRYANgWLkiIJKOP3DBYf/s+Knauot3Vp0+K5OosmPKUmuH/YP/yNJxLizrGnDZ8QQ==
X-Received: by 2002:a05:6a20:9f04:b0:ef:ef0d:7dd9 with SMTP id mk4-20020a056a209f0400b000efef0d7dd9mr18904996pzb.51.1682472881673;
        Tue, 25 Apr 2023 18:34:41 -0700 (PDT)
Received: from localhost.localdomain (192-184-219-167.fiber.dynamic.sonic.net. [192.184.219.167])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b0063b70f0b657sm9789235pfl.24.2023.04.25.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 18:34:41 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] developer: remove gcc 12 workaround
Date:   Tue, 25 Apr 2023 18:34:28 -0700
Message-Id: <20230426013428.53206-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 846a29afb0 (config.mak.dev: workaround gcc 12 bug affecting
"pedantic" CI job, 2022-04-15), DEVELOPER mode has this workaround
for the version of gcc that was released with Fedora 36.

That version of Fedora is about to be EOL and latest versions of
the compiler don't have that bug anymore, so remove the workaround.

Tested not to trigger with latest gcc packages from the last 3
Fedora releases, including gcc 13 from Fedora 38.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..6d07ef3692 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -94,9 +94,4 @@ endif
 endif
 endif
 
-# https://bugzilla.redhat.com/show_bug.cgi?id=2075786
-ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
-DEVELOPER_CFLAGS += -Wno-error=stringop-overread
-endif
-
 GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
-- 
2.39.2 (Apple Git-143)

