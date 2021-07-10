Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A0C07E9E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2CB613DC
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhGJNkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhGJNkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52103C0613E9
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m2so5457198wrq.2
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0Ggmi1d4Tujx9XzD7foLX+2TuPB8Vab8wiF9BadapI=;
        b=pThZPk3JwPiWD3hcerAiP6s+mUQI+75EYlv40jTnWp9CCJgkUtaOQz4Bql8ie40GNa
         G6zLUtyRPEk4A6vbJF0DJ6Vb35dOs0abe6tGRe63fnpXQHxUyM6c/ewLnPF8BmYtxiVN
         VhIE04ExenyvdThT5D7XiFLFsBkxompFT0dkVZw9+ACxQTUrKOqAjv5cDMVMJVarPvfG
         IOQ9ykR/XZE8xRbAnGEEsIrgJcioB3+Mwyr55q2VCXZ5BopOuSheLqOMvVxpJ9pEUVdm
         kHLSjvo61AxMD9JPi2wdycFAWRLSq8MFTh9hAYL/IdMImxMglu0XQadjOiQ1La8XyPHy
         gyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0Ggmi1d4Tujx9XzD7foLX+2TuPB8Vab8wiF9BadapI=;
        b=gGLwHZ9wmIMk3BPSnGi0ifaKQ4QR/PbxGPPNTTo9nYRmPO1snwIGz5s7SB8O+cS8aV
         3LRyyxFji1NNGM/QKp2ZnI/ZIlqJFl8lrPpikLs7QC2QS/9TWInCexWYlOpTKMjEp32G
         FEcGR1ptBLYK0D1M4Rto+rdXyUTwWlxAEpOA39Hotc3plYuJoTTR7elY5xthSw/Rg+a2
         FCoU5e0ywdDM65YpIOkR3LVx5w3guTFOk4nMz5s67Tp1pmnSQvjP2wpa04iqK9dTdT0A
         TQ5OU82Jd+E3jy701Y5C/JoSP49a4RiLxAIoUc7Uw4BEZBEPN44yJ6J1LsdOUI5ZGq8g
         G+jA==
X-Gm-Message-State: AOAM5316R80BWvtPFGugohUqMri7D9WkeRoOmcc0/d7OfBCmOMP4G9sX
        Jr56n5X8d/j6OFdV7xIqRHXTfByNe7Qkgg==
X-Google-Smtp-Source: ABdhPJyktLCstfd8uM77kcvZmFPGLdiy9fIBIuNAX+1wQebTmJozGMLy2Zcvbe+VYqIs7wVeXUNPjg==
X-Received: by 2002:adf:ef11:: with SMTP id e17mr10418092wro.71.1625924254740;
        Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/21] cat-file tests: add corrupt loose object test
Date:   Sat, 10 Jul 2021 15:37:09 +0200
Message-Id: <patch-06.21-43335e653b8-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
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
index dc01d7c4a9a..7f10a92f0e4 100755
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
2.32.0.636.g43e71d69cff

