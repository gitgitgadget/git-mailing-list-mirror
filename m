Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176D7C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77ED2072D
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHH9RiHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHaG7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgHaG7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14354C061575
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g128so4774211iof.11
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InFgH+cFkstzFiPOBjm5B+UoOAkTHeaKKQoVHPUPcwo=;
        b=OHH9RiHff3FzhVzx+8Z/AxXd/C3qOW+GrqjSBL9Xp6oujRQMaqwR9T9SnK9ecAqG/t
         fd3XfhiOvy/5Y5roQlm4CQRHBqB100ArCwBUx+YSTjO6uFJVAjoJ23YIGF5+A20K4w3x
         w2lRX5J7KQPbhrwOm8EGrIsUkkQFRSckniOsJdPF9ZVlyNPzVPVCXSFil7aqSptSiVHo
         9rH8jBsXtzuQ58aOW8BSdvb3Unf1fbEN15+1YGE+Z2z0f8L+v31EsFMt0fgC/LVwgzYC
         OKtqrASDXNXzBXrhb0+0jk6p7P7LOpzSPzGNR9/Wjoe4sE5QarJGZ2DXymoVpiH8zwOv
         uIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=InFgH+cFkstzFiPOBjm5B+UoOAkTHeaKKQoVHPUPcwo=;
        b=Vt0EOu04Wej918D1FvvjwlesNDMBkrvApMIJGVFjwx2t+dFkTBiEOsuiYrc87mOUYk
         rLavWvC0+UUykx7minUW+yNZBxsE/T8CJTl6f03203PZwyj2opatKHh+ayiTmCzOATia
         ZIQ97tFtbzsMgJqhHZVpn/Q2b+JZiPMFMUSHxvi0lgYg4bZGglhq5fDOWLTL9QMHvm3m
         JcRpmKS2oWM4qdiISDbwbea6LD6QYf/ae98O6sZYv6TiOhvrJ2NhH1PAYC0pFj0gYUiG
         Vs3MYZ1RJ4DOXGZFXV5qY4ku8daDXfIuFw/G9WTLz0yQUwiQO7BnWeNGRmbV/DERpZAR
         6Y7g==
X-Gm-Message-State: AOAM532blbydDwKGtT42ukHYuPyBeBH4NTJPhU6CzWOOh0nlT3AE7omC
        h3MD47I7UQ0eFZC4gjaRK42klv5cZ2w=
X-Google-Smtp-Source: ABdhPJzq0wC6JCXMrh/P+Cvb7Akz72bIJYA3mYPYQ932xGRA66twPb1Cs0wrIBoKfKryqyUESpFlxQ==
X-Received: by 2002:a02:840f:: with SMTP id k15mr30836jah.100.1598857147870;
        Sun, 30 Aug 2020 23:59:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] init: make --separate-git-dir work from within linked worktree
Date:   Mon, 31 Aug 2020 02:58:00 -0400
Message-Id: <20200831065800.62502-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200831065800.62502-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intention of `git init --separate-work-dir=<path>` is to move the
.git/ directory to a location outside of the main worktree. When used
within a linked worktree, however, rather than moving the .git/
directory as intended, it instead incorrectly moves the worktree's
.git/worktrees/<id> directory to <path>, thus disconnecting the linked
worktree from its parent repository and breaking the worktree in the
process since its local .git file no longer points at a location at
which it can find the object database. Fix this broken behavior.

An intentional side-effect of this change is that it also closes a
loophole not caught by ccf236a23a (init: disallow --separate-git-dir
with bare repository, 2020-08-09) in which the check to prevent
--separate-git-dir being used in conjunction with a bare repository was
unable to detect the invalid combination when invoked from within a
linked worktree. Therefore, add a test to verify that this loophole is
closed, as well.

Reported-by: Henré Botha <henrebotha@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/init-db.c | 24 ++++++++++++++++++++++++
 t/t0001-init.sh   | 21 +++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7b915d88ab..cd3e760541 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -642,6 +642,30 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 
+	/*
+	 * When --separate-git-dir is used inside a linked worktree, take
+	 * care to ensure that the common .git/ directory is relocated, not
+	 * the worktree-specific .git/worktrees/<id>/ directory.
+	 */
+	if (real_git_dir) {
+		int err;
+		const char *p;
+		struct strbuf sb = STRBUF_INIT;
+
+		p = read_gitfile_gently(git_dir, &err);
+		if (p && get_common_dir(&sb, p)) {
+			struct strbuf mainwt = STRBUF_INIT;
+
+			strbuf_addbuf(&mainwt, &sb);
+			strbuf_strip_suffix(&mainwt, "/.git");
+			if (chdir(mainwt.buf) < 0)
+				die_errno(_("cannot chdir to %s"), mainwt.buf);
+			strbuf_release(&mainwt);
+			git_dir = strbuf_detach(&sb, NULL);
+		}
+		strbuf_release(&sb);
+	}
+
 	if (is_bare_repository_cfg < 0)
 		is_bare_repository_cfg = guess_repository_type(git_dir);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e489eb4ddb..2f7c3dcd0f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -329,6 +329,15 @@ test_expect_success 'implicit bare & --separate-git-dir incompatible' '
 	test_i18ngrep "incompatible" err
 '
 
+test_expect_success 'bare & --separate-git-dir incompatible within worktree' '
+	test_when_finished "rm -rf bare.git linkwt seprepo" &&
+	test_commit gumby &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add --detach ../linkwt &&
+	test_must_fail git -C linkwt init --separate-git-dir seprepo 2>err &&
+	test_i18ngrep "incompatible" err
+'
+
 test_lazy_prereq GETCWD_IGNORES_PERMS '
 	base=GETCWD_TEST_BASE_DIR &&
 	mkdir -p $base/dir &&
@@ -405,15 +414,23 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
-test_expect_success 're-init to move gitdir with linked worktrees' '
+sep_git_dir_worktree ()  {
 	test_when_finished "rm -rf mainwt linkwt seprepo" &&
 	git init mainwt &&
 	test_commit -C mainwt gumby &&
 	git -C mainwt worktree add --detach ../linkwt &&
-	git -C mainwt init --separate-git-dir ../seprepo &&
+	git -C "$1" init --separate-git-dir ../seprepo &&
 	git -C mainwt rev-parse --git-common-dir >expect &&
 	git -C linkwt rev-parse --git-common-dir >actual &&
 	test_cmp expect actual
+}
+
+test_expect_success 're-init to move gitdir with linked worktrees' '
+	sep_git_dir_worktree mainwt
+'
+
+test_expect_success 're-init to move gitdir within linked worktree' '
+	sep_git_dir_worktree linkwt
 '
 
 test_expect_success MINGW '.git hidden' '
-- 
2.28.0.531.g41c3d8a546

