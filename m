Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A531F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH2BOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:24 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33721 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeH2BOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:23 -0400
Received: by mail-io0-f196.google.com with SMTP id r196-v6so2736376iod.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdvw4UJr6tPEh9vyOmPQr3yAW6vwlwqD7A1jZCnsnHY=;
        b=p32jmjosIfdQpBYM7N0K2QHarqwTzLpxkHTCHX2Pl5QD9CSomftLQKC2OfUXHQHvgE
         6UOJmWoCjaK/LC8Yuhwty97oJnKS+p1gTOBvvoTt8BujwOAlgGVK4GyEh3JCKsdK//XG
         Bic5YGFJFqJEggpPDHzXWvcsVUIIWvAjy9WcQ9K6K2V2BPIt/ZYkCbmbQFXZt5iD+72T
         bWvNEfwf0gaUntDAcFnyEZnwBk3y0wFP+qXiUK0vB5JTZzgsmX3VFIsauj+wrQ2AwULg
         1gbo/lFfjLaZlphxKZIGplQBlZ98YKpx2NNGKYPdixDbzAKxmxKj8Klq+pgJprEhDY26
         gdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zdvw4UJr6tPEh9vyOmPQr3yAW6vwlwqD7A1jZCnsnHY=;
        b=DFUoHHZtRLEwHhyyqtR/cC+O8jRmgelfSxI7cpGzRkQMzSbvc71sUbAOInwH/ogPQf
         uXXZc3adbKBmN3v6o4rCMR2csjmuOmf9cGl7NFFpuWOlxGLls+UFlLWJWKy6FN8Lc8jA
         Apwofrw6tf0ySU9PjXLgdOgizOf3Y3MuE3CTbCT/ElO71j+n7lNiiBjfryIMHEtQtzvy
         DEXzZbP+eJn/JLsdJiYLwR3ib/+fbcSHI606eeb4KRFo/gvxXRu1tJBi16lUbl7mjqxS
         URK26HHD3MrmdIn0kz8uzhaCrU9fXFbJm2QtSBsBFKK4t9hfQ2RWS1gt5qA8mo5zUD9+
         dq3Q==
X-Gm-Message-State: APzg51DS9dc7YKslARo2tBaUq1s5TRO05TwkFGUakkXqbRcCRnbTq8DI
        gAp7oYQGq2Fut5TZJNtbwKvgukaU
X-Google-Smtp-Source: ANB0VdZaglEyJ499EXqIhBcTyBClliTM6LupIXHeNZmXlQozCebayZTUmaRqfRYlvKG0SE1WykSBjg==
X-Received: by 2002:a6b:a3c1:: with SMTP id m184-v6mr3038096ioe.61.1535491253344;
        Tue, 28 Aug 2018 14:20:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 8/9] worktree: teach 'remove' to override lock when --force given twice
Date:   Tue, 28 Aug 2018 17:20:25 -0400
Message-Id: <20180828212026.21989-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For consistency with "add -f -f" and "move -f -f" which override
the lock on a worktree, allow "remove -f -f" to do so, as well, as a
convenience.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  1 +
 builtin/worktree.c             | 11 ++++++-----
 t/t2028-worktree-move.sh       | 10 ++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d08b8d8e4f..e2ee9fc21b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -129,6 +129,7 @@ OPTIONS
 twice.
 +
 `remove` refuses to remove an unclean working tree unless `--force` is used.
+To remove a locked working tree, specify `--force` twice.
 
 -b <new-branch>::
 -B <new-branch>::
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 354a6c0eb5..a95fe67da6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -875,13 +875,13 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	int force = 0;
 	struct option options[] = {
 		OPT__FORCE(&force,
-			 N_("force removing even if the worktree is dirty"),
+			 N_("force removal even if worktree is dirty or locked"),
 			 PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
 	struct strbuf errmsg = STRBUF_INIT;
-	const char *reason;
+	const char *reason = NULL;
 	int ret = 0;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -894,12 +894,13 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-	reason = is_worktree_locked(wt);
+	if (force < 2)
+		reason = is_worktree_locked(wt);
 	if (reason) {
 		if (*reason)
-			die(_("cannot remove a locked working tree, lock reason: %s"),
+			die(_("cannot remove a locked working tree, lock reason: %s\nuse 'remove -f -f' to override or unlock first"),
 			    reason);
-		die(_("cannot remove a locked working tree"));
+		die(_("cannot remove a locked working tree;\nuse 'remove -f -f' to override or unlock first"));
 	}
 	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
 		die(_("validation failed, cannot remove working tree: %s"),
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 9756ede8f1..1b5079e8fa 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -163,4 +163,14 @@ test_expect_success 'proper error when worktree not found' '
 	done
 '
 
+test_expect_success 'remove locked worktree (force)' '
+	git worktree add --detach gumby &&
+	test_when_finished "git worktree remove gumby || :" &&
+	git worktree lock gumby &&
+	test_when_finished "git worktree unlock gumby || :" &&
+	test_must_fail git worktree remove gumby &&
+	test_must_fail git worktree remove --force gumby &&
+	git worktree remove --force --force gumby
+'
+
 test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

