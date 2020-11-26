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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F6C64E75
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298F421527
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqAwQ+mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391796AbgKZWXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391790AbgKZWXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FCC0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p8so3689938wrx.5
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+Oer4GSRchoXVNYtlL5I1oxz4Ket+on6CG5jj0l5gg=;
        b=DqAwQ+mAUtU4be5q5cHC/iyY/OUC8f1iJy7pp9cVS+zGKtmNgAQkf4lcvTHiZU4xAQ
         z8qZp5xcxVRnVNzkAq1pXVxRfzOY40TuhJub6tbRSDqS4Wi0DNomOBcXCIsBcGsGe2LL
         m7vFFn+7d13fMaEXBmZWAF261Qq7poxm7Wedvcfa8xMSShMmAoRTREgU4tWRW49KEs/v
         I+t9yXxQufNc9qcw2dKEvkGHIrWR9JtGTuS288LSlCz2ht0Oss9OQwK1dmpGLSeyv5dK
         IxCfowsyFvc3WBkeTD4ILdtc1C5nQOF5kwaYrLncHxkiS8qSX+TLLxESXSF3yPSo9Qew
         2Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+Oer4GSRchoXVNYtlL5I1oxz4Ket+on6CG5jj0l5gg=;
        b=XgbTb9X+iDjnU0Jv2YOaNJGDdmmg3SQEvBGIEzxqLVs8P4aYCuniyGkEAoAw3Ej+YX
         oijLBvHft4AjTzQYQaMBjNMO2u8mnX6Jeiz0AXr9byd2UFN2Bb2g4fktOqEEiozGimN/
         BbEykTKUqf1XrIRJOGrjtsHpSQDPduqeLQ4NQ2BcVZ+BLyXpIXk4NgaqbQZxDIFOHUf9
         0dU8213MQh4VTmWhaH7FMFvoLbuJ7c1t8plvfUBohQWGoPLbI26Ex/St0BWBroHql/sG
         b1P9lLeDQ6//2JcEH2QyBmiS3OrgrbGiKL3N4dTYlIu8ddJJ9NwAoDecVvMNuKhi1/9p
         NqHg==
X-Gm-Message-State: AOAM530Ps67TEpJ1Xudbdo3mSCj9xhQb1dK++Bz6vl6qWutAR6gVCq4M
        f5wfPxV6dPFLXofwFtuG5TMCGsFgZgs1vg==
X-Google-Smtp-Source: ABdhPJxRl2tY2Zopj8jH5yope6QzSnxCu43QowWkBucr8tL0GIwa8/zQG4eublciEKY5ouM2qhUp7g==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr6722776wrx.108.1606429391767;
        Thu, 26 Nov 2020 14:23:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] mktag: reword write_object_file() error
Date:   Thu, 26 Nov 2020 23:22:50 +0100
Message-Id: <20201126222257.5629-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error message emitted when write_object_file() fails to
make more sense. At this point we're not writing a "tag file" (which
as an aside we never do, we just write to stdout). We are writing an
annotated tag object, let's say that instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index ff7ac8e0e5..603b55aca0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -171,7 +171,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die("invalid tag signature file");
 
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
-		die("unable to write tag file");
+		die("unable to write annotated tag object");
 
 	strbuf_release(&buf);
 	printf("%s\n", oid_to_hex(&result));
-- 
2.29.2.222.g5d2a92d10f8

