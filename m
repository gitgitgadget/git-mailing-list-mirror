Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309DC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E13960FE9
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhGLQrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhGLQrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD9C0613E9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t5so12670412wrw.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79wy7yg0RL4WI3JlF9hqjKjI608FL1XhF0FHsoTw3tM=;
        b=FTsf+JftbNomRgKSg0VU0asCmC75JOt3pMDnSX2+jfnU7nui5Ams2vCw6ZOguoT7HQ
         WqRENZ965FddxvlLQuxYlm8bhUISO7Tsb7t6Ko6+WnCfkjLNSBsD5ZFK/S9g3vsxOOWM
         8fKLb81SxsZQq1GLPPYm2B1TiagJoizLD8xscIlNdP6IKd0W7ZxAGk0hh/hqTXzu+JnJ
         6qXOTfH1IcN3AmJOWLE20wC+HpKm1hCuAdiiXEwQOPrQZmJfKfMQbkCsfUKMo/n1wa5z
         6EbtwMV0nYuL9vMn8YMSfjlzMXHbRUEeS52R0X94CL9x6uJHu4JvJvCiuBaFqj84yb/f
         PyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79wy7yg0RL4WI3JlF9hqjKjI608FL1XhF0FHsoTw3tM=;
        b=JMJQFmSCFZJa6KSx9FjGy3AaYR4xmhzrcMMALsjEhxz41KP629tRO3PkyYsFktkjBQ
         AhFWDU9em4rQRdKFpJkneZAkWlzuXnqdftJRFVYpdiwukBtjtkYM+EEBMpnnEtsJwMx2
         nlvQEtU+S0NSEWizSjuUbqTcgbsSRDgsmbJkUmg3j6w6duSOJxH1ae/qsMiJmky3Fple
         J4MCtPrqDIAb6r5CA8AdF6mMD74FV53an2rba2m6LgdMOQkS6wjJijHvOTogsoUi1d16
         jgkHGmlR83fOwGVZl79BYfFqs/X+aX8Oui4hcLEYt6Um77NDtq1Dbu5mT7NCxE5HxvNh
         GY8w==
X-Gm-Message-State: AOAM531G/Yg1yWYcurGfj3hMv+KhNg7/8GcpKqOzp6QqWlyCLAiPn4f3
        BGnxEMqEwwBbS8fd+8dStslPgbI8jgyAhuf7
X-Google-Smtp-Source: ABdhPJxHs8bVYbaZoqTWarXYQkgWDDACwHT3H3paWUfiEa6/U2STmdhZ6S6sC5QUAM5NSDQ8Xfy2EQ==
X-Received: by 2002:adf:cd86:: with SMTP id q6mr58289547wrj.422.1626108266266;
        Mon, 12 Jul 2021 09:44:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm12988347wmb.40.2021.07.12.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] tests: replace remaining packetize() with "test-tool pkt-line"
Date:   Mon, 12 Jul 2021 18:44:19 +0200
Message-Id: <patch-4.5-a44e1790f2a-20210712T164208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com> <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the only remaining users of "packetize()" over to "test-tool
pkt-line", for this we need a new "pack-raw-stdin" subcommand in the
test-tool. The "pack" command takes input on stdin, but splits it by
"\n", furthermore we'll format the output using C-strings, so the
embedded "\0" being tested for here would cause the string to be
truncated.

So we need another mode that just calls packet_write() on the raw
input we got on stdin.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-pkt-line.c               | 12 ++++++++++++
 t/t5411/once-0010-report-status-v1.sh  |  4 ++--
 t/t5562-http-backend-content-length.sh |  3 ++-
 t/t5570-git-daemon.sh                  | 10 ++++++----
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 5e638f0b970..8563a0da4c5 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -26,6 +26,16 @@ static void pack(int argc, const char **argv)
 	}
 }
 
+static void pack_raw_stdin(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_read(&sb, 0, 0);
+	if (strbuf_read(&sb, 0, 0) < 0)
+		die_errno("failed to read from stdin");
+	packet_write(1, sb.buf, sb.len);
+	strbuf_release(&sb);
+}
+
 static void unpack(void)
 {
 	struct packet_reader reader;
@@ -110,6 +120,8 @@ int cmd__pkt_line(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "pack"))
 		pack(argc - 2, argv + 2);
+	else if (!strcmp(argv[1], "pack-raw-stdin"))
+		pack_raw_stdin();
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index cf33d993192..75d4233e49f 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -28,10 +28,10 @@ test_expect_success "proc-receive: report status v1" '
 		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"
 		then
 			printf "%s %s refs/heads/main\0report-status\n" \
-				$A $B | packetize
+				$A $B | test-tool pkt-line pack-raw-stdin
 		else
 			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
-				$A $B | packetize
+				$A $B | test-tool pkt-line pack-raw-stdin
 		fi &&
 		printf "%s %s refs/for/main/topic1\n" \
 			$ZERO_OID $A | test-tool pkt-line pack &&
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index e6c8338b648..23a8a8d5c70 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -64,7 +64,8 @@ test_expect_success 'setup' '
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
 		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
-			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" |
+			test-tool pkt-line pack-raw-stdin &&
 		printf 0000 &&
 		echo "$hash_next" | git pack-objects --stdout
 	} >push_body &&
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 2dde0348816..b52afb0cdea 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -193,10 +193,12 @@ test_expect_success 'hostname cannot break out of directory' '
 '
 
 test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
-	{
-		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
-		printf "0000"
-	} >input &&
+	printf "git-upload-pack /interp.git\n\0host=localhost" >has-null &&
+	test-tool pkt-line pack-raw-stdin >input <has-null &&
+	test-tool pkt-line pack >>input <<-\EOF &&
+	0000
+	EOF
+
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
 	test-tool pkt-line unpack <output >actual &&
 
-- 
2.32.0-dev

