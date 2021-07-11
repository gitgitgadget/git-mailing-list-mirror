Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26909C07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D216121E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGKAaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhGKAaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:30:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B79C0613E8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f9so12753205wrq.11
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=doNO/H+yymBmP9CMLggZFqCEhgObOPJu7vNmhKmj97g=;
        b=V4d7z2bRaGmprMtwIB1FlmdxzeAdgHEawAVHafKn9/vQoeU/hUIuvQ0lKhNvh6+I6E
         XV8UYPYsFyFiloidcsG17wNIPxSxKsJkpsX1Ru6ozqp6a+ZgPw0MXhmNl0504AnTEKwv
         yJ58XZXvTXyCLwSNZUfCX2wUB4FoNKFRlY0YsoovqTvqN+nUkcxtZY5tJuhJaazAsqXR
         F2Lh8XJBQzPC192khex7wK2K7cLhD0P3gAJViY+ffEtEiQ1yZLnGd80l9jPIX+FLEcOl
         ofKHHMGnUA9+VfpvoAlP8fc+9KJ+m7TBNLav621pl3sXj+/Deyy3LojcC+zHPh2R8dUk
         In2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=doNO/H+yymBmP9CMLggZFqCEhgObOPJu7vNmhKmj97g=;
        b=rDleiqM5zNTE7mpk6PuAtqSB9EIncdA8upRkMrKTEk1LffGCZhPTthZem8+FamTrYw
         Pe77BBFAIrDM2a2N2LUT9arNPYRo0aOinhAY0Bzcz7UhhYFJZCytJmkkZ2L1bNfOP2fs
         x62vjn+TVp9xDrEQ7SzbgNBveE/5YtC0VlYEKdI/3rj778iXmzH+r5Wsd+udzHvlGHma
         VvA0EvJHNDLNIyqF16QqM04cnlcgazoT4Ohp4L0VbF+78t88eNhMbGaPF80hljyjUf4I
         LKJq7DMImX52++8IxrxZ2JZhd66L0g/vY1zTDm/KOqDCkoSVb51SzTLr/iZ/d/NzZRua
         9K5g==
X-Gm-Message-State: AOAM531wLqt3u8n+cDOFcx9zpsTAIheNyiOolPKj62dzy+BVlJf1noAn
        Onf2AdIlca+jeaz3XfyJT3HsGiqnKBA=
X-Google-Smtp-Source: ABdhPJxUDtvCLvJPrj/ov9AhYIBJEulMurpvBY34Bz46uZeIMNVqiTfxwkbErzPVIgffc5ODHm1SfQ==
X-Received: by 2002:a05:6000:11cf:: with SMTP id i15mr30533091wrx.212.1625963242782;
        Sat, 10 Jul 2021 17:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm9488407wrq.92.2021.07.10.17.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:27:22 -0700 (PDT)
Message-Id: <ceb7a58b0049a8afa8c5f9f706b9a0b0abfb843e.1625963240.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
        <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:27:19 +0000
Subject: [PATCH v3 2/3] worktree: mark lock strings with `_()` for translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

- default lock string, "added with --lock"
- temporary lock string, "initializing"

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed063..4829b9507ff 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -303,9 +303,9 @@ static int add_worktree(const char *path, const char *refname,
 	 */
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	if (!opts->keep_locked)
-		write_file(sb.buf, "initializing");
+		write_file(sb.buf, _("initializing"));
 	else
-		write_file(sb.buf, "added with --lock");
+		write_file(sb.buf, _("added with --lock"));
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
-- 
gitgitgadget

