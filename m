Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAB91F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeFLVZs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:25:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37655 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeFLVZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:25:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so180821pgv.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TqfnqnrhvrTNbxAGX1TKPL4vhTT9owP3RFpWDa4tLoI=;
        b=abISNRXF4u8S0f21qaGmnnhLoBcPih7hPpc3D/bZEpUTGQuAtfHsEtQnmAeUT2SKiw
         EhDJZ+D1uldBBWF0IqExwe3UaQEgA6FfeTVe7qd1qG1bXBS0IQc/PGrjs0Tcjzwq0k26
         BTJQz0TmZl0l1t4UUVKLLiFc8Aov35rgcWTy/EHqJrKhWBIBnW/ckhNGmvvi9Dr18eVc
         NdDz8Vy6/JB9LVYUkO4EMNuZOSc3nGznWtwIXYlgkdOzvAVHT/TySiQM6qiqctcHwMjw
         Ng6yIlbG8hLmXjKYgTMJ1F3ux685L11NNRFc7se9ImlHDBPteSGaFR4QDsjASbySbeVy
         2krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TqfnqnrhvrTNbxAGX1TKPL4vhTT9owP3RFpWDa4tLoI=;
        b=rTWogMY5YnrgLSEjXXP0gY1FzmGowoaOoLGJP1oGJYAyqYJN2DglXXGPLNG0ZJWAt7
         /b+uCXp9lVDX3v4NEAEfhePUxg7ntmvzjQI2h3+1/P3dRQ/uiEVL9kSmTqr2BJJYXppt
         skTy/fnSCoWgUOIhSZuAua3to8smZeg2iAf21cptaW3Bk/2an4HadeZobYOlF8yaOnOC
         cfBjPyFREShlBYCAwQz/HOWjr9X4BhE9y3wII/15QgIcYDE0hOUzxRcZkkzf39gFGtpq
         QKrlA7HCTWLYrlfvv3zPe3tpOl70eIwUfCSthXl+7ZLG/h9asCr+Yq80CPtFYL26sCK9
         YKDA==
X-Gm-Message-State: APt69E2XIXnkUsVVBPr3iPbaMMIdRwQPCx5M1W8D93jHgk1VQ438wlL4
        X10TUrgo+Ft02kcGPfGm7ESf4LwlaLM=
X-Google-Smtp-Source: ADUXVKLqKGguQeUqq5ixAYOUrEfdlhWhLxDImcEYMzB/rSD/qIdlWVcPgwPGJkr/LzkmlPLyoh6h2g==
X-Received: by 2002:a63:27c6:: with SMTP id n189-v6mr1767194pgn.164.1528838746253;
        Tue, 12 Jun 2018 14:25:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m12-v6sm929292pgp.88.2018.06.12.14.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:25:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7400: encapsulate setup code in test_expect_success
Date:   Tue, 12 Jun 2018 14:25:40 -0700
Message-Id: <20180612212540.200142-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running t7400 in a shell you observe more output than expected:

    ...
    ok 8 - setup - hide init subdirectory
    ok 9 - setup - repository to add submodules to
    ok 10 - submodule add
    [master (root-commit) d79ce16] one
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+)
     create mode 100644 one.t
    ok 11 - redirected submodule add does not show progress
    ok 12 - redirected submodule add --progress does show progress
    ok 13 - submodule add to .gitignored path fails
    ...

Fix the output by encapsulating the setup code in test_expect_success

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 1a33040d94d..c6e1f749639 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -126,8 +126,10 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
-test_create_repo parent &&
-test_commit -C parent one
+test_expect_success 'setup parent and one repository for further tests' '
+	test_create_repo parent &&
+	test_commit -C parent one
+'
 
 test_expect_success 'redirected submodule add does not show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
-- 
2.18.0.rc1.244.gcf134e6275-goog

