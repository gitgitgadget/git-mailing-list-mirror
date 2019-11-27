Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA38C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AB2071A
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsGg5ZZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfK0CJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfK0CJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so4562514pll.13
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEBQ4SrCH9y+VGLndRCzMRAkZ1/rR3U/yXLtaXzvIVY=;
        b=hsGg5ZZIvdCDRVzT39qOms2BvcdggkFgZ7hlM3Sqc1bhSnBYxl3iLm8/XqD6hksbu0
         P3IjLuwuA+1V/AQaciz136VQ9OUgy3PoENgrwEohvY5qPTqpeCZHVrX4DRkCGgC8FMw4
         fV6Yd6nJqb58R9HCcTztGtrlGZvbtila0rb1OeQo2+7s+9KF6AQ4UUkhCFeVNrsG2koy
         qvpgLkRhtZFiOdlBEStGkLTc85ytceGAvLhGm/IU9RLkfkhVBjy/sxqbun0sUacH/4jl
         CEidZmnFOo6QUVLt8VKMB7M1km72qHtyuZSCmfGvJ4MhSDvpdfk+5A9Q/PPuhI2J6+oP
         EzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEBQ4SrCH9y+VGLndRCzMRAkZ1/rR3U/yXLtaXzvIVY=;
        b=reo+scbrsU2lF80cIJ/QE/U/QsB7QU3VtsZzFOFs55WPeqVrZrCK3kvESFcMzbL/4g
         Z7eMBdNtu2ObpWFUnnEojUhG+H2XaD1SQXBf89IdhY89KxQMThCm8UTTk29rQPt25635
         min71MvqpLGWBGlS16Kzt4uVZh4p2CGcj7DhL3ALvX0hHzNIH7uG96YCsU3qCifHdOZr
         b0n6rV8Og6u/O7WKhEUUBKw08VQYpx20+REQruP50HZ39/rbPAu6ejGxQVfG8YzKbyBJ
         0T8lfq2aW2ceK0zz+d4XKnzKmxmmC5NcZzCs5jOD2dt1WJfIuyTGmboklmPpf/oMv/ir
         AYRQ==
X-Gm-Message-State: APjAAAWvS765JbUktP3jDdW4J3cofHjsoezS0PNO128yhWTJ2pm2be5g
        yaG+XmxG85GjBO4kD12JNaITqKyA
X-Google-Smtp-Source: APXvYqwz8CJMeLJmduijPg/UIgtolxiYs+iJhfn+bXFxpbVHcyecyFnqu1EjDtuFX2PgjW6710Wu+Q==
X-Received: by 2002:a17:902:d696:: with SMTP id v22mr1547128ply.66.1574820554624;
        Tue, 26 Nov 2019 18:09:14 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id t27sm14252046pfq.169.2019.11.26.18.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:13 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 1/5] t3400: demonstrate failure with format.useAutoBase
Message-ID: <a1741e54346a387a65e272f0210118ce81475358.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since bb52995f3e (format-patch: introduce format.useAutoBase
configuration, 2016-04-26), `git rebase` has been broken when
`format.useAutoBase = true`. Demonstrate that failure here.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3400-rebase.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ab18ac5f28..ca99e8c6c4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,6 +159,12 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
+test_expect_failure 'rebase works with format.useAutoBase' '
+	test_config format.useAutoBase true &&
+	git checkout topic &&
+	git rebase master
+'
+
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
-- 
2.24.0.504.g3cd56eb17d

