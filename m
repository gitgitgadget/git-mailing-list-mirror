Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD8C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E62D2073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVeMWGuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgC2Odi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:38 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52566 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgC2Odi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:38 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so6375312pjb.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kjk2rCXE9A6IgxrhpAPKePv1bZU4BGhxcxuuvRE1m0=;
        b=gVeMWGuke6qocE98AXvsxB69Ont4OEuMhjEeZmGyyls54uzUusp2L485DnY+v7sTSa
         LXDRtQ51Hb4JjjJxFqi3D6wxWcWCaYnBlRv/kYTrFg3OskAZUZLn0oUbuSXjoSdSP2kZ
         37Z6gebZ1h8SeXBuVS+fqnNwmSegc485e9v3OyHMzAmUECNjGWutcjQTde+VmzzLwTnw
         HNyRtKduQgAyNIPgLydGcJaDSRTugRYi80iKAxQPHzW/u0/G02p0lUW25kYkiT0Uv6b/
         am+f+8tgfqXzYr5XPKmS0qFOX81OPbH2BzkfvjTu9AwcCTsVVNdC7iBUuNsbuK54T48E
         SEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kjk2rCXE9A6IgxrhpAPKePv1bZU4BGhxcxuuvRE1m0=;
        b=sYdPX8r4vP2tcjb2/M/5M18C4fDKKTrttuUeNcQ7xO701Q7FWs+8rVdq/Sw/6EaF3f
         sN7G7KW6IVt/w15NNu4AO0O6FH4i8k/sMA9S4LOAA9HJ40dfQ6MT5tnQ5TWKXU58jlSR
         tpeuXNhiEM3gkhS4K6FVJmp+Mg69VwDTofhKCuB7ITROeA5m7MVPcpZnNt3nRJab9Wgd
         CN6pHjBm04Qy6I3nGEf8JIFAj77BkmUnzwiGvNWeGY0V+9rlRjsS06OfZoyO0k6aS/e3
         F06sdO0MMJ/BtjrIpkPpO3fHHA1H6J08AfkeQrr6wTYPkzU23wcwFKQmyeKvoRWj+4An
         y8tg==
X-Gm-Message-State: ANhLgQ1N8zge5/yR5TagtKIwbcYd10T7qM7fDb19MSdDI9zRWJn2sCve
        o/ceVx4T/tdgriSbEe44JQ8=
X-Google-Smtp-Source: ADFU+vvEHZo3pZBaQ2fU+D8mXLX90KRTYdDdWBfiTTflz9eEL8vxCbkccYO2fUceBjf5gD07hBzdNA==
X-Received: by 2002:a17:902:d3cb:: with SMTP id w11mr8424672plb.257.1585492416669;
        Sun, 29 Mar 2020 07:33:36 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u13sm2947246pgp.49.2020.03.29.07.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:33:35 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/4] t5543: never report what we do not push
Date:   Sun, 29 Mar 2020 10:33:26 -0400
Message-Id: <20200329143329.13846-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
References: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
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
2.26.0.4.g39bcdcb101.dirty

