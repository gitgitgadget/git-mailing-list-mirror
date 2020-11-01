Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC067C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E5F22265
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd3nOy8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgKAR3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgKAR25 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22588C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so11936188wrm.4
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KtM3ah1m5iPmVtqoSDImGvgde4PfPAlNe1t2WvU6tiY=;
        b=fd3nOy8K56FOGYAecHvEkq3xhsFTSb8ddCJaq62N7/JuXPuBK5ZjKK2dfYoNNWBVqR
         YAWrk/LPLUfKWYJkJuP6cqapsaPuzv+UBJuymKt/tJ+zn+TT8JTpFxeZCbzWeYLg9eLF
         sVuILYjM/fupeVcMH+8AvASbw9beIGKIWaWEsa0oeI4z5ewAc7f4HQDDr80I5S24JaVJ
         1s59IID3/J8fNTJ9mxrpB+ARkcwT4xHTqGB00/K/XFtYkklo9BPstKGVWxmnEfI3Jjp6
         k7xSuj8rxRZnqQw/0kMCQkOnKHKTA/dfmy3xfBxT2g3281WM7f6B6pnY2uEt3NL/H+0q
         LBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KtM3ah1m5iPmVtqoSDImGvgde4PfPAlNe1t2WvU6tiY=;
        b=WoMhEETJwh//pLxWaYa/4xK6bXuF6Ea24k+crF/W6sHEQtjH3NxRea/IDMULbk2VA7
         ILAW/ev4IEkcAO703p2Uvi8ecvBI8G1/NNzm234mYJOj3N8B5Njn+d6KuXCwUkzJLPEX
         h2dloN9hu4YR0s+RbXX+IP8Ekx+v6THvAbXe/xe0yf5zTrsuqOP4kDVfLEC9Ox9LwvRJ
         m9UQ5pFYnGUUv9X5eoTYkrJbSv+dAlC3ZsE3zYco9Gp+v0yHg7tsWYNJyB0mv/PVxnkX
         +sABFYJgkO7TXi0T52DF6atEtYrPyWWifKpn8g5iW5V89JlL3lc6/RlWP6QOQ8i2pqJ2
         arkg==
X-Gm-Message-State: AOAM530zgRQBV0ZUK2yEKBe/wwnp4BkJ5xPDIKVClyVGUV6vnBDwVotv
        LL1BkPyzHSx79SZ/YLuq8U55Sii/I68=
X-Google-Smtp-Source: ABdhPJzsVNbKBc/gMtvdpXuXmY/7kshCMIyG6IDl/2goovROvXvauJ2ISNZQb3ajFz0WYtMyp2x5yg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr15770404wrq.106.1604251735813;
        Sun, 01 Nov 2020 09:28:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b136sm11885456wmb.21.2020.11.01.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:55 -0800 (PST)
Message-Id: <7aca3274d2d25994984cd98f94ed8c3a8411749e.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:47 +0000
Subject: [PATCH v2 8/8] blame: simplify 'setup_blame_bloom_data' interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The penultimate commit moved the initialization of 'sb.path' in
'builtin/blame.c::cmd_blame' before the call to
'blame.c::setup_blame_bloom_data'. Since 'cmd_blame' is the only caller
of 'setup_blame_bloom_data', it is now unnecessary for
'setup_blame_bloom_data' to receive 'path' as a separate argument, as
'sb.path' is already initialized.

Remove this argument from setup_blame_bloom_data's interface and use the
'path' field of the 'sb' 'struct blame_scoreboard' instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 blame.c         | 5 ++---
 blame.h         | 3 +--
 builtin/blame.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/blame.c b/blame.c
index 128cb7ba55..9042aa3f2b 100644
--- a/blame.c
+++ b/blame.c
@@ -2887,8 +2887,7 @@ struct blame_entry *blame_entry_prepend(struct blame_entry *head,
 	return new_head;
 }
 
-void setup_blame_bloom_data(struct blame_scoreboard *sb,
-			    const char *path)
+void setup_blame_bloom_data(struct blame_scoreboard *sb)
 {
 	struct blame_bloom_data *bd;
 	struct bloom_filter_settings *bs;
@@ -2908,7 +2907,7 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb,
 	bd->nr = 0;
 	ALLOC_ARRAY(bd->keys, bd->alloc);
 
-	add_bloom_key(bd, path);
+	add_bloom_key(bd, sb->path);
 
 	sb->bloom_data = bd;
 }
diff --git a/blame.h b/blame.h
index e8c185c8ef..38bde535b3 100644
--- a/blame.h
+++ b/blame.h
@@ -182,8 +182,7 @@ const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 void init_scoreboard(struct blame_scoreboard *sb);
 void setup_scoreboard(struct blame_scoreboard *sb,
 		      struct blame_origin **orig);
-void setup_blame_bloom_data(struct blame_scoreboard *sb,
-			    const char *path);
+void setup_blame_bloom_data(struct blame_scoreboard *sb);
 void cleanup_scoreboard(struct blame_scoreboard *sb);
 
 struct blame_entry *blame_entry_prepend(struct blame_entry *head,
diff --git a/builtin/blame.c b/builtin/blame.c
index 5d8f4c4599..2f8b06e589 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1092,7 +1092,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	 * for copies.
 	 */
 	if (!(opt & PICKAXE_BLAME_COPY))
-		setup_blame_bloom_data(&sb, path);
+		setup_blame_bloom_data(&sb);
 
 	lno = sb.num_lines;
 
-- 
gitgitgadget
