Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B8A20D16
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdFTTUb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:31 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36239 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:30 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so47426784pgb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sOhP6Gwp+qgyMLwf59mN0GCP3vgQHynZKdDTEDskbOc=;
        b=jNgLrMZc98dQUs70L8R3BeYMERZVrQai8rrtBxemvNtJ4HiMAQ6t9JnfSXLA9+j7nV
         KK/tjndiw52Jkc2p58XLSURwJguk73LlzrWYi+u7TP+JFLO+hCxBJ8QY7Jz2qpAnASC+
         Iff5fNk01vsM94WM8PwUtqKkJwY7iAfvwuRjgu1pJNpgOovsmNMxrC8MWsPep1L81IXX
         u+8uCtKtyWZnQcaMgrLQcuaCDiKKtt+zZQs2mXlPV8dTDP8UcAKELSCupFwT3q++76eA
         s9W62AZgw+4f26QAocBYpLizdPldMMsRBcqBljhMKoIf4e0yLA6VYoNxLIBCRc+8iN0q
         uSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sOhP6Gwp+qgyMLwf59mN0GCP3vgQHynZKdDTEDskbOc=;
        b=KIT0vDwf02bsZ5m+WZVi2UM2gFRbEx7LD6pWQB7md/18EtGdoNO89uUz4WhTflw6Vy
         rZvNVuzo3OC/Uxv9ijX+fCIHPI1Ufdi9eWfH/qAIc1ONmxBPNfST5ttbIVRWQILiutbI
         ylnpVLiVkagIavXEwHF+x4e4ibVFmemZWEcwNX2l6Eo8j0hWhWgUP9RYLrg4g7T4Xe+o
         3VjkMJ5uoasZKPtwVraSWGQ7hMPfITja+0ZDeANe4FhgOTCyT5WzaOKjUkCaYuIWy0Hi
         Z/N1eaA55QtdlfkUTMl6O6om2TjRUS64lYORNNXwr6PJCAtuSzWT8UCxH3FjUsemm58x
         aD0w==
X-Gm-Message-State: AKS2vOzG11Do8ic8qp8O1XbGxEpq7go3wcTB+i7A4L+3LVZm7AWfy9Ep
        f5Oafjca9HUbJLL5God8mw==
X-Received: by 10.98.219.5 with SMTP id f5mr31679344pfg.2.1497986428924;
        Tue, 20 Jun 2017 12:20:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 11/20] path: construct correct path to a worktree's index
Date:   Tue, 20 Jun 2017 12:19:42 -0700
Message-Id: <20170620191951.84791-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with worktrees the git directory is split into two part,
the per-worktree gitdir and a commondir which contains things which are
shared among all worktrees (like the object store).  With this notion of
having a split git directory, 557bd833b (git_path(): be aware of file
relocation in $GIT_DIR) and c7b3a3d2f ($GIT_COMMON_DIR: a new
environment variable) changed the way that 'git_path()' functioned so
that paths would be adjusted if they referred to files or directories
that are stored in the commondir or have been changed via an environment
variable.

One interesting problem with this is the index file as it is not shared
across worktrees yet when asking for a path to a specific worktree's
index it will be replaced with a path to the current worktree's index.
In order to prevent this, teach 'adjuct_git_path' to replace the
path to the index with the path recorded in a repository (which would be
the current, active worktree) only when not asked to construct a path
for a specific worktree.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 76a872297..c6832a30e 100644
--- a/path.c
+++ b/path.c
@@ -372,13 +372,20 @@ void report_linked_checkout_garbage(void)
 }
 
 static void adjust_git_path(const struct repository *repo,
+			    const struct worktree *wt,
 			    struct strbuf *buf, int git_dir_len)
 {
 	const char *base = buf->buf + git_dir_len;
 	if (is_dir_file(base, "info", "grafts"))
 		strbuf_splice(buf, 0, buf->len,
 			      repo->graft_file, strlen(repo->graft_file));
-	else if (!strcmp(base, "index"))
+	/*
+	 * Only try to replace the path '$gitdir/index' with the index file
+	 * recorded in the repository when not constructing a path for a
+	 * worktree.  This way we can retrieve the correct path to a particular
+	 * worktree's index file.
+	 */
+	else if (!wt && !strcmp(base, "index"))
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
@@ -411,7 +418,7 @@ static void do_git_path(const struct repository *repo,
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
-	adjust_git_path(repo, buf, gitdir_len);
+	adjust_git_path(repo, wt, buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
 
-- 
2.13.1.611.g7e3b11ae1-goog

