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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4886C352BE
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4CE207FC
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="culB7OGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgDQJpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgDQJpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:45:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E3C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z6so776053plk.10
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEl9XdfiAgzLgL0z+IoR/phX8zO1Qe5zurFTiYwMMIc=;
        b=culB7OGejxpQl6kLAL3nfRdjg5sWClG9bMWnJLw8v+/xZ5B55xBh7yuUsIaTQVvuLn
         uzUupHKiyCS4tZVByPaCQPNxO4EKDr0AQtErHinh58183lMI5NwtD7Hqb+dSOvyo2PXR
         zuYTfPaB/xTiJxw7u7Lfam9C1+VieeNI2r0Mnv8ivKxQv+dpKGcc3s6AYRHp/ueuE9q+
         wUdHDjrWHpoHncI+eZZSq82pt2/BEYpNXzKvRSbMie2lhvIgye4ZgM/YE7ns9StibK02
         iJ+8EAnJnoMt5d1vZsTHkwFS1pG8x6rnSwLGp4D2sgYQJPIiVDAGAwo1NMTkmELH8Cl1
         IyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEl9XdfiAgzLgL0z+IoR/phX8zO1Qe5zurFTiYwMMIc=;
        b=QQUur2+EjC5JAAdt68qKg7Fc4YzD2AkQWal+F5g+YYAY8sXkk6w2O8e5vVhowSDqTG
         Mw4PcCkPs1LUVgMr9uMEOIPtoWC5MV+nqH4kFJiliz7cyMRd/k+H5Y6sp5x3SMwcX/uo
         p2ALojj31lCIr4QUZ/u2DzUzZmaafa2pVYfUZ9rOLVJUzA0Y/cdWnBleRCiDdX7wu44K
         f6h9s3ANq5MgitfKL3h3bj/ClGoQJEQNzmg5EPI9jZ9hR+3s1aVW/bNI6vk87BkOPfYV
         oOgiEE9JSPPnqyftQr9BKMAskUu3xXhErjmKfTyN3UOGVQcQPhxG/MzWWCu5beDMTlvc
         5IsA==
X-Gm-Message-State: AGi0PuZw0ewI+dBVneYWn+MIAvpgE7fNIvf4tM94NV3rhqPmhPBP/GqF
        axPxAW476IoyeYkAHRx4i6w=
X-Google-Smtp-Source: APiQypJ5fJsFP/6cpSZ9fngcdrs8IoCe/Zr0SmI1kBQHv7LI9KcsHfxkTWjeHntwU5hqituaXSm2fQ==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr3309114pjb.7.1587116744867;
        Fri, 17 Apr 2020 02:45:44 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q145sm4790979pfq.105.2020.04.17.02.45.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:45:44 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 4/5] transport-helper: mark failure for atomic push
Date:   Fri, 17 Apr 2020 05:45:35 -0400
Message-Id: <20200417094536.9463-5-worldhello.net@gmail.com>
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

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) noticed the incomplete report of
failure of an atomic push for HTTP protocol.  But the implementation
has a flaw that mark all remote references as failure.

Only mark necessary references as failure in `push_refs_with_push()` of
transport-helper.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5541-http-push-smart.sh | 14 +++++++++++---
 t/t5548-push-porcelain.sh  |  5 ++---
 transport-helper.c         | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 2c2c3fb0f5..afc680d5e3 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,7 +177,10 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'push --atomic also prevents branch creation, reports collateral' '
+## References of remote: atomic1(1)            master(2) collateral(2) other(2)
+## References of local :            atomic2(2) master(1) collateral(3) other(2) collateral1(3) atomic(1)
+## Atomic push         :                       master(1) collateral(3)                         atomic(1)
+test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
 	git init --bare "$d" &&
@@ -189,7 +192,8 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 	test_commit atomic2 &&
 	git branch collateral &&
 	git branch other &&
-	git push "$up" master collateral other &&
+	git push "$up" atomic1 master collateral other &&
+	git tag -d atomic1 &&
 
 	# collateral is a valid push, but should be failed by atomic push
 	git checkout collateral &&
@@ -224,7 +228,11 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 
 	# the collateral failure refs should be indicated to the user
 	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
-	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output
+	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output &&
+
+	# never report what we do not push
+	! grep "^ ! .*rejected.* atomic1 " output &&
+	! grep "^ ! .*rejected.* other " output
 '
 
 test_expect_success 'push --atomic fails on server-side errors' '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 9f4b7de74b..1b19b3ef55 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -136,7 +136,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
 	# git-push         : master(B)  bar(A)  NULL    next(A)
-	test_expect_failure "atomic push failed ($PROTOCOL)" '
+	test_expect_success "atomic push failed ($PROTOCOL)" '
 		(
 			cd workbench &&
 			git update-ref refs/heads/master $B &&
@@ -150,10 +150,10 @@ run_git_push_porcelain_output_test() {
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
 		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
 		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
 		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
-		!    refs/heads/next:refs/heads/next    [rejected] (atomic push failed)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -168,7 +168,6 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual
 	'
-
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
 		write_script "$upstream/hooks/pre-receive" <<-EOF
 		exit 1
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..ab3b52eb14 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -894,6 +894,21 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			if (atomic) {
+				/* Mark other refs as failed */
+				for (ref = remote_refs; ref; ref = ref->next) {
+					if (!ref->peer_ref && !mirror)
+						continue;
+
+					switch (ref->status) {
+					case REF_STATUS_NONE:
+					case REF_STATUS_OK:
+					case REF_STATUS_EXPECTING_REPORT:
+						ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+						continue;
+					default:
+						break; /* do nothing */
+					}
+				}
 				string_list_clear(&cas_options, 0);
 				return 0;
 			} else
-- 
2.24.1.15.g448c31058d.agit.4.5

