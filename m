Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03ED20966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbdDGTYH (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:24:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33250 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbdDGTYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:24:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so17426193pgf.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o413KT6xL/e0kw3jAf9/BA8YlDzMMeCeHKHbAW2KmUE=;
        b=O+OknTdJxs50RIz7mTsW59wCZoATP5ls9b8L4VwKkjDyE1jnpxn5dnm1GptEl357IV
         mD6qb9BvfHOWBDozlvJFkUqGd+qNRLK4EuYUi15bU1gs6FmDsWF7KV8KKnkTNkjwFoDv
         S4im4oLcxFXIV7TacKjvBUOyzPQaNBphX8LbACJl7XOhk3s2Kw/FhYfCSSHcrajOaur7
         CDKC1r/R7SAUlRywqeHb6EAaMxVkT3VHZPx8pVOUtynWBfUPFWFPnvvMksLCmcrvkxBG
         +wGyIGiA7sAxJ1bUnNV9GLlbEURQFecJOOm8TC6rJjsAlj2hK909mvcIq04DY9BR4rMj
         EG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o413KT6xL/e0kw3jAf9/BA8YlDzMMeCeHKHbAW2KmUE=;
        b=OU6f/kk4Vb5ZucxduBKJLpdp7QBJQWloq6vMHCVRXNmAx+SAMJycOa/iG0MvFlwySQ
         dH7RrLngJV5HIp7J5m+AsN1+sYKqBkTrG4T0TLN2/90qAVzwkO5ydaC65/SJrc5srt5d
         vSIjbOQSEagJrWr+fDSuNXRxN2o+CSuOQDL35kt3etdlwxpkQTNgJWcBK5xXun30mQAl
         b+54vtlgCrFS2SH3324FXF8Q1wl+nASFSAZdn5z2Gofefh4PS54whvgEOmeodRtCb711
         7FkikuQ4Aie2Bi+b4wK0wF4Ka0dF2xs/u8dM3I+jYrUKuC7LqcoGi1IQLiRgDs745AGd
         /+UA==
X-Gm-Message-State: AFeK/H24xlnaDZ2ophN5HP9z9tttNniAL1S8/nkYfVxG0SORcXqODxdV9A1tQDnDtktLCQ==
X-Received: by 10.99.55.78 with SMTP id g14mr43075374pgn.191.1491593043382;
        Fri, 07 Apr 2017 12:24:03 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:9::3b6])
        by smtp.gmail.com with ESMTPSA id u29sm11018797pfa.123.2017.04.07.12.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 12:24:03 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/3] merge-recursive.c: conflict using sparse should update file
Date:   Fri,  7 Apr 2017 12:23:55 -0700
Message-Id: <20170407192357.948-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.12.2.windows.2
In-Reply-To: <20170407192357.948-1-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the file when there is a conflict with a modify/delete scenario
when using the sparse-checkout feature since the file might not be on disk
because the skip-worktree bit is on and the user will need the file and
content to determine how to resolve the conflict.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c                |  8 ++++++++
 t/t7614-merge-sparse-checkout.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100755 t/t7614-merge-sparse-checkout.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index b7ff1ada3c..54fce93dae 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1103,6 +1103,14 @@ static int handle_change_delete(struct merge_options *o,
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch2, change_past,
 			       o->branch1, o->branch1, path);
+			/*
+			 * In a sparse checkout the file may not exist. Sadly,
+			 * the CE_SKIP_WORKTREE flag is not preserved in the
+			 * case of conflicts, therefore we do the next best
+			 * thing: verify that the file exists.
+			 */
+			if (!file_exists(path))
+				ret = update_file(o, 0, a_oid, a_mode, path);
 		} else {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree at %s."),
diff --git a/t/t7614-merge-sparse-checkout.sh b/t/t7614-merge-sparse-checkout.sh
new file mode 100755
index 0000000000..6922f0244f
--- /dev/null
+++ b/t/t7614-merge-sparse-checkout.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='merge can handle sparse-checkout'
+
+. ./test-lib.sh
+
+# merges with conflicts
+
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit file &&
+	git checkout -b delete-file &&
+	git rm file.t &&
+	test_tick &&
+	git commit -m "remove file" &&
+	git checkout master &&
+	test_commit modify file.t changed
+'
+
+test_expect_success 'merge conflict deleted file and modified' '
+	echo "/a" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	test_must_fail git merge delete-file &&
+	test_path_is_file file.t
+'
+
+test_done
-- 
2.12.2.windows.2.1.g7df5db8d31

