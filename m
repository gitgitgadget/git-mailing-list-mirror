Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2211F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 11:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbcIULaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:30:11 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35921 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbcIULaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:30:10 -0400
Received: by mail-pa0-f65.google.com with SMTP id my20so2191397pab.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3ZtvDSux2xzQ8j0P3QB0rQ9C50CAXob6OJFJfqlMa4=;
        b=TYivJZePP/fOrj/7KcExSGEf4fzlpe9hBH16ZD+3kg7uX2NrOYph6eUvAp/lpgFRkr
         sKJkrktnkgi0hfYxs3Cld1azdwEDA0W6w2aFZojlIzvu8H3EVS5n34/HixzRsll8ZMgM
         zXoUFin33N6gKyN7x1zoYTb6QVOEW8tq47IBrslyTef2sh+PfcICbWndi2bn6jQ4pgBU
         c+NJM6ORvHkx+UkFHuVorwgDxz7EzZq/0HhjQs80xLRBaqJTa4vhUw/X6gxk7t3dTndf
         Dfw6tbvD+yYNFgFshx6re09MCNslYLZZeNdGf7mZkctFUecDyDQMVb8UYDQRU2bEsvid
         P0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3ZtvDSux2xzQ8j0P3QB0rQ9C50CAXob6OJFJfqlMa4=;
        b=T2OV5+HBnaM4r/rtY41B686gfUh8Tv+BQMoS/1gDdypkVazo+Xu9x9jJE/8CT6RGuc
         x5Ibj9M+wdHrhoSe62OJgSeMtLIp4GKKUeKWwH41X2uzfKLbq8VgnIYxIcKzV+zEkIRV
         RtVC1HASotsdc/Exg5dUEK+D13H14dzi4IO6Qs8KF6+uGE/RvC/7vLeot7j6qxzgT110
         qVd0ewmoi2Mz1c6hRrXC+6bzLPBxTlW80pTKrCcl5ZGPYBoa21DCOT0qVbcKokBKyjRH
         wybIbWjjseCwszc+MXu4nlLUhwEw/vlB67PWa3iw2nLFq9K2oEe85OvZT2JQ9alPmiHg
         wA6g==
X-Gm-Message-State: AE9vXwMYmt+nCVlzsSmtQOjor+3UqQJrtHY/u2dt7b/cVGQWOE8Ag59C36fjbexsOu6VOw==
X-Received: by 10.66.72.69 with SMTP id b5mr63407478pav.98.1474457409161;
        Wed, 21 Sep 2016 04:30:09 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id y184sm86031223pfg.94.2016.09.21.04.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 04:30:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:30:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/3] init: correct re-initialization from a linked worktree
Date:   Wed, 21 Sep 2016 18:29:37 +0700
Message-Id: <20160921112939.3444-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160921112939.3444-1-pclouds@gmail.com>
References: <20160908134719.27955-1-pclouds@gmail.com>
 <20160921112939.3444-1-pclouds@gmail.com>
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

