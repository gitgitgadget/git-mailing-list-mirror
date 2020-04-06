Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6519C2BA80
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7164A20719
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9XQz0Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDFR5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:57:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDFR5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:57:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id t203so322597wmt.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmNguelgSDcN2fjdcyw5LvBwVPWR7oGHDF+t6BJkfVU=;
        b=u9XQz0JcY8JrDzriD6oPCp2Qoq9FXIozCNflV05RnHei6nrMwhVyMbSgT64Ut4r4XG
         JzdjtpHp/QVOL9kyg9lml98TTZTKNFWTqy2K0AIa4TMTh3qwPeuRDdezuCriYUQjNSOp
         60d3aOUcnotdD2Xhbu6QeGwdrlRqpfwKHxlm9RVx5sQCPhPBkj687AHoNXi2q9Gphrc7
         Mh7A01fuaX+u3woYN87YwEq2ezC410zMEhov4v87d84Llg4dnvELLiWc1O9v7JDrWfDh
         RXHBBonwZExh7dAFigLemet0I9azN8RW0+nBuPgfCxpRB+2mNAO1aCMpjxEoa1TiRTmZ
         BrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmNguelgSDcN2fjdcyw5LvBwVPWR7oGHDF+t6BJkfVU=;
        b=K6vzoVB3wlE6eyQd2tAH+ureCESKgf/BNgcLfYrInR/6+Ydw7lYlQW0luavKsxCJJR
         LTe6wBpyAWvRZq8UkLb+Qd4b7RILUvTJ+W61dgGvpY8gb+l9JsU9tZEtwId5A1BlhMP3
         JmyrKm/Jjk917qls6UeKLdhlzXZch1OX2SKEjy16LLQ81b41f3oNcTFGkDN0mkxEjcwH
         P5mGkcSTlQnplhQl9mbw3ROBem5VZtu7M/9oN0mbfz827zyVnrfZQ3QQHWVEOgxNdKrJ
         XRffBQyFIPgNwJswMa2hpT+5ReztC4Eo7J1IRJPzKOzwfV77EXa1ogO0VFrHVWeUd+sg
         looA==
X-Gm-Message-State: AGi0PuabO4UeDaUn/q0UyzJWz9TQpBwln3AUQKlRPSpMsePnOPJOFTrO
        GPg/OBpXZkCU271qR8ztg6ayRSanuNs=
X-Google-Smtp-Source: APiQypILGKWRzkT0tP7MISRpf5kcNcMCpdsTB7whYIjAlMDHP2MRPUR2KZhwlNHcyztzfxZ+LcbLxA==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr188861wmm.137.1586195841202;
        Mon, 06 Apr 2020 10:57:21 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j10sm10465041wru.85.2020.04.06.10.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:57:20 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 2/2] remote.c: fix handling of %(push:remoteref)
Date:   Mon,  6 Apr 2020 19:56:48 +0200
Message-Id: <20200406175648.25737-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406175648.25737-1-damien.olivier.robert+git@gmail.com>
References: <20200406175648.25737-1-damien.olivier.robert+git@gmail.com>
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

Finally we also test for triangular workflows.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c                | 97 +++++++++++++++++++++++++++++++----------
 t/t6300-for-each-ref.sh | 81 +++++++++++++++++++++++++++++++---
 2 files changed, 149 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index 3750a2bcc1..2b7f8a3af5 100644
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
@@ -1663,6 +1641,67 @@ static int is_workflow_triangular(struct branch *branch)
 	return (fetch_remote && push_remote && fetch_remote != push_remote);
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
+		return apply_refspecs(&remote->push, branch->refname);
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
+		if (is_workflow_triangular(branch))
+		    return NULL;
+		else {
+			if (branch && branch->merge && branch->merge[0] &&
+		    	    branch->merge[0]->dst)
+				return branch->merge[0]->src;
+			else
+				return NULL;
+		}
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_SIMPLE:
+		{
+			const char *up, *cur;
+
+			if (is_workflow_triangular(branch))
+				return branch->refname;
+			else {
+				up = branch_get_upstream(branch, NULL);
+				cur = tracking_for_push_dest(remote, branch->refname, NULL);
+				if (up && cur && !strcmp(cur, up))
+					return branch->refname;
+				else
+					return NULL;
+			}
+
+		}
+	}
+	BUG("unhandled push situation");
+}
+
 /**
  * Return the tracking branch, as in %(push), that corresponds to the ref we
  * would push to given a bare `git push` while `branch` is checked out.
@@ -1755,6 +1794,20 @@ static int ignore_symref_update(const char *refname)
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
index b3c1092338..8e59ab2567 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -875,13 +875,80 @@ test_expect_success ':remotename and :remoteref' '
 			git for-each-ref --format="${pair%=*}" \
 				refs/heads/master >actual &&
 			test_cmp expect actual
-		done &&
-		git branch push-simple &&
-		git config branch.push-simple.pushRemote from &&
-		actual="$(git for-each-ref \
-			--format="%(push:remotename),%(push:remoteref)" \
-			refs/heads/push-simple)" &&
-		test from, = "$actual"
+		done
+	)
+'
+
+test_expect_success '%(push) and %(push:remoteref)' '
+	git init pushremote-tests &&
+	(
+		cd pushremote-tests &&
+		test_commit initial &&
+		git remote add from fifth.coffee:blub &&
+		git config branch.master.remote from &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,, = "$actual" &&
+		git config branch.master.merge refs/heads/master &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master,refs/remotes/from/master = "$actual" &&
+		git config branch.master.merge refs/heads/other &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,, = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,refs/heads/other,refs/remotes/from/other = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master,refs/remotes/from/master = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master,refs/remotes/from/master = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test from,, = "$actual" &&
+		git remote add to southridge.audio:repo &&
+		git config branch.master.pushRemote to &&
+		git config --unset branch.master.merge &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		git config branch.master.merge refs/heads/master &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		git config branch.master.merge refs/heads/other &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual"
 	)
 '
 
-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

