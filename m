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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D6C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0A61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhGNA5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhGNA5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304DC0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f17so979033wrt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+i+IFrFqHxB3Xd31yVqr/mypKHo7HjZpG3IR7j+cwz4=;
        b=ShdF2ZjcV0rMhjINQOZFojP6EeklGUiF93aPXgkBYilNzCs9aQkfZXqFRzM9t4Vc3C
         UsJG1H+Ma1uIA5Kbvxr6mmzlooJ1yhTwAY4M6L7TbcPw/CR5Z2rCD4MY8Z6Tq0cepsUQ
         8L/raBYWWkwnfQUedF6v/ZnIXn4oeXeAgOkuhGYzCZvzmxnl9AhWwA8Xds2wjhIv7wYZ
         KCuVSZOCe1XCwA7TwpqKVuUSxpfhowMWTQwL+nRjmiAK3w9BA3lHl99/jpUz4I0D7F5d
         hi3z7EC4cm+9uM8LIrG9CKzurxBMYtVpYODCRVFIVZL1sC4rMJUFxBhapvhLduzhfQWr
         Z/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+i+IFrFqHxB3Xd31yVqr/mypKHo7HjZpG3IR7j+cwz4=;
        b=lzWUnehklABF7C+WFK5dDdymnt7FhBHyC+Ru/B6uRpKuZ4t4pgwr9yKZA2LoDea2At
         fkIGFyFsbdq4uBXDiv4exkq9B1CkfR6pImbiWOeFUAqGJOely9CSxFzTdXc76XeRZvPR
         lLGdK6CZvr3QkcvLC1UL96HVAN79SjdvmtwewEVuxiIuWQsnkDOC+kOBuMvk4F4+/2Ur
         YI4QVdLKpBPMlLRgTlyiV54GPzSgxrDx58UgM9bHaX5ZA0f2L74ZWxLRI5RJ8aHZRq8C
         wU3TCmxc7dJS8F8hgmh6V0YqJsNRy6LlptCbHbZhh6TNQ3iB7PIbR4lljPVxRU4OCU1Z
         kxRA==
X-Gm-Message-State: AOAM530SKywHHES9AOpHuPslGt05OCuO2xeihfDhYr2NJFu785gsaFn4
        VM1xVsiSyfuctZIx0W4sxAsJbeHuVYsJevcu
X-Google-Smtp-Source: ABdhPJwesv7I82KxcgwLkbuub+Ztx01H7mHIWih/Om2SDOHiKF8DgszhUl/x7kHXbuP48tcs4SotHA==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr8892140wri.423.1626224049714;
        Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] tests: replace remaining packetize() with "test-tool pkt-line"
Date:   Wed, 14 Jul 2021 02:54:04 +0200
Message-Id: <patch-4.5-9842c85d1f-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
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
 t/t5570-git-daemon.sh                  |  8 ++++++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 5e638f0b97..c5e052e537 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -26,6 +26,16 @@ static void pack(int argc, const char **argv)
 	}
 }
 
+static void pack_raw_stdin(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+
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
index ddf3da5a26..666b3d8726 100644
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
 		test-tool pkt-line pack <<-EOF &&
 		$ZERO_OID $A refs/for/main/topic1
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index e6c8338b64..23a8a8d5c7 100755
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
index 2dde034881..e2cb4f376d 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -194,9 +194,13 @@ test_expect_success 'hostname cannot break out of directory' '
 
 test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	{
-		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
-		printf "0000"
+		printf "git-upload-pack /interp.git\n\0host=localhost" |
+		test-tool pkt-line pack-raw-stdin &&
+		test-tool pkt-line pack <<-\EOF
+		0000
+		EOF
 	} >input &&
+
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
 	test-tool pkt-line unpack <output >actual &&
 
-- 
2.32.0.788.ge724008458

