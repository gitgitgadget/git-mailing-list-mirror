Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD12C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51820863
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQV2xTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgCCQM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:12:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgCCQM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:12:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so5120869wrr.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PP97p3oeJ+bQw4+ze0jb029iDypVaZayxDIXSCL3+f4=;
        b=ITQV2xToTBcn1jcOsr1h1ugyu99ocI09f0IU2796ofBmZRRJV6ecyoWA03+4ON2JGG
         sl3HlVk4XJIVH4GG1cpzkgoHPKLkB5Y7qFpvbyycA924o6LLugu+8XugNIza7xvLnHpI
         1gkCCQNY/lEEvbCJ8GGWBi5rPjVhHjtHFKftNzzens/xLXOPMU4qcv5fizovobOxfR5P
         gkjJ58TGa6M1GYasMbdz2yuyCxASjVhvjgL8Je3mdZ4aFrDYOrTebLebh599bLmIR625
         nhhuDX4qiMmxYf0KtmNjVu7/tNnqe4ghhoqqia/Vro8OCKZWL6+nfN8PzFcRUTvvHboY
         lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PP97p3oeJ+bQw4+ze0jb029iDypVaZayxDIXSCL3+f4=;
        b=B8Wl/IDF2mHDkJfjP9PIh2eDV7QWn4ijIWblLywFN76zuQjjZXm+pPYIza8822m1Zu
         lrLTKUYWkDYjEKT+Mm/jPVp5RHdh693u9U+MxqkM/KNhbpnMutOPdj4726wqZW0nqyGF
         lqKMYRGwJQeeqN8QQSN4SGLGJ/5yAJM1TC5pBSFc7H1qedcL/v5/ioybaPxgHUKGCzsI
         ha2Cw1OUlZ+CK2pcM2/E9nLgwh5tYrd4kUvQLK06VUqpAiOzpyWLVS1pllfHO8H9y1Fl
         MSLwJW1Xg6h85sZtyBd20Putd4acrwl6y226waX33VFc1u2DShqeQke6I1Kcpiy0mPSG
         tV6w==
X-Gm-Message-State: ANhLgQ0kONXLBYJJCiicIsfrqcvLq8bhyEc6EZshaRiVze0S2KsG14+x
        c3lODuBsB+28D6DscDsrkjTicaFaUHo=
X-Google-Smtp-Source: ADFU+vsE/y8cxgDTM4Cc87rLQSQYFY+yTU4a5g4hbyJlz6MgBrYycv+F44xX66XuIfiM9TdN7gd2cw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr6428948wro.255.1583251975909;
        Tue, 03 Mar 2020 08:12:55 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id l8sm4847472wmj.2.2020.03.03.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:12:54 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
Date:   Tue,  3 Mar 2020 17:12:23 +0100
Message-Id: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
References: <20200302133217.GA1176622@coredump.intra.peff.net>
 <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking at the value of %(push:remoteref) only handles the case when an
explicit push refspec is passed. But it does not handle the fallback
cases of looking at the configuration value of `push.default`.

In particular, doing something like

    git config push.default current
    git for-each-ref --format='%(push)'
    git for-each-ref --format='%(push:remoteref)'

prints a useful tracking ref for the first for-each-ref, but an empty
string for the second.

Since the intention of %(push:remoteref), from 9700fae5ee (for-each-ref:
let upstream/push report the remote ref name) is to get exactly which
branch `git push` will push to, even in the fallback cases, fix this.

To get the meaning of %(push:remoteref), `ref-filter.c` calls
`remote_ref_for_branch`. We simply add a new static helper function,
`branch_get_push_remoteref` that follows the logic of
`branch_get_push_1`, and call it from `remote_ref_for_branch`.

We also update t/6300-for-each-ref.sh to handle all `push.default`
strategies. This involves testing `push.default=simple` twice, once
where there is a matching upstream branch and once when there is none.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c                | 106 +++++++++++++++++++++++++++++++---------
 t/t6300-for-each-ref.sh |  29 ++++++++++-
 2 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/remote.c b/remote.c
