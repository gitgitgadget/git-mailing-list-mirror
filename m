Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E99C38A29
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78995207FC
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D98X4oA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgDQJpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgDQJpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:45:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7EC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ng8so877407pjb.2
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyxuMOk9EO/0k84GD8wXJZYoGb6KHR263TB1IprII/0=;
        b=D98X4oA3var853bKH6+AT5xN3E6Fjf3QSNKgcYw30tYUDXnZb1T3BXb8D//fBy4lWn
         VBNBU32VBxDjuv0NWMQ3k+/eu75j9wF/EgvUhkt6nSdYvqR/ac/uyODINx9Cu2+47RfM
         uTLA1q0SgCHFmiuEgxMFy2qNNIp6f0O9jaqTywtfcujsMI9qzH0bECj6G/i0huqrkQSS
         XcMwzVZv0oLbJHesnewNg53nJi16s5gym1xPP5A7QCOhZWxnoZN+214bZkXx1pQOQ41w
         djpwp2ots/IIohnR7RUh5oQP0vUmEglFz7bJMTkDJEe8pfDv4KlppuMFTmadUp/cqdj5
         W7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyxuMOk9EO/0k84GD8wXJZYoGb6KHR263TB1IprII/0=;
        b=mJgpjM0FQx80Q6OHZ6ZJ04Um7gh3x9sHo7GLxmMe4rAtRMCuDwUX9Txq2a1ocDj/xR
         m+WKqid4mVEBJGnOoamJ6Dg+UMNeUfGzIt1hkR7EilCUTJZ5q3cHJfj7RjtT/F7OH13Z
         BhnceYSegqHAEWgPXo4bejvCW9TGowEdfQml9ezYJSbtr6HLHLkAJwzOSEJNiHDY5j8v
         mGphS64WyArd4wjFZLKf78TTMQkLxSeuFwHhePFTDgIPnbZXLKIjbejYS/kO/hs5QUpf
         L6JXN0/rN6uSNHgS2wJzogUeAPwD3G6Dii9sqh9FPWgcVukdC5Zk/CSQMhoQVhjCG5NT
         OguA==
X-Gm-Message-State: AGi0PuaKxuwZOhVqTwZV67IXLf29nCvOyWE/vhZX/QorjaSCrHWsvw/9
        KHC1xpKcUcGLWpiJHs6RU74B1rOzatU=
X-Google-Smtp-Source: APiQypL+PHoPSdP+/ghbKCYnHS/ZrBMcGB2lVZq1UZEozC5AUSSrRxDR0lTE5F2330jbwnKCQJbwog==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr3401840pjb.94.1587116743055;
        Fri, 17 Apr 2020 02:45:43 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q145sm4790979pfq.105.2020.04.17.02.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:45:42 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 2/5] t5543: never report what we do not push
Date:   Fri, 17 Apr 2020 05:45:33 -0400
Message-Id: <20200417094536.9463-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200416162415.5751-1-worldhello.net@gmail.com>
References: <20200416162415.5751-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When we push some references to the git server, we expect git to report
the status of the references we are pushing; no more, no less.  But when
pusing with atomic mode, if some references cannot be pushed, Git reports
the reject message on all references in the remote repository.

Add new test cases in t5543, and fix them in latter commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5543-atomic-push.sh | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 7079bcf9a0..001240eec7 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -27,6 +27,12 @@ test_refs () {
 	test_cmp expect actual
 }
 
+fmt_status_report () {
+	sed -n \
+		-e "/^To / { s/   */ /g; p; }" \
+		-e "/^ ! / { s/   */ /g; p; }"
+}
+
 test_expect_success 'atomic push works for a single branch' '
 	mk_repo_pair &&
 	(
@@ -191,4 +197,87 @@ test_expect_success 'atomic push is not advertised if configured' '
 	test_refs master HEAD@{1}
 '
 
+# References in upstream : master(1) one(1) foo(1)
+# References in workbench: master(2)        foo(1) two(2) bar(2)
+# Atomic push            : master(2)               two(2) bar(2)
+test_expect_failure 'atomic push reports (reject by update hook)' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git branch foo &&
+		git push up master one foo &&
+		git tag -d one
+	) &&
+	(
+		mkdir -p upstream/.git/hooks &&
+		cat >upstream/.git/hooks/update <<-EOF &&
+		#!/bin/sh
+
+		if test "\$1" = "refs/heads/bar"
+		then
+			echo >&2 "Pusing to branch bar is prohibited"
+			exit 1
+		fi
+		EOF
+		chmod a+x upstream/.git/hooks/update
+	) &&
+	(
+		cd workbench &&
+		test_commit two &&
+		git branch bar
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic up master two bar >out 2>&1 &&
+	fmt_status_report <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] two -> two (atomic push failure)
+	 ! [remote rejected] bar -> bar (hook declined)
+	EOF
+	test_cmp expect actual
+'
+
+# References in upstream : master(1) one(1) foo(1)
+# References in workbench: master(2)        foo(1) two(2) bar(2)
+test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
+	(
+		cd workbench &&
+		git remote remove up &&
+		git remote add up ../upstream
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic --mirror up >out 2>&1 &&
+	fmt_status_report <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] one (atomic push failure)
+	 ! [remote rejected] bar -> bar (hook declined)
+	 ! [remote rejected] two -> two (atomic push failure)
+	EOF
+	test_cmp expect actual
+'
+
+# References in upstream : master(2) one(1) foo(1)
+# References in workbench: master(1)        foo(1) two(2) bar(2)
+test_expect_failure 'atomic push reports (reject by non-ff)' '
+	rm upstream/.git/hooks/update &&
+	(
+		cd workbench &&
+		git push up master &&
+		git reset --hard HEAD^
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic up master foo bar >out 2>&1 &&
+	fmt_status_report <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [rejected] master -> master (non-fast-forward)
+	 ! [rejected] bar -> bar (atomic push failed)
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.1.15.g448c31058d.agit.4.5

