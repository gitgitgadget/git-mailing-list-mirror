Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B3C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH2BOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33614 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeH2BOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:21 -0400
Received: by mail-it0-f66.google.com with SMTP id j198-v6so3269249ita.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44Ood2tVNtJOjYjZCjQAZMUYUxiKHiKrJSOSNYcK4Cc=;
        b=TKOZgIrIzJF77UP99uWT2HkP3DWZfVcjlD/6+mN0q5q/BXCcA5eJIM7mTxZefUyAXg
         bgo4jFkRdA8m11HgDN4XkiDN37YAu3LVZGuJzN5aXS5MCMcNFaP13MwR4xhYCBw6IB3n
         ON0gPth9lXpj3WhOheNk0zZP1S3JQ3SXr1mWSRzxQ+GN+cwdZhJwAO8TtPbQnEjoklVf
         GGAq4FCNjhq35quPJ1/2QKJQCUzX9+Qf67L9fv6V3XOdWFxhNzpeRnB1dkWkBS7Dka9W
         xm8sg0Lz4uvuh93HjbX5IT2qcH9k9qzbDZGyOa8QR4Oul1ejiwkN6/6WZa4jLxYGVrpY
         r8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=44Ood2tVNtJOjYjZCjQAZMUYUxiKHiKrJSOSNYcK4Cc=;
        b=UR60m3o5J0tCSpeRvC2BoONdir7GP2YoLowy4ZcrSu+DhQd4PrLdORKwzG1IqDXLv5
         /GUXq8A25flzrkWumwXxyBy/c4MZdTbUCvIWm9QIHijY6nYX9U/op0hMMj98eNU5UjMr
         vAFoS0QdtyQRakWdW7zmXI8Kn45ZWxFuHTqclER/HsnuQTWk6eO4Q0ExetZY5EfNPBPZ
         FXWqjXCmKpjN8SeubhPUK48EXn/JIbPLAlNjLcnGAD+Teo79Mqc3om+bFe9lVh8abLPz
         Y2f2V9n5nbbknJE++Hm5gLfR0Bwrt8lxruYWqaYNY4jP6G/2UWVK0x/1/1iCe/C0OC+z
         ltPA==
X-Gm-Message-State: APzg51Czy10lm8LUdUhBU1085fIir0bVENk8i4FIMXHvHxTJOhsao1x4
        MsTbmK2BJ5J3IDPmcYh+PGQTBWXm
X-Google-Smtp-Source: ANB0VdbX2gG8X5XfJcTEPtO6YTimndlpQ+sMDxvYwohjzP8Q42E5wiq+M5V5XNKFMDy9aZeIDNn4yg==
X-Received: by 2002:a24:4c90:: with SMTP id a138-v6mr3116951itb.138.1535491250283;
        Tue, 28 Aug 2018 14:20:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:49 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/9] worktree: prepare for more checks of whether path can become worktree
Date:   Tue, 28 Aug 2018 17:20:21 -0400
Message-Id: <20180828212026.21989-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Certain conditions must be met for a path to be a valid candidate as the
location of a new worktree; for instance, the path must not exist or
must be an empty directory. Although the number of conditions is small,
new conditions will soon be added so factor out the existing checks into
a separate function to avoid further bloating add_worktree().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0affcb476c..46c93771e8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -219,6 +219,12 @@ static const char *worktree_basename(const char *path, int *olen)
 	return name;
 }
 
+static void validate_worktree_add(const char *path, const struct add_opts *opts)
+{
+	if (file_exists(path) && !is_empty_dir(path))
+		die(_("'%s' already exists"), path);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -233,8 +239,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct commit *commit = NULL;
 	int is_branch = 0;
 
-	if (file_exists(path) && !is_empty_dir(path))
-		die(_("'%s' already exists"), path);
+	validate_worktree_add(path, opts);
 
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-- 
2.19.0.rc1.350.ge57e33dbd1

