Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10679C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E620A61266
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhI1CUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbhI1CUq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E4C061740
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f78-20020a1c1f51000000b0030cdb3d6079so1481290wmf.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+VgJQBF4Ibz/S7wpfnLpadfvhVfbkj78rCHCz1DmPQ=;
        b=nDIoMFBDot53ifg5GAxHzVIuLHN71GGAaQ27YF1lOVa/iClCDQ1RdjpuLJsr873QSf
         JzZYfmpMNgC3JV4exlA9S4NI3rb3Ly6Ch/sHfPWL514cElHrN1IHi7PsISQ5QsbxyVf9
         kWYJ/3bskoICCDsAX4j4ZOil2y+fOv/OsmC8KHskRLDxW3p9msU7OaUZ8+Ic4pdRnAtp
         gyCaxDbHV9ClRO+ANeRgyh0rRbuzIgSJY6vk1udLSiJdzFTN2sVi1nxCcZtnxHorQHQW
         8CoPVg9bL2TppSThTMFxn/6IMkWfr3CxFoeJvb0De2o+y5ersUKbxSIOtRrZcjyDmH7o
         dBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+VgJQBF4Ibz/S7wpfnLpadfvhVfbkj78rCHCz1DmPQ=;
        b=aZHGYSkrBwLQ1l8bfP8JXEiAWeRQRPZ+bNQyKrCrmv7Z72eqlhcFJyWYec4duXxLK0
         ZLPK8rtsaWoAnUhtnuzIsPDMl7AgmFfRQ3LlWUP4m3cMrqofwjhyEBJ/O4x+L1AnFAcD
         3gQsUwmcyFXDMVVfhZubvWPgHiZVb2vjcrtgHrPfCY/40vMaGjI3byVFJ4L+fqph03Ab
         Ut6S6T0bG5PeWL/4XFmfisbwYG02B4ixZQsIPjkIFx3lzMnG7f61qBXNhml0QWz9r8d5
         qeVyTNTDsbXoDze18ySE/gTYHZxandSqDq97UA4mjPpSSdH/vy8fJ6pZTXwltvwSgzJa
         qZ3Q==
X-Gm-Message-State: AOAM532icqgEwuRFtwtr6RemLektEeeiD8DCkQ+p4AaCXV1P0jQdbUfi
        7epwZYg4jxkuTkHn1Hd0YH6sIuoALnW4aA==
X-Google-Smtp-Source: ABdhPJxxZLjNTvNuRTlupfu0lbKHbMCQK0JB0ri7ALjOJBPG4Ibzc/TSUgSBnnGSqiAHC1YUWq0igg==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr2164852wma.143.1632795545517;
        Mon, 27 Sep 2021 19:19:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 07/17] cat-file tests: add corrupt loose object test
Date:   Tue, 28 Sep 2021 04:18:48 +0200
Message-Id: <patch-v8-07.17-9e95e134d30-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
index abf57339a29..15774979ad3 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -426,6 +426,58 @@ test_expect_success "Size of large broken object is correct when type is large"
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
2.33.0.1327.g9926af6cb02

