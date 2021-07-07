Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A437C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063C761C9D
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhGGKYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhGGKYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDAAC061760
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:22:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so1314476wmq.3
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YY1WQBapUW606d/27H4hUlezUCd21kgu2L382vLeJw=;
        b=sSG0LqzO+UX52cyoSdUmtWRyRcoF2g9hXjlu2sg9M3sUWoHbRTHlHKMoxJ/ErJcypD
         hld9OGVrUL1Q8DkHZ8/pGDrMExXWe59gnCl4/2KWL7sLSoinhTDu/jB9t0Auq4teaLGr
         lsxW1nJIdnNM+NxBvgV0sai6Af6Im8Z49QskNX8BCTYZcV1NH8QCzOF3KDnUaWWba3Nc
         FkQP0FtuV9tBzKsYxO+JSJ8zkzWgd6lIDt8tNTnDx29w+KYgusaXCKheqWke+b9do9cB
         eS7eQVmNFxWzpS+x0T5soyFHarQx+P4IJ8CgZX3F6gu3cD/MMMOLAomZhiVi6ADvZ624
         x78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YY1WQBapUW606d/27H4hUlezUCd21kgu2L382vLeJw=;
        b=lHX0rGAXRVkKrwyNyZVyivzM6pDhYIBM3YfhcoS7eSD5cDNX3vEqthd9jcNSnWjhfH
         O7E9TqwdZs6Dl6BfUfaoMELT82bz3eKDljj52RKNhtPUcjymrXJrmFkyJpnIbcb3zFZX
         5FwnSUcCoW8Ow5fzRX61tyEuz9LZDZB6wxVxvfnbU5wQWiLpfJWjuczBVKm0oCwOlZmP
         HhqQ2wdwlD/fM2853D0q1b25qi8cEuC8oflZ6r4zMdfUTHoPub9J2IppHDDOJ7FVSt/I
         fOs9TgQHDcTITjJDSXp17Jwveyy62d6pF/sfE7g/CW/fN3mEFp4jP0iz0tw6DTIUlBd5
         +cIg==
X-Gm-Message-State: AOAM530+SSM4O+3f09kx+jNLWWFuh0xOBvQx9Cp6g9HBukvJHFvORUYG
        z6Kf34ZT1Z0LquS5KsWx1woa2V0AiuNIfA==
X-Google-Smtp-Source: ABdhPJzDFsyhDH2P6Ou/BEkD4ZsCmmF2SYnUwAWh1mZ7roT+XqOt92qBpqK14QC2ZmY6y131zmtJPA==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr25373081wmc.142.1625653318804;
        Wed, 07 Jul 2021 03:21:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] tests: replace remaining packetize() with "test-tool pkt-line"
Date:   Wed,  7 Jul 2021 12:21:48 +0200
Message-Id: <patch-4.5-ab23513b48b-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
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
 t/helper/test-pkt-line.c               | 13 +++++++++++++
 t/t5411/once-0010-report-status-v1.sh  |  4 ++--
 t/t5562-http-backend-content-length.sh |  3 ++-
 t/t5570-git-daemon.sh                  | 10 ++++++----
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 5e638f0b970..a2437fbe57d 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -26,6 +26,17 @@ static void pack(int argc, const char **argv)
 	}
 }
 
+static void pack_raw_stdin(void)
+{
+
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
@@ -110,6 +121,8 @@ int cmd__pkt_line(int argc, const char **argv)
 
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
2.32.0.636.g43e71d69cff

