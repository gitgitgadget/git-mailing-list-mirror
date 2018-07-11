Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AA81F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbeGKNBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:01:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39957 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKNBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:01:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so19131087edq.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfiqshFxC6fKed72IliIBpws8Kt5U2zvkbjTGfxHFhg=;
        b=sVwY1ucU9ldpERpkHv5DkFxsNopyX3CJvVH+f/rFTi2aDRQHOB+3NHI0MVKlKkeLF+
         32stTiEc0v/lFlLg+fD2jVimSgNfgme2b82KfDTocadP/UYEnlA/dP5vRRnhj3VXpb9W
         NiTHrhTVchZ5OgEbgu67P2YudG7Oyez5lRbCpbTvXGp6GYwihmnlcy5/BQt8iLpBZyGo
         8hwK4hF2ytPhMswoEa2lzzwBK3qfVT1ds744Hs/QOCTWN3f6XpCQvBpeDX22acCgpjkH
         790RyPq5NApVzJxjS8sUci4jvhPgA/aHFxHf7X6mQtAECPrdGbz4pefiiKGH7YPUgvXz
         QWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfiqshFxC6fKed72IliIBpws8Kt5U2zvkbjTGfxHFhg=;
        b=ELBdQ3PUXpfP2LiEzYWoWbT9lYVzhCyi0uxvS3cU4qeflaUypC9qr7icEGE5hNoyt0
         qiQI7J8SvO4aVzMdHYRMjsI6e7j+VR6udkIBEY+sh95/rnjN8t0tKLRbK3zw/bP/3M8d
         iu5zUxPYsnWlrlLzogxiRrCL7Jp0M18ZdHbThkss47+hkcDSnooBfv+Xz0dcqXVLyk5+
         UUnT1oreAaKz3h4gbV5p8Uby8U9kplz9oNk5YfpEe/enoY6k1fIFXhMkM32DflDV8oy8
         bzjdsSXn42ASnam22gre52cjAFSLo1PzkpJVmBwEsiAaTrlQ5SUSiLJjCJzotyd18yg/
         9pcQ==
X-Gm-Message-State: APt69E05DbVwwLWMTyySSorh0ZRm6Rv6/niNg4KFfmAqyZuMKAwdMLif
        JD9oIc+1M3SzSD8Sc8BE0nc=
X-Google-Smtp-Source: AAOMgpflydu+ihID/FjVBwHf58dJ3W390hqe8j0l4ZAFq9FIPuMQqGKAM0kjAUsQK9XcCbMcFhGkcg==
X-Received: by 2002:aa7:c542:: with SMTP id s2-v6mr30165496edr.224.1531313828901;
        Wed, 11 Jul 2018 05:57:08 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id h1-v6sm768050edr.86.2018.07.11.05.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 05:57:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/3] t/lib-httpd: avoid occasional failures when checking access.log
Date:   Wed, 11 Jul 2018 14:56:47 +0200
Message-Id: <20180711125647.16512-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180711125647.16512-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test of 't5561-http-backend.sh', 'server request log matches
test results' may fail occasionally, because the order of entries in
Apache's access log doesn't match the order of requests sent in the
previous tests, although all the right requests are there.  I saw it
fail on Travis CI five times in the span of about half a year, when
the order of two subsequent requests was flipped, and could trigger
the failure with a modified Git.  However, I was unable to trigger it
with stock Git on my machine.  Three tests in
't5541-http-push-smart.sh' and 't5551-http-fetch-smart.sh' check
requests in the log the same way, so they might be prone to a similar
occasional failure as well.

When a test sends a HTTP request, it can continue execution after
'git-http-backend' fulfilled that request, but Apache writes the
corresponding access log entry only after 'git-http-backend' exited.
Some time inevitably passes between fulfilling the request and writing
the log entry, and, under unfavourable circumstances, enough time
might pass for the subsequent request to be sent and fulfilled by a
different Apache thread or process, and then Apache writes access log
entries racily.

This effect can be exacerbated by adding a bit of variable delay after
the request is fulfilled but before 'git-http-backend' exits, e.g.
like this:

  diff --git a/http-backend.c b/http-backend.c
  index f3dc218b2..bbf4c125b 100644
  --- a/http-backend.c
  +++ b/http-backend.c
  @@ -709,5 +709,7 @@ int cmd_main(int argc, const char **argv)
   					   max_request_buffer);

   	cmd->imp(&hdr, cmd_arg);
  +	if (getpid() % 2)
  +		sleep(1);
   	return 0;
   }

This delay considerably increases the chances of log entries being
written out of order, and in turn makes t5561's last test fail almost
every time.  Alas, it doesn't seem to be enough to trigger a similar
failure in t5541 and t5551.

So, since we can't just rely on the order of access log entries always
corresponding the order of requests, make checking the access log more
deterministic by sorting (simply lexicographically) both the stripped
access log entries and the expected entries before the comparison with
'test_cmp'.  This way the order of log entries won't matter and
occasional out-of-order entries won't trigger a test failure, but the
comparison will still notice any unexpected or missing log entries.

OTOH, this sorting will make it harder to identify from which test an
unexpected log entry came from or which test's request went missing.
Therefore, in case of an error include the comparison of the unsorted
log enries in the test output as well.

And since all this should be performed in four tests in three test
scripts, put this into a new helper function 'check_access_log' in
't/lib-httpd.sh'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-httpd.sh              | 12 ++++++++++++
 t/t5541-http-push-smart.sh  | 13 +++++--------
 t/t5551-http-fetch-smart.sh |  3 +--
 t/t5561-http-backend.sh     |  3 +--
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b6788fea57..7f060aebd0 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -296,3 +296,15 @@ strip_access_log() {
 		s/^GET /GET  /
 	" "$HTTPD_ROOT_PATH"/access.log
 }
+
+# Requires one argument: the name of a file containing the expected stripped
+# access log entries.
+check_access_log() {
+	sort "$1" >"$1".sorted &&
+	strip_access_log >access.log.stripped &&
+	sort access.log.stripped >access.log.sorted &&
+	if ! test_cmp "$1".sorted access.log.sorted
+	then
+		test_cmp "$1" access.log.stripped
+	fi
+}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 6cd986797d..a481e3989a 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -43,15 +43,13 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	strip_access_log >act &&
+	check_access_log exp
+'
 
+test_expect_success 'clear access log' '
 	# Clear the log, so that it does not affect the "used receive-pack
 	# service" test which reads the log too.
-	#
-	# We do this before the actual comparison to ensure the log is cleared.
-	>"$HTTPD_ROOT_PATH"/access.log &&
-
-	test_cmp exp act
+	>"$HTTPD_ROOT_PATH"/access.log
 '
 
 test_expect_success 'clone remote repository' '
@@ -132,8 +130,7 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
-	strip_access_log >act &&
-	test_cmp exp act
+	check_access_log exp
 '
 
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index c8b6ec493b..3aab44bdcb 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -103,8 +103,7 @@ GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
-	strip_access_log >act &&
-	test_cmp exp act
+	check_access_log exp
 '
 
 test_expect_success 'follow redirects (301)' '
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 4248b5a06d..1c49054595 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -129,8 +129,7 @@ GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 EOF
 test_expect_success 'server request log matches test results' '
-	strip_access_log >act &&
-	test_cmp exp act
+	check_access_log exp
 '
 
 stop_httpd
-- 
2.18.0.273.g57f1ecce9c

