Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB351F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935259AbcIYDQM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:16:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36768 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbcIYDQL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:16:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id n24so7198768pfb.3
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3ZtvDSux2xzQ8j0P3QB0rQ9C50CAXob6OJFJfqlMa4=;
        b=WxA5BfrPgYHRl3LmwU4E2jaZxM/eG2DbMUZ7Gz4Zsg6/Y+ny+Q40mtYk5klbk5WZR0
         nsyoWLz1XFzp5bbBmPqUkqEW5C764HQWujZynuOxvCTBAf8wCTgN1ScA71ryBOH5mI7j
         Pzxjf6zWH+7wmczmTFL+sE93UANNmeW1QHtiTTpUfJ9XrCLQqANi0YtZ5DKnXsbhm6b+
         zOLiSNtuLXxwh6in5vFJyn1oM/+lbaJDJq9f0JR/nhd2y+RPTN5lkD/XUFCO6XgIvHVU
         f18IAexVWSqSGrfo9L6hvZzVp2vcHZ+jXnOHsteZqvUKOyYHrdToIpEzBINcqT7cDrun
         5CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3ZtvDSux2xzQ8j0P3QB0rQ9C50CAXob6OJFJfqlMa4=;
        b=PNqFmPLP4zqGYl2Xpk4X5PWtWSY1x4rN+SYtSttoKFLxcBKwf1r0e50ZSOy6MDCzaI
         /EIfiigRON8F86+jLlryUYqm+d0+sAmR/Qdzq/CWu8NfYitaD2Pnpn8WvneNW+NVtqPg
         Lp6kN/5TX4CMhb6bwLgbH4URUgN+NNyA+zAwk5i/CD2f1lIAFj9cvka+EFQ5bGsq2wrm
         4GjHRBZWcSAS/nzT1eY530Dfgm1alWegcj0VgSuvDniwTyvy/6Y2T5dZGliRYrwiSq1E
         +O6nt1b2f6V6sNFiUF4vzeBahgrA29OHGSV0CfHa7hLaAUmIkeSKEWfQ9HtLGYXgrjHV
         wb9Q==
X-Gm-Message-State: AE9vXwO5OkJBebjNsQAGdSxlOfrBGR/G3HgsWKS5DIe/lcVd10Bs7jUI5XUy1RtpgGBwbA==
X-Received: by 10.98.197.1 with SMTP id j1mr26749273pfg.77.1474773370523;
        Sat, 24 Sep 2016 20:16:10 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id mz4sm21247959pab.21.2016.09.24.20.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:16:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:16:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/5] init: correct re-initialization from a linked worktree
Date:   Sun, 25 Sep 2016 10:14:36 +0700
Message-Id: <20160925031440.10435-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160925031329.GA9124@ash>
References: <20160925031329.GA9124@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git init' is called from a linked worktree, we treat '.git'
dir (which is $GIT_COMMON_DIR/worktrees/something) as the main
'.git' (i.e. $GIT_COMMON_DIR) and populate the whole repository skeleton
in there. It does not harm anything (*) but it is still wrong.

Since 'git init' calls set_git_dir() at preparation time, which
indirectly calls get_common_dir() and correctly detects multiple
worktree setup, all git_path_buf() calls in create_default_files() will
return correct paths in both single and multiple worktree setups. The
only thing left is copy_templates(), which targets $GIT_DIR, not
$GIT_COMMON_DIR.

Fix that with get_git_common_dir(). This function will return $GIT_DIR
in single-worktree setup, so we don't have to make a special case for
multiple-worktree here.

(*) It does in fact, thanks to another bug. More on that later.

Noticed-by: Max Nordlund <max.nordlund@sqore.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c |  2 +-
 t/t0001-init.sh   | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index cc09fca..d5d7558 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -138,7 +138,7 @@ static void copy_templates(const char *template_dir)
 		goto close_free_return;
 	}
 
-	strbuf_addstr(&path, get_git_dir());
+	strbuf_addstr(&path, get_git_common_dir());
 	strbuf_complete(&path, '/');
 	copy_templates_1(&path, &template_path, dir);
 close_free_return:
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 8ffbbea..488564b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -393,4 +393,19 @@ test_expect_success 'remote init from does not use config from cwd' '
 	test_cmp expect actual
 '
 
+test_expect_success 're-init from a linked worktree' '
+	git init main-worktree &&
+	(
+		cd main-worktree &&
+		test_commit first &&
+		git worktree add ../linked-worktree &&
+		mv .git/info/exclude expected-exclude &&
+		find .git/worktrees -print | sort >expected &&
+		git -C ../linked-worktree init &&
+		test_cmp expected-exclude .git/info/exclude &&
+		find .git/worktrees -print | sort >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
2.8.2.524.g6ff3d78