index c43196ec06..b3ce992d01 100644
--- a/remote.c
+++ b/remote.c
@@ -516,28 +516,6 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
-{
-	if (branch) {
-		if (!for_push) {
-			if (branch->merge_nr) {
-				return branch->merge_name[0];
-			}
-		} else {
-			const char *dst, *remote_name =
-				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
-
-			if (remote && remote->push.nr &&
-			    (dst = apply_refspecs(&remote->push,
-						  branch->refname))) {
-				return dst;
-			}
-		}
-	}
-	return NULL;
-}
-
 static struct remote *remote_get_1(const char *name,
 				   const char *(*get_default)(struct branch *, int *))
 {
@@ -1656,6 +1634,76 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
+/**
+ * Return the local name of the remote tracking branch, as in
+ * %(push:remoteref), that corresponds to the ref we would push to given a
+ * bare `git push` while `branch` is checked out.
+ * See also branch_get_push_1 below.
+ */
+static const char *branch_get_push_remoteref(struct branch *branch)
+{
+	struct remote *remote;
+
+	remote = remote_get(pushremote_for_branch(branch, NULL));
+	if (!remote)
+		return NULL;
+
+	if (remote->push.nr) {
+		char *dst;
+
+		dst = apply_refspecs(&remote->push, branch->refname);
+		if (!dst)
+			return NULL;
+
+		return dst;
+	}
+
+	if (remote->mirror)
+		return branch->refname;
+
+	switch (push_default) {
+	case PUSH_DEFAULT_NOTHING:
+		return NULL;
+
+	case PUSH_DEFAULT_MATCHING:
+	case PUSH_DEFAULT_CURRENT:
+		return branch->refname;
+
+	case PUSH_DEFAULT_UPSTREAM:
+		{
+			if (!branch || !branch->merge ||
+			    !branch->merge[0] || !branch->merge[0]->dst)
+			return NULL;
+
+			return branch->merge[0]->src;
+		}
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_SIMPLE:
+		{
+			const char *up, *cur;
+
+			up = branch_get_upstream(branch, NULL);
+			if (!up)
+				return NULL;
+			cur = tracking_for_push_dest(remote, branch->refname, NULL);
+			if (!cur)
+				return NULL;
+			if (strcmp(cur, up))
+				return NULL;
+
+			return branch->refname;
+		}
+	}
+
+	BUG("unhandled push situation");
+}
+
+/**
+ * Return the tracking branch, as in %(push), that corresponds to the ref we
+ * would push to given a bare `git push` while `branch` is checked out.
+ * See also branch_get_push_remoteref above.
+ */
 static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
@@ -1735,6 +1783,20 @@ static int ignore_symref_update(const char *refname)
 	return (flag & REF_ISSYMREF);
 }
 
+const char *remote_ref_for_branch(struct branch *branch, int for_push)
+{
+	if (branch) {
+		if (!for_push) {
+			if (branch->merge_nr) {
+				return branch->merge_name[0];
+			}
+		} else {
+			return branch_get_push_remoteref(branch);
+		}
+	}
+	return NULL;
+}
+
 /*
  * Create and return a list of (struct ref) consisting of copies of
  * each remote_ref that matches refspec.  refspec must be a pattern.
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce746..60e21834fd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -874,7 +874,34 @@ test_expect_success ':remotename and :remoteref' '
 		actual="$(git for-each-ref \
 			--format="%(push:remotename),%(push:remoteref)" \
 			refs/heads/push-simple)" &&
-		test from, = "$actual"
+		test from, = "$actual" &&
+		git config branch.push-simple.remote from &&
+		git config branch.push-simple.merge refs/heads/master &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/master = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual" &&
+		git config branch.push-simple.merge refs/heads/push-simple &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual"
 	)
 '
 
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

