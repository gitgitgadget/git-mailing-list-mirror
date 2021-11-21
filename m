Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB49C4332F
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhKUAuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbhKUAuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFBC06173E
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso10508752wme.3
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9h8b2WP43X1mVJW7SQOhSXJLeLMjNAq60C6WDGw+TiA=;
        b=GM5+5SoBmD3m62LR+oRFK805semoQ6+feO+sgldtm8VQSoZQzAJ58RAsgshPdoecCH
         WBLzhBQtKraQAPT3xYGPGCYJjzkDJb5eiOK96Ogh8TX9pIB9HVhk0arMqO6mb8qSvb0x
         hkt3ZzqUH6cd7XFgjmcoqcpRCD+poMmghsX+2rIG4jok3JMeGI7dF3i6uEDU6SAkCQ0K
         tneTeZrK+fxis+60vLNGo4VZFCjb9WiFZJYHxSKjCR4IDh6Zm+CkCy9ohlCeawIM0C5A
         ySHy3EB+KxCtDbMPTaHYJIW+Vj3yYWiYPO8jUDaqxeURSxkOiaaDVxeo23o4qhgqv2Gw
         fNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9h8b2WP43X1mVJW7SQOhSXJLeLMjNAq60C6WDGw+TiA=;
        b=FHsoCg+OmzlVW/XwJm3TLHH2rPPhYz+op3/lsibOKSFZfU88D/mgSsPQnfgAipDa7z
         +MdAJIbgu2Bhr8OGASPjY9tIgG0QgZZDcjnZUFLXZ5js3Ywu6xmTmCH09EyDlRwqH6Di
         0cLYJ1l75co2jEoS7McPn9GuDjrW86q1GbYoF27WclG8udpyQ0Ghvy8lzsHYBhSptiBv
         /BGVFS8qcwj8QanB/ICjWyvG86zWVF3AnyqL0Kh1sO+Z5p3hq/ZQYIeT4uNivcldJ9Mt
         WBZlsZFyKN94A75fsWtPsB2YIoUiyQqZTWZhP86xmh1ewAdn9IwHulY2fA903kT3eR3d
         z92w==
X-Gm-Message-State: AOAM533oB1xm8DyPO/u3dBk8G6H8u8M/t1EywY3/j5vod2Cuv+6AgRkm
        2S2IZRYx8TslGnUAKyIIGHtYyZJJ5+s=
X-Google-Smtp-Source: ABdhPJxRFOm0bqQ8N9YryfvJ0uKb5d+eutoQn/LZZQmr4KqNYkpfmkqE7PKvvFRJp98bhRdrawXXzw==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr15296601wma.129.1637455626682;
        Sat, 20 Nov 2021 16:47:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm4314596wma.8.2021.11.20.16.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:06 -0800 (PST)
Message-Id: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:47:00 +0000
Subject: [PATCH 8/8] dir: avoid removing the current working directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

dir has a convenient remove_path() helper that will both remove a file
in a directory and remove its containing directory if it becomes empty
as a result of the removal, recursing all the way up.  However, we do
not want the current working directory to be removed, even if it becomes
empty.

dir also has a remove_dir_recursively() function which appears to mostly
be used to remove metadata directories or temporary directories or
submodules or worktrees.  I am not sure if it needs to be protected
against removing the current working directory, but did so for good
measure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                | 11 ++++++++---
 t/t2501-cwd-empty.sh |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 94489298f4c..15e7639a158 100644
--- a/dir.c
+++ b/dir.c
@@ -3259,9 +3259,12 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
-		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
-	else if (kept_up)
+	if (!ret && !keep_toplevel && !kept_down) {
+		if (the_cwd && !strcmp(the_cwd, path->buf))
+			ret = -1; /* Do not remove current working directory */
+		else
+			ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
+	} else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
 		 * did not rmdir() our directory.
@@ -3327,6 +3330,8 @@ int remove_path(const char *name)
 		slash = dirs + (slash - name);
 		do {
 			*slash = '\0';
+			if (the_cwd && !strcmp(the_cwd, dirs))
+				break;
 		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
 		free(dirs);
 	}
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index ff4e7cd89fa..4362e7b15e5 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -191,7 +191,7 @@ test_expect_success 'revert fails if cwd needs to be removed' '
 	test_path_is_dir dirORfile
 '
 
-test_expect_failure 'rm does not remove cwd incidentally' '
+test_expect_success 'rm does not remove cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
@@ -205,7 +205,7 @@ test_expect_failure 'rm does not remove cwd incidentally' '
 	test_path_is_dir foo
 '
 
-test_expect_failure 'apply does not remove cwd incidentally' '
+test_expect_success 'apply does not remove cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
-- 
gitgitgadget
