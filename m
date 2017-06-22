Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD3A1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbdFVSo3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:29 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34523 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbdFVSo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so12519008pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XI2EPrNt8vCjeXOeVgWvYNwcHEU+mUn7GIRLI6/LgBs=;
        b=lgukg3T2hdWQ5Do3L5nMNE3IJs2ZRRQhBkuPTWJjTyPS1/VltbvbbCimWdCeVNHKjl
         KYF0NrxvcNTYBLS4+YmbntlQpzZe47knWwyPdjmHElIsjZUzHXgUsra/2mvIUGfllPN1
         ecRNkuaUVZIkL7Zu06oEyGt4D+BKIqTx3Ssmt0VKNBG3i/j+6lvVua5mKMdLUyBhCXkI
         sJEvoCCIGGNrR3Re6zG3d0wgN5ZrYI8tMK9yFdqdEl9MkLYaCKGlJ7DumnTTZ28UuBEP
         Y53VRHeuIbe/6L3REZRl4ZCZo1vPZqspqumwbvBioLz+yfndBetOrWwnizLT/3ETn9AD
         3NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XI2EPrNt8vCjeXOeVgWvYNwcHEU+mUn7GIRLI6/LgBs=;
        b=p780Wxy/ZzLEELS0qm/DK8CGwQ0iZc2HkdMbNrgfOD1wEjgr7QFfJvT5pkhGqW5Q1U
         TuCo+JYBdoEcSeUea4U2+uLN0WkUm43p+g7dfJFlRQAH+x4yl1hk0iCnQ4/FsCrwcEJU
         pVQvJVxbKPvK+fiP3zqu3R+DqsTyr/2MkdrzM1iuxVolP/gF4whwoQxM0DL/A3O84cNu
         MIr85CZUI4dZ8TQjS4Jm9m1RSTg62fckJKHUgtLAN/NrSxkI1Atl7hy9o/GYwVNm8fjs
         Lon/mfcSMbHkOXpi/TdSu7/3pnUjc9uoeIXcEoDcg5ZjriuMt5iHusPMbct9IEjEKCXz
         SOqw==
X-Gm-Message-State: AKS2vOyaedvuR5nCjQ57ecrnI9bWgkRdktm1sRPY1Reyr3TNuoW9ZGIk
        tos/X6YWs+WUqMLSbQ7k4g==
X-Received: by 10.98.252.77 with SMTP id e74mr4097727pfh.42.1498157059960;
        Thu, 22 Jun 2017 11:44:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 11/20] path: worktree_git_path() should not use file relocation
Date:   Thu, 22 Jun 2017 11:43:39 -0700
Message-Id: <20170622184348.56497-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_path is a convenience function that usually produces a string
$GIT_DIR/<path>.  Since v2.5.0-rc0~143^2~35 (git_path(): be aware of
file relocation in $GIT_DIR, 2014-11-30), as a side benefit callers
get support for path relocation variables like $GIT_OBJECT_DIRECTORY:

- git_path("index") is $GIT_INDEX_FILE when set
- git_path("info/grafts") is $GIT_GRAFTS_FILE when set
- git_path("objects/<foo>") is $GIT_OBJECT_DIRECTORY/<foo> when set
- git_path("hooks/<foo>") is <foo> under core.hookspath when set
- git_path("refs/<foo>") etc (see path.c::common_list) is relative
  to $GIT_COMMON_DIR instead of $GIT_DIR

worktree_git_path, by comparison, is designed to resolve files in a
specific worktree's git dir.  Unfortunately, it shares code with
git_path and performs the same relocation.  The result is that paths
that are meant to be relative to the specified worktree's git dir end
up replaced by paths from environment variables within the current git
dir.

Luckily, no current callers pass such arguments.  The relocation was
noticed when testing the result of merging two patches under review,
one of which introduces a caller:

* The first patch made git prune check the index file in each
  worktree's git dir (using worktree_git_path(wt, "index")) for
  objects not to prune.  This would trigger the unwanted relocation
  when GIT_INDEX_FILE is set, causing objects reachable from the
  index to be pruned.

* The second patch simplified the relocation logic for index,
  info/grafts, objects, and hooks to happen unconditionally instead of
  based on whether environment or configuration variables are set.
  This caused the relocation to trigger even when GIT_INDEX_FILE is
  not set.

[jn: rewrote commit message; skipping all relocation instead of just
 GIT_INDEX_FILE]

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 76a872297..2bdd0044f 100644
--- a/path.c
+++ b/path.c
@@ -411,7 +411,8 @@ static void do_git_path(const struct repository *repo,
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
-	adjust_git_path(repo, buf, gitdir_len);
+	if (!wt)
+		adjust_git_path(repo, buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
 
-- 
2.13.1.704.gde00cce3c-goog

