Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577FC433E5
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917FB20738
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBa+Q4sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgH0IXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgH0IXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD52C061232
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j2so2682181ioj.7
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qz7iQlM9eZVy8DRWqSLivbEpJ/TClwPgMZNfHbjx8nM=;
        b=jBa+Q4sKnVkiwzhL+F3G4x48hTjLcub44WLi20qw5ZrjImA4/Wfts+G6HbK2NxT7+q
         3sB+MQGM5hdRVoZ/Vok8H2FmvnqjBkJkz+8WIKwjE4sSZF8rzMlakKGiJbzJYPN9lAHF
         zz/+WM1fJnlSoucG77GasdmMf3eomKHozENx4DHIiNCdJA6JPBM4og+UiySbainvzFRe
         cUGy1vpLMj+iwEgWraRDO5GXA02z/OSPmU2w8nW+TScmr4BJDdKzfcmYxYgWKCORZaLy
         ffRQMRt2/z7/YC+mY9GFBOPmVcHAz6ruM27XwtKZsvdJT89hgJXdp89dczA6GV8IgixG
         lpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Qz7iQlM9eZVy8DRWqSLivbEpJ/TClwPgMZNfHbjx8nM=;
        b=SnV1tEXWYk3+MIv2NHcdI/+LyCO3uON6Xv9fgvO3B1FAvLXQuyUX8BN3MS2t5KoHdU
         5d0FehhEgRgLRsbqVAO2D4OHfyi81aIlmQhwYi3VStlSUpLColFyU+rqAeXrcSFU+bB/
         DjUcheUgzhZpmZKvvEZ5/tnFnHJ0RYQ/PCCsE7NnJY3XvleypUKsMqe3x0CFzoAKTeUn
         hdmVinR3TDwz6OF0bVkwQmXidm4pcHqgrm1TGahpeRLZBqIUcW4pqPXSumGU24f4mgGv
         SIKrZt5LpIG1LgBJDnvbrUkHW0xFkm8EDxiznnn8NuwsxOHKduzSCXhgaRsYcq8pp78o
         Jc4g==
X-Gm-Message-State: AOAM531KlGirxBc4QK1eZjH39vn5JBbc/9J50GwBs+PX+sVvCGXHfltM
        sZrwhvxE8WFDWsllJXUzQOrbrVzIvFc=
X-Google-Smtp-Source: ABdhPJyrJjJ3YgfDMv3xn2SYhuwf+PrwhSnT/dkEHWuTZ9l3OLryqbiL0NLOIKmUWNkeaUbXCgqd+g==
X-Received: by 2002:a02:65c2:: with SMTP id u185mr6437257jab.35.1598516589040;
        Thu, 27 Aug 2020 01:23:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/5] init: make --separate-git-dir work from within linked worktree
Date:   Thu, 27 Aug 2020 04:21:29 -0400
Message-Id: <20200827082129.56149-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
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
index 7b915d88ab..6a94d20a2e 100644
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
+			git_dir = strbuf_detach(&sb, 0);
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
2.28.0.461.g40977abb40

