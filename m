Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1079C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87542076B
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4w7NJhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIWH2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWH2D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6EC061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so5978636wmh.4
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+JmQMk+e2m4npZedAl84xsb23PB90uGmu0PhUZk5L0=;
        b=b4w7NJhxEbIFOHB7my3zrwDsuS2nFfFDguYJdqIyDLnjYWXAEX7hhkLH7rGkZ6wq1r
         1TwbuugMt+kKVlHK6Tp5gsvfkRTC9pbUUpEAqj4tGny2dPdGy885ws9fNwcEzFEy2UHb
         gwY0xmLTUEFvPHaCFLnvKEQxhO+M9owh3g3KtBNqYF4BaDETfL5pJqs/G8LShKiVRmDL
         21SxK5QHA0Gzgmlfarh181fdtK26RaOXUO32fj2lQ7B0Hi3V5KcnVhnhUpSXG8CN12Td
         0Kdnh//vAm3Mey4WkppzXiMjxMZRa5X3jdG7beDg/opKM7qUs0v5geuHm6toVY8hFtcf
         ICDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+JmQMk+e2m4npZedAl84xsb23PB90uGmu0PhUZk5L0=;
        b=keqkgvAmpNrmC/W/lzPcaUBCoZUq1qGB0LxJRP1nlHtyHjy8lWvfK/rsz/wI9nkKiS
         Tzbsj50J2cP4yiOxDmlSBakKrrSUSXoExBCC4ber8J7c3cdo9mXUiG3d42E5vwDyTU7k
         +vp2NFSjUl3X/F0s9HymXBbCY1VSTeuetOno7Glt2cRxJ/qFGlRTlP15Gio6tXwi0JDM
         0i1rGCWKZbVVqg0gTk3yLiDY7gMFetIvFWtrFvDo+OMfiR4BLme5yj0zo4Q6IW99B5SN
         TPNf3SZbnTz7TRm8h/fAQYhn6++JjZcxu6fRbUIaU+VTr1tsW3+hX1iT2woDmN4FXypS
         crFQ==
X-Gm-Message-State: AOAM530G9HzT7dSR1o12+tAXqGyZg6J9fuj68qTy51qez6H2mPr/KmF/
        ro2VbLMkb4PyEu3gzXVAYdkUHWauVik=
X-Google-Smtp-Source: ABdhPJzMMxew31yEGz55UwxpteZzpIAkmaGPbfJIuiY8qBP+CNZI2iu8VNIsNsa9prN0MtMYYaOQhQ==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr4660949wmb.80.1600846081635;
        Wed, 23 Sep 2020 00:28:01 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.28.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:28:01 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 1/6] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Wed, 23 Sep 2020 09:27:35 +0200
Message-Id: <20200923072740.20772-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
References: <20200923072740.20772-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, if an invalid or no
subcommand is passed there is a BUG.

BUG() out instead of returning an error.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dcc1b5188..23a9f00035 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -720,7 +720,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

