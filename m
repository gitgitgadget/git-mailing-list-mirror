Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B2C38A2C
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEDB21D94
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWOycDIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgDQJpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgDQJpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:45:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4BC061A0F
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so778345plp.9
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgjq3ZrAdr8/gFf+YwgeXqiwATBnJ5AhvuT9Wa6tQKg=;
        b=kWOycDIhaGvlMBYM7pMEa+tEoU4MF1prSdhpi6fxZo7mzMWZkJckSUebrHE+m/jBRd
         nvl/NqNDs5EFQNP7LG8QbI4SjFjD6gr6nx88eBH4bpX0gDpEEFSD72Q7ZTgEUdo+m7ik
         R84fzBVj8UGWiNO+StDABp+lZXn8d1sPLW/Wei+HXG0XkfqAeoyMMEfr0Fpr4e+sCK7O
         BfOtv1RnBw3Wu/tenVbhEMbEJxV6kFlO5HJ1wDqT/+dofnklf99ijy5i3HjPS7CAGL2u
         0lAFXvvn8/Tcy8HVqBiVC6DSf6An6lqq9djMERLD/+H6g4aCAArRIYRyho9mhFkMN6O/
         y2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgjq3ZrAdr8/gFf+YwgeXqiwATBnJ5AhvuT9Wa6tQKg=;
        b=BHq1SGRS6P0oyqikcvsThfPYiUKeXMxXEqpdYZW7Ka3uYr8RD2SNTyXJvJSxG3WIZ7
         d0DjaNHJHcsfblsJ+EswpPv1jFXXps2F37toLolwyV/iVF2GYzpzeimuDybJJz/ok+9E
         wD9RGDtoIcEiJpl2jift11wxU8qQj3UcjwgsKdueur1ciWP1q3/62+NLe9tw7S4tXGBT
         uwgOlguMVBbH/G0AZzPMvNWIh9UU9JxykcZ6sXzaQO7dJUVd08H89Ry/FHHJCSGKweV5
         x5nrBuiG6TF9/+WXKFpQrdJ5k9w+c/8iECPXgXLzOlIpdKIPBLxRp6zbrqP+Vrq5YFjS
         zy8g==
X-Gm-Message-State: AGi0PuaXb6WpUlI8PWytSHo+ERcfDPEijyXvm68gt75jJKb1uuLTs52V
        2LBnTWNX1YLNuxkWWSB1wR8PN7yeX4w=
X-Google-Smtp-Source: APiQypLPzs03Wep0KUfVTDRU3HE2xPiKCYPuksIV1cBciTWqzllfmhqorL559DJFca6Y/YKAxeNJBA==
X-Received: by 2002:a17:90a:ce08:: with SMTP id f8mr3427277pju.76.1587116744029;
        Fri, 17 Apr 2020 02:45:44 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q145sm4790979pfq.105.2020.04.17.02.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:45:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/5] send-pack: mark failure of atomic push properly
Date:   Fri, 17 Apr 2020 05:45:34 -0400
Message-Id: <20200417094536.9463-4-worldhello.net@gmail.com>
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
 t/t5548-push-porcelain.sh  |  2 +-
 transport.c                | 14 --------------
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 1835cd5582..efefb687b2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -332,6 +332,8 @@ static int atomic_push_failure(struct send_pack_args *args,
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
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 96ba449a38..9f4b7de74b 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -136,7 +136,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
 	# git-push         : master(B)  bar(A)  NULL    next(A)
-	test_expect_success "atomic push failed ($PROTOCOL)" '
+	test_expect_failure "atomic push failed ($PROTOCOL)" '
 		(
 			cd workbench &&
 			git update-ref refs/heads/master $B &&
diff --git a/transport.c b/transport.c
index 13d638d5fe..a07e39564c 100644
--- a/transport.c
+++ b/transport.c
@@ -1248,20 +1248,6 @@ int transport_push(struct repository *r,
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
2.24.1.15.g448c31058d.agit.4.5

