Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DBFC4332F
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA4E619E9
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351680AbhI3Nj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351645AbhI3NjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADEBC06176F
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so4383206wme.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rzl7K7e7Xkgw/tpKZQmu0vjtXUqb58hGxXcRzkRBsIM=;
        b=hW4qcMy065EYAOhGz/Tj0BK28LYOun4hSaspH40R+ZguTpsPptwXMKkGo1yND8AAME
         +sDDUz5CosZdhJGAcHCSxjKLNhbr7bMQrxwVyer5ihDxwrPSB+vO6lHor+RZDpn4tlrR
         ymiYpxyojI02R2VuiKW8c9R0q69VlbRJqSA060Yhc90NM0HGj7nBBC13GKKERZwUWLPm
         g0hR90mZaVkSmKg4Zkyw3SWWeEEpGX1F2N7cvXacgGgDeelv+tHo9fgrNT1pdJXKgIxv
         Z7/AY74by+fNVBmACBwuThCNeMLYs9kjju44oJaYXv8ot6Fpo3yLQIQm27rS1x3GrX0r
         IWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rzl7K7e7Xkgw/tpKZQmu0vjtXUqb58hGxXcRzkRBsIM=;
        b=548YsMqS7W1AIcgHvbEF2xfEbBkBKz6IgLv4QJQCwP9jj/tl0hDmeIF75SyRfV1thX
         PIGr8wWRMQrlaqAcm+KX6ct4OgzSehUBSjO/3nHFjoGKcs4hC3MghXJrtHLsiLjZCXvD
         /Xt7K0RyKy+aLeQfTJyZV23AmHqwnq5VBvGctJ08INQo8vwv2e8x/lCdlsaZ+YMFn5Bd
         bA6rmVEXOdhgh8KHXpJRpEzg4WZgUkDm1myfmVm4h04lvhgKfwlnPokPtnKFj64XvMD+
         AVpdeBcwIx9J6lNr/V+4VM45ilaERpjou1eJbuupwPOt3TSeHQtiDNZpMABbLf871AMu
         6hEg==
X-Gm-Message-State: AOAM531UQ/4Zsvz/G6ikPni6eCmKorBPEyswWfqublh1rtLBah1C9Nd2
        uDN8eL+CiNqwI5JnvoHiVO4FBtIFoV/WfT7k
X-Google-Smtp-Source: ABdhPJzNyEwpPP0JS9C67ce9+OP+WCMBuOVXiDRlK886I9wWfBa3ynv6HJQJjeIwgNNG0XF3zrPzVA==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr5427229wmj.33.1633009052877;
        Thu, 30 Sep 2021 06:37:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 07/17] cat-file tests: add corrupt loose object test
Date:   Thu, 30 Sep 2021 15:37:12 +0200
Message-Id: <patch-v9-07.17-a41b2c571e5-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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
2.33.0.1374.g05459a61530

