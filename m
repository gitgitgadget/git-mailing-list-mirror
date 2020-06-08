Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DEC433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DED52067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjpsWTR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgFHGZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722CC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l6so15681650ilo.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whdnnkmjw/vW6hMpYZTnY2nW9IjTmi0t9yHuZThitD0=;
        b=BjpsWTR5n5xn7euPZlOAWtMi05Zka+Og0IyK6pgj+AYg1AybFI79+4ZeruiJyK2c71
         UtlzeIdLaqSxUvRj00I0xz8cRZBh7VAHidlX5wAAgKMPlSG1K0NkeCv+Ng35Ix6UwPpg
         JRJh0FwcREM2IB/JocsjOzaPEE/tG3WZ0rT45GMiz/RB9s2tS8hfFrkyvmr8NCkhOL6D
         PtRO1BgxhtS0aeof2PO9RNFTMH9LxRlLTbpCodjVlIJpxVLwZMYKcG0cX5jy0bVLS5wq
         Uyg2/FvUpAJxUTsKssit+AuZ9loAAVhj0mszwC0VPne+xKIK3szmMdIXNhqUU1CGqb8k
         7flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=whdnnkmjw/vW6hMpYZTnY2nW9IjTmi0t9yHuZThitD0=;
        b=UU0KESh0bxlj2tECr3nTqV4t6D0OL053Htoo3HDywAWoPnZMX8ow7JHzlIjA1K0T+o
         NBmpXE2P6xP195pST2eYaVX1DGHaKNosD4DTFmXu/JkTvt3jwe3wvHIr4QYpivcaHCjv
         EuWHfvzHuWE6us8W7Dwamct6WArjkXlT5Mlq+WBaK/KIdqTmBRrphirIUwcihBX9OIrM
         3zXjKs/jABv+ROnE3IBRqVl2BXx1BB+Tghe16+UIkadkvTuEBQPAOjPTiBcJWHGc/EaP
         zZ0uf7mJmqSbrolOvpmNT724lSQGg5SFzgy/h5nbXBC6M1Xm7IuwJJjrYuAm2XAPidvI
         hNtg==
X-Gm-Message-State: AOAM530gU3nnDjw1WKYRgBRXe23k5Wurot9b0bvlYQowxqNeUmgcLqBk
        zLxcpbUbGz1c24EypNHXakfsiSwfo+0=
X-Google-Smtp-Source: ABdhPJy5zN1LWIvHK851xryxM3GnPRwQGHye7IAAD1L7yhp9LMhQfPBYVgc1ClEeuipy/T/T6Gcdvg==
X-Received: by 2002:a05:6e02:812:: with SMTP id u18mr20273848ilm.257.1591597500220;
        Sun, 07 Jun 2020 23:25:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:24:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/8] worktree: prune corrupted worktree even if locked
Date:   Mon,  8 Jun 2020 02:23:50 -0400
Message-Id: <20200608062356.40264-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .git/worktrees/<id>/locked file created by "git worktree lock" is
intended to prevent a missing worktree -- which might reside on a
removable device or network share -- from being pruned. It is not meant
to prevent a corrupt worktree from being pruned, yet it short-circuits
almost all "git worktree prune" corruption checks. This can make it
impossible[1] to prune a worktree which becomes corrupt after the lock
is placed since "git worktree prune" won't prune it, and it may not even
be possible to unlock it with "git worktree unlock", depending upon the
nature of the corruption.

Therefore, delay the check for .git/worktrees/<id>/locked until after
all forms of corruption have been checked so that it behaves as
originally intended (to wit: preventing pruning of a missing worktree
only).

[1]: Impossible, that is, without manually mucking around with
     .git/worktrees/<id>/ administrative files.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c        |  4 ++--
 t/t2401-worktree-prune.sh | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9b15f19fc5..f7351413af 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -79,8 +79,6 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		strbuf_addstr(reason, _("not a valid directory"));
 		return 1;
 	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
 		strbuf_addstr(reason, _("gitdir file does not exist"));
 		return 1;
@@ -121,6 +119,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	path[len] = '\0';
 	if (!file_exists(path)) {
 		free(path);
+		if (file_exists(git_path("worktrees/%s/locked", id)))
+			return 0;
 		if (stat(git_path("worktrees/%s/index", id), &st) ||
 		    st.st_mtime <= expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index b7d6d5d45a..9be8e97d66 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -69,13 +69,23 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -r .git/worktrees &&
-	mkdir -p .git/worktrees/ghi &&
+	test_when_finished rm -fr .git/worktrees ghi &&
+	git worktree add ghi &&
 	: >.git/worktrees/ghi/locked &&
+	rm -r ghi &&
 	git worktree prune &&
 	test -d .git/worktrees/ghi
 '
 
+test_expect_success 'prune corrupt despite lock' '
+	test_when_finished rm -fr .git/worktrees ghi &&
+	mkdir -p .git/worktrees/ghi &&
+	: >.git/worktrees/ghi/gitdir &&
+	: >.git/worktrees/ghi/locked &&
+	git worktree prune &&
+	! test -d .git/worktrees/ghi
+'
+
 test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git worktree add jlm HEAD &&
-- 
2.27.0.290.gba653c62da

