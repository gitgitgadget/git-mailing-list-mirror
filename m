Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC27200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbcL0RuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:50:19 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33614 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbcL0RuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 12:50:18 -0500
Received: by mail-pg0-f46.google.com with SMTP id g1so107826564pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8rZ0tWC+PspSkhqPKSWpOtEekSTPK4XnY4RQRellBfE=;
        b=VzKJ9XOhhGXAmY+Krg0GVq3t1rDDvACDD49Rc8MDbsTjC5sE/nPZyD65dVulRvZUWX
         XmNWR7aWm22N1/08+GOxJgjrAKQ45vukyIGagDOH1vjdzCA5+bjVa0nwV6gKkDDVvR5x
         KRfWHoYkCV3utgue5EzZXjp/lG8rnuGp/h3WUbkSMOj1coCK5KptDuKqA97rREEUYlNL
         HJtlWx+TPbUkUN5k8oeSTxcxcuDkQvtXDh2qsNGoe1UVFHA2ZjLqO4WOc5jf/SBrUuSC
         CNoNkaYKhyI/5lK4R3xZBxItb37f/8g5sMTLAZSnxvbGM0NzQJGEaJS1aTxldSsZxiX4
         VjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8rZ0tWC+PspSkhqPKSWpOtEekSTPK4XnY4RQRellBfE=;
        b=uMZMFv3OOFUDuDG1+koxdhSKQUJzrxWfHdVLdfNLlVOzDQjKeaB5Osv8keZx8HERe3
         03rFbzw4QVYYsGNlXojbMtxDcYPYXOotqYWIxOIi4AsTjUS/1Oyy0DucxP5VK22tYbSG
         9w5SNgKZi3mcosrMJDhmDv8XwjFNK7TZxhgVQ+HU114gK+zoBMPXKyv3I6ywEinlFqPD
         NXM1cLXOs8J7RwHjltMwYnmPbsyUCFh0j3eovskxnqdUFpvLYYDIPsmNSC2wOtfKx2aD
         aa6MaNj0i2+rJzlaR30+MpIWW/PZjDcwiwNaJeF8o4LRg0NbEzbgupNG909vNdb+zj0K
         M9eA==
X-Gm-Message-State: AIkVDXKRR+OjlUKqAyPiAKuyM2MMngnh5+IbP50ephC857W3D4Lyg2YtFI6FU7MmvwOK3Rrf
X-Received: by 10.98.62.153 with SMTP id y25mr21368027pfj.162.1482861017468;
        Tue, 27 Dec 2016 09:50:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id n25sm91114276pfi.33.2016.12.27.09.50.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 09:50:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, larsxschneider@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] worktree: initialize return value for submodule_uses_worktrees
Date:   Tue, 27 Dec 2016 09:50:13 -0800
Message-Id: <20161227175013.12747-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.50.g8bda6b2.dirty
In-Reply-To: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
References: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the worktrees directory is empty, the `ret` will be returned
uninitialized. Fix it by initializing the value.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This goes on top of 1a248cf (origin/sb/submodule-embed-gitdir);
ideally to be squashed, but as it is in next already, as a separate
patch.

Thanks,
Stefan

 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index d4606aa8cd..828fd7a0ad 100644
--- a/worktree.c
+++ b/worktree.c
@@ -387,7 +387,7 @@ int submodule_uses_worktrees(const char *path)
 	struct strbuf sb = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
-	int ret;
+	int ret = 0;
 	struct repository_format format;
 
 	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
-- 
2.11.0.rc2.50.g8bda6b2.dirty

