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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD2C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F16613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhFITcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:32:06 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34606 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFITcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:32:06 -0400
Received: by mail-ot1-f54.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so21991374ott.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwRxTEzKTIJp89t5MCIr50HGWeRAVJBsKG4euMVU1+U=;
        b=Pu2XJEK0SS4PMX0FXvsT+rd6aBgTG28P7FM7WfWS/OzYPOkQ+ZQFU3qlUFalltTNTz
         1o5mW0NcSxpD627MSTgZJ1H8OQW7O+qzLWil7+z3Th5shJV1Kd+7sxQP60nrEBkHpVio
         wiVAgw1hLxn4RA5haxCi1eyb2PGtYzQKRuLvQkph3I4MjEjFVSq7Mee++4FJcuPlQX9G
         +9m7asqskGugTO2+V1PbFyFkmLlQEumWtAx7mHFicFd6JJdwWU6jJZypBSBP+B5o8rjp
         y9q3mFveeeDr8QEPjBrp1ytFHbERg0PdKQVo4Mm0yaCl02Vb2g/cAScU8ZmzPq6IjNSH
         L3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwRxTEzKTIJp89t5MCIr50HGWeRAVJBsKG4euMVU1+U=;
        b=MpLM1RnWfihIJTAxoEu9JXSdzhXdAcb3uk6l2FV9V/kpaWjS4pTuG2rnUAhSua9XAl
         l7TZumK1ZvCu/2o7HzDAa+NyFs6aYgn2U5ql8mW2WlmNiwkGWR+Ne3KGFHxShvRaJHqk
         IZWWw+fZUbwR+e9MwvWJ6Pbvi5rDJ6zMUzs1DGDI9Yngx1Mp7nMN3ANXBWvbxQzpBAWW
         nFgcr/fMhriKazNHsENe2dKq2vjFTvS2HhmyNJsJ11b5I04RuxywPUYq4pTtYrg7qikX
         +b/IRTdAAlxl+YC7VLeLWD94l7vUyD1X1AJXkUGN3HgcGgpykZJ2NuW1GCE19V4c9/nl
         P0bw==
X-Gm-Message-State: AOAM533H7C0ENj2h0GpEx2orrnBplyN9hP/PRqUI9hZwcfKylKca9fNm
        oyn64S2H3oGqiKkRCoWmOVy/VihK4l+V7Q==
X-Google-Smtp-Source: ABdhPJyVRNyYXMMUo4i/zAJAo7zP7vXLcH/I6oSvrR9gbZrn5vFxqr1MK81Lz2UfN6eFqyApbGzTpQ==
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr854076ott.332.1623266937528;
        Wed, 09 Jun 2021 12:28:57 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c11sm127435oot.25.2021.06.09.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:28:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] merge-tree: fix merge.conflictstyle handling
Date:   Wed,  9 Jun 2021 14:28:37 -0500
Message-Id: <20210609192842.696646-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's completely ignored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-tree.c               |  4 ++++
 t/t6440-config-conflict-markers.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index de8520778d..7d677bd75c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -7,6 +7,8 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "config.h"
+#include "xdiff-interface.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 
@@ -378,6 +380,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	if (argc != 4)
 		usage(merge_tree_usage);
 
+	git_config(git_xmerge_config, NULL);
+
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 6952552c58..978f4e3e70 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -41,4 +41,25 @@ test_expect_success 'merge' '
 	)
 '
 
+test_expect_success 'merge-tree' '
+	test_create_repo merge-tree &&
+	(
+		cd merge-tree &&
+
+		test_commit initial initial-file initial &&
+		test_commit r content r &&
+		git reset --hard initial &&
+		test_commit l content l &&
+
+		git merge-tree initial r l >actual &&
+		! grep -E "\|+" actual &&
+
+		git -c merge.conflictstyle=diff3 merge-tree initial r l >actual &&
+		grep -E "\|+" actual &&
+
+		git -c merge.conflictstyle=merge merge-tree initial r l >actual &&
+		! grep -E "\|+" actual
+	)
+'
+
 test_done
-- 
2.32.0.2.g41be0a4e50

