Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DFF1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH2BOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:19 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51737 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2BOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:18 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so4769104itf.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/64creiM+ikqg+ui5em+9mAqrbuGy7L/NA9vYkQ/B/Q=;
        b=ldQ+DpniKBSfwZ2hOauDlBFsFgmVFR2jHGwihAL/uhi8YiNrwpLhzkKGAe84LDPJpD
         ZeJgdRJ4xoBZz6tPLWREZ88FIvoaB2cDLdTCZfVeblJnkg+M4Ewa+FJ6lCucFfo9ApCb
         JStT43Xsy2c6ObJwjBQb94s5/a5Au4RYXvJ0+e7bTnCSgDGE60CPaJ6It00c22K8TxxJ
         vfZOjqwj5gj+VYyANUskZ2Mj91Lra5rSasUn0lFhtHoQM8rQshROT5dUXUcaUgOMN5OI
         /tk3XBzTaXYPhWLIUIQgdkB8BPA1mZHIJWN+wXkjaoABFMk/tGuJEUXFPNnSvgv6t7PT
         Xc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/64creiM+ikqg+ui5em+9mAqrbuGy7L/NA9vYkQ/B/Q=;
        b=DTIHDOSuQIDvoecFYs9LGML9IGTScoOqR7ipDjGaEQC/sCAnAaoONtGMUvjfU3Zgv6
         wnsmkDTg0eC8G64DMA07TfHQo/DHlSVKnLpISRyuW1KVgieyLQ1It9OiSHi6ohPIWh3Z
         vTU4HxMqpeByufIa4o+YZue8DgJhl6epyaeJq4rV+RmBbD04Ex7kdE6ycvMSyo0tGDuy
         0r9C+4ZMbmLEshhDNPhRpw9R14eIqHJI0gzFyb0hrrmzxsxTyluA+HUWHUgu+sXNVTUL
         TD5zQQOmMRPkDiSfBiI+RhAmrgCwrrMf/yJ4nMpjg0yLd7ATnXvIPMVD5FHj1FTdxwn1
         2xJQ==
X-Gm-Message-State: APzg51ARkDSjAVv6Cq3aLj3hANiZrEf8XFTbtxr5FLJ5BqfTaf983Pts
        on4W69ckda9Ug2sh86CJDuwVcHuf
X-Google-Smtp-Source: ANB0VdZJpcu/b6pMfOby39QiblC3we/a0tRroPMeEDcTHtXTZHHTgjF7DZRKh58b4iynkRrE5eOpJA==
X-Received: by 2002:a24:9787:: with SMTP id k129-v6mr3129070ite.51.1535491247926;
        Tue, 28 Aug 2018 14:20:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:47 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/9] worktree: don't die() in library function find_worktree()
Date:   Tue, 28 Aug 2018 17:20:18 -0400
Message-Id: <20180828212026.21989-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers don't expect library function find_worktree() to die(); they
expect it to return the named worktree if found, or NULL if not.
Although find_worktree() itself never invokes die(), it calls
real_pathdup() with 'die_on_error' incorrectly set to 'true', thus will
die() indirectly if the user-provided path is not to real_pathdup()'s
liking. This can be observed, for instance, with any git-worktree
command which searches for an existing worktree:

    $ git worktree unlock foo
    fatal: 'foo' is not a working tree
    $ git worktree unlock foo/bar
    fatal: Invalid path '.../foo': No such file or directory

The first error message is the expected one from "git worktree unlock"
not finding the specified worktree; the second is from find_worktree()
invoking real_pathdup() incorrectly and die()ing prematurely.

Aside from the inconsistent error message between the two cases, this
bug hasn't otherwise been a serious problem since existing callers all
die() anyhow when the worktree can't be found. However, that may not be
true of callers added in the future, so fix find_worktree() to avoid
die()ing.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2028-worktree-move.sh | 8 ++++++++
 worktree.c               | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 5f7d45b7b7..60aba7c41a 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -141,4 +141,12 @@ test_expect_success 'NOT remove missing-but-locked worktree' '
 	test_path_is_dir .git/worktrees/gone-but-locked
 '
 
+test_expect_success 'proper error when worktree not found' '
+	for i in noodle noodle/bork
+	do
+		test_must_fail git worktree lock $i 2>err &&
+		test_i18ngrep "not a working tree" err || return 1
+	done
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 97cda5f97b..b0d0b5426d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -217,7 +217,11 @@ struct worktree *find_worktree(struct worktree **list,
 
 	if (prefix)
 		arg = to_free = prefix_filename(prefix, arg);
-	path = real_pathdup(arg, 1);
+	path = real_pathdup(arg, 0);
+	if (!path) {
+		free(to_free);
+		return NULL;
+	}
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
-- 
2.19.0.rc1.350.ge57e33dbd1

