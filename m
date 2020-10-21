Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1529C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8B22249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 06:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu48Nb9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440452AbgJUGZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgJUGZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 02:25:01 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A5C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 23:25:01 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id t15so338374ual.6
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yE1G9K5bY9pdXGMXp3g+3gN4XqD2jDWEkrMOryXhpTY=;
        b=Tu48Nb9DxsXuVII7zDrBjI1xDdMg+dL/CM/kEb+oE9GNmINzo0/l54Gd9xi4D6WT5J
         G5kXx2qZMF/foZcgzu2sV808jJGDIBCo6EeVsghGQZRvH1/KL+2Sa3mbpycPjNBQrlY5
         VexzsKbd51X84HwG+1Mz0JizIdcXdKB5PqXBvsCiybica1jPgtSCmy1pCxcT1ELUfmpl
         9WkkjppU51kwoKLcW7oOkI7nWfKYFKOz6/FWwdUojx5pQVXSeVhDVRtx5ZBKGgpYKcBG
         dyBeC8Ffa961N3Qz2YHTgROmdtRiiOmtE0v4IVDCsqszD+pYczsjzvS0hvw9XBlWJie2
         2H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yE1G9K5bY9pdXGMXp3g+3gN4XqD2jDWEkrMOryXhpTY=;
        b=t9RvfVfD++qLQlbhvsZbLg7czPMgqKrw3WN10OaI7WGcuWf3jr2D2d/Rek1aSEhvI+
         vZPdKn440F8wdp9o9rC+l0ATQOIEIlnmI9Zxpx0dSBYzqsqbfeeKcx8ASZB345fuFyWF
         RsQFfTOpJx3SzUPr+ca4bxgxveMpgXvXF/mbf5K7C6U3TyEcvzDDtJxgLDmJIy6wEmnw
         dKKPRMcvlBQMzJJz2x7mM1FojAZqPKsHxkvTLRPu469ZfCzCbMt7O6x2pXe1AWcAZIN2
         3JhBy+kUfvWVOd2TqLaNYbG8MNwBIuedijNhhsPeE095Fplk4cgdLxmMDrdt+wxnEOaw
         QOUg==
X-Gm-Message-State: AOAM533bRk0IJE1YcA0clwCEgNGFZ6+OaFqxshShKCyWWmW5VGgfkJFy
        JfzMsycxs7fm+xvBv9ZSNDGz7YlYabdeYVkz
X-Google-Smtp-Source: ABdhPJweNI8vntVGX0K8Lh/TrWpBRLXtXpcMDS43Jvym/f3iVvNzEiNYQsecndsclUqIgsQAWKaIkA==
X-Received: by 2002:ab0:39d1:: with SMTP id g17mr890827uaw.34.1603261500068;
        Tue, 20 Oct 2020 23:25:00 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.194.42])
        by smtp.gmail.com with ESMTPSA id i3sm181015vkp.6.2020.10.20.23.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 23:24:59 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC] sequencer: allow metadata to be saved if using cherry-pick --no-commit
Date:   Wed, 21 Oct 2020 00:24:30 -0600
Message-Id: <20201021062430.2029566-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if 'git cherry-pick --no-commit' is run _and the cherry-pick
operation is successful_, the metadata from the original revision is lost and
to git it's like a cherry-pick operation is not taking place at all. Hence,
we can't wrap up the cherry-pick operation by calling
'git cherry-pick --continue'.

With this patch, we allow sequencer to save the metadata from the original
cherry-pick operation so that 'git cherry-pick --continue' can be called.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 sequencer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 00acb12496..c1ccbe0faf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2022,9 +2022,8 @@ static int do_pick_commit(struct repository *r,
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if ((command == TODO_PICK || command == TODO_REWORD ||
-	     command == TODO_EDIT) && !opts->no_commit &&
-	    (res == 0 || res == 1) &&
+	if ((command == TODO_PICK || command == TODO_REWORD || command == TODO_EDIT)
+		&& ((res == 0 && opts->no_commit) || (res == 1 && !opts->no_commit)) &&
 	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
 		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
-- 
2.28.0

