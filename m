Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7781F404
	for <e@80x24.org>; Tue,  3 Apr 2018 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDCOrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 10:47:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42529 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeDCOrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 10:47:51 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so9096499plo.9
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsPHc3tbKEPFJMVJCcwJF/FCpp7sbbWcMJlLGq7jYUc=;
        b=aX4CyjI6LIML2WSx0KYHdNwQHyXjxyxVMABTVN6q8BYdBBwSlcXOpUgD2FpD39Itrb
         v3l9FKQ5t/5AzdJWL+yDydfVtsDky5Ap0+/O+AUGx6aQxfiOWr5aUJ60J30PhD+GMpoQ
         8PTiu6R6timt8oS8DthrBv8VGAZ1fNwV4FbAluHvl+t/yaKM6aRwP1okEscffc0FLFaU
         Huuij+U4w51YOvIYHZqkYLITcTSZgLbtEgCI/lgb8m5xkJcxdLSQbI7OtcN14hDx0DhV
         dmWnKwFmdQXiZ6/cocND2wJ9+IOeMivYGilbdHJD8+hasjbhCsTGy/qxNZLmvDKCV2GP
         49wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsPHc3tbKEPFJMVJCcwJF/FCpp7sbbWcMJlLGq7jYUc=;
        b=F7y77s5U3z0V9BJnuPqMCHZCmAMYLjYaElsav8UzVJxh6CBxO7XkOKNQt0Fm2Y9kkF
         ToOapGsfT0xZMyNpCzHJCXFrV0gdyBPaaMI1pXrCenArXb+sWUJs+yEOjUaC/WZIZj+n
         ynXiG+gR3PEewBL9l3/4go9r5LV24ww2jakf+nw9UlMwoRasPwj2AMRyei8hVzHrAELd
         ZHNEALCKtlWmzFe0W2yZUtdrXm9Qayq2rKuCX/GXDFnzzJc5OZkV8hnqTO+evdgKcHSb
         E+0n27WdHbEBhLMmCCmdKRC/PU5gpgJIM3KwUcihgUzT936ptYcdapqeha5wBtAiG2ye
         wPcg==
X-Gm-Message-State: AElRT7E3eb6dZqqIYOdXK63vtF/+uy8KEsSm2M3Vh4krfo+IuKCNN9+Y
        GpUVO7z/o1dXbaUNfgACjP7J4GRl
X-Google-Smtp-Source: AIpwx49072LRI9TYC270puSQkBaMFdz8SjDhBP4g/VwL71XsF1lJ16FbgOeYVYn+NR4JzYY0OHWhdg==
X-Received: by 2002:a17:902:468:: with SMTP id 95-v6mr14645911ple.360.1522766870220;
        Tue, 03 Apr 2018 07:47:50 -0700 (PDT)
Received: from localhost.localdomain ([157.50.18.246])
        by smtp.gmail.com with ESMTPSA id o88sm6305463pfk.91.2018.04.03.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 07:47:48 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] t3200: verify "branch --list" sanity when rebasing from detached HEAD
Date:   Tue,  3 Apr 2018 20:17:15 +0530
Message-Id: <20180403144715.11174-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318
In-Reply-To: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
References: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

"git branch --list" shows an in-progress rebase as:

  * (no branch, rebasing <branch>)
    master
    ...

However, if the rebase is started from a detached HEAD, then there is no
<branch>, and it would attempt to print a NULL pointer. The previous
commit fixed this problem, so add a test to verify that the output is
sane in this situation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t3200-branch.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 503a88d02..89fff3fa9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -6,6 +6,7 @@
 test_description='git branch assorted tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'prepare a trivial repository' '
 	echo Hello >A &&
@@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git branch --merged HEAD --no-merged HEAD
 '
 
+test_expect_success '--list during rebase' '
+	test_when_finished "reset_rebase" &&
+	git checkout master &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	test_i18ngrep "rebasing master" actual
+'
+
+test_expect_success '--list during rebase from detached HEAD' '
+	test_when_finished "reset_rebase && git checkout master" &&
+	git checkout master^0 &&
+	oid=$(git rev-parse --short HEAD) &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	test_i18ngrep "rebasing detached HEAD $oid" actual
+'
+
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
 	git init a &&
-- 
2.17.0.484.g0c8726318

