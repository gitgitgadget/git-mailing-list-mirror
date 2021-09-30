Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04738C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1786611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351660AbhI3Nj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbhI3NjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A075C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so10134597wrg.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyrRUmELexY6Y8Mka4qYCfup65yQR3qTaI7B/PcebK4=;
        b=PGclwFJ3n7sVMJlP73H6sws7/W8evnBi8d5Rp5xq5KrlhXWDGe2bSn+i74kxT9i133
         l9oNURSM43nOvQgKDQ2kdckkC97LfaxbCPSqgZ3ce5eF+R6SlynOd+K3v7SCIfKs3R/a
         OM/+6UnrlujSl6TuJh1VHZYn8ouE9ZhNNNarLtG9TM3kNCnAi/lREeWt26xaLOG1Rw8h
         X6mHdJj34KhnPRMRZxE9tDSsqso+jG8t33eqwcRXk1F8nwkGjw1ICyU1XbnChUlYyi/A
         NliAY0FkEMhZeNDcSQrtzJxyLnzY6CWp5ARRqlvF53hWFySk/aIff3Bj8BWLeVDPSg5w
         OzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyrRUmELexY6Y8Mka4qYCfup65yQR3qTaI7B/PcebK4=;
        b=uAhpbvQSQHSuDA9nEckTslhMLyyu2F3QsxAqNWJc8haRD+hhb+vG1NeFwdoq3XlEd+
         X3ha1AFps0o5HVn54Yg5JfRCBJOF/CI6qStqWr5BVHBshN18bcaKY7lm3h+t16R7hldI
         oMu6OQvLKt/Ny7UwzwKM/LArfiWu3Fz+pFdQeqiZSbqYn6agDbLccLWsg9wzww77XX5+
         PnFvk2pX530d5GyewGdAm2/PRX8dJnLI2uYInlDC85DOCOIvgHZNVO8JsFGp/Ek7xGDg
         t+2R5b1KzZeQQct6q8WENphQI7ZoEjtmW12Ulekpp94GdIuq4yQqypeMY8sKv7VKJdiN
         QZpw==
X-Gm-Message-State: AOAM531Ax1U64qYQSt1BCNCZCZ7P/e108q2OZnya4EePzoR+RHrqDVUG
        vXSH4TKn1ffGdQfyCre6zQmIki03sUDkMU2u
X-Google-Smtp-Source: ABdhPJyj5Oyxdj7b8cKn8e/muY2HghgK1P1uxlVM2hkAFPbe2ezM6+a0vvVnkqYWiveYWtYsCQ7+8g==
X-Received: by 2002:adf:e84b:: with SMTP id d11mr6162345wrn.70.1633009053793;
        Thu, 30 Sep 2021 06:37:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 08/17] cat-file tests: test for current --allow-unknown-type behavior
Date:   Thu, 30 Sep 2021 15:37:13 +0200
Message-Id: <patch-v9-08.17-cedeb117330-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 15774979ad3..5b16c69c286 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -402,6 +402,67 @@ do
 	done
 done
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_short_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_short_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_short_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_short_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	test_when_finished "rm -rf .git/refs/replace" &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
-- 
2.33.0.1374.g05459a61530

