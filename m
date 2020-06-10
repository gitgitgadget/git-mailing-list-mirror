Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB60C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347E520760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve5hwd6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgFJGcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgFJGcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:32:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C89C03E96F
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:32:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so911079iow.8
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4mCa6+Xibe7dd4u6/EznwsHbw1TA/1Laf7a6SNQ3sc=;
        b=ve5hwd6Gr2WVaZDjJJsG3dP7VrXitws9875i8MZQ7MqZkpgjt0xcQlbgBjj7FDiw2j
         1h2N49hNjBaYCxYt5e4dWpV6KgYC9KdYTY7dx5BHNWS9/AsEDorxDPpAntv16W/CyPoZ
         rLN1aPfxA9QyUy1QvzI48JB54gYgwJgrAH9KHF4fOyVsB8rcwboNkobGKOP/139TKR8M
         I5X+NSFyoiHhYjRhg9tepHIGS8hRQWxSdWT3BQD+/+9BeLna0YnH2iSm0ZYCl80SuUtM
         Ef8aR99nuVYCtY3cDMafjQhqVhS+nSXz3LePnf6126Qxu2gXzdQBw9KvNhjikWpHjrsI
         g0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m4mCa6+Xibe7dd4u6/EznwsHbw1TA/1Laf7a6SNQ3sc=;
        b=a5N4LwNVhoQzB5jREvU59JviXYgClQshMrLr3nKCOSfrvgmzyy0ubErQFdAFytH7Ye
         PG2gDM91lK5flhIY+BAo5+eCd5NZK7tv1T9Z5RYfFTs5NKP0CXUvKhQF15E+yh1lUfwE
         WGIGJx+Asoz8aAGFJS2n0VTb9ZwuZB6AOw6hp1B0mp1k3UooW3qjpmA971QD5judjv7Q
         REQqtUZsrs5Kxd9rXgm4O23pmZ7SNnO3a7EzknQgfRyDj0Ix6ibtlht794MH3hRKUd99
         BWIiYimBqxmNohuRkbKuaMHgPWN69EOuzv5zQnwgpQO1Xr6+dLVx4I2IhFMAcR+6LkO9
         m6hA==
X-Gm-Message-State: AOAM533GVzwdySzDax/xcfSROkY53J1OhMNK5d1TiHdskQxuHkFBUkfc
        q9htY6x3j1ifo/WNca1+zZahQXuulLk=
X-Google-Smtp-Source: ABdhPJz9xMY4lzUiGmJaRyonqXvPkugC64SSxERdxX97HfmgdbcMS/Nz3L/j8BojFM/25KwBJQJasA==
X-Received: by 2002:a02:c004:: with SMTP id y4mr1676454jai.81.1591770724147;
        Tue, 09 Jun 2020 23:32:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.32.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:32:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/7] worktree: make "move" refuse to move atop missing registered worktree
Date:   Wed, 10 Jun 2020 02:30:49 -0400
Message-Id: <20200610063049.74666-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
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
the same path, which is expressly forbidden by design. For example:

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
index 8fcf3f38fb..1238b6bab1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -863,8 +863,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		strbuf_trim_trailing_dir_sep(&dst);
 		strbuf_addstr(&dst, sep);
 	}
-	if (file_exists(dst.buf))
-		die(_("target '%s' already exists"), dst.buf);
+	check_candidate_path(dst.buf, force, worktrees, "move");
 
 	validate_no_submodules(wt);
 
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 939d18d728..a4e1a178e0 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -112,6 +112,27 @@ test_expect_success 'move locked worktree (force)' '
 	git worktree move --force --force flump ploof
 '
 
+test_expect_success 'refuse to move worktree atop existing path' '
+	>bobble &&
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
2.27.0.90.gabb59f83a2

