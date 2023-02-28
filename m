Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9EC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjB1XjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1XjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:16 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0015562
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:15 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c4so3958366pfl.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AINjlT2zqt6oriW+wceOlh9rJPFO6vSmOq/RfBfwvNo=;
        b=kz08VHNdeGtdq6V36GR7FtEwJ03XduVLym1Gp6LZGu2ehxb3sG1RBPB9iLtmc3RHiy
         dM8rF0F7xO5PljNCz0lsL7Q4q2Gat3CHf0+wuyRy5oL8kAkMA28tT4iNZNgkmQxbyzl9
         Cg1IV+zgi8i0R6/0j81ER81oqd1VkCTq1ir3ep9SZzKKB0QUInqqqgm8toEvNe7OMGjO
         nRQ1d68ITP9aHO1sDetbCCNjvaXAd4OiSHhbz8mm5nZWCYf9qt//+aPwmDzJbGUpagxD
         jTskNxQfPkJH5HaiEQ8epD6f70I74aK3mAI715vr7rkrnrX/OvrIdFHZDNys9OV1d4gf
         +mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AINjlT2zqt6oriW+wceOlh9rJPFO6vSmOq/RfBfwvNo=;
        b=DdwSks3YL4Ihnu9vB/dVDUPJ8Fsb6R9dHsfM2CStCzB7BBwxh/BY8kD2CtyAMbxGVM
         V+pkIbuj18CDv71OokcuoFjQt4VWCJHzc75YglgIMvb/wx1DCGL12nVRcGI9OggdsEqM
         o21ARtJlhGowZTphhXejaReMEMIjih9+4vzr9lta1rpEIN6nfVjlt0H3UMKr81/mbb7+
         lNeKX4AMjGekmTLoTTt70anVsKDj6PH8R76swKZH90CT9Rm5ISTCbp/ZFPWqQqW69RV1
         xeLoB6peXwAJz11SW7/oIImLID0CInbxxUX8CEVubp6n1j2kbsJ/SCmdgTd5ANPiG1Bi
         aI7Q==
X-Gm-Message-State: AO0yUKUsOC7ZZ647lvIHPf2EBSXNaORXJ2kVE3bHcGl9OPI6E1Xs2mML
        fx8foMuw2ElLytsXKVlsld3XxDSEfiI=
X-Google-Smtp-Source: AK7set/jflA8KJQntB52p26G2jSX235/iK6FX5gMgmSAuNGL4KYRAi1jUATLnwORxM6VeKWouwca4Q==
X-Received: by 2002:aa7:9704:0:b0:592:de72:4750 with SMTP id a4-20020aa79704000000b00592de724750mr3899019pfg.23.1677627554253;
        Tue, 28 Feb 2023 15:39:14 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b005b6f63c6cf4sm6547110pfi.30.2023.02.28.15.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 01/20] t5541: run "used receive-pack service" test earlier
Date:   Tue, 28 Feb 2023 15:38:54 -0800
Message-Id: <20230228233913.684853-1-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

There's a test in t5541 that confirms that "git push" makes two requests
(a GET to /info/refs, and a POST to /git-receive-pack). However, it's a
noop unless GIT_TEST_PROTOCOL_VERSION is set to "0", due to 8a1b0978ab
(test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate,
2019-12-23).

This means that almost nobody runs it. And indeed, it has been broken
since b0c4adcdd7 (remote-curl: send Accept-Language header to server,
2022-07-11). But the fault is not in that commit, but in how brittle the
test is. It runs after several operations have been performed, which
means that it expects to see the complete set of requests made so far in
the script. Commit b0c4adcdd7 added a new test, which means that the
"used receive-pack service" test must be updated, too.

Let's fix this by making the test less brittle. We'll move it higher in
the script, right after the first push has completed. And we'll clear
the access log right before doing the push, so we'll see only the
requests from that command.

This is technically testing less, in that we won't check that all of
those other requests also correctly used smart http. But there's no
particular reason think that if the first one did, the others wouldn't.

After this patch, running:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5541-http-push-smart.sh

passes, whereas it did not before.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5541-http-push-smart.sh | 44 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index fbad2d5ff5..ef39d14ed2 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -41,10 +41,6 @@ GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'no empty path components' '
-	# Clear the log, so that it does not affect the "used receive-pack
-	# service" test which reads the log too.
-	test_when_finished ">\"\$HTTPD_ROOT_PATH\"/access.log" &&
-
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
@@ -67,6 +63,10 @@ test_expect_success 'clone remote repository' '
 '
 
 test_expect_success 'push to remote repository (standard)' '
+	# Clear the log, so that the "used receive-pack service" test below
+	# sees just what we did here.
+	>"$HTTPD_ROOT_PATH"/access.log &&
+
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -80,6 +80,20 @@ test_expect_success 'push to remote repository (standard)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'used receive-pack service' '
+	cat >exp <<-\EOF &&
+	GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+	POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+	EOF
+
+	# NEEDSWORK: If the overspecification of the expected result is reduced, we
+	# might be able to run this test in all protocol versions.
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
+	then
+		check_access_log exp
+	fi
+'
+
 test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
 	cat >exp <<-\EOF &&
 	=> Send header: Accept-Language: ko-KR, *;q=0.9
@@ -141,28 +155,6 @@ test_expect_success 'rejected update prints status' '
 '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
-cat >exp <<EOF
-GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-EOF
-test_expect_success 'used receive-pack service' '
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
-'
-
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone main 		success
 
-- 
2.40.0-rc0-32-ga0f05f6840

