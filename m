Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CC42023D
	for <e@80x24.org>; Wed, 17 May 2017 00:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdEQAus (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:50:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35106 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdEQAus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:50:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so23241984pgd.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/petlubfOZfuGUU/4/SdOa1GnsBkIYj3KZIXH4pDgnU=;
        b=W7oLi7ZYW0UXoZIqDc5qN4oOpwiw64T27sD47b2LKI50rWGmJGh/jYL6ib3Ec+JIua
         1dpR9rlBbW/jcZ5jYkMwdiIlaqQKCURp6CueTaJ8lsO0BP5NgZFgfGLB9JZvrBRw76Zm
         JRLXt9SJpQKGM6InaE4H4ifQaTB+DTMc4IWY6wKRhOgG7YDP3/KBmxVUbqqMlmqqkd/G
         RTY1BK3As6P07SF2oDFaIIpYa+yeDlsg2u54Uke8HWH0jRV4+Iedhicekzu3TPS6bBla
         F+9oZfpIEhDVdSKnZY2QG5rAsF+k2Nd3FFcF1qgPWsSogxzuWbsaEACDBiboOYMfkIw8
         Njrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/petlubfOZfuGUU/4/SdOa1GnsBkIYj3KZIXH4pDgnU=;
        b=Q4qMnDBt1CAbT/Qk7gISIxOOE9sIxW+TQNUuRl4sD++HDKw7LM0M6MUXU6Zm8nh0x9
         bBkTsO3MHFFaG8fKAshzkEmN0FH9FltXWh7b21cTOHNGkkDmE/Y5A7xTm+FUEjjHUmee
         IRxlakIL6k0C8ey69OvIQbSYP0ev9dN4mO879GNvagwx2PfKP5n8hz2KnxdqLeiDAMSa
         jmq3ZGvZWr8ocjVlRntBZ5ch+ZE+1lr+FqVvQ5RQDzqYMYXNU5ExRagCsM9WMOkMW3WW
         Il1gTPJmxNrGbh+EUm15SqqoQz2z2C/ZfK9pcwOlAIx5ln7kHokv2t1qQ+sR0tGaoMMZ
         rGAw==
X-Gm-Message-State: AODbwcBlsLmBTkMafNFaQ5VuWwgzlpckJDdUxK1+Gk34urHA5Op2MaXU
        qtAz8BTSdnw+XA==
X-Received: by 10.84.171.195 with SMTP id l61mr913100plb.147.1494982247575;
        Tue, 16 May 2017 17:50:47 -0700 (PDT)
Received: from ligo.sfo1.mozilla.com (corp-nat.fw1.untrust.sfo1.mozilla.net. [63.245.222.198])
        by smtp.gmail.com with ESMTPSA id g27sm372699pfg.63.2017.05.16.17.50.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 17:50:47 -0700 (PDT)
From:   manish.earth@gmail.com
X-Google-Original-From: manishearth@gmail.com
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Subject: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over all worktree HEADs
Date:   Tue, 16 May 2017 17:50:40 -0700
Message-Id: <20170517005041.46310-1-manishearth@gmail.com>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20170517002825.GR27400@aiede.svl.corp.google.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com>
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
 refs.c | 16 ++++++++++++++++
 refs.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/refs.c b/refs.c
index 2d71774..27e0b60 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "commit.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
@@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
+{
+	int i, flag, retval;
+	struct object_id oid;
+	struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
+	for (i = 0; worktrees[i]; i++) {
+		struct commit* commit = lookup_commit_reference(worktrees[i]->head_sha1);
+		oid = commit->object.oid;
+		if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
+			if (retval = fn("HEAD", &oid, flag, cb_data))
+				return retval;
+		}
+	}
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

