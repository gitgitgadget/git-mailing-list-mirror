Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C9DC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5734208CA
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWm7+ti8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCYOgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:36:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39846 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgCYOgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:36:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id m1so866776pll.6
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHa6uqTK/ZIi/VV7jI6KqiVSLQ3QUAQUv38qUzYy6l0=;
        b=tWm7+ti8uyTkOZvJiAuwSx32lGEPCDWPLbdev3FOth9piWo52hJ5Ij9vl2N+ruWd0M
         g6sI/AKqr8mwVxlwB04ZgJ40wQLPxs/87/LiqtQaA+0iYKN1GaES7bVxd2PSs40Nze0C
         BbEjLgVVnggj9r2A8DCd+9bjvstfqBKxiqCCt+YwFj6mgEJnJ8tvf9oejEkGI8bMZFo0
         PGHU27snyUo9kkvVwqrMeGiIit0F0PJ5Bl0YLfuaEOorZrAd+nHqdM1Nxm+PzAeBCZuQ
         tZkzNN4N0XOcbOWD9tUBGxF3XASeMgziSqF+NhGAwtlxf0x4Y0bcB7FBpxExvuRdFfig
         6vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHa6uqTK/ZIi/VV7jI6KqiVSLQ3QUAQUv38qUzYy6l0=;
        b=Mdss4mmE9FHLKDTR3frhwkhqLLhHa1Nz1xkOeYx1A3fN80alrTJmkW60SHBqdGs+Kx
         8Y2BqbELvbhUfvCLNAZNU1src/DzdHhyyTtYXfGpDUAsY1iy7g4RBGJySZB7eRzVKW7G
         AgpfBcho9xpPDSS6BYpkOxkG3iwUZdzUtgsqg/rzV3UiIZzMq43YDC24NMOWmirMHLdz
         RNcI3OuNpfG3l7WDsreJcAN2Y+YsA4KK0fiPz8a71weGK1fovExPwQ6kGXBqF3HYLJsW
         7ezI6NMacVQZDMKN7nMH8mF8+buXWc7b9U1rUEARoN+9Y1cF6tmmnEF9WaKabX1vdVPb
         vcpg==
X-Gm-Message-State: ANhLgQ1Yep4sjjvV6e4SLHu62np/nD3HaYqLpJVJKgRcOD58Qb65ZgLl
        sg9auU9et4UXFydfYruqjuU=
X-Google-Smtp-Source: ADFU+vtaR0GQ48qkOnnb3efsdciWPprpoyy0pJLXr6q68qKRie9Boo6kUcdGpNoOUGy0D74y8Po/8g==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr4332799pja.132.1585146983187;
        Wed, 25 Mar 2020 07:36:23 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id f127sm18180423pfa.112.2020.03.25.07.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:36:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/3] send-pack: mark failure of atomic push properly
Date:   Wed, 25 Mar 2020 22:36:07 +0800
Message-Id: <20200325143608.45141-3-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.3.ga7a9d752d4
In-Reply-To: <20200322131815.11872-3-worldhello.net@gmail.com>
References: <20200322131815.11872-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pusing with SSH or other smart protocol, references are validated
by function `check_to_send_update()` beforce they are sent in commands
to `send_pack()` of "receve-pack".  For atomic push, if a reference is
rejected after the validation, only references pushed by user should be
marked as failure, instead of report failure on all remote references.

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) wanted to fix report issue of HTTP
protocol, but marked all remote references failure for atomic push.

Revert part of that commit and add additional status for function
`atomic_push_failure()`.  The additional status for it except the
"REF_STATUS_EXPECTING_REPORT" status are:

- REF_STATUS_NONE : Not marked as "REF_STATUS_EXPECTING_REPORT" yet.
- REF_STATUS_OK   : Assume OK for dryrun or status_report is disabled.

This commit break test case in t5541, and will fix in other commit.

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
index 4b4c0a262b..d7be1c098b 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -201,7 +201,7 @@ test_expect_success 'atomic push is not advertised if configured' '
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
 # Atomic push            : master(2)               two(2) bar(2)
-test_expect_failure 'atomic push reports (reject by update hook)' '
+test_expect_success 'atomic push reports (reject by update hook)' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
@@ -244,7 +244,7 @@ test_expect_failure 'atomic push reports (reject by update hook)' '
 
 # References in upstream : master(1) one(1) foo(1)
 # References in workbench: master(2)        foo(1) two(2) bar(2)
-test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
+test_expect_success 'atomic push reports (mirror, but reject by update hook)' '
 	(
 		cd workbench &&
 		git remote remove up &&
@@ -265,7 +265,7 @@ test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
 
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
2.26.0.3.ga7a9d752d4

