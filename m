Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8413B201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdERBmT (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:42:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34302 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdERBmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:42:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so3903430pgb.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQUmucwqoZQMrQ2E5RWOb6e9E8mLurGAf+eAinDJAak=;
        b=c3Du+9ODRR+58KGuXa1EmBWPGB+2vpqg16Qupd8DEZ2q5cjb+MZBDkdBMIcpzRDQ+m
         yVr4jtr2Dj3UZC1UBEo/+yIkxIkumnFkqqe2QqSlPDusXt0M7ofyMPA6jX+qiR05n+LT
         qCy4wE6sMQ9yk8C4lQpKwIlGOFGqxkpomzB1GVz+bN9Lbp2YApG+UZo3AnuoP+tQG82T
         2/TBT8cXK7te0ZPn9Z2Y6Ba6AogZ2EbZf1EeMYuYR1cuVCDFJXmJI57sJ12bdfYUOYOv
         fAMIJHox98G1hQz0e9h6feqqQybLeafmUag/y4gAG7WjwhVVsPlUY2+pEhClhmRg5qvt
         CzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DQUmucwqoZQMrQ2E5RWOb6e9E8mLurGAf+eAinDJAak=;
        b=eYiXJTbAD9Agzzn5rGRo+PTQgMzTR028zSEeyLpvoFBxY8OT/uBUErjSJml3Lgeqw5
         P9m0ba0Ebf1dfOYL8jy/ZeLDeU51cbyN005rrYrLOteI/hGHUQKrjkC3kB+D14uXbNhS
         xeYmYIguBsisOzYFMW7h5ndQr8cUXAHYSzdJ8tNPi5hIqGFMVJrCSTuEqOsk2aZVdDCO
         Ip8AlRR5nvZ4K+83KUuPpEbhP6j+kiWLw+6Am2QZX9HR8Iqv6s8r0tjeVGklsq+qOJUW
         OoV+S/jY2XKFWqHk3GaG4xgl62dKbKIwLBtimTe7GITb3wGl71iYtf5ARJUDGEdvoB1M
         kftQ==
X-Gm-Message-State: AODbwcBS9YrMwN8m/23XPj7qh8nF0mtxUgPpzICiSDRnzh2L7VWxBqxX
        sOwWNQm5l3a9SQ==
X-Received: by 10.99.186.21 with SMTP id k21mr1668493pgf.165.1495071736683;
        Wed, 17 May 2017 18:42:16 -0700 (PDT)
Received: from ligo.sfo1.mozilla.com (corp-nat.fw1.untrust.sfo1.mozilla.net. [63.245.222.198])
        by smtp.gmail.com with ESMTPSA id i15sm7749705pfj.51.2017.05.17.18.42.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 18:42:16 -0700 (PDT)
From:   manishearth@gmail.com
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Subject: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over all worktree HEADs
Date:   Wed, 17 May 2017 18:42:09 -0700
Message-Id: <20170518014210.94189-1-manishearth@gmail.com>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishearth@gmail.com>

To ensure that `git prune` does not remove refs checked out
in other worktrees, we need to include these HEADs in the
set of roots. This adds the iteration function necessary
to do this.

Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
---
 refs.c | 20 ++++++++++++++++++++
 refs.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/refs.c b/refs.c
index 2d71774..7dc82ba 100644
--- a/refs.c
+++ b/refs.c
@@ -3,10 +3,12 @@
  */
 
 #include "cache.h"
+#include "commit.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "object.h"
+#include "worktree.h"
 #include "tag.h"
 
 /*
@@ -1157,6 +1159,24 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
+{
+	int i, flag, retval = 0;
+	struct object_id oid;
+	struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
+	struct commit* commit;
+	for (i = 0; worktrees[i]; i++) {
+		if ((commit = lookup_commit_reference(worktrees[i]->head_sha1))) {
+			oid = commit->object.oid;
+			if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
+				if ((retval = fn("HEAD", &oid, flag, cb_data)))
+					return retval;
+			}
+		}
+	}
+	return retval;
+}
+
 /*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
diff --git a/refs.h b/refs.h
index 9fbff90..425a853 100644
--- a/refs.h
+++ b/refs.h
@@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
  * stop the iteration.
  */
 int head_ref(each_ref_fn fn, void *cb_data);
+int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
-- 
2.10.1

