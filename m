Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26DC433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbhLVENN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbhLVENK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07410C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso510559wmc.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk55bpM17mgXIkTntP3p4FjMecksNEhoxaySQd7JTrY=;
        b=avplrWiV92Wd9rxurGNPNJ0lddDDjwIMb+K0W6ybDY3p+pT4a82T9ZPNb1P2f5wcsU
         X9A6he0+/QWBTWszt8r/8Kqvvs2bf4UFe8XknFfGstYDvVrn+TZKjJUxAm+Scp6U2sWm
         Q64Wpik1ruQ/VpHSSgqFB3wdOhlQhZ3kIxARJhvIWdoOYIFe37kgV2FOQvwvf/3G7PXQ
         +SiS5KAQ8rAQHtuLhHm3CmQM0xqY6cGyJ5yUC6AieL5TxLvYrjaOKQP8zkOwYRmgr8zL
         H4I/vRrMXc2uR6Z0P8BrtOIb3IKMM0uk35axMa8E5bKd02uysyhnpmcPVkthaM4j3nwj
         I3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk55bpM17mgXIkTntP3p4FjMecksNEhoxaySQd7JTrY=;
        b=CLGK226QiuuW7fzL9jOYhASKK8lXpvNScy8pJ9Kt+wSoJqAvwfj4ktI2UPrj/ZGkyt
         n5pc1bDeVvRS8cBKrPnMR2JJpl70ExtKdszFJxY7KMtgF/dpGvhsPUWf5PYKcD30YVUJ
         p4MST3sVr2bBVIU++oL6XnhgURnAmlBuZ72sJpGIi7O7noN1vgeQztUjMAomCuPsObUc
         5Yk1fF/4SIUrtxsHzSm11/4feDziMfhYaR8XwoiJOdlt4A8y4Sji/JS689wzFmgPK/DZ
         ggobIA4grZkeJPuUMV5BN/5tJLjeZXavfxZJcbwLiP+FeWUiIClU6S7KYm1HMW+4kUED
         SLrg==
X-Gm-Message-State: AOAM530NLuksZ8psl+P9tVRc0rQtmmr14Bm15+M2qhhtNyDRYbzL8JEq
        v0I5VonI9F6XqgM83F95WiiemaRbyNbudg==
X-Google-Smtp-Source: ABdhPJwNEheXsfhvWOitO0RCHHmj3U3yn6gqGiCviWNqzaiNTcXnGWBgsundbORWCS5UKyopgs6vzQ==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr775532wmq.152.1640146388431;
        Tue, 21 Dec 2021 20:13:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Wed, 22 Dec 2021 05:12:55 +0100
Message-Id: <patch-v5-02.10-291312e2fb5-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

