Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB87C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhLHMiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhLHMiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA4DC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so3944219wra.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t78MdcMpvZ8iZvOrkJ9Mgso+dzkAHUY7ErUSqkghxHA=;
        b=dQhzIZTRhVJoTJBtIuxkvmoM2RuBUr7jTfMkEa7dXbxxRwuDqqQhU6CPbUdevnMBfj
         Jp4J3K/BBHTbn/WVEheKkL1kk98NjwiJV624qR1RsOQPIxC5dEVlLU27VMigndbSILHN
         4eAxQx74z+nILweTQ+LCRXynkpUxHTUypsybgsChwDJMZFKuWmxAR6isgC/9Eoq61R4i
         IhRvrICX/K4Lji2JSIPxi2bJogdkyX5uNeXuRGriontIaVltEfBHRx4FqrIxMONOffyT
         MmkmdsOE5lmzSEyLNAhBb91RMLeKBx2ZFO9HhBNucGvk5epVLtk3thu/jLs073aQY3X6
         EJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t78MdcMpvZ8iZvOrkJ9Mgso+dzkAHUY7ErUSqkghxHA=;
        b=XnYjYduZJv9KlRn/UYmC90DAUo3P5s913zEnVWMfDrzeUbyA2iNiJO2xEPtuo9Rl8V
         dQcp50Dpx9P4cAJyr5SSWSvOxYspjxBLh+Cfh2MQqqwnM/txfoH42clYbpRyz1m5iUcs
         DFW/VqrVWX0cZSzLAvouz2XR3TQ+Inyzsko6PVdcKAxSUXjxlhriQpaf6M3dJJsLtv5q
         4etnpv8D++RmoGG2zwsKeDsZFnIlfsJk1Y8Tr+6NLh2WHXXRsKwmeGYuQ3pmEbKwWxRs
         OOQLGQ7ppbp03gjny7zIpsrowZo9pxrdrD8IGdbRHUhJ+Q7xE+nbNjb3udetb5/CxUCn
         s8Iw==
X-Gm-Message-State: AOAM530gS7daLqaraGveMumeEqjywsQSJv42E6MrChW5fydsjBe2xqwS
        ZtPSFSsswF3SxD+bDDGRrVQ+1i/mb/zgWQ==
X-Google-Smtp-Source: ABdhPJzlLFMEkRkoaSqO0RXYvU8pCmbEKCqsjEQioFGiMrbJzPlagWz6BHCj3w67+x+NgKSci8uWFA==
X-Received: by 2002:a5d:4889:: with SMTP id g9mr59645015wrq.455.1638966868283;
        Wed, 08 Dec 2021 04:34:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Wed,  8 Dec 2021 13:34:15 +0100
Message-Id: <patch-v4-02.10-eb6fa584287-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
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
2.34.1.926.g895e15e0c0c

