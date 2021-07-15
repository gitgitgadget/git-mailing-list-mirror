Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FDC47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2816613CF
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhGOCf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhGOCf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:35:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE0C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d12so5583978wre.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=doNO/H+yymBmP9CMLggZFqCEhgObOPJu7vNmhKmj97g=;
        b=f1yBHXblUFt4lB+x8rD3F6Hbb5PLAvT4w7GtAnpwr9F5wFQmosq7yjKHimk8ZxwvHi
         lpGAvHw0vF4VRbgPcsBWKw9TVoDk1//nD4yS6hZUcsR7Z3KCn4O3fPkilpoZNsPxxuOw
         rlIlZT+LrVNZjL4+Bzem1G5VRKdZwWmd6tnAVMaFU/CA8gXEKU5udbZUf/DVK+BLBnOX
         cSzyiQ0a5hdAUvSnzsRJ6PGn0Uc85698qkXoKtUnL/yKMwk0kwbASYK9Brl+OGMmxtEi
         ufwje0PHk9vaDv3owNAzhTrbJaTcvZtVbk8NhBDb1dqE335XXRtI47qTy5KESiZjOE1C
         alTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=doNO/H+yymBmP9CMLggZFqCEhgObOPJu7vNmhKmj97g=;
        b=aoAJ5FsFRshi8GEd5oLkH1aDFTI/nESESRPjOetXJ2mQ65s4QH/qOigCOxd7i2JhSc
         EjX48dIHynDXPpp5TolxJhly1nQLkW1GeR36M1MhCC1dn5YIs/qXvedUXIzs2i0lIiCV
         JORLwbW8PkkGKPUFu6xf+Ee37IZqMy0Rlv8S7ogfTv6Fhi9azm39w5T6Eoj+TPAIYXf4
         xdrEebQizwolsXGy2idUaREpQBFcPrx205q4ptMUaM4lXmyJHfg+J0P20QIDTRyhCOpq
         K4jdXC+nxJhj7cerj8ZEekTOnef0FNCvbDDGbI3aJSgLTjn0crl3JEVENWZ0tcRnsX/i
         IhCA==
X-Gm-Message-State: AOAM531OW/937O8fIc9Nys9lJskuaTQTLfsYChZOGrPZjYYrvpXLKsId
        Fr2RzTbsW99KPDbl6JztHTGnkpb1tk4=
X-Google-Smtp-Source: ABdhPJz7APB2OrTRrqK91BkIzzawozhFRnsmCJ5PscHfuEjXHqiCzLZX6qaAKrHz+OwZ6oIt6b8m/A==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr1723829wrt.224.1626316353904;
        Wed, 14 Jul 2021 19:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm4348295wrs.22.2021.07.14.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:32:33 -0700 (PDT)
Message-Id: <ceb7a58b0049a8afa8c5f9f706b9a0b0abfb843e.1626316350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
References: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
        <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:32:29 +0000
Subject: [PATCH v4 2/3] worktree: mark lock strings with `_()` for translation
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

