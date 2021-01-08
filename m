Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB218C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E290233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhAHJ0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbhAHJ0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:26:09 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9DC0612F5
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:25:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p18so7281163pgm.11
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+928/NLQrAzhBc/uF6G3lqqK0enztvZp/wEKWLJI8E=;
        b=SP2wOyAJp7SIOukdr/b2RPEa0a1eZrzkW9k3s+abuT+OwsZK5dNwMbRy+VUEEngXkb
         s6caeK6nfcCKUXxP+nqPCxhq24GDrUzpgi+5+3/LAp9otJWVIY3Y2y7nHr8ZiAq7v62B
         e+0k5b2gAHrdFF2tMvgUUH6ZymSXOFn1u+ZPBohwRqJL/n5K3F0pDiySwkba8xG4Dzcl
         nZzCQbMTa8kZMC5IBDb1MnAXt0123EKA98iex5rnmEATru72JuhLzOurGZHuBs67UT+g
         LBzchOZZEJ7AkqadvhFmi47DAqi1gOXyW1V+WTA7X+Jdrz4c2RVwiV36FROgVt/Q9bHd
         Iu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+928/NLQrAzhBc/uF6G3lqqK0enztvZp/wEKWLJI8E=;
        b=MPjMNOHZpaydSKJofN94iG6F4VOHggj/T4TmROQyKo0u6552fwYx3CMXiIkRvTCAqV
         f16j3qZgRM3psVHiSlKnG9qdfLo875B+IbhAScrnkVSD/4rsd4uOXlHYtDOyXcnBO/eJ
         4hJTzag2YYcUNUc/2HkwAH49Js00nNzXnrVq8HMQ1nmo4VbPhGrZuQvdOLvgVUjPpASp
         9wTrugWD6BXlo8e4hAqhNfXLbn4eOO1Ctc40hmEaGT3M9QQcZazBhVl24hF/EB9+2Ot1
         R2sC4SWVdGPt2KxNoiEdqGoOVOYQVzImi8tZltKWrOUmZljU3Q3bnGq4JJ2+7gVyWvDj
         cbyg==
X-Gm-Message-State: AOAM531oV9Ot8/51lQDFbBDJgIbjbOhprNfFLc1UyNBx+1HF2BJAHmbu
        HO9jI7M8FgIG9dnAQOdQjhvWEFA0WmtwyA==
X-Google-Smtp-Source: ABdhPJwsNDZ8ULjzLUFcmGeN736n4I8m/pTnn8/iMtrIrCuZGn5J5w5P5lERa2WtIWEC6voAaVrfWw==
X-Received: by 2002:a63:b4a:: with SMTP id a10mr6117095pgl.112.1610097929020;
        Fri, 08 Jan 2021 01:25:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:25:28 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de, Charvi Mendiratta <charvi077@gmail.com>
Subject: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's needed
Date:   Fri,  8 Jan 2021 14:53:39 +0530
Message-Id: <20210108092345.2178-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
commands, there's no point in writing it for squash commands as it is
immediately deleted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a46770..f888a7ed3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1757,11 +1757,13 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (write_message(body, strlen(body),
-				  rebase_path_fixup_msg(), 0)) {
-			unuse_commit_buffer(head_commit, head_message);
-			return error(_("cannot write '%s'"),
-				     rebase_path_fixup_msg());
+		if (command == TODO_FIXUP) {
+			if (write_message(body, strlen(body),
+					  rebase_path_fixup_msg(), 0)) {
+				unuse_commit_buffer(head_commit, head_message);
+				return error(_("cannot write '%s'"),
+					     rebase_path_fixup_msg());
+			}
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-- 
2.29.0.rc1

