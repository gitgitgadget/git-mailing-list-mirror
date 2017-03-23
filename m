Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436BD20958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935921AbdCWVJl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36382 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdCWVJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:35 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so129052793pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BrSe3SO6cJswhdtB+ePVM5H8QbBhYHvMus7NOuRfmE=;
        b=EPHtiRnMtX3teN8jdZcnIjhMWuu6dKdhqXMEFlvmL2ULka5fHIM4FZZdLzmjiwqRz5
         BVStJv41OR9CoPNr59DALoQqphQ3aZ8lcRA5oCObF8jzMsr26JG2XiTy6hMmpOO4mIOi
         vud7yiWjcZbTUE1srJjJDTIuiMdh0C3vLqzudWIA6OfXx9CRQGSI3cpAEPf0ooyGlMM6
         9lOEWAvplkkDORLe9CHPYJWLXcwjcBj6jEMbOb4agf5COUNKCiwtzyufqT359iYijREU
         XRF1/d97YUcCifGoXUXcnMj5iStEPA3KweiTd5vLdX9NJYiQxCqRezeGZR0ared1nHZd
         UT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6BrSe3SO6cJswhdtB+ePVM5H8QbBhYHvMus7NOuRfmE=;
        b=Kp1cEpBKTvAXIRZc/oO95lS6E7vkgGBRYGg0h6hQVtsNUWK20FcwuLhbf0qFMfU/ku
         tRFWrhbNu9uxD1MZ21dt/lFJmdeVO32mwt0CfDFDq8nDTGuN/fTirkFS+9Tp4kAbflIa
         vnZEaUT5OnH6VFIZ7mkJJALpAdm4osj9aWOT/rKFD9wCdGDyBk2m+gZK8RncIbGdCXCQ
         DeosvulcgLt8DOwl3OZd8Rbr/JcJbXVYvoPzxAX4/sCVnIo97pSwfxvThyrqY2BGqHwS
         MBLVn91NqkQ4BsJ0TbU8Oq1x75n93MgBpbBbzgtUk40caAg4QflV9dlJIFtux/oiaH2W
         067g==
X-Gm-Message-State: AFeK/H12il8z9WpzX2wANtZLgUqPy9PVV5P8AFWtiPOMq/AgX+Tq+K1I+SH7FETGC7JW8j8B
X-Received: by 10.99.49.13 with SMTP id x13mr5116164pgx.128.1490303369298;
        Thu, 23 Mar 2017 14:09:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id w28sm171236pfl.115.2017.03.23.14.09.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] submodule.c: use argv_array in is_submodule_modified
Date:   Thu, 23 Mar 2017 14:09:18 -0700
Message-Id: <20170323210924.26818-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct argv_array is easier to use and maintain

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/submodule.c b/submodule.c
index d355ddb46b..dc61ca7103 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,9 +1041,11 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
+	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
+	const char *line, *next_line;
 	const char *git_dir;
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -1068,35 +1070,32 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain=2' in submodule %s", path);
+		die("Could not run 'git status --porcelain' in submodule %s", path);
 
-	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
-		/* regular untracked files */
-		if (buf.buf[0] == '?')
+	len = strbuf_read(&buf, cp.out, 1024);
+	line = buf.buf;
+	while (len > 2) {
+		if ((line[0] == '?') && (line[1] == '?')) {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		/* regular unmerged and renamed files */
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
-			if (buf.buf[5] == 'S') {
-				/* nested submodule handling */
-				if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
-					dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-				if (buf.buf[8] == 'U')
-					dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			} else
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED &&
-		    dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+				break;
+		} else {
+			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+			if (ignore_untracked ||
+			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
 				break;
+		}
+		next_line = strchr(line, '\n');
+		if (!next_line)
+			break;
+		next_line++;
+		len -= (next_line - line);
+		line = next_line;
 	}
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain=2' failed in submodule %s", path);
+		die("'git status --porcelain' failed in submodule %s", path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.12.1.438.gb674c4c09c

