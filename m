Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B986EC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 22:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDKWzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 18:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKWzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 18:55:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27A3A9B
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 15:55:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so5145925wms.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253734;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KQbEM0793tEb4IjBPuk45E7xc8CoMZ9aI/WORu5HXj0=;
        b=ayk4fps08uHpT3c7x9qw+WycvH4ZBNp9nllqE1SlQep/WRFcQXJyiOyBSsc28YkTYn
         jnE/rrMg0hh4yQpFcxsK4MC1NZWAix+7G0e1fICZcm5PmdQmiyYTimNOByNoRY0mQlKB
         xYSwJJ19EZIXZOEEfjdywn5gE8uxXKihsrNV04W65JjAYl9evFzXyHAj2be4d9cqO9LJ
         fOB80oQJYmNs2zdqjpJrq03SxaFAUKgSLYlNjyLatiizDgCAY/6eWWfBEoBd+MXpjJp9
         aUHzAYX6cG7BWVckqCigO8QikHo9i3DeF0R9gsu5dsnX25xFUaosbR8zMCVbGO3TuYQw
         xzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253734;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQbEM0793tEb4IjBPuk45E7xc8CoMZ9aI/WORu5HXj0=;
        b=sPcYwLHqVrmOPsOxa0GblSW9GPnu6fLRpV4ZDbbmAvd039Qr4bWZcq1XWxCovY3OMt
         TFp2firciQyTGJ5eB0xPC3dgMO3zi+qVw8iuF6QwxFhIMXDu0wdytteZKAbWlmky7kIf
         7dlqbGKIn4H3dj2+NU3qURenAfBAklnu0WpUs81KCSKZ+pGv3NbYUt8UqMwP+3jSd55J
         t/97efeBr62KDuzuvmtk/lI1dhdZnp1W8oZfLgxVuTPAtdkKjNHuA20rzhDtVA4lshSM
         EAzEetrhcDISipQaXuz0eSt6zyMMmePoS/e0msOLvQjtr8t9k/EbUTaBjcrMwSagBOrB
         56jw==
X-Gm-Message-State: AAQBX9eZfO4xFI8SIN+rwvob23DcNU0L1sp2v/wCFDSecUXqkhrxkq1i
        8vFwrqzjrPjl0RhwItq8Ru5emLEPuaQ=
X-Google-Smtp-Source: AKy350YwRarj15GPCSuBZ+sSKXc0nJ5vRTliFnBoilnSqHHnpY768yEkiQUcqMTo3OB1tP4TnXj0Ig==
X-Received: by 2002:a05:600c:3658:b0:3ef:7594:48cc with SMTP id y24-20020a05600c365800b003ef759448ccmr7820743wmq.23.1681253733641;
        Tue, 11 Apr 2023 15:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1-20020a05600c364100b003ed2384566fsm330673wmq.21.2023.04.11.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:55:33 -0700 (PDT)
Message-Id: <pull.1513.git.1681253732794.gitgitgadget@gmail.com>
From:   "Robert Boyd III via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 22:55:32 +0000
Subject: [PATCH] git-commit: fix cut_line behavior with CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Boyd III <git@robertboyd.dev>,
        Robert Boyd III <git@robertboyd.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Boyd III <git@robertboyd.dev>

On Windows with certain editor (mis)configurations, the cut_line that is
used when commit.verbose is turned on doesn't work correctly because
COMMIT_EDITMSG is rewritten with Windows line endings. This used to
happen on old versions of VSCode, but I can't seem to reproduce it
anymore without explicitly setting the line-endings to Windows. Even so,
I think it would be sensible to fix this for good, even in the face of
bad editor behavior.

This patch moves the \n ending out of the detection string constant, so
that regardless of the line endings, the cut_line is detected correctly.

Signed-off-by: Robert Boyd III <git@robertboyd.dev>
---
    git-commit: fix cut_line behavior with CRLF

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1513%2Frob-3%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1513/rob-3/maint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1513

 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 3162241a570..85904362fe5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -24,7 +24,7 @@
 #define UF_DELAY_WARNING_IN_MS (2 * 1000)
 
 static const char cut_line[] =
-"------------------------ >8 ------------------------\n";
+"------------------------ >8 ------------------------";
 
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -1090,7 +1090,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, "%s", cut_line);
+	strbuf_commented_addf(buf, "%s\n", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
 }
 

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
