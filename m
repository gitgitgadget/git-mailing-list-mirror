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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A38C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90CC61050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhIUC7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349420AbhIUC0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE955C1E3270
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so32432727wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNBSjKdlf9tK7aWr3iQt2IEQ+I7orn/LbCkM+36hWyk=;
        b=j3G4LiU81ulgp/b8Fp9wRxkvTLRYcl6pOvhXzx2q6EYmVoQN5pp4gwkxPeX5vky5h0
         UvpZTmTUUx65JTdPYYQyG6Y0+PFOpnYAv5sPZ2T/HOcNjmmad7BpLxd5xVhmV02fhHcp
         3LCaz1o84pcLqMKOtSoUVRmWo9q5JHWExUxqR3gG9jVKSvf7JmWVN0ow6FAsw+Am7kxO
         cnuOrsk0cUByvdi8LKh9yQenRuXZKY13m2Zl1P3Gk4V0cq8hjVWCWhxa77MYIwoZ+qTN
         lT/Ym2pLkEHAkUfmauH8HGqZCvwESNl+uVklWfdlSO80bAedz1JP6YkZ/WD0WddmdrIY
         0gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNBSjKdlf9tK7aWr3iQt2IEQ+I7orn/LbCkM+36hWyk=;
        b=WTZg3nevOZq8p+Vu4Ymat3KVNGkNrcuDSQOnBghnU41LHgww4+JWEUmoX06TKyItyw
         5EkaRhhuZHPj3WiCthKak5ImX4ZsOwGFLDeUs/UDQttTVmVJjjbhZI2isVmWdW0g9PFt
         iTD9Lv3cddie1C6DrKKvcfwseUGwbzjTVgzSECFYV2lR0X/6qFMUlp0X878Tkyko8ca9
         84UGoBLfSVx5nibFApdVd+7wM/Y0YOO9DkhHKX7uoODWGliWxh42UR4RXWjusI4cSwbC
         FIQiuLtz2bC/0ITXxJBwdUL6XOToHI9b+667mDsfg90MQjO0jtOCcvvr3Mgfn+NXqKko
         FG3Q==
X-Gm-Message-State: AOAM530jQi9eDb31pbWVPg5Q6V0o9weZwjtlcx2n7GLqXwK1bvatCx//
        cjo3KfiP9OMyXTusekvvceeiw91ugvhUVA==
X-Google-Smtp-Source: ABdhPJw2rHUmjS7Tke6CPORNq+gGNznZLxA6PrcX8o3a0o4/uVk6q50pHnuDKS8R0ZS1WX+/JOyr0g==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr30979220wrv.405.1632164672090;
        Mon, 20 Sep 2021 12:04:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 07/17] cat-file tests: add corrupt loose object test
Date:   Mon, 20 Sep 2021 21:04:11 +0200
Message-Id: <patch-v7-07.17-20bd81c1af0-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index af59613250b..8bbc34efb0c 100755
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
2.33.0.1098.g29a6526ae47

