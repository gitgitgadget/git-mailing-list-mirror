Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79469C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7672468F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7Oh59OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgB0UZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:25:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36957 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbgB0UZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 15:25:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id t7so615381edr.4
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=KkTKkrDqnQbgNmQH3bf9+timYpMbWw1T0fVYw4y75+k=;
        b=r7Oh59OAwxxPfoq1aOb9OAe1kOHdD986Zh4Bnw8jJ3W3lDCFEMIP491TPJFr8WWgre
         9kODmd8SjEgIy9vU/YuF7KS6g/8Wg0+AaLQKWOIp6+9c3MEqJ2Gb56CEccLtU1LI22KO
         1znM7qeN+XQdynFwkS2Ie1nz/0h7pLrOzdqMrtl5K2IqDf9f5Bvr7OqtUjMKCsSO/0Mp
         N2abNHGPUnYJSIU/tDGG7dO9FHFGSQVPcXOsZupi42M2+Vj1OQ9EvhsUmvLXz2hre9Rz
         TiEF3RwQ63B8vAAV0WGsEh/A8l/dJhnsUmJ1dczvoguHNAJOGgMgO3wuY8eo79l0WlHX
         Zp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KkTKkrDqnQbgNmQH3bf9+timYpMbWw1T0fVYw4y75+k=;
        b=aE5uTGJ5p0YZnLYDiMwhslQ2ryr1VxMeJGB4LNa0xvy+1j8ETWiB+APPb1yUZwYpZN
         Sl0aogYUArRAPuBSajhb9JCWb5bAEOpL9oWgzaF+/sEjT8r+Y/IwrwKYgyFi9Wuo9RzX
         bOGYwBszpV1LFxuKVbM8DWRv8r3QXmnRD0i41wC07Eo9PVlAPNvKb3dsG4OEVRMCUMtG
         diECUDKLm7nDrFOD8pmQ9CvDVNDCWcaBqRKGQfolHFOvtijs9wl8ShHzq2LecCGEyhUY
         t9iiPKTC/GbR8hjoJQPeDMmEBod1yQeCx4j3RaH5GR2QgH11nmhN6QAvb+2Hp2FU/izn
         V9ew==
X-Gm-Message-State: APjAAAU5VR3ApiUf6HXWP/0OVPBrzyeu93Q27kImmXHERlPNQO4hGIuN
        +N3Vir8+PSYqhQBt9vCVVKXMF+E+
X-Google-Smtp-Source: APXvYqwAEvHW9xNEbHwRfXgpEyW0wQJPtrXrtyzT2dEUTG1tSQz2luuJ7agUEdt+r85QSsD0tL7Abw==
X-Received: by 2002:a50:ed18:: with SMTP id j24mr341754eds.124.1582835131489;
        Thu, 27 Feb 2020 12:25:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm316381ejb.34.2020.02.27.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 12:25:31 -0800 (PST)
Message-Id: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
From:   "Ralf Thielow via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 20:25:30 +0000
Subject: [PATCH] rebase-interactive.c: silence format-zero-length warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ralf Thielow <ralf.thielow@gmail.com>

Fixes the following warnings:

rebase-interactive.c: In function ‘edit_todo_list’:
rebase-interactive.c:137:38: warning: zero-length gnu_printf format string [-Wformat-zero-length]
    write_file(rebase_path_dropped(), "");
rebase-interactive.c:144:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
   write_file(rebase_path_dropped(), "");

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
    rebase-interactive.c: silence format-zero-length warnings
    
    I noticed these warnings a while ago and they're still there, so here's
    my fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-567%2Fralfth%2Fformat-zero-length-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-567/ralfth/format-zero-length-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/567

 rebase-interactive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index ac001dea588..0a4572e67ea 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -134,14 +134,14 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 
 	if (incorrect) {
 		if (todo_list_check_against_backup(r, new_todo)) {
-			write_file(rebase_path_dropped(), "");
+			write_file(rebase_path_dropped(), "%s", "");
 			return -4;
 		}
 
 		if (incorrect > 0)
 			unlink(rebase_path_dropped());
 	} else if (todo_list_check(todo_list, new_todo)) {
-		write_file(rebase_path_dropped(), "");
+		write_file(rebase_path_dropped(), "%s", "");
 		return -4;
 	}
 

base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
-- 
gitgitgadget
