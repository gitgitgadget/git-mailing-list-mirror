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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1527C2D0E9
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92082073E
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcylhE0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgC2Odj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38648 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Odi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so7388757pgh.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x51WrHICfDqQzhHNE99mCvEADJtrNgUcOhOdC2kwG/E=;
        b=hcylhE0ePQZOL0qsGiWxSe/O1B7p0foL5IfUZNUXslhtaOJIaWKSrnF3aXLCP31R+/
         GAzD6ebYz3kYPGhG98wflKgVybrscZ7Hthk7U420Pm9u/QNRTeXJtOb+LaKqsFmdO9G1
         9RoJs443QEANUleJn/cDsrL9H5dZVERuMA67ujwVgH7Mq2Drpm7kNEYbMQPPD94XYr2R
         alm66wwyfEyODZfgzssrpifS3q6A63GFza6U5FzTlvNVqZBlWbheQhD/nKPeRKNuPSgY
         9Z90vHbAZeFMZcs/LS1TnRmc9Dje2E15i/bfnCmUycHSBQvq0s0XgwWtFOBZoDB5ctaJ
         6uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x51WrHICfDqQzhHNE99mCvEADJtrNgUcOhOdC2kwG/E=;
        b=j3bsHp2bCJnFJMDe0GcofJ6mCcpzhyRetX8Tk3dqRmORogYMheIEdGq4pjqrD1po9j
         ErfeEYKUx1pWeyAFymvbQMDD4OseoroE42p6GRl/iMe791HjtzSnPFgah0qj1rEDWDKJ
         4LspsOgR3oSskwvL8tr7045TI0T8NMy7DEYixQ0hfoZHOjhhshA7XzyjrKzS2Ga3kbGH
         pvKCOYp10+d2heFnANAW78OEUswfMYVTxjeUNnnJ2eLrTu0ZF6h+Nx8Nxw1akE20RL4U
         AcwL4rrmg5psnGJPJyLDN81raIAUuEiQxJV+L0dnueMOKhKIrLtlg/w/YJ21TcQEX1x6
         oJ3Q==
X-Gm-Message-State: AGi0PuYEX9xS+1pi7678Heb1I/dcg3GI8j5WtFcsMDtfQopX+aqk2u+8
        BhA4vrqUNsRaMOPiyLs+rfk=
X-Google-Smtp-Source: APiQypLyqNKQonNokZ8dV+wSCA09IUm8COssFuyUP+U3nHFrFnhMFNgGJy9uIt8cfLthYCA5Y6xs8w==
X-Received: by 2002:a63:31c4:: with SMTP id x187mr2134041pgx.205.1585492417460;
        Sun, 29 Mar 2020 07:33:37 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u13sm2947246pgp.49.2020.03.29.07.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:33:37 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/4] send-pack: mark failure of atomic push properly
Date:   Sun, 29 Mar 2020 10:33:27 -0400
Message-Id: <20200329143329.13846-3-worldhello.net@gmail.com>
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

When pushing with SSH or other smart protocol, references are validated
by function `check_to_send_update()` before they are sent in commands
to `send_pack()` of "receve-pack".  For atomic push, if a reference is
rejected after the validation, only references pushed by user should be
marked as failure, instead of report failure on all remote references.

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) wanted to fix report issue of HTTP
protocol, but marked all remote references failure for atomic push.

In order to fix the issue of status report for SSH or other built-in
smart protocol, revert part of that commit and add additional status
for function `atomic_push_failure()`.  The additional status for it
except the "REF_STATUS_EXPECTING_REPORT" status are:

- REF_STATUS_NONE : Not marked as "REF_STATUS_EXPECTING_REPORT" yet.
- REF_STATUS_OK   : Assume OK for dryrun or status_report is disabled.

This fix won't resolve the issue of status report in transport-helper
for HTTP or other protocols, and breaks test case in t5541.  Will fix
it in additional commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c                |  2 ++
 t/t5541-http-push-smart.sh |  2 +-
 t/t5543-atomic-push.sh     |  6 +++---
 transport.c                | 14 --------------
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..ff016c468c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -334,6 +334,8 @@ static int atomic_push_failure(struct send_pack_args *args,
 			continue;
 
 		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_OK:
 		case REF_STATUS_EXPECTING_REPORT:
 			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
 			continue;
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 23be8ce92d..2c2c3fb0f5 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,7 +177,7 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
+test_expect_failure 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
 	git init --bare "$d" &&
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 001240eec7..620c30d58f 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -200,7 +200,7 @@ test_expect_success 'atomic push is not advertised if configured' '
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
 # Atomic push            : master(2)               two(2) bar(2)
-test_expect_failure 'atomic push reports (reject by update hook)' '
+test_expect_success 'atomic push reports (reject by update hook)' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
@@ -241,7 +241,7 @@ test_expect_failure 'atomic push reports (reject by update hook)' '
 
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
-test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
+test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	(
 		cd workbench &&
 		git remote remove up &&
@@ -262,7 +262,7 @@ test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
 
 # References in upstream : master(2) one(1) foo(1)
 # References in workbench: master(1)        foo(1) two(2) bar(2)
-test_expect_failure 'atomic push reports (reject by non-ff)' '
+test_expect_success 'atomic push reports (reject by non-ff)' '
 	rm upstream/.git/hooks/update &&
 	(
 		cd workbench &&
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..75c5c9fe98 100644
--- a/transport.c
+++ b/transport.c
@@ -1240,20 +1240,6 @@ int transport_push(struct repository *r,
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
-		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
-			struct ref *it;
-			for (it = remote_refs; it; it = it->next)
-				switch (it->status) {
-				case REF_STATUS_NONE:
-				case REF_STATUS_UPTODATE:
-				case REF_STATUS_OK:
-					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
-					break;
-				default:
-					break;
-				}
-		}
-
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-- 
2.26.0.4.g39bcdcb101.dirty

