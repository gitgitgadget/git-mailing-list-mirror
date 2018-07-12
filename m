Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189061F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeGLMbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:31:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45970 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGLMbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:31:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so8718331eds.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4UuJkXUYVddcaNxp/nAyxXAOJsPnioC6Y8zpcKyrKs=;
        b=snxIQHt6QuaNr6US8cKEhw7SjDBGmnuy73aGxVVj4EWuR4tSgibzB4975Z/z83d6zb
         t9IjlSH7U6QnWV+HW5x6aDgrDoPf6dKd61oSKo5pF2sjHx0lK1flCh7kSf/x/DOa6mgG
         kGAhIyT4F/lFNUxzMZJCAetWRj64+4E7n5hBLD9E5YN17OR7E95v19UicDuDW4sWdoxe
         ybUbzyIhvoDv1wbctTcQ1Aac/7r5ExIJe6ENA1NhxzclRT+ikm8W2YLvG6JPUl79NH+Y
         gqD4xvr95XpMHrWse1aPUJNZ/7tOiS9pRGJSh3W/hhhk08k8NMn0UU+UwsYXUzbhQ7yb
         SYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4UuJkXUYVddcaNxp/nAyxXAOJsPnioC6Y8zpcKyrKs=;
        b=qGQ6E4mtybQaMrBboUwfdDloCuD4EUwlUjS8zg+HeJdLA/jVOrClezjbd2jqrCwmeQ
         v1v85Zt46IQWHWa327SsXgKHneXky4ZCT48FnDPakFOCa6qTgGxslkuQ7r1KXMp3pOW+
         Tb+WvK6uZ1R87XCGUQpf5Y2pzNQhs6wjXloLpkF1odx+kP9wk3+IAmX4hMhfK/3YLFvC
         xxma+cZJIgDpc3n3Y8EV8RViLkTHA9O/IIMlKg1eS/OJI3/Am3FTtDrSfQPzkVK+TsXK
         uy0pmTA09O3lqMM0FPeepsZwdq5bPrjWU5u+icDLEYGnwc+TLz/ZMxzIDOqvGMP6b1A8
         XGdg==
X-Gm-Message-State: AOUpUlFut5GjxZ7ZxK6n4cun+c+De6IJfi0FSnhCDMUgRDIjOdtE8YwQ
        PCZhQvNCaDmqrLHSZNg6CIQ=
X-Google-Smtp-Source: AAOMgpcknfTdmZEcxqgIoJOQkTDePSdwOTJrWOjkAhpJJgDV5Zvbpzzng7OC9pzcRCOlwf/FCwOFGQ==
X-Received: by 2002:a50:92c5:: with SMTP id l5-v6mr2367893eda.52.1531398147586;
        Thu, 12 Jul 2018 05:22:27 -0700 (PDT)
Received: from localhost.localdomain (x590d07e3.dyn.telefonica.de. [89.13.7.227])
        by smtp.gmail.com with ESMTPSA id a2-v6sm165618ede.21.2018.07.12.05.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 05:22:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/3] t/lib-httpd: avoid occasional failures when checking access.log
Date:   Thu, 12 Jul 2018 14:22:16 +0200
Message-Id: <20180712122216.12691-4-szeder.dev@gmail.com>
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
 t/t5541-http-push-smart.sh  |  6 ++----
 t/t5551-http-fetch-smart.sh |  3 +--
 t/t5561-http-backend.sh     |  3 +--
 4 files changed, 16 insertions(+), 8 deletions(-)

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
index 83390f80cc..a9836e4af0 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -47,8 +47,7 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	strip_access_log >act &&
-	test_cmp exp act
+	check_access_log exp
 '
 
 test_expect_success 'clone remote repository' '
@@ -129,8 +128,7 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
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
2.18.0.305.g66e9e0a543

