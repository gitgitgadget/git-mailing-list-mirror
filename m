Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B91C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FABB603E5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKLWXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhKLWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CCC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso7860902wmf.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULeEJ+GGfls3mKqEWfCuuXt7Rd5F0AJcwcwRHoAsLQY=;
        b=ipqzks94v+yW0WR/7oMmGmWgq9C6unKVNrk7w66nZddQkQfv7ym8+EdxNE+qRjHZHT
         01L/8x4D0ONY8ERb4cS8dgPWi+EI+axM2N94qCrFN9InyKYMzYI6ah+wnYh2cJpwJabj
         EhIGmh0EJIcgTLxg4393CkcW47wZC8yq4AX5jc9CSUoVLtpjcu/17e8Swp5ErRvum5gK
         hGhCz+xLNF45zk5gQidEH7f3vapRpP9vNr2piP0GCrtCRW8k8Ig5PF4+cAFp5ee6/RGP
         yij4JEes/6MMjEvJNxHOZqF4iJuwnXxqG6+v9pUnVNHR9TrTSh4LH8+K9M/dK6K6IOEg
         X3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULeEJ+GGfls3mKqEWfCuuXt7Rd5F0AJcwcwRHoAsLQY=;
        b=hv6n90Jx2+K/sR3LOpFLqnJpYFU/RHPg11Dy+aUk8B3uw/jeCWnDq7nBF4BsZ5pT1h
         9tWAyKEha5bq8ehYu+SPg+HlOpBVDTZntr0STnK/dmFIJQQPowT2sXBbSxbtlNoIqIb9
         xoe0Mhx29Lf5opvjCymXcRY8V9KvZoiHPTLRy6yVnQ4zOkBc6YON4sgnhPaDhXq4X/RI
         UMHZFzLoU8+RKwpu3Hdu5ZwdnluMLd53iC5zcWgOytG9M466stEjwd9H3qSzVp/GzfEI
         yaQtes9FEPgor7ohmHttBG6jXeIGmyMmi9pmT4Y8EC/wy1PYc5/DxR5QpcT45A1cTo0p
         N7yQ==
X-Gm-Message-State: AOAM533K4eVF56h4cO5ZsLJ6D83V50s9244kpOYu9qSHSsUTlcs3n5Yt
        KEc9wakG48ESx/qXIye1KyKuyxsXoRwlTA==
X-Google-Smtp-Source: ABdhPJzjubBhZQGErGnY+8PgS35T0FBuxS8/lsGy6nlO5uqes/2N3p9YfFehX+Vcq0xvU1a8NG5bmw==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr25738031wmc.187.1636755653046;
        Fri, 12 Nov 2021 14:20:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Fri, 12 Nov 2021 23:20:00 +0100
Message-Id: <patch-v2-02.10-fc8d5e60682-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for the output that's emitted when we disambiguate
<obj>:<path> in cat-file. This gives us a baseline for improving these
messages.

For e.g. "git blame" we'll emit:

    $ git blame HEAD:foo
    fatal: no such path 'HEAD:foo' in HEAD

But cat-file doesn't disambiguate these two cases, and just gives the
rather unhelpful:

    $ git cat-file --textconv HEAD:foo
    fatal: Not a valid object name HEAD:foo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t8007-cat-file-textconv.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index eacd49ade63..45471cefe73 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -19,6 +19,32 @@ test_expect_success 'setup ' '
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
+test_expect_success 'usage' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2
+	EOF
+	test_must_fail git cat-file --textconv HEAD2 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	EOF
+	test_must_fail git cat-file --textconv HEAD 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<EOF
 bin: test version 2
 EOF
-- 
2.34.0.rc2.795.g926201d1cc8

