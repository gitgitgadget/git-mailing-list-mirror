Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514BEC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3861B61261
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhETM1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhETM0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5AC0438EB
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz27so24632293ejb.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ep6MHXX7MgySl2lRuw1QeCEkvT61VaNDLwOeB3SjQlU=;
        b=ZSIO2k/UGJjyT9Wog/Z3j7qdM+hZvQwuocjjFpGeEE+2/xkEVEpQwrW4KB1RcBKdLZ
         pbfcTzOakySJj/nInHIxQV3Inij0EplzJTDRjtta6CrO3XtI1sf3TdP3Vx+NLvfgeSAE
         ZIHQXtrUE5WreSSrZQM1CS+2ce4f8KD/AmDU1USlGj3xpzHzxL7FVVFZd7RQ3LEsYPd3
         +gjbV+VtGRgdqPnUi2gPc83cD0DLryODUwdcpFoFaZih6LF4deIERHmPoV8t02JibUoJ
         l3tHRNDXUACFmKDatounpf44jHiq0uO8Y5TH8RsiMvIVrDuiKEODXwMfbrEU4CpIZrXo
         FaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ep6MHXX7MgySl2lRuw1QeCEkvT61VaNDLwOeB3SjQlU=;
        b=ciyqOhSDTGklotlXMk7KAWYQSW3HrY3CJ6KgLb07pdNkNhsp2EY/aVK1IRX4cT4wjD
         CxHrNbQGlrdgFY/zItcdgrUvJb65nzclK8WU7fTGTJAK5ejmFgMCJoxLpXY1r2O3PkQN
         9kxStuNp7sxIRw8VLfxA64r09Al5OF18/lFvHkgiqLgm+0dS1K2uS1BlSl60TADM02m2
         P9Arw7tv6aawFmJb6ni3fVZ09Dg0C7XrRvmv8qISWU0OjSaQJt6GGBcQ+FlmHbyj0n7X
         tU6hcfT+qLT9wMBEKhsljnNUYCLm87d2WpPswgjzfoKJXhbrm8RVcmh5e8+9RNdgpnFV
         RdoQ==
X-Gm-Message-State: AOAM5315N/ayyd7D1FT5JGSzCw2F5lURtyPKipIHk+X0fW5vGIMlFZER
        DRGve7WWWdp+1fqJi3tYPxSENUT0hJGQuw==
X-Google-Smtp-Source: ABdhPJyts7c2lCDPLT5ef6rQKxBPXsCtlPvboT3/SrNBtdMyL1eYnh8ylbx70gIuiQ2m1Ggj09lPgg==
X-Received: by 2002:a17:906:2f91:: with SMTP id w17mr4213003eji.443.1621509799770;
        Thu, 20 May 2021 04:23:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/17] cat-file tests: add corrupt loose object test
Date:   Thu, 20 May 2021 13:23:00 +0200
Message-Id: <patch-06.17-04cc1d20f6-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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
index dc01d7c4a9..4a76ff024d 100755
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
+		mv -v "$other_path" "$empty_path" &&
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
+		mv -v other.blob "$empty_path" &&
+		test_must_fail git fsck 2>err.fsck &&
+		grep "^error: inflate: data stream error (" err.fsck
+	)
+'
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.32.0.rc0.406.g73369325f8d

