Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712CF1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeGLMbr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:31:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37930 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeGLMbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:31:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so7135252edr.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L75y1hzB0ZGnWxKE217RvoeOI4ahYOL+o4bp9aykSns=;
        b=GcgNMBYhKTvtIxV0G8EZPHTjC6W0HAT0CD45hMAk4mpnb7JJKWnmTYezLvHIk3442S
         ae9XrRicSu0XikOc2z/pGNSD7LjpHJHys/tFgbjRthSZ1FTW7tQv5heqoJIRI23f2pez
         Sy2dKMIE/AwUMGP/RvSAXzdpszBtGDkEGA8Ko3BDxfswqjDZAERUvtm8iilbFIy5lN+U
         GIYjkbKrRwxSMw9JK6Y+PrfJQNZ54v/fjTr5gTvAbD9CDb7H1f9UUSp2E5P/H9rTcyrz
         ijTGbjktL/7LaWe5VoLtT3Jku2RO1xlgYbbhwt/CTg6EYDnlYgrKS+IOTkVigHy4jjsA
         PEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L75y1hzB0ZGnWxKE217RvoeOI4ahYOL+o4bp9aykSns=;
        b=k1/TQcor1Ac40f2Ws3xo9Wlj99dzRDMIWIoti2DzizN2WUdCXDOTtHD6KElxPTrg+p
         Tix3LS+0tySA62xfIqkzILhhqrvxkFNPXOCvmDuqW725OtwA5T8fT8KsWWTCsdqL/Sf3
         O7QmYJZjIvXVrIbFyt/lc4/MRROxPRwM96X3KanABdFlxVhBnD/CHpCf3swcr2DmEIlN
         BqKzTDxdOko8nE5Rp1vEgAV+pwC+oTLkCnzPFoqIItvkNkc6YIl9sCn3fMdVL2m8+ulc
         q7HGHJ/YBjGmbcPd3OttmQkHLVG3cAlEafKirzXo0yBuKy4rEy+NNtrfk9fsTB/D/UVJ
         JnGw==
X-Gm-Message-State: AOUpUlFcPkLfU7m1AaEhFd/liLE082GPJ/XhxduCFftTYIqEQX8hnlW2
        IkFGHjRHh2Aa242fV6yvjKnMtz4T
X-Google-Smtp-Source: AAOMgpeNOEL+RpGVHXihjS5dKSozknzxNFQvMAwctng18XdKtTl1wxPjoer8iix1IHWjqsl2IZ6K0A==
X-Received: by 2002:aa7:d60d:: with SMTP id c13-v6mr2352327edr.301.1531398146204;
        Thu, 12 Jul 2018 05:22:26 -0700 (PDT)
Received: from localhost.localdomain (x590d07e3.dyn.telefonica.de. [89.13.7.227])
        by smtp.gmail.com with ESMTPSA id a2-v6sm165618ede.21.2018.07.12.05.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 05:22:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/3] t/lib-httpd: add the strip_access_log() helper function
Date:   Thu, 12 Jul 2018 14:22:15 +0200
Message-Id: <20180712122216.12691-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.305.g66e9e0a543
In-Reply-To: <20180712122216.12691-1-szeder.dev@gmail.com>
References: <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180712122216.12691-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Four tests in three httpd-related test scripts check the contents of
Apache's 'access.log', and they all do so by running 'sed' with the
exact same script consisting of four s/// commands to strip
uninteresting log fields and to vertically align the requested URLs.

Extract this into a common helper function 'strip_access_log' in
'lib-httpd.sh', and use it in all of those tests.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-httpd.sh              |  9 +++++++++
 t/t5541-http-push-smart.sh  | 14 ++------------
 t/t5551-http-fetch-smart.sh |  7 +------
 t/t5561-http-backend.sh     |  7 +------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465a..b6788fea57 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -287,3 +287,12 @@ expect_askpass() {
 	test_cmp "$TRASH_DIRECTORY/askpass-expect" \
 		 "$TRASH_DIRECTORY/askpass-query"
 }
+
+strip_access_log() {
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" "$HTTPD_ROOT_PATH"/access.log
+}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 5c9ca19401..83390f80cc 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -47,12 +47,7 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
@@ -134,12 +129,7 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 913089b144..c8b6ec493b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -103,12 +103,7 @@ GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 84a955770a..4248b5a06d 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -129,12 +129,7 @@ GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 EOF
 test_expect_success 'server request log matches test results' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
-- 
2.18.0.305.g66e9e0a543

