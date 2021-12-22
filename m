Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbhLVD74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhLVD7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EEC061747
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t26so2065320wrb.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbjkKWMfaGacuSQjas0jvZkMj0+eXrixHCO+wIuSVc0=;
        b=hjjhzwaWvW4XJWg5bRuKCQk9VYgAEYPV8EBUovAeZ92u+bdq6/UopA4dFOIJh092BK
         5LAqUzh5Ejsn4wvxBu3KTXcC5xrVSHVcToifRMdhESLGgmeZ4x5O2Pb4D04udHGdyrPO
         /CJ45a6PqLQ9lNrArCRYA8iI3tzEH4SQIMmAcmTn5U4EB803Iy3zg/VLCh/8NQXeMREU
         32Itm3a8WH8+PtSAIsiATQGnWamcf4tnnVCx6R2tZotkvTZZ3h6++bvHY70S6bXOIayB
         Yjx0nASfGxgMbjng2fzleOG06lS8oZvewndH6eE1Kxq8KfuQqQchS+09A3u5smjF2lRU
         SifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbjkKWMfaGacuSQjas0jvZkMj0+eXrixHCO+wIuSVc0=;
        b=D2b+y50oa6rrc3x/ziGMWZfgVLxEJRMf7PZLonx7l6+zOlR/dlCRYfCDrvfn1098jx
         FvnSWVeBabbLUGGt7aqjFn4YOIq5U3I+xQRonJgnVTf24FMm+KSyZpxUg7JMb1Hd+KRo
         rnN+7Voode7UjNaPOw3yZNJgx3BGadCNNz5qqRZtBUD2VzcJbro1mNQ3cxBI0/ET4HHi
         FzQlh556RCY6mkVgb8Jh3n8FAon+kl8z9rkZqrGxf+fwfuEXESf8yr98REZfeq3KwsqG
         AKQd4rwe7dJspW8dTdt4TxPSUIv4WCZ60k+XvCqiQrsVQbERMr4KODI1f8w/oFl37hgp
         EhtQ==
X-Gm-Message-State: AOAM5339Nj3FChhrAbl+W04szSTbLYFMI4PAPLStgI0zlFs1cZwiRzgh
        hXHcQQW8DXrfFiq/Zi9+llONidySRiExKw==
X-Google-Smtp-Source: ABdhPJyZxAuHuzZJK5GZIop4ZJbWDFpM11RtpY1dPsos0b61zB+3DJtFvz1j3Xxlqe6u9TPixzCECA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr732957wrs.64.1640145590012;
        Tue, 21 Dec 2021 19:59:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/17] am: convert {pre,post}-applypatch to use hook.h
Date:   Wed, 22 Dec 2021 04:59:30 +0100
Message-Id: <patch-v6-04.17-ce57ce1adcb-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach pre-applypatch and post-applypatch to use the hook.h library
instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..4b334cb7b12 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1609,7 +1609,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch"))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1661,7 +1661,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch");
 
 	strbuf_release(&sb);
 }
-- 
2.34.1.1146.gb52885e7c44

