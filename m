Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139DC48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AB461209
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhFNRU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhFNRUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D16FC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c9so15346280wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvUebfcLRafGZJuwIJ+QbVqr6EUA57YPBUDfPovYeLM=;
        b=A4oZUiploSPGLsoEHu8BFyOeLd7eGXscI2ls7zKhC6zB1SKmPAi69CFG7fEALJsXNY
         F0xi8L5HPUR4yTftrxIQQ8AK8YBNpFoa8oiPgH56pPC7e7rP6vGIgNaC9fHYnfnQeybL
         LRhFOXZZoRSu60VFGstfOCtcPxiYcEQuGJeEZicP3EmTDYGvlS8EzFEyBzkwIDr6ggN0
         e3NW9u3OLSonrEGuRSndt8zfqYmrifQuSW7j6AoQE28xMXxsfxf4+jBpuw7KvTZR/38r
         yes+pnU9k4NwO1BBMnbrPyPudLMKHQa9lUS1oVXnpVT/YtTf7OSR4K+dHZHMvQPr5Tss
         XcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvUebfcLRafGZJuwIJ+QbVqr6EUA57YPBUDfPovYeLM=;
        b=Z46zKufBhYRGMaUHAiAFXAK5CaDmRAVQOlIbEt76XawfCzb5FkVEEc0ZI+5CRyvd9Q
         R1iks4KZ8w0GDPGZEpfu5Bc7NnBG1aEwt73Nyt58XFLbozEn9PvyHgY5tl/9CpUAE1c4
         rOQEpCkyGzInmtieEeUrWHL/Y1jLnK+1PTliEg3hVzwqBgcSgo//UJUT/DXLglj/VXmc
         KuUmw0tLJIKlxlyh4PMryVva3MgIjcC72OhnBuGTE6YxO5bCpnn3UrCkBjPGaPcHi6Ge
         rj5eByX0/WpmcWKWMEludH71te6KMeknZIyNM5U450hECLG1JnyNTP4fKzsuqsKhmPCK
         oCig==
X-Gm-Message-State: AOAM531hWPg6du7VuD1ydIPxSEzUsUGzZZteT4vg2Z4Fzi6UwvzaZvaH
        2assqPYvdEaJlHbc6mKnajkRQPy/PZfrKQ==
X-Google-Smtp-Source: ABdhPJwJXlAEZIUM8suePocfrc9v7YwZyEItw4bLEGMNBZtbq+qBjUkoalFu0lyKZdb2UapfmB4qMg==
X-Received: by 2002:adf:e389:: with SMTP id e9mr19723758wrm.424.1623691095814;
        Mon, 14 Jun 2021 10:18:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6sm83816wmb.15.2021.06.14.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:18:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] show-branch: fix and test --color output
Date:   Mon, 14 Jun 2021 19:18:09 +0200
Message-Id: <patch-3.4-8db7029086d-20210614T171626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the "show-branch --color" output so it doesn't needlessly color
and reset each time it emits a space character.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c  |  9 ++++++---
 t/t3202-show-branch.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d6d2dabeca8..d77ce7aeb38 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -939,9 +939,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 					mark = '*';
 				else
 					mark = '+';
-				printf("%s%c%s",
-				       get_color_code(i),
-				       mark, get_color_reset_code());
+				if (mark == ' ')
+					putchar(mark);
+				else
+					printf("%s%c%s",
+					       get_color_code(i),
+					       mark, get_color_reset_code());
 			}
 			putchar(' ');
 		}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 7b06048905a..54025f03379 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -55,4 +55,34 @@ test_expect_success 'show-branch with showbranch.default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show-branch --color output' '
+	sed "s/^> //" >expect <<-\EOF &&
+	> <RED>!<RESET> [branch1] branch1
+	>  <GREEN>!<RESET> [branch2] branch2
+	>   <YELLOW>!<RESET> [branch3] branch3
+	>    <BLUE>!<RESET> [branch4] branch4
+	>     <MAGENTA>!<RESET> [branch5] branch5
+	>      <CYAN>!<RESET> [branch6] branch6
+	>       <BOLD;RED>!<RESET> [branch7] branch7
+	>        <BOLD;GREEN>!<RESET> [branch8] branch8
+	>         <BOLD;YELLOW>!<RESET> [branch9] branch9
+	>          <BOLD;BLUE>*<RESET> [branch10] branch10
+	> ----------
+	>          <BOLD;BLUE>*<RESET> [branch10] branch10
+	>         <BOLD;YELLOW>+<RESET>  [branch9] branch9
+	>        <BOLD;GREEN>+<RESET>   [branch8] branch8
+	>       <BOLD;RED>+<RESET>    [branch7] branch7
+	>      <CYAN>+<RESET>     [branch6] branch6
+	>     <MAGENTA>+<RESET>      [branch5] branch5
+	>    <BLUE>+<RESET>       [branch4] branch4
+	>   <YELLOW>+<RESET>        [branch3] branch3
+	>  <GREEN>+<RESET>         [branch2] branch2
+	> <RED>+<RESET>          [branch1] branch1
+	> <RED>+<RESET><GREEN>+<RESET><YELLOW>+<RESET><BLUE>+<RESET><MAGENTA>+<RESET><CYAN>+<RESET><BOLD;RED>+<RESET><BOLD;GREEN>+<RESET><BOLD;YELLOW>+<RESET><BOLD;BLUE>*<RESET> [branch10^] initial
+	EOF
+	git show-branch --color=always $(cat branches.sorted) >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.555.g0268d380f7b

