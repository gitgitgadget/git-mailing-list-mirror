Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14EC35673
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 02:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62CF20727
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 02:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0g7tcT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBXCAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:00:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:47006 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXCAh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 21:00:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id z141so4530898ywd.13
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmpCCvbJQZedLLo/CxzybPwPJ/6HtZqvQSA75gwwtm0=;
        b=p0g7tcT409fHZbTsygDpZpcynXmUN/0ZMvdlqL4SJzcEHYfdSfO7JFBADY31CkMqwy
         tOAlc+rAVxaayPAGUswZBX2mg1JG1z2s4e0O0xg64PSFHLx36/z2+S5i5chQ3h35+8cs
         K1ijQWwFKhp4hvI7xuiFq73gJsaJspSY0t5L/yMW9m3xzoCmetVr3EeV3zhaixjIsM9l
         dLAmE1S2jrcy1Gclm9xaLM2BND6SSEGWOaXJNJKftFsM1dBVpqExJmXCDhy6kFqmxiif
         0MormFqHrJmcid7qI7O6rSx5J63OhwWd9OxMOiua6yF+ANr77B0DO/hij7wIuxtC6sF1
         R++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QmpCCvbJQZedLLo/CxzybPwPJ/6HtZqvQSA75gwwtm0=;
        b=Wwf49H9LJDw58OJJkPpqJjpAtWqajfvAsTQh5NZieprrJC6zBDJYcXIbtOqq+Zto6P
         OTJ4w40vl0mS+WBbztMCMqOob1WsU6Lcegx79r+Cgk7brTSPRlgFhis/KScek/yIGoIw
         owd/ggoxUiRpJYGLVpB1qig6bo5ggWitqQ/MWudXTWmHbiUhQArkpr2TfFzpwGFRVuI4
         f7h3FxklQD0LTixD5qk+L+2J764XpdVcho2RElGU3eod9sHTrGDh2GhotybFKsv0WZyy
         ISSyWzHmiS1l6I1GeB1qb4NjaOApN7xtvUqK8BnG2THKE/+Ccxnfo9JUKgcOJKUEN9SO
         9JMQ==
X-Gm-Message-State: APjAAAVab0VTQhuJMfmTzZcSa/u9FYoTAe1roJwSbYwKGS4VTrjoSgRu
        4GvWCct1fGFaxTAQ2M4cIAXpSKsa
X-Google-Smtp-Source: APXvYqyBvdgMHQPOHlJ1/RXWZJm6lNI4G3LyNN6BE0j6OQkRaIZe+NPDKGjbcyMfr/ebCG1n9GQmBA==
X-Received: by 2002:a81:2e57:: with SMTP id u84mr38344759ywu.98.1582509635438;
        Sun, 23 Feb 2020 18:00:35 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id d13sm4817555ywj.91.2020.02.23.18.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 18:00:34 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: drop unused code from get_main_worktree()
Date:   Sun, 23 Feb 2020 20:59:35 -0500
Message-Id: <20200224015935.19190-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code has been unused since fa099d2322 (worktree.c: kill parse_ref()
in favor of refs_resolve_ref_unsafe(), 2017-04-24), so drop it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Just something I noticed while reviewing a patch[1] on the mailing list.

[1]: https://lore.kernel.org/git/8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com/

 worktree.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index 5b4793caa3..33c2655534 100644
--- a/worktree.c
+++ b/worktree.c
@@ -47,15 +47,12 @@ static void add_head_info(struct worktree *wt)
 static struct worktree *get_main_worktree(void)
 {
 	struct worktree *worktree = NULL;
-	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	/*
@@ -69,7 +66,6 @@ static struct worktree *get_main_worktree(void)
 		is_bare_repository();
 	add_head_info(worktree);
 
-	strbuf_release(&path);
 	strbuf_release(&worktree_path);
 	return worktree;
 }
-- 
2.25.1.526.gf05a752211

