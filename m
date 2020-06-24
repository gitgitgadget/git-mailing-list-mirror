Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D8C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA920702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6l0d9ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404767AbgFXTGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404079AbgFXTGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 15:06:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C0C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 12:06:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y5so3354302iob.12
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SI1S3Wa4DXOLBKXT+Was1yQgCP81JjTR+L9NNjVvHzU=;
        b=D6l0d9urRkEhkXQhdMPkb1bGpbVYVUsW1BMaWssCFKvuieZHQv9dfr1YsY6xU5n3TE
         EEZ9nsK6ZT2Z8pdIzkv76ejMA6WRATnbh5tT7oS6MRa086DdFFVF+VqK/3l7hbLBzvJD
         hCflCETQlaodCP9gdNwXdtBQQXVEz8ZHWP7xYx8R7ZVRZph99S0obXqIIDPbErIIiY4K
         thTVytY+W4PJA2EORliFKcPQ3qaoWgVNgritiHRnLnGZ60tdt+vh2i4I9xIOgqfMITtJ
         MoEa5c16JFuT2BBnhhMX5SEpIut7m+PvjyY26L2J6mcA7tXHEOPpyKs/R5yHo0C/u+f+
         o8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SI1S3Wa4DXOLBKXT+Was1yQgCP81JjTR+L9NNjVvHzU=;
        b=JuGqnT9EgfuBMwohRdVrxqg9RG+dnyRTjTpWVQMz092VUojFoE30cvxEa7FjukRg9U
         rrjhH9bstBc/wfyCLmbMwIH/B7nFhG/va2BQSltTBHKoTzVU5chputgTJ92ZBzRqL+jd
         2mEHsZE1jN+b3ZEeh/5it2pn1aDVxUqbdn2hQa5aYhykk7wGL6e/8dygk/fKtBLJg/Cc
         rp9Cty4p7Vi3/w88kPH8U7zxNA8fAY0Q3fx80Zjgh8tmCznfV3IPKX2Y7PNqPM/y1MGv
         Xw03/kf02GvFGMolLBKfGDRbQZWu/TtIBAXib0jsxXe8l/9ZIu46s4Jfp8nY3cyB6SVL
         YI8g==
X-Gm-Message-State: AOAM5328w44PqKI7pH82XJdIi9xhuSOUb1IDsOIBfXMZ6rDvms1Q4l5A
        j2wXA+lFuqJg0X+cY7DvW3vGeU4jGPU=
X-Google-Smtp-Source: ABdhPJxK7PMA63sAdn4z9+apSXzBYxNgfbU2FG4SL73bHgBXAp3p6hc6u5zUzZBLqyKhg6tQzrKgmQ==
X-Received: by 2002:a02:1d44:: with SMTP id 65mr8209047jaj.20.1593025602581;
        Wed, 24 Jun 2020 12:06:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id i84sm3059153ill.30.2020.06.24.12.06.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2020 12:06:41 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: avoid dead-code in conditional
Date:   Wed, 24 Jun 2020 15:05:41 -0400
Message-Id: <20200624190541.5253-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.288.g4b34aa94c7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_worktrees() retrieves a list of all worktrees associated with a
repository, including the main worktree. The location of the main
worktree is determined by get_main_worktree() which needs to handle
three distinct cases for the main worktree after absolute-path
conversion:

    * <bare-repository>/.
    * <main-worktree>/.git/. (when $CWD is .git)
    * <main-worktree>/.git (when $CWD is any worktree)

They all need to be normalized to just the <path> portion, dropping any
"/." or "/.git" suffix.

It turns out, however, that get_main_worktree() was only handling the
first and last cases, i.e.:

    if (!strip_suffix(path, "/.git"))
        strip_suffix(path, "/.");

This shortcoming was addressed by 45f274fbb1 (get_main_worktree(): allow
it to be called in the Git directory, 2020-02-23) by changing the logic
to:

    strip_suffix(path, "/.");
    if (!strip_suffix(path, "/.git"))
        strip_suffix(path, "/.");

which makes the final strip_suffix() invocation dead-code.

Fix this oversight by enumerating the three distinct cases explicitly
rather than attempting to strip the suffix(es) incrementally.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This "dead-code problem" was caught during review[1], however, the patch
was never re-rolled and ended up being accepted as-is. Dscho had raised
an objection[2] to the suggested way to fix the dead-code problem but
his objection was based upon a misunderstanding[3] thus (implicitly)
withdrawn.

An alternative to enumerating the three distinct cases, as this patch
does, would be to strip suffix components incrementally like this:

    strip_suffix(path, "/.");
    strip_suffix(path, "/.git");

However, such code is relatively opaque and would require a largish
in-code comment mirroring a chunk of the comment message of this patch.
The chosen approach, on the other hand, is relatively self-documenting,
requiring only very small inline source-code comments.

[1]: https://lore.kernel.org/git/CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com/
[2]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002241942120.46@tvgsbejvaqbjf.bet/
[3]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002271658250.46@tvgsbejvaqbjf.bet/

 worktree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index ee82235f26..b5cdee34de 100644
--- a/worktree.c
+++ b/worktree.c
@@ -50,9 +50,9 @@ static struct worktree *get_main_worktree(void)
 	struct strbuf worktree_path = STRBUF_INIT;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
-	strbuf_strip_suffix(&worktree_path, "/.");
-	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
-		strbuf_strip_suffix(&worktree_path, "/.");
+	if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git */
+	    !strbuf_strip_suffix(&worktree_path, "/.git")) /* in worktree */
+		strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-- 
2.27.0.288.g4b34aa94c7

