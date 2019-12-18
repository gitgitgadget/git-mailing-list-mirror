Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738BC2D0BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCB20674
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7H4xgmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLRT37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51063 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfLRT34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3059573wmb.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OiVOjfhOoMJ2pyMlGtWTDqDyjMxgdcdniVdqMQnmLYQ=;
        b=O7H4xgmLgHMSEyKQnVxRB3O9lqTAmeG5aZhqLi5Yt9NupIWFHazpil0mb2BMMe5FSV
         UD6LX3f3vliPfliUDVEoZTDXTdxwvB64kegXE+joDZ4dyX5baG5FJmLsRNCtB3l/N4jW
         jq4uzmZW/Fb67PlUebo0sXoih3tQGwLS/JCXz3liQa5xWT98vtucoMQzXbMchs23jxzM
         uZz8bcwscp+m3nqgbLgdMJHnmO7zLcb3xZixMEfTQr+T9DruP5sVUj5spUVjlT3U3Fhz
         OD05DjWqDNUElXquF+5HBCdl57eOcdWJoQsVfe7iS5qBv01XHsyNWAI6TNDlGJiZme3D
         +XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OiVOjfhOoMJ2pyMlGtWTDqDyjMxgdcdniVdqMQnmLYQ=;
        b=ioX9ymAr33Z+XjE6p52QGufosWHOxhyJmcClju2A0YhUNZ/hxfHD57kBsR7veO5KgZ
         ZnzyAeWLn/n3Hfb4n8+oSa0dTpJJRcJLdK9XACfQ7x2HNX7Azs+v4K3s/vEiwvVog4zk
         euTzWtHj0P6KzsncjhpmqDfmPYetx1QPRu9wyKnjY4zYlWkH5bkAyDhpHbAiLl/8h75x
         L2G+mLdMEKQJJ+SYjY+tfJMRYlLXcyZ/6xVkb6bV7i92SWhUmHVJQTVVbQ3jlmWIBlh/
         abhOez3Fls2RXyGHgIOeHgd6t/Us+eEQjZxiyYfUI81PElfwriIBx3jjTeezxH/ds2dE
         41TQ==
X-Gm-Message-State: APjAAAXJCvpeHjpI4ZKl0xlgTu7dOZC1myx4WoNZZ6rn7Lqc/Git13ub
        HCo6OE/uvUNn8G0Xjyi/JPIM7XQG
X-Google-Smtp-Source: APXvYqzEuA4PVheBRjO5qeCxZcGZ9FaLM5Io2I4CVHP7/2sU/UGgXnr0s/jgQhvqE1pOH3t/jU47og==
X-Received: by 2002:a05:600c:409:: with SMTP id q9mr5111679wmb.19.1576697394615;
        Wed, 18 Dec 2019 11:29:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm3591690wml.31.2019.12.18.11.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:54 -0800 (PST)
Message-Id: <31079dc1cf10d031010846f1d1a0b30a05341943.1576697387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:46 +0000
Subject: [PATCH v4 8/8] dir: consolidate similar code in treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Both the DIR_SKIP_NESTED_GIT and DIR_NO_GITLINKS cases were checking for
whether a path was actually a nonbare repository.  That code could be
shared, with just the result of how to act differing between the two
cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index f500fd9279..6912f7eb5e 100644
--- a/dir.c
+++ b/dir.c
@@ -1461,6 +1461,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int baselen, int exclude,
 	const struct pathspec *pathspec)
 {
+	int nested_repo = 0;
+
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(istate, dirname, len-1)) {
 	case index_directory:
@@ -1470,15 +1472,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
-		if (dir->flags & DIR_SKIP_NESTED_GIT) {
-			int nested_repo;
+		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+		    !(dir->flags & DIR_NO_GITLINKS)) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addstr(&sb, dirname);
 			nested_repo = is_nonbare_repository_dir(&sb);
 			strbuf_release(&sb);
-			if (nested_repo)
-				return path_none;
 		}
+		if (nested_repo)
+			return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
+				(exclude ? path_excluded : path_untracked));
 
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
@@ -1506,13 +1509,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 			return path_none;
 		}
-		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, dirname);
-			if (is_nonbare_repository_dir(&sb))
-				return exclude ? path_excluded : path_untracked;
-			strbuf_release(&sb);
-		}
 		return path_recurse;
 	}
 
-- 
gitgitgadget
