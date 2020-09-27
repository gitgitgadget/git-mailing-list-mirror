Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA0C4727E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176C72389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqAcSY0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgI0NQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgI0NQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97AC0613D3
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so8027698lfj.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aevlg/FGJxSsLzjA9QWJE1dKGUO92VUSoULqA/qtorI=;
        b=LqAcSY0WaPqQctM21ChYI9C0lso9hkg1WT4CSHOgt2wKwTfq4Tx70NAcGrZI2OFoPq
         whFxQPYUN6dtMu6YjbaHY9o1engetCnMkJbBzd2uyxUxpwp5hv08iRan6OlsuIhD1k3f
         2mWklMOX7Kav6LEGdWnmFaQwc0dn/kXJxJys5fmRGM4JaUlaxSXZbeg8h8FgMKB1Yv1t
         /uk5Er4rcimdmuxvWcsub21y7rM6hAytZT1yo7+60FHNAWMI4EaZDKCQ97cjphP4OfFC
         ZfVq7QNBv7DNaReLViPyQEpfOla2x04wvSfT8xLGHAMbOqGSmDQHum4ckowWS98ZItSg
         ubdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aevlg/FGJxSsLzjA9QWJE1dKGUO92VUSoULqA/qtorI=;
        b=QT8XSfWdT/B+iPfIvDKc48sX5E1ckLOL8roj2eXbVp9CTKrwUdO+OvS2tyc9H89skm
         vtcvJDF0xzRW8Oclp77riJodfm+w/XfA0gQL2j3uX/JLoLYuJBbgigC8uhYa1cjmv6K9
         xOdp7GssCmilhtpr6bZnNm5cUmCZkVNORSLRez5SM00cLuGUJCEE/RTzRyp7b/HOi9Z3
         jNhtbOd2kMclbrjSXq9tz4ZMHrzh8WTWXdoBiN/BEYLZoos+k8ozX08yui2xjcgW3MKZ
         floftJvgkX9ysmgVHxl9Ww3BsFyZ64TArdwm7cm78j6z59l9f3tjIRdc9ryDbXHNcgCg
         yHpw==
X-Gm-Message-State: AOAM532v1D5BcEBmYJfK/1o3v0tpgmMSD/G5wTO4Uofx+qIMHQHHvWy/
        JbYSlFzAqgM7L7E+mC/H9uAAOvLCyFo=
X-Google-Smtp-Source: ABdhPJzhIOYbEuG2qbY/ZqTwm7WK2ApEqcAjcPOCOkuwqXitTKwsWrcpOplc+E6mW7XywoUEeOCEkQ==
X-Received: by 2002:ac2:43d5:: with SMTP id u21mr2743858lfl.135.1601212571807;
        Sun, 27 Sep 2020 06:16:11 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/7] worktree: inline `worktree_ref()` into its only caller
Date:   Sun, 27 Sep 2020 15:15:44 +0200
Message-Id: <c4825f461e0408970f2adb272098bd6f2a80ef78.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have `strbuf_worktree_ref()`, which works on a strbuf, and a wrapper
for it, `worktree_ref()` which returns a string. We even make this
wrapper available through worktree.h. But it only has a single caller,
sitting right next to it in worktree.c.

Just inline the wrapper into its only caller. This means the caller can
quite naturally reuse a single strbuf. We currently achieve something
similar by having a static strbuf in the wrapper.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.h |  7 -------
 worktree.c | 17 ++++++-----------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/worktree.h b/worktree.h
index 516744c433..1449b6bf5d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -136,11 +136,4 @@ void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname);
 
-/*
- * Return a refname suitable for access from the current ref
- * store. The result will be destroyed at the next call.
- */
-const char *worktree_ref(const struct worktree *wt,
-			 const char *refname);
-
 #endif
diff --git a/worktree.c b/worktree.c
index 23dd547e44..a37d543394 100644
--- a/worktree.c
+++ b/worktree.c
@@ -548,18 +548,10 @@ void strbuf_worktree_ref(const struct worktree *wt,
 	strbuf_addstr(sb, refname);
 }
 
-const char *worktree_ref(const struct worktree *wt, const char *refname)
-{
-	static struct strbuf sb = STRBUF_INIT;
-
-	strbuf_reset(&sb);
-	strbuf_worktree_ref(wt, &sb, refname);
-	return sb.buf;
-}
-
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
+	struct strbuf refname = STRBUF_INIT;
 	int ret = 0;
 
 	worktrees = get_worktrees();
@@ -571,14 +563,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		if (wt->is_current)
 			continue;
 
+		strbuf_reset(&refname);
+		strbuf_worktree_ref(wt, &refname, "HEAD");
 		if (!refs_read_ref_full(get_main_ref_store(the_repository),
-					worktree_ref(wt, "HEAD"),
+					refname.buf,
 					RESOLVE_REF_READING,
 					&oid, &flag))
-			ret = fn(worktree_ref(wt, "HEAD"), &oid, flag, cb_data);
+			ret = fn(refname.buf, &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
 	free_worktrees(worktrees);
+	strbuf_release(&refname);
 	return ret;
 }
-- 
2.28.0.277.g9b3c35fffd

