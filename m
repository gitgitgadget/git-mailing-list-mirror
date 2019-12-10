Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D687C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4592077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgCTp7xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLJUAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41112 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfLJUAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so21526747wrw.8
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zze0uH3Nj4ZOmvZ1O0g/xeKVlrddGGSxpyF/tpjrz40=;
        b=HgCTp7xgXoz8tKiKqtfXE7pfEr3f4KBzDz6ZgFO6JxXdZnO75gqsmjlvAFH5NnXUnd
         5eVUxAK+/hj+0qsRDgiCjQTe1qSzPrWjoaNTi5oYwgQXXEy0/r+TaDQB/xDOLko3ev98
         eJCOCKc9kBUxpsj7A394bz3g42UTrY7rx6KCcmTnr/4WxL3nC6B0b56p8amI8IbqfUqZ
         e16Xs3t0UHYIkWFInVgJfA+PBdpox7OJ/HyJ5dL0Jx6tN1rlG+tnZChasLiz2VB2eB0E
         mrqK4w3PZSKR849jZGOiK9HLXAmnascvMh6hicJeMq02UtLo6QKDVgMkLicLsphDDcfK
         AvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zze0uH3Nj4ZOmvZ1O0g/xeKVlrddGGSxpyF/tpjrz40=;
        b=Ta+GQw7+uQPe0yUsC+jbqAl72w78AVFGL13bLcGCBbGeSdWNh0UT7f66GPb++KS9nQ
         WX1vBLRnqBbbiTkOpdRDu8RRyLIdDW0NN60vcwVwFunRrqpF2PAf+gGfimHPwMl++qHv
         gOsQYoeUdNJcxQUQX8HjU27LHUTE6qoWYrbQG6ADH8PSp9/L3+gIlQ2cNG75cxd1jwOt
         fv3JWL44+r6CpVaDiaHf/Fx3S05KR6OfcxgIF9wWZzNH7UhlBu3zA6iPJPmg9nLluyoe
         PALe6eK28Qn8JoheHNRy0T1JA5+H8Bh1JSTiO9Yfc5nk4g/2c0YgQ0prjNEcO9FT+z52
         xJMg==
X-Gm-Message-State: APjAAAUMrvJNItveUqYFKuLuJCpoC6nZs5D8YP5F25rNmEhyVuFLdNfz
        bEyeVhr52e84k3ERUnorfZHbat4h
X-Google-Smtp-Source: APXvYqwq2eK4vao8wmsrRccwKufI20dX0+eZ5qn0vZK6ACm7nYAck0EnJK9Xxvp3XMp9Ip0q0uwD5g==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr5029941wrs.20.1576008035971;
        Tue, 10 Dec 2019 12:00:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19sm4093039wmc.22.2019.12.10.12.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:35 -0800 (PST)
Message-Id: <77b57e44fdd819536c9be37a6190a79792efbccb.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:27 +0000
Subject: [PATCH v2 8/8] dir: consolidate similar code in treat_directory()
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
index bb6e481909..04541b798b 100644
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
