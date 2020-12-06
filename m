Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CCC197BF
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A39A2313E
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgLFAZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFAZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 19:25:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EAC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 16:25:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 91so5065832wrj.7
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 16:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2ZTSvWySxS2pIoV3RsjQzL7KBtb1JQBiJDaBIgVfGA=;
        b=js+9bLCJKxCXe21FGeYfncx4D15eifNQHXztvjrWIt6EdsCrAzqOC21U5vC+8EeRj7
         0vB1U2Q8P9LFMMvo0x9dCOMpG+J5YKMfqy6uvcoAXD/M+DekBr8C86RRj1rmMdUCmHF4
         RAP4CJCEqiy0hfVtDn3mzXPyy60FJO2QMhjgSFMW8QBO/brtJslacmbndAlGxaMSHkTK
         FdPtwDUT+Q/XGihLL5chy5XgyhflnDOTIT6qWfOzYoAWFP+rIZ1ZeM5AlTUjYY3dFaJI
         lkJAagf0GhZmyzx+C3ANi5X8WxvqjJbdJSYlz/wJmE3+wpUvlIRqkAYA2tOFH3Ci1vLn
         Uu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2ZTSvWySxS2pIoV3RsjQzL7KBtb1JQBiJDaBIgVfGA=;
        b=eFcDXdt9Wg8Bfr+PkNWbOZWVyWPsDoM4HrBjv1RciAU6mVeSMUlPAK6jTFe0LWqRdR
         k/1HSKekBaG0da+/lHfiQIzk4EGCdwP5CQhWotwCjtXjU9CZ34vJyHSOtBLobGwryKdW
         +ythz3um16UnP3ebWs7aQh6crWUTxQ3tkGeNP8ecQPG0rJjqxRDjyiE1rD44wftdkDO2
         S4r0DSnmlgMmeoKKryfKjEu2jHX0CJ99XtuTNjIDfkIu+EqtZ1ngNgvd/xh4WzK5HtrL
         fEOeBmwq25Ufp0yxdvqEb535k3gs+i4viY460zr4Q3cGXTm7WG56th86GBnQdM8LC1ZX
         +MqA==
X-Gm-Message-State: AOAM532VGG6zMmLH5dXWwzwvupMMw84NXiY8OMOpdV2fJqekwNBbiMHZ
        JICeeu4Q9MB8ZkpFfxSdDok76nakyGdLTQ==
X-Google-Smtp-Source: ABdhPJx6JBIfpeVH377pOCzJvH2SwxlTqFtGtOLxW3jm4IPjB6xH3nUdrA1m5+7bLT4dppcyRxNIoA==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr12503103wrr.351.1607214305234;
        Sat, 05 Dec 2020 16:25:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm9144338wrh.78.2020.12.05.16.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:25:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] pretty format %(trailers) test: split a long line
Date:   Sun,  6 Dec 2020 01:24:45 +0100
Message-Id: <20201206002449.31452-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201205013918.18981-1-avarab@gmail.com>
References: <20201205013918.18981-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split a very long line in a test introduced in 0b691d86851 (pretty:
add support for separator option in %(trailers), 2019-01-28). This
makes it easier to read, especially as follow-up commits will copy
this test as a template.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 204c149d5a4..5e5452212d2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -717,7 +717,12 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 
 test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
-	printf "XSigned-off-by: A U Thor <author@example.com>\0Acked-by: A U Thor <author@example.com>\0[ v2 updated patch description ]\0Signed-off-by: A U Thor <author@example.com>X" >expect &&
+	(
+		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
+		printf "Acked-by: A U Thor <author@example.com>\0" &&
+		printf "[ v2 updated patch description ]\0" &&
+		printf "Signed-off-by: A U Thor <author@example.com>X"
+	) >expect &&
 	test_cmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

