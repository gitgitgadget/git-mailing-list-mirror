Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8828C4332F
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhLVD76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhLVD7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D88C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i22so1984329wrb.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWXFkykf3ve1z11gwEEAzo/g2vz8vkH7h4Z37DlxoVY=;
        b=RDioV+iiOyMXk+wYNBMwCppx+R0m5SP+ZIGWmN4oEHn9PTd74FrobAJMsfVIIq/mD5
         4vxvLVeCXpP6l+5+xs8/wHVQqnjqYtk8/pThV8CjO7iqMCYPsfFa7aygGC6GStez5hy8
         BpWybnqRkLbFcBRRoxVRy6xhfKKOTr1Hz8l0P0lZ2lqRoKfB4jEScWRcsSYrHfvOqk9z
         feROiM4VidiFHknUslC+HSHWXDW/vev9P/sZ7zMh0U6FzmuAPTONJegTxB36g1L3YH+M
         dUrE2cEmWjftu1KD0/ZCvCJvSokKgHpHfp96eCI1nixjjJ2fc+mvdrop3d2Ql3SKF//C
         Dc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWXFkykf3ve1z11gwEEAzo/g2vz8vkH7h4Z37DlxoVY=;
        b=Ew2ChqpSsF2JZIOWnY2ofSCB+tu95fZ4+74wegJDeWgu0Cqv8R0c/mnbvejsAbiwJp
         Okzip6rSSjdg1R+YCYsxOF1DHf5bg0p7OnhbZ2V5ygFY2IjYEcaHDwT7DOjjuDv1MQ9Z
         fpPrMfkMnmgEmuAynt/9Oz6345y5qKhP/ndSg/ylUVScxPZTiK4Tdqrk1vRaQDvTStVa
         xxaYtL7SgpBDjbdkUYWBLUMzKXdUPpV7JI2GwtUIG8O8qYTth8IY38nAA1JtYh9nGxyi
         zaKWgnOKtlmdDKFsjMAOSRoFqexDw0O6oonXhweWETAGD0FYQ5IjP3K/Ro6uCqXfGsyz
         M8Hw==
X-Gm-Message-State: AOAM532uQtk6meuKzbvr0dFxZqleVNSKy2FIzVTiBYD1wFTLMOi41Sxk
        mA+i9pEXp0tYpfHYFVCwmBEVzxoUfbmnag==
X-Google-Smtp-Source: ABdhPJy9dorINm1wL7D2lzHuDBqxyP+F+hrFjHdG42u6tkK94P4buTloi1r7LFoSpX48L3jwix2/Vg==
X-Received: by 2002:a05:6000:cd:: with SMTP id q13mr720766wrx.302.1640145591688;
        Tue, 21 Dec 2021 19:59:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:51 -0800 (PST)
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
Subject: [PATCH v6 06/17] rebase: convert pre-rebase to use hook.h
Date:   Wed, 22 Dec 2021 04:59:32 +0100
Message-Id: <patch-v6-06.17-4c1a8951fc5-20211222T035755Z-avarab@gmail.com>
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

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Since this hook needs arguments introduce a run_hooksl() wrapper, like
run_hooks(), but it takes varargs.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 34b4744e5f3..ac4120013a0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1712,7 +1713,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
+	    run_hooks_l("pre-rebase", options.upstream_arg,
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
-- 
2.34.1.1146.gb52885e7c44

