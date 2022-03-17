Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCAC433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiCQKPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiCQKPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:15:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CBDBD27
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so6019400wrb.8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ra/+pn8iLDnqR8URwVHIYIXqhk/m0UPIBSWC7gr83KY=;
        b=a/o5UFJ8famyVZ1/vX2Z+X4SJYR6REevP7bADsgNapP6c/Bn5q5xwQesM4myTq4Him
         Ebs2B0jZRPcxqcpP32HXWjggQjiKWQNDwAQwLk5viBA/XskB+EX+uLMlU/ENyVZI6qEX
         7I+DuD6bzTjE54mBUYadWqLPxXvC+dR/0oWZOaOKcEIeFe02gHxwq7twwsEHMA9n2Bo9
         lUx0jR+jke3xG6WufmXHa9KaqmRFZYMJkev9JImULvFqEEXO1ErweaA/IcDrz44jVolY
         Us2y8Gg9zGVetgxGruy8lJvdxqhyl5Cp/IicY9IGhrTx3z6LEXia2j7IQ4psEV7NEYdm
         1vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ra/+pn8iLDnqR8URwVHIYIXqhk/m0UPIBSWC7gr83KY=;
        b=rYazkpZ47eavoOKT5rd/yU22v+ptZADRz2X3R2pV14jBIkPzdoJUjmcpdjbvAVozhJ
         VYelloTyNAfc7praiyQQYyX2t/Xy0Iz3+Vurs1xmztrZDAanzQ2S4S3G/kAfuWOdww7J
         ekxZTnHitpGmY2ttFBGhn8QPTUB0SbKnXm0A2ACScyxVouLOBd0j12vIuCDiYGBrczPZ
         73on1w+fIm2mzEMSszfmEIPNo7BKh8oBrHZigM73bQFuCaPPos7LByPDc1+QKUM5INlV
         6b5uxuGmfOgIw8YvxpiAKkE0YdYUqgZdg9M2qE2yDc0zEGE7GINwEDBgMsNLEsgj7rRF
         /cxw==
X-Gm-Message-State: AOAM531oQvk5Sp/2VhceYcy8t1JZwtQTR8iL4PysN5Tpr/0MBZkOz6SP
        mfP6vB9GgSP16yU7FhWNQ0VsqzUJSBI=
X-Google-Smtp-Source: ABdhPJzKgZeu0FfagZ73twv0Iinb0ojOM1AgHukdfKHcop4PURYZL1msRz1z0+YqLn6+IOxLho1qQg==
X-Received: by 2002:a05:6000:1a85:b0:203:86bc:9816 with SMTP id f5-20020a0560001a8500b0020386bc9816mr3178033wry.67.1647512014191;
        Thu, 17 Mar 2022 03:13:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/13] proc-receive hook tests: use "test_hook" instead of "write_script"
