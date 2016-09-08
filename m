Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3384520705
	for <e@80x24.org>; Thu,  8 Sep 2016 13:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758143AbcIHNri (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 09:47:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35529 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756979AbcIHNrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 09:47:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id n24so2546926pfb.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w22wlbRlxr5sqdppQCq2ZJKXBGDHxu0oeg4VBuhNHrY=;
        b=hl/p6mNOwVI9/u/fDeDdOZJTzQyFw1W4MONQZMvmiTjOiDfxnjt6zUWRdUoR2fGeal
         JOJ4OSDG21aFksTrOaBU0yQjtbSCC8NxH7Qw4ONOj6UxbE2SV8KZqjuH3c2anrZE/cKq
         2EjD6SyRzZx1cN/U0GDzjdA6FRe+LtNhZPvVM+T7MQK95LRwKlQWGn1wAmBHyg6UNepg
         sZ7LxSISMjKkhvZ+1zuJD9jdPRzfaaUHY/+SPt+IY6xuvR88wwTWXwjl45l46GlhXN9q
         xz/Y0ryQl5BGwtSjYnnfcv5yI6yWJtV86Pwa1cYAGzEmFPpJ/vcgIw96dmafi2GpNRWq
         fzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w22wlbRlxr5sqdppQCq2ZJKXBGDHxu0oeg4VBuhNHrY=;
        b=l/KMo9eZoKJ2uDDOlQpu6EDZG06u8ZvYKuDAihjiz4BSuDrXoXYRdEL6Oq67r6l8qA
         zBXFkSDqzCxNINDM2GDzY9iAUi+tRCPc8k3l5zygNyNRQ7V7cSP5FVK9qNCqu25qIgri
         bYi/rxdAteu54FmxLHNxUtPPiLq7zqsLetJT4Auuf3uVp1SyHU41NnWuv0HURkAdpNx3
         7rqE0/FO6G8Z6hZgSXyyzUg0dMYDZpw7M0I+lU6c3HfqI/J0V/RUdv35RYBxqEW1Rb0Y
         WuqlRPpxMUDN5VxjPqBG6GQKE96NfkZpK+vYuSEzr5T7x2bKia1kwtSU1kq7+hUbF2kG
         bTDg==
X-Gm-Message-State: AE9vXwNgpENy8/QuoIM64nh7nqdW1LbPeLtq/KqgR92BkqyOQ9dOXBETqrAQb4KA00vIDw==
X-Received: by 10.98.157.140 with SMTP id a12mr58202189pfk.75.1473342456339;
        Thu, 08 Sep 2016 06:47:36 -0700 (PDT)
Received: from ash ([27.77.242.225])
        by smtp.gmail.com with ESMTPSA id u64sm462208pfi.0.2016.09.08.06.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:47:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Sep 2016 20:47:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     git@drmicha.warpmail.net, max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] init: correct re-initialization from a linked worktree
Date:   Thu,  8 Sep 2016 20:47:17 +0700
Message-Id: <20160908134719.27955-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160908134719.27955-1-pclouds@gmail.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git init' is called from a linked worktree, '.git' dir as the main
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
index 3a45f0b..6d9552e 100644
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
index a6fdd5e..d64e5e3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -384,4 +384,19 @@ test_expect_success MINGW 'bare git dir not hidden' '
 	! is_hidden newdir
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

