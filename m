Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9102207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031215AbdDTKLm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34744 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031205AbdDTKLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id y11so5655791oie.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5prlj0dItwxXaJ7v8Le/2fM7yzZUSOxABzfsnl2EWg=;
        b=ijsc0tiXlXGqFTKtyjodRSllS9VfgTh9OYKqYwWp11TjhG3Sbtm2krH8yTgbG5Y5bX
         mfNHuQdlO8lWgOw4/8QVVzw8xZorIXFxQBfnTOe4rRJPh0kj3Ua3JEBtGMl7XynB6Nmk
         dCTNFnQL3gWHJiSRIaQ9lxB0MsVQw7RlXSkSpWpDyyiVxMqufs8SMpdkRb5ADnAGxoGk
         DucLc2pVBe8oC+yyrzxuv/mRhih3Lz5iifqIi+sNXSHkMPQ6ly9Y40tswLmfDscCOjGK
         AQgQOhIWaN44WlxUk2q9MXjCZYCvN2vRxvrnRncVu+PFK99eaPJ8QkgrRAnzcszpWR/i
         p1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5prlj0dItwxXaJ7v8Le/2fM7yzZUSOxABzfsnl2EWg=;
        b=tOREEItk6riHPB/cd2PoMRgUdkbHIasFIrQ/hqa07MtcGlqyTrqfvpB9soATvzZmRl
         8Dg5iZ6nSq899tg4GtsWxwKF7n2sGgapeSAsf0pgLtmgTff3fSsCQj+vbfHNEauqeQ5R
         rdBc9iZGLl6fCjpNEbiGoMdo8dA2p8X2M3hxKNFjZZe+HkmarcEPUpgal7KU85/DUtQN
         nvEyDQAc2JJ7P3w3+WIe8nI/RjyozBo/1nH33aS6bLsCQTbukxs5TlGBFAAwOm2/IMVa
         1UCPVEw8alFlXejJjWYwk+5apdgWOTi5YJfbu2UtTfXeyttyPivqP9YYW1JX5zlcZ8GR
         LdaA==
X-Gm-Message-State: AN3rC/4rutcZgSkPG7g3lXC8ZR00wf8Kq5NhOhU0ZsBOH1QkzLSBDKlV
        NOVyVqX0cIBPvw==
X-Received: by 10.98.29.86 with SMTP id d83mr7447089pfd.68.1492683100078;
        Thu, 20 Apr 2017 03:11:40 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s65sm9530870pgb.34.2017.04.20.03.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] worktree move: refuse to move worktrees with submodules
Date:   Thu, 20 Apr 2017 17:10:23 +0700
Message-Id: <20170420101024.7593-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 116507e47e..825b3e9d9a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -526,6 +526,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = {0};
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("This working tree contains submodules and cannot be moved yet"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -564,6 +585,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	validate_no_submodules(wt);
+
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
-- 
2.11.0.157.gd943d85

