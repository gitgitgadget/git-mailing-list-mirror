Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A840F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCMMYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40361 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCMMYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id g20so1631733wmh.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SANSLHa1gjJDwBRFom9quG2SznkPJBj0TV2pMNxH/gE=;
        b=gdsHhgeGgMq8qqCuidhksHwajW+oeGWjlwXDnm8jKQBSAH+ezdOA+VZHjxugmsgAfw
         2yG7co6kpp5JHQrcDtYpoOuKXBeJfZyGQkX7CdabUrcPPJMaisrIuJWoPaGhz4W4uInd
         EGJKmp8+mDm10iKKHSpic083fWiEOjUhGSo/fG++VpF+xQf8ZofhgPx2e3ClZm4I5QdE
         A87y9TnkgwGyHy53pTO9R/EmO0eCi7yxAloqYn4hXBvSJkvJui7CfL7OMY7nyXKuN6Kp
         IIr0TuDN8pR2JYqsMKQNM6uUyTl3u6TMyaOqjA9RGTI6kGHiC2p7c9l5h2sYBiYAxmrM
         RIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SANSLHa1gjJDwBRFom9quG2SznkPJBj0TV2pMNxH/gE=;
        b=X5P6jpT9a9k8JL5V1O38dMXNoDuaSETKfDmJzXEEGXRVY+Shzs+6uPOI61RBHdIybH
         arZtZn5Y+sChxajDrusuvhM+oUc5flCUT1kgkYGi8jmL022hdgxxYcLgmn5OwJlZtT7i
         dpoDDWivdhYVs/oQOqnF5vMQqzOBSkop0gJcOwNfqqJWME+O1yH9X5YasiV9KEmEAwVn
         I96NqGX5LoH5xlCmpVx9d/VfUYaLfaF2J6H+vD+0vBRPb/wBF+F4j7hClp680hnjQl+9
         LnvN0gKM2yRiGnrx0VS5YiC66ZRHncgOs5NwZlqn0TTV4y8zeHUGD02X89TymEHDPXA6
         wp7A==
X-Gm-Message-State: APjAAAWN8LZB+9cpugzTY4aSuO88dMIZsovuBRS4ILjtvE2JGGJ9kc5u
        cxFZdIZj67W667eSqFrE+WR4QsLa
X-Google-Smtp-Source: APXvYqzg5b2FCERATXElknBEzZxJg22l3tvd1IO8SUcZSIpQ2z27fyUGuJtXloyth+nMHCNWf6kS3A==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr2006513wmc.100.1552479886515;
        Wed, 13 Mar 2019 05:24:46 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/11] tests: use 'test_atexit' to stop httpd
Date:   Wed, 13 Mar 2019 13:24:13 +0100
Message-Id: <20190313122419.2210-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use 'test_atexit' to run cleanup commands to stop httpd at the end of
the test script or upon interrupt or failure, as it is shorter,
simpler, and more robust than registering such cleanup commands in the
trap on EXIT in the test scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-svn.sh                              | 5 -----
 t/lib-httpd.sh                                | 6 +-----
 t/t0410-partial-clone.sh                      | 2 --
 t/t5500-fetch-pack.sh                         | 3 ---
 t/t5510-fetch.sh                              | 2 --
 t/t5537-fetch-shallow.sh                      | 2 --
 t/t5539-fetch-http-shallow.sh                 | 1 -
 t/t5540-http-push-webdav.sh                   | 2 --
 t/t5541-http-push-smart.sh                    | 1 -
 t/t5542-push-http-shallow.sh                  | 1 -
 t/t5545-push-options.sh                       | 2 --
 t/t5550-http-fetch-dumb.sh                    | 1 -
 t/t5551-http-fetch-smart.sh                   | 1 -
 t/t5561-http-backend.sh                       | 1 -
 t/t5581-http-curl-verbose.sh                  | 2 --
 t/t5601-clone.sh                              | 2 --
 t/t5616-partial-clone.sh                      | 2 --
 t/t5700-protocol-v1.sh                        | 2 --
 t/t5702-protocol-v2.sh                        | 2 --
 t/t5703-upload-pack-ref-in-want.sh            | 2 --
 t/t5812-proto-disable-http.sh                 | 1 -
 t/t9115-git-svn-dcommit-funky-renames.sh      | 2 --
 t/t9118-git-svn-funky-branch-names.sh         | 2 --
 t/t9120-git-svn-clone-with-percent-escapes.sh | 2 --
 t/t9142-git-svn-shallow-clone.sh              | 2 --
 25 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index f3b478c307..c1271d6863 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -76,11 +76,6 @@ maybe_start_httpd () {
 		LIB_HTTPD_SVN="$loc"
 		start_httpd
 		;;
-	*)
-		stop_httpd () {
-			: noop
-		}
-		;;
 	esac
 }
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 0dfb48c2f6..b3cc62bd36 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -14,7 +14,6 @@
 #
 #	test_expect_success ...
 #
