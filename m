Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F1C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5260F42
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhKATBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhKAS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620CC0613B9
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d13so29490488wrf.11
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8b9Uh9oXQiIVYcVI9uVr+pVmRNiNOVyhLZWHNbnygA=;
        b=dtTMyNRqg9NEvwuLzAIMNR16AkzohIwqt3+AIxLdcLxWQxr9xatuTS0IACoQT55dXz
         ENgX2CdQ/UFVpJ8Y3sBF0QiCES5L1fXJQSek5rtgk88v9X4LkrYj5hMZ5YcG8OmWZi0x
         fpwO7X5X9VbYJr8g4CoyaXhJYORe2Mv6joS9ZRXYyhcgAetD3u8Ba9PwnfkhK87iM3xi
         +2cUiJmKGRLF1GJK/2Cm+Ss85fNazNXNOMtU44gVCl7g1zXX80CEPzu50JGMQWutThb4
         lvZ5B7LZnvkFzNDlaoC6jqIU4ogEFCMgWJ9rOmlawINA0dF1c4cWHpKipbFXQ8ll8dd8
         UAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8b9Uh9oXQiIVYcVI9uVr+pVmRNiNOVyhLZWHNbnygA=;
        b=UdLLo+h0NY3KfDoqUb0MsVLz6VwRbw1nkzey6iNn7riURG6nX5DbfJKq79YD9ck3Pf
         hHO6DU2BBPJ3xd+6zR6bhR1B1b1wM6pMszzspy799pkuOpKTX2w/0ILtjI7iX/e9c+LW
         cXryYlNjnlosPt/Yvd6msiWyYfMX6vTGD+do2dBmrs6/fo67XCbdTtOukBUJqnP2zCaW
         nHeJpznWhho9LJ+Cny9wWsuYwlzEazjQen5IWd3caR91TtNYRDVDjOwfpqcX7jmlRpgb
         oCjqqSQijZjpPy0lvFTclSpOih05+C894JtGzcaXOme37899dzsfeK4jk4CEhOrcMjBL
         3Dnw==
X-Gm-Message-State: AOAM531JiOQBoIPtFcxbp19Yswl1EDgCUzJlEc4fRwXJ8XeYDpHA6VLt
        KitcuBZhAGy6DHtu6wtUmiapRQwLxiWchsi2
X-Google-Smtp-Source: ABdhPJzxSq56wbaKkopInTfi3oWLsRQJdmDt8526uw7mnYA8Ldcsj++kJyiNnimjlcLB+r8isQTwiA==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr39586474wrn.291.1635792989793;
        Mon, 01 Nov 2021 11:56:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/17] rebase: convert pre-rebase to use hook.h
Date:   Mon,  1 Nov 2021 19:56:11 +0100
Message-Id: <patch-v4-06.17-1fd70c0e88a-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

