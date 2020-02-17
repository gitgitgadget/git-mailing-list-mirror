Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D23C7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ADB2064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOhKdgGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgBQIl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37546 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgBQIl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so18555271wru.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7LEZGJjRIfYsumNABEw6099v9waAI03KQWY0SNTAtY=;
        b=vOhKdgGGvwkylXO1DYdsBPrBLPq1d4sgq9tfeAu9JGxpg2xTnQQDRjSS7A+yweHbaS
         0AY9LGdZ2CExjzY/tnVnqN3kBN4ujJxvEcZ2ub8Sjuxe6JGdlPr6vWOm20iiWiamxWHI
         blFpnjqW+KT1ypSr9/M7QvbPHJya+qbcSV/qg3g5ftVeSoI+22dvalkN8xuPGzUxSR0t
         JAl2V2zjNoF3ayqg2sjj3zjuWKvC2o1YgFePK5KSgJjaRO5aEkmv+bSjAxRj27GFle20
         Kgv4l8yeirXFMjiQML2zHep76OtbYwbzGivhlQ/o91whWiNi3Cud6tKZwv7OL7D1lVHU
         9LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7LEZGJjRIfYsumNABEw6099v9waAI03KQWY0SNTAtY=;
        b=o3lI/mbIHI8dly7v+n/C5xncsX9fNY02I1dDdKA+Y1VKvDDZ/RijECFnY3LyKemywV
         rvYRHpKO9XP7k3kNQA8rXJQBguPYs/ENXCCARQpSKriLwbyDY4fJ47NRjwNNuYbAq8p1
         bUNxnDDSrBCf8yS6ioPf2ZSr1Gb4olOe6Z/ZFLhVsX51EAxSLDeLzsATqxcEI2WHWBjQ
         JbVp6UKCdImNdqkDGjKSMzkrlu9I/IoEZ6BYD6Z21qTzyajgELys90+VNCT0bh4bBWQh
         kv4zvK6hah4XQlvZseclgeGo7PyPTjZwvE4e/FC897613/6Ab/9oJ89/naad1ebUklb1
         jpww==
X-Gm-Message-State: APjAAAUcGCPwKwOIdl5or5ORsclIzE0UjtvRU+qm9wNU8QPxNv7MncfI
        C8iYPLrEyxsAL8JxwsCKBH9/GDDR
X-Google-Smtp-Source: APXvYqzV9HdhKkvbCisSqWygGOBDIghT8IGDi4gkSIYnoyl6+UFC1XTEqMl2H/gDp1GpVEdLpH0VSQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr20417389wro.384.1581928885605;
        Mon, 17 Feb 2020 00:41:25 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:25 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 06/12] bisect--helper: return error codes from `cmd_bisect__helper()`
Date:   Mon, 17 Feb 2020 09:40:33 +0100
Message-Id: <20200217084039.78215-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary
to convert bisect.c exit() calls to return statements so
that errors can be reported. Let's prepare for that by making
it possible to return different error codes than just 0 or 1.

Different error codes might enable a bisecting script calling the
bisect command that uses this function to do different things
depending on the exit status of the bisect command.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e21d3d1a4c..e6bd4d6645 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -713,5 +713,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	free_terms(&terms);
-	return !!res;
+	return abs(res);
 }
-- 
2.25.0

