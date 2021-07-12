Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15480C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F128261186
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhGLQrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhGLQrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87220C0613E8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so26498073wrf.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruqkHLtP3AjQcDLK1MKlkm5M1+OUORB21Gzp5AqNfdo=;
        b=Bq5ZwEc7BreG07qNaFI5pEoQuAawDWfZn6WYnhoClrsSiVC6vXpmlSoGFYJm0GQaSZ
         YHNdM0G8hi7DDrqSuy8Q9pP1QEKHA105gSTzy5hm0Pi+DSShtqXok9sJorRo8g9Ko6Zj
         g0ry1Yc/L5iZ+7OCQBAxoNiMz7vjgcAPvffetW5o+c/iIvB1yuoeyLEg4v8j4QA5PnpX
         06Yc3Yz3wmOw+peV2rZfe/jNSscIQvKPpSQZhoeuEyrXhogo3HMrWlKnoCCLe6WE+MEy
         cBrETu/WeMZrvwDRaBLUCI15MFTd4NIxBKCPE8uflECN3EhJAlR4nNZ9GmKTGl6nDzyq
         f1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruqkHLtP3AjQcDLK1MKlkm5M1+OUORB21Gzp5AqNfdo=;
        b=sy5HzJsyV667WC4KanFo7Qlx2gdfz/KR0SX3KX7gEj9WBrF4JUVXRsiMQuFxxzK3qb
         aenTUh1tjbeM8HwGjxMoHSRXknwK0156BtZssi48unfgQSov3C66FmgwE/7+q+Du12Fl
         2SCTkQF7qKvLv2+DHM4HPLU9esepW7zmZ0wcOt54xvMIDj12tp5lT87+vlImVz29yxpO
         hTHRQHkqXtOYi+LSx3CU3duaS9rIQTRUWMmXCyFVXNEXWbI2OOEX2JjCAXeswIJVYs99
         i47Rfqj2LF75vGy+xkHAzJBTWUiSBtfrsUjJ/OPRSKt2KQFMUxtHJyFB5oo6JY8lE/gg
         utdA==
X-Gm-Message-State: AOAM533Lvr9LEd+f+qcZv4YnE/LYXRKeCdQWrzkZnaF48iDDhdATtx6B
        NMuT6p0EwpRnkY2Wi8i7mBhJb/EMGP1DY0Py
X-Google-Smtp-Source: ABdhPJwdL1hh3/UykCn5X3QPw/ju4XoKm0cRDO89hEqWxxTVvalPsX1cdxVpqF3TLZ2k9zRFoBatsA==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr7641757wru.406.1626108263983;
        Mon, 12 Jul 2021 09:44:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm12988347wmb.40.2021.07.12.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] serve tests: add missing "extra delim" test
Date:   Mon, 12 Jul 2021 18:44:16 +0200
Message-Id: <patch-1.5-67aa8141153-20210712T164208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com> <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the object-info protocol v2 call was added in
a2ba162cda2 (object-info: support for retrieving object info,
2021-04-20) we didn't add a corresponding test here.

We had tests for ls-refs and fetch already since
4845b772458 (upload-pack: handle unexpected delim packets,
2020-03-27), but the same behavior in object-info (which is clearly
copied from the template of "ls-refs") did not have the corresponding
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5704-protocol-violations.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 5c941949b98..95f68e1d4b7 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -32,4 +32,21 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 	test_i18ngrep "expected flush after fetch arguments" err
 '
 
+test_expect_success 'extra delim packet in v2 object-info args' '
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: object-info: expected flush after arguments
+	EOF
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_done
-- 
2.32.0-dev