-#	stop_httpd
 #	test_done
 #
 # Can be configured using the following variables.
@@ -176,7 +175,7 @@ prepare_httpd() {
 start_httpd() {
 	prepare_httpd >&3 2>&4
 
-	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
+	test_atexit stop_httpd
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
@@ -184,15 +183,12 @@ start_httpd() {
 		>&3 2>&4
 	if test $? -ne 0
 	then
-		trap 'die' EXIT
 		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
 		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
 
 stop_httpd() {
-	trap 'die' EXIT
-
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bce02788e6..5bd892f2f7 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -518,6 +518,4 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 49c540b1e1..32426fa5d1 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -918,7 +918,4 @@ test_expect_success 'fetch with --filter=blob:limit=0 and HTTP' '
 	fetch_filter_blob_limit_zero "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
-stop_httpd
-
-
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3b7b30568c..e98d90dd9b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -978,6 +978,4 @@ test_expect_success '--negotiation-tip limits "have" lines sent with HTTP protoc
 	check_negotiation_tip
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6caf628efa..66f0b64d39 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -255,6 +255,4 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	git -C client fsck
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 5fbf67c446..98f028f203 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -146,5 +146,4 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
-stop_httpd
 test_done
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 88ff5a49e4..a094fd5e71 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -176,6 +176,4 @@ test_expect_failure 'push to password-protected repository (no user in URL)' '
 	test_cmp expect actual
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 5475afc052..bdf40f445e 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -373,5 +373,4 @@ test_expect_success 'colorize errors/hints' '
 	test_i18ngrep ! "^hint: " decoded
 '
 
-stop_httpd
 test_done
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index 5165833157..ddc1db722d 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -90,5 +90,4 @@ EOF
 	)
 '
 
-stop_httpd
 test_done
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index b47a95871c..6d1d59c9b1 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -278,6 +278,4 @@ test_expect_success 'push options keep quoted characters intact (http)' '
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d7d88ccc9..57f6f8c628 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -408,5 +408,4 @@ test_expect_success 'print HTTP error when any intermediate redirect throws erro
 	test_i18ngrep "unable to access.*/redir-to/502" stderr
 '
 
-stop_httpd
 test_done
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ba83e567e5..9faf6349cf 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -434,5 +434,4 @@ test_expect_success 'server-side error detected' '
 	grep "server-side error" actual
 '
 
-stop_httpd
 test_done
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 1c49054595..6eb0294978 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -132,5 +132,4 @@ test_expect_success 'server request log matches test results' '
 	check_access_log exp
 '
 
-stop_httpd
 test_done
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index cd9283eeec..5129b0724f 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -23,6 +23,4 @@ test_expect_success 'failure in git-upload-pack is shown' '
 	grep "< HTTP/1.1 500 Intentional Breakage" curl_log
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..b04d668684 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -733,6 +733,4 @@ test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9643acb161..9a8f9886b3 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -331,6 +331,4 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..b0e4752232 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -289,6 +289,4 @@ test_expect_success 'push with http:// using protocol v1' '
 	grep "git< version 1" log
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index db4ae09f2f..35424bb8af 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -656,6 +656,4 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index f87b2f6df3..b6a995e857 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -257,8 +257,6 @@ test_expect_success 'server loses a ref - ref in want' '
 	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
 '
 
-stop_httpd
-
 REPO="$(pwd)/repo"
 LOCAL_PRISTINE="$(pwd)/local_pristine"
 
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 872788ac8c..af8772fada 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -34,5 +34,4 @@ test_expect_success 'http can be limited to from-user' '
 		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
 '
 
-stop_httpd
 test_done
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 64bb495834..9b44a44bc1 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -120,6 +120,4 @@ test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 rename o
 	git svn dcommit
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 41a026637f..a159ff96b7 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -87,6 +87,4 @@ test_expect_success 'test dcommit to trailing_dotlock branch' '
 	)
 	'
 
-stop_httpd
-
 test_done
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index b28a1741e3..40b714df31 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -74,6 +74,4 @@ test_expect_success 'test clone -s with unescaped space' '
 	)
 '
 
-stop_httpd
-
 test_done
diff --git a/t/t9142-git-svn-shallow-clone.sh b/t/t9142-git-svn-shallow-clone.sh
index 9ee23be640..a30730502d 100755
--- a/t/t9142-git-svn-shallow-clone.sh
+++ b/t/t9142-git-svn-shallow-clone.sh
@@ -26,6 +26,4 @@ test_expect_success 'clone trunk with "-r HEAD"' '
 	( cd g && git rev-parse --symbolic --verify HEAD )
 '
 
-stop_httpd
-
 test_done
-- 
2.21.0.499.g4d310c7a8e.dirty