Date:   Thu, 17 Mar 2022 11:13:17 +0100
Message-Id: <patch-v3-12.13-5b764ffc65a-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the t5411/*.sh tests to use the test_hook helper instead of
"write_script". Unfortunately these tests do the setup and test across
different test_expect_success blocks, so we have to use
--clobber (implying --setup) for these.

Let's change those that can use a quoted here-doc to do so while we're
at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5411/once-0010-report-status-v1.sh         |  2 +-
 t/t5411/test-0002-pre-receive-declined.sh     |  4 ++--
 ...st-0003-pre-receive-declined--porcelain.sh |  2 +-
 t/t5411/test-0013-bad-protocol.sh             | 20 +++++++++----------
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 18 ++++++++---------
 t/t5411/test-0020-report-ng.sh                |  4 ++--
 t/t5411/test-0021-report-ng--porcelain.sh     |  4 ++--
 t/t5411/test-0022-report-unexpect-ref.sh      |  2 +-
 ...est-0023-report-unexpect-ref--porcelain.sh |  2 +-
 t/t5411/test-0024-report-unknown-ref.sh       |  2 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  2 +-
 t/t5411/test-0026-push-options.sh             |  6 +++---
 t/t5411/test-0027-push-options--porcelain.sh  |  6 +++---
 t/t5411/test-0030-report-ok.sh                |  2 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |  2 +-
 t/t5411/test-0032-report-with-options.sh      | 14 ++++++-------
 ...est-0033-report-with-options--porcelain.sh | 14 ++++++-------
 t/t5411/test-0034-report-ft.sh                |  2 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |  2 +-
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  6 +++---
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  6 +++---
 t/t5411/test-0038-report-mixed-refs.sh        |  2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  2 +-
 t/t5411/test-0040-process-all-refs.sh         |  2 +-
 .../test-0041-process-all-refs--porcelain.sh  |  2 +-
 ...t-0050-proc-receive-refs-with-modifiers.sh |  4 ++--
 26 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 297b10925d5..f9ffb01e509 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -3,7 +3,7 @@ test_expect_success "setup receive.procReceiveRefs" '
 '
 
 test_expect_success "setup proc-receive hook" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic1" \
diff --git a/t/t5411/test-0002-pre-receive-declined.sh b/t/t5411/test-0002-pre-receive-declined.sh
index 0c3490c9b1b..98a9d13041a 100644
--- a/t/t5411/test-0002-pre-receive-declined.sh
+++ b/t/t5411/test-0002-pre-receive-declined.sh
@@ -1,6 +1,6 @@
 test_expect_success "setup pre-receive hook ($PROTOCOL)" '
 	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
-	write_script "$upstream/hooks/pre-receive" <<-EOF
+	test_hook -C "$upstream" --clobber pre-receive <<-\EOF
 	exit 1
 	EOF
 '
@@ -21,7 +21,7 @@ test_expect_success "git-push is declined ($PROTOCOL)" '
 	EOF
 	test_cmp expect actual &&
 
-	test_cmp_refs -C "$upstream" <<-EOF
+	test_cmp_refs -C "$upstream" <<-\EOF
 	<COMMIT-A> refs/heads/main
 	EOF
 '
diff --git a/t/t5411/test-0003-pre-receive-declined--porcelain.sh b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
index 2393b04ad95..67ca6dc4f8f 100644
--- a/t/t5411/test-0003-pre-receive-declined--porcelain.sh
+++ b/t/t5411/test-0003-pre-receive-declined--porcelain.sh
@@ -1,6 +1,6 @@
 test_expect_success "setup pre-receive hook ($PROTOCOL/porcelain)" '
 	mv "$upstream/hooks/pre-receive" "$upstream/hooks/pre-receive.ok" &&
-	write_script "$upstream/hooks/pre-receive" <<-EOF
+	test_hook -C "$upstream" --clobber pre-receive <<-\EOF
 	exit 1
 	EOF
 '
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index c08a00ded29..8d22e17aee3 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --version 2
 	EOF
@@ -40,7 +40,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-version
 	EOF
@@ -65,13 +65,13 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
 	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
 
-	test_cmp_refs -C "$upstream" <<-EOF
+	test_cmp_refs -C "$upstream" <<-\EOF
 	<COMMIT-A> refs/heads/main
 	EOF
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-write-version
 	EOF
@@ -102,7 +102,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-commands
 	EOF
@@ -132,7 +132,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-push-options
 	EOF
@@ -164,7 +164,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-write-report
 	EOF
@@ -194,7 +194,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v
 	EOF
@@ -236,7 +236,7 @@ test_expect_success "cleanup ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (no ref, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok"
@@ -269,7 +269,7 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "xx refs/for/main/topic"
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index 3eaa597e0f7..298a3d1feca 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unknown version, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --version 2
 	EOF
@@ -40,7 +40,7 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-version
 	EOF
@@ -71,7 +71,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-write-version
 	EOF
@@ -102,7 +102,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-commands
 	EOF
@@ -132,7 +132,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
 '
 
 test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-read-push-options
 	EOF
@@ -164,7 +164,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
 '
 
 test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v --die-write-report
 	EOF
@@ -194,7 +194,7 @@ test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
 '
 
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v
 	EOF
@@ -236,7 +236,7 @@ test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 '
 
 test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok"
@@ -270,7 +270,7 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 '
 
 test_expect_success "setup proc-receive hook (unknown status, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "xx refs/for/main/topic"
diff --git a/t/t5411/test-0020-report-ng.sh b/t/t5411/test-0020-report-ng.sh
index e915dbc28df..6347c9629b3 100644
--- a/t/t5411/test-0020-report-ng.sh
+++ b/t/t5411/test-0020-report-ng.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ng refs/for/main/topic"
@@ -31,7 +31,7 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (ng message, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ng refs/for/main/topic error msg"
diff --git a/t/t5411/test-0021-report-ng--porcelain.sh b/t/t5411/test-0021-report-ng--porcelain.sh
index 2a392e099b9..502b34fe3dd 100644
--- a/t/t5411/test-0021-report-ng--porcelain.sh
+++ b/t/t5411/test-0021-report-ng--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (ng, no message, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ng refs/for/main/topic"
@@ -32,7 +32,7 @@ test_expect_success "proc-receive: fail to update (ng, no message, $PROTOCOL/por
 '
 
 test_expect_success "setup proc-receive hook (ng message, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ng refs/for/main/topic error msg"
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index f7a494bdb9d..7744392a626 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main"
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 63c479e9759..6d116ef692c 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main"
diff --git a/t/t5411/test-0024-report-unknown-ref.sh b/t/t5411/test-0024-report-unknown-ref.sh
index af055aa0864..619ca2f421a 100644
--- a/t/t5411/test-0024-report-unknown-ref.sh
+++ b/t/t5411/test-0024-report-unknown-ref.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0025-report-unknown-ref--porcelain.sh b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
index 99601ca321f..8b3f5d05a3f 100644
--- a/t/t5411/test-0025-report-unknown-ref--porcelain.sh
+++ b/t/t5411/test-0025-report-unknown-ref--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (unexpected ref, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index fec5f95793b..6dfc7b1c0da 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -1,6 +1,6 @@
 test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL)" '
 	git -C "$upstream" config receive.advertisePushOptions false &&
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
@@ -31,7 +31,7 @@ test_expect_success "enable push options ($PROTOCOL)" '
 '
 
 test_expect_success "setup version=0 for proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		--version 0 \
@@ -75,7 +75,7 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL)
 '
 
 test_expect_success "restore proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 8fb75a8789d..768880b40fb 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -1,6 +1,6 @@
 test_expect_success "setup proc-receive hook and disable push-options ($PROTOCOL/porcelain)" '
 	git -C "$upstream" config receive.advertisePushOptions false &&
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
@@ -32,7 +32,7 @@ test_expect_success "enable push options ($PROTOCOL/porcelain)" '
 '
 
 test_expect_success "setup version=0 for proc-receive hook ($PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		--version 0 \
@@ -78,7 +78,7 @@ test_expect_success "proc-receive: ignore push-options for version 0 ($PROTOCOL/
 '
 
 test_expect_success "restore proc-receive hook ($PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0030-report-ok.sh b/t/t5411/test-0030-report-ok.sh
index a3a6278213c..0f190a6e851 100644
--- a/t/t5411/test-0030-report-ok.sh
+++ b/t/t5411/test-0030-report-ok.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (ok, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0031-report-ok--porcelain.sh b/t/t5411/test-0031-report-ok--porcelain.sh
index 0e175388b65..7ec39812638 100644
--- a/t/t5411/test-0031-report-ok--porcelain.sh
+++ b/t/t5411/test-0031-report-ok--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (ok, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic"
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index 988a4302a67..07733b94b81 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "option refname refs/pull/123/head" \
@@ -30,7 +30,7 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL)
 '
 
 test_expect_success "setup proc-receive hook (option refname, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -62,7 +62,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -95,7 +95,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 '
 
 test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -129,7 +129,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 '
 
 test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -161,7 +161,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -195,7 +195,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 '
 
 test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/a/b/c/topic" \
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index daacb3d69d4..2e1831b104e 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (option without matching ok, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "option refname refs/pull/123/head" \
@@ -31,7 +31,7 @@ test_expect_success "proc-receive: report option without matching ok ($PROTOCOL/
 '
 
 test_expect_success "setup proc-receive hook (option refname, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -64,7 +64,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 '
 
 test_expect_success "setup proc-receive hook (option refname and forced-update, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -99,7 +99,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 '
 
 test_expect_success "setup proc-receive hook (option refname and old-oid, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -134,7 +134,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 '
 
 test_expect_success "setup proc-receive hook (option old-oid, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -167,7 +167,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 '
 
 test_expect_success "setup proc-receive hook (option old-oid and new-oid, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -202,7 +202,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 '
 
 test_expect_success "setup proc-receive hook (report with multiple rewrites, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/a/b/c/topic" \
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index 73a47d1ffdb..0e375350653 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index c3502011075..b9a05181f1a 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-\EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 8c8a6c16e10..889e97057b8 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -14,7 +14,7 @@ test_expect_success "setup git config for remote-tracking of special refs" '
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -87,7 +87,7 @@ test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -162,7 +162,7 @@ test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index bc44810f33a..1e523b1c173 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -58,7 +58,7 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
@@ -119,7 +119,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/main/topic" \
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index e63fe7ba110..4c70e84e410 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/next/topic2" \
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 99d17b73afd..40f4c5b1afb 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -1,5 +1,5 @@
 test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/for/next/topic2" \
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index 2f405adefa8..7ae3851efb9 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -17,7 +17,7 @@ test_expect_success "setup upstream branches ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main" \
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index c88405792ef..02e1e084d6c 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -17,7 +17,7 @@ test_expect_success "setup upstream branches ($PROTOCOL/porcelain)" '
 '
 
 test_expect_success "setup proc-receive hook ($PROTOCOL/porcelain)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main" \
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index 31989f01850..7efdfe55987 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -9,7 +9,7 @@ test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)"
 '
 
 test_expect_success "setup proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main" \
@@ -70,7 +70,7 @@ test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
 '
 
 test_expect_success "setup proc-receive hook ($PROTOCOL)" '
-	write_script "$upstream/hooks/proc-receive" <<-EOF
+	test_hook -C "$upstream" --clobber proc-receive <<-EOF
 	printf >&2 "# proc-receive hook\n"
 	test-tool proc-receive -v \
 		-r "ok refs/heads/main" \
-- 
2.35.1.1384.g7d2906948a1

