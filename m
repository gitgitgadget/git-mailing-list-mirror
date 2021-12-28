Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhL1N26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhL1N24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F322C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o30so9100157wms.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeznOIXIBoSdXHQ9eIavrY8uZtUsYtdzb0ccd7m/Sh4=;
        b=C8Z1xgc3Dd4k4yMxmQwFJuNix6zGA+eRF6ym93RfaDALJvEsDov5fybA5AhzHp/NuX
         sYWJFkruxl7C33ULqQYCxO2tUMhNMagQDIcx4fykod1vhyJ88wvomZYMmcW0k/0Bw2Qb
         xX9LulD8jQq92oKlsmWOr6OpUlb2x8g1T0/e+b3yZhB4gR9JEAOLB/Bx3NxT5v1E69o3
         pg//7c72Ww9/gBsmShVs2V+xET4PFq+rGUaWhsi+m93vgJ/oQulo1xUppCqThyX/CuJj
         t+39SHlZt/TY24q8FDltO+MDWnCYfm58E728B/raCrKRFhxYeHuOHTQo4j7WoBgJaSru
         WRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeznOIXIBoSdXHQ9eIavrY8uZtUsYtdzb0ccd7m/Sh4=;
        b=ENuzNV3ZtoEr+s7jUwtlfd+39Iev7HbWbDdQjR4dFInQkYQlf1N5vo+uV2PPJtgHfE
         /UCeVTqQH0pl8gnl/ylRypHxt8jP2N+DF+bm3D4He0aAayrAKUtGwOWBMHWZ1+x0TUZi
         4vl1F3UrothQGP3eBv/qGpoX7cq5H+3Kz24FG0v5CF6PQDg4Td6hsdv3dSs3178JtRQR
         n69bP/MdWnPVxwTtVtDVaTieZufwcEirQeKq6KKNYmWtt633iVp2VS/eze3XLaHpKbqW
         UOWU3LiE/yZMkFIWqNjpvdtX1s7kHP39guRx1PU8iRieBN2/zNCHB/kCJuag2FiVSDCF
         fi2w==
X-Gm-Message-State: AOAM532tTBa4sjBNdy6nkenKizlrCgtvkI3oY1yATPmICWjlHBtMuvUH
        2HX4qxYBh2NoCxhcxk51L+VRF3tv/ESVv7ju
X-Google-Smtp-Source: ABdhPJxWtl9AFqXUGCVGK0Pwp0i1AdYK30Cl/ammQ2ONJzmlZNcEZl8ou5rkF5jY+GanLniW7O4nCQ==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr16660028wmq.195.1640698134503;
        Tue, 28 Dec 2021 05:28:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Tue, 28 Dec 2021 14:28:42 +0100
Message-Id: <patch-v6-02.10-02622592803-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
 t/t8007-cat-file-textconv.sh | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index eacd49ade63..71ea2ac987e 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -19,6 +19,48 @@ test_expect_success 'setup ' '
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
+test_expect_success 'usage: <bad rev>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2
+	EOF
+	test_must_fail git cat-file --textconv HEAD2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: <bad rev>:<bad path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: <rev>:<bad path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'usage: <rev> with no <path>' '
+	cat >expect <<-\EOF &&
+	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	EOF
+	test_must_fail git cat-file --textconv HEAD 2>actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:one.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<EOF
 bin: test version 2
 EOF
-- 
2.34.1.1257.g2af47340c7b

