Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2CC433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF60610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbhIGK7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbhIGK7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01409C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so13767928wrr.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbKE2r5K2HvEU8KOTr9OLuep7B3kuRwcbVqAKUCbf5A=;
        b=h/PiuN+9pre6bsFdRDdGORxG5uHIhz6B3x9Ar2ilGZdk9rHpAuUA15qbJjTPHkuGyP
         CF/P96KlGN6vNJvJ8p6n1rJiQbvimy17dffL4JHpk/HjNZCTAqfX0cCqNNAkI+4McGIi
         Qs256NfRZKKT+CTYF6kcbu8UxEqaJ+poiATLq209o/dB5bz4MMOGlOeoH2YNOtyAzzjs
         IGYt2U/W87T4k8UIEYtmoAqtfFZD1dQfz3s8192TK7Ox8F25na0E9VLuvhEvo2jejxVS
         hfbsHayc6no37oXMh2nlk/f2SlZIk144WO8d1BY+QpyvG8q3IZwWkwpiwTvbr0xOnTQ3
         +Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbKE2r5K2HvEU8KOTr9OLuep7B3kuRwcbVqAKUCbf5A=;
        b=clSLWFfkVoNwcAFLzQRStfwzgzJjZUinnjpPUXAM9Df95pfALLPIGn88I9b06jo4hp
         EpIfspQycrB6C8WVE6D+0dkL1lKeE7SVux1Wlsqo0ErOgXJs6yv5C9RVXZna4QR6rxXT
         mUw58uu48Stm57rH+DL/asbiC3EhwwsrUU90xYAeRRQ3WIkPd+su6Nvs/OZfaniQl8C6
         QGIBG+A6N5mJXbp3k00XzvbGaTtYKKA0wtGHU48JuT7Rx6rKfQpQrNQeh/tlk4T2GNV3
         7Ivu5rWMvxfbewQFhJpov8CnigNr0XFdfBussrvH3KSzhv/OLBIQZ1GSIKLORNSquzTY
         9wRw==
X-Gm-Message-State: AOAM5319ZPF6iKRUDhoLSzstNY4C/ZROjCpGOL46xAB4Pk35i6pHX2+1
        R5xKINzvckeln1p4mkpaLkpHUtl7aHJB6g==
X-Google-Smtp-Source: ABdhPJxZhUrZVBc/NuuCw1+/+Hmrxmnm0Ia9J9NB89SGgHlEdX3SrN31HSCjShJt9yyWFXaTJYHtig==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr18224271wrm.394.1631012309348;
        Tue, 07 Sep 2021 03:58:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/22] cat-file tests: add corrupt loose object test
Date:   Tue,  7 Sep 2021 12:58:01 +0200
Message-Id: <patch-v6-06.22-d1ffd21acc5-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for "cat-file" (and by proxy, the guts of
object-file.c) by testing that when we can't decode a loose object
with zlib we'll emit an error from zlib.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5e05ea0861e..8f3516db188 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -404,6 +404,58 @@ test_expect_success "Size of large broken object is correct when type is large"
 	test_cmp expect actual
 '
 
+test_expect_success 'cat-file -t and -s on corrupt loose object' '
+	git init --bare corrupt-loose.git &&
+	(
+		cd corrupt-loose.git &&
+
+		# Setup and create the empty blob and its path
+		empty_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$EMPTY_BLOB")) &&
+		git hash-object -w --stdin </dev/null &&
+
+		# Create another blob and its path
+		echo other >other.blob &&
+		other_blob=$(git hash-object -w --stdin <other.blob) &&
+		other_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$other_blob")) &&
+
+		# Before the swap the size is 0
+		cat >out.expect <<-EOF &&
+		0
+		EOF
+		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# Swap the two to corrupt the repository
+		mv -f "$other_path" "$empty_path" &&
+		test_must_fail git fsck 2>err.fsck &&
+		grep "hash mismatch" err.fsck &&
+
+		# confirm that cat-file is reading the new swapped-in
+		# blob...
+		cat >out.expect <<-EOF &&
+		blob
+		EOF
+		git cat-file -t "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# ... since it has a different size now.
+		cat >out.expect <<-EOF &&
+		6
+		EOF
+		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# So far "cat-file" has been happy to spew the found
+		# content out as-is. Try to make it zlib-invalid.
+		mv -f other.blob "$empty_path" &&
+		test_must_fail git fsck 2>err.fsck &&
+		grep "^error: inflate: data stream error (" err.fsck
+	)
+'
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.33.0.815.g21c7aaf6073

