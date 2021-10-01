Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CA7C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16ACF61A51
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352977AbhJAJTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352933AbhJAJSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4AC0613E3
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d21so14360847wra.12
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WEWMcm9Fm7re5QjzYF2qR6MKXh+iIxFBhMI785xe9mw=;
        b=DrVgSHo2uig4IKpZo6Zr2VuLeXCyiwfCJLo7dzEx9Ln4Bxf5i/E7JXnDkwOD99NEE+
         xeDa82OubY53HgfKnvnQsNMAm0nzqKXoG4rdlr6RZS6Rg/fvPKXSPOLiRixwZHSkwX3Q
         iSx2HH5ny0NevJdXKHnF+5GYPfu58rnUBaO3SYk61AZOt79hW3L5FEAX4cQKEox0y4mx
         6OHA/FWHKsLZqtzYZxOCSL8VbEG43O5mWAYNu605GyrSIdKy064wHPy9Smy27k0mZ+CB
         Ea5mYJ5Kt/Lp2WMzUs6nJRLEHqV1y1u4PFQZpcCIykHup77UlPtTY4U9IoQjpa7pQ0DY
         uRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WEWMcm9Fm7re5QjzYF2qR6MKXh+iIxFBhMI785xe9mw=;
        b=MWKq9q8brJRUrywnMqiCxIMkCX6BttHOzuNaWe5gkft5OvYHeEuUjGwvEiUAJT/LF5
         btCZYM2Q8OLGpIEtK2dMWX8PLgKV1jEpgQwseYZsUAMGNUU6oSvYne/4lCSNexsFVSgd
         L+Yfecxryolk65mkLJv6lXcwxCC2Rw6VaRlhFL74JNEjoZXkzdw+P9BKo1JHemoSgTbZ
         Dsvqcrs/MQU14D2HmICH1neNZV3++41nLmbI26Lr1LxaofBaKFBGVogWPrJZ3QnXBnUo
         heo5QQaHvEsA7JsMMHcLAb3uZuzWOHfhB7tdDTLSWYf5vXDg+lJr8+EYGXr8buLTGLpi
         BQ6Q==
X-Gm-Message-State: AOAM531r/sotZHl2vvDLVTsbGj5fzGSwvgppCdYpnt0TLYGVfHEVta1C
        pEJlwGt7FGU4bDrxoIyZLA780Htul/eleg==
X-Google-Smtp-Source: ABdhPJwObBFQmwBQCQfQbobnpXkVSEJfEmXCdp+gOeuH7o2VCPrr7wMKciKUwyDzVvx2IB0DrCI/7g==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr11141258wru.255.1633079824021;
        Fri, 01 Oct 2021 02:17:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 07/17] cat-file tests: add corrupt loose object test
Date:   Fri,  1 Oct 2021 11:16:43 +0200
Message-Id: <patch-v10-07.17-c5affb65b7e-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
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
2.33.0.1375.g5eed55aa1b5

