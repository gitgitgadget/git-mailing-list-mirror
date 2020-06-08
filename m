Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA2C433E2
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C902067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5Jgb/hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFHGZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgFHGZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDFC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l6so15681861ilo.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNmqK2kDZaqaI/z+axjQhUH36iOAl9JJU+tnx2sC19Q=;
        b=o5Jgb/hyK/ECHTD5pFBbeum5WUrhvmKWO6H6p4jnssmB2R6ixTA78091eibHRlhXg7
         P5Wu/PisWScInTOSVbAQ9xi9kwS04aXSOg5TS8Wc/C0RYNdZlQ4QrGLPNellb7SBusMP
         BwCh7b5ZwtvIJK3HgRyTdhWicMrtAfuljhuUsu8MPcB0/nIw+QEndi63g/WTMNmSItQ+
         jBjKLzc+oWQvocy5C9tlHe4A9a8uRlTYH4knm9cVqWyqVYNVZU/jS6ABia2mgDWQ9VIW
         LBcIHHqtbjImHekQ+lYx2oldAhzRXRXr/RIJDqmAtoqnJOJ9YK9AFLwaRUszChgGLnOw
         d+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jNmqK2kDZaqaI/z+axjQhUH36iOAl9JJU+tnx2sC19Q=;
        b=KvWXUQLUgueiRu0jnYjjVAhCT4BOL6iAdqORFDOVVGc+BcANlPlfwpOYIZZUb+e2cQ
         fdG0TLjLuCsO5w1ZuNNb1LZNmvxrwkYf/iImQJ+6DGORElHMoryqfsQfXJrABREkfGy5
         dzHZSjWV8BeDjTKaVENVf7wXsEcDbLDi/8E8ApaRQlreHDPBMWG7v7hHra6y/InNQ19H
         h9avdzhanAooi74JgrIn2odlmZH8t4xfMU2wdWy5YeZZUSbq754JNHVZI9/akBdt95Qe
         NZygpjTi1rBbyeUEtzo1/BU1Qo6c1SlxShBR6tcUcmta2kkvFUgC+fSUUeoMzP52G6Q/
         9dfw==
X-Gm-Message-State: AOAM531E2CyVupBW9+fWv9DRRotKWZmfVno7nHJS02YFGB0s993BbUxx
        vJ0ZpoQR2goLNzxWAHq25loR95VsswM=
X-Google-Smtp-Source: ABdhPJwyFymV7YL0z8Ukcgpeimnqeo+atL7m4HG9tKwRZbJ/f4q2lsaUXhBFgYuPK54v20abjKKosg==
X-Received: by 2002:a92:d302:: with SMTP id x2mr8117999ila.175.1591597507215;
        Sun, 07 Jun 2020 23:25:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 8/8] worktree: make "move" refuse to move atop missing registered worktree
Date:   Mon,  8 Jun 2020 02:23:56 -0400
Message-Id: <20200608062356.40264-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree add" takes special care to avoid creating a new worktree
at a location already registered to an existing worktree even if that
worktree is missing (which can happen, for instance, if the worktree
resides on removable media). "git worktree move", however, is not so
careful when validating the destination location and will happily move
the source worktree atop the location of a missing worktree. This leads
to the anomalous situation of multiple worktrees being associated with
the same path, which is expressively forbidden by design. For example:

    $ git clone foo.git
    $ cd foo
    $ git worktree add ../bar
    $ git worktree add ../baz
    $ rm -rf ../bar
    $ git worktree move ../baz ../bar
    $ git worktree list
    .../foo beefd00f [master]
    .../bar beefd00f [bar]
    .../bar beefd00f [baz]
    $ git worktree remove ../bar
    fatal: validation failed, cannot remove working tree:
        '.../bar' does not point back to '.git/worktrees/bar'

Fix this shortcoming by enhancing "git worktree move" to perform the
same additional validation of the destination directory as done by "git
worktree add".

While at it, add a test to verify that "git worktree move" won't move a
worktree atop an existing (non-worktree) path -- a restriction which has
always been in place but was never tested.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  4 +++-
 builtin/worktree.c             |  3 +--
 t/t2403-worktree-move.sh       | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 85d92c9761..4796c3c05e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -126,7 +126,9 @@ OPTIONS
 	locked working tree path, specify `--force` twice.
 +
 `move` refuses to move a locked working tree unless `--force` is specified
-twice.
+twice. If the destination is already assigned to some other working tree but is
+missing (for instance, if `<new-path>` was deleted manually), then `--force`
+allows the move to proceed; use --force twice if the destination is locked.
 +
 `remove` refuses to remove an unclean working tree unless `--force` is used.
 To remove a locked working tree, specify `--force` twice.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c0637234e..dda7da497c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -857,8 +857,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		strbuf_trim_trailing_dir_sep(&dst);
 		strbuf_addstr(&dst, sep);
 	}
-	if (file_exists(dst.buf))
-		die(_("target '%s' already exists"), dst.buf);
+	check_candidate_path(dst.buf, force, worktrees, "move");
 
 	validate_no_submodules(wt);
 
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 939d18d728..7035c9d72e 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -112,6 +112,27 @@ test_expect_success 'move locked worktree (force)' '
 	git worktree move --force --force flump ploof
 '
 
+test_expect_success 'refuse to move worktree atop existing path' '
+	> bobble &&
+	git worktree add --detach beeble &&
+	test_must_fail git worktree move beeble bobble
+'
+
+test_expect_success 'move atop existing but missing worktree' '
+	git worktree add --detach gnoo &&
+	git worktree add --detach pneu &&
+	rm -fr pneu &&
+	test_must_fail git worktree move gnoo pneu &&
+	git worktree move --force gnoo pneu &&
+
+	git worktree add --detach nu &&
+	git worktree lock nu &&
+	rm -fr nu &&
+	test_must_fail git worktree move pneu nu &&
+	test_must_fail git worktree --force move pneu nu &&
+	git worktree move --force --force pneu nu
+'
+
 test_expect_success 'move a repo with uninitialized submodule' '
 	git init withsub &&
 	(
-- 
2.27.0.290.gba653c62da

