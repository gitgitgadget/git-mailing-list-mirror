Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A4C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA03D64E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBOAzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhBOAy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A26C0617AB
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v7so7116762wrr.12
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URUjqn2Bo9nhQNOwRK+sq96L5AapwHMwmkjYXG54kvM=;
        b=j9VWUazW7vUtM0fbP8edM/nQLUD3w9Nv8/JE4zN8uBV+RNrJPwwwLVa4MotPyF/bNV
         Zo0dBGpIy0JX4l8Qkz7fjAt84Wf3TKYET0lhsZxC9p1UyQ3ufwgTR2YtLsWXmhhFkmc2
         ed+Z1cL1IA9Mofod0d5iYYt2cMdK96gNVu6KwU1JXUpL51fOMdQVo3c3YfpoOmBrjnBE
         qdBV/Tl8a0PJOucYbDTulgHh4EltwA93dzhKaO57VWJYt7hAOEXUD/vQDvt0jQg0W8+O
         JxrCS7HY7v/soKyxHs0dpIimcQUVhRoie15RZxUECOn88o/05qE45g4zXFauRMX9R4cf
         Kfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URUjqn2Bo9nhQNOwRK+sq96L5AapwHMwmkjYXG54kvM=;
        b=f7oFT5N6KPZfG/aKDw5dJEJ7FrrFjReaiArAsCU3EB78JBfOfqoHii3tHJ5UyHqSrC
         PQofQQXmHPcCMCu6NOMbllbyIhGkRa3abLkAKoMCn+XG4ndlsMY4V7h4Dd4eKL6FITc+
         9G4yIohtXZ8kmSXmtPesf4LZ5rbtVNRFxuE1zc7DOvIFMEz2ohgXhEaUA9US+JOP36p5
         84jWZrzzUY7p3OYVfG0mJrpgu8YSGfOUhW7KLIIuuffBODRVYpwSFhPReD0794Sv2tHQ
         iZqAB/47VZO20Mfh9WPbOHkl5KjkX98domr/3mHQbfFy8lGjHOx6vtF5B0cWYHiH0tBH
         tw9w==
X-Gm-Message-State: AOAM532pHPHSNHc205pRLaFzz2ZOkl6AgQuwfNXnIIOYCtb6OVgirBNt
        JHUpPEI3/Aj97MCSYIylSb+C9lqrp59JkA==
X-Google-Smtp-Source: ABdhPJyQz6C1IpYuR/m6X+tIq0VBGp/pUxbdoYrO8DWROmdJLkA+ypUqS9eX5F0wx8onmPhUEaF/qQ==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr16229317wru.407.1613350390298;
        Sun, 14 Feb 2021 16:53:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/20] gitattributes doc: reword discussion of built-in userdiff patterns
Date:   Mon, 15 Feb 2021 01:52:30 +0100
Message-Id: <20210215005236.11313-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the discussion of the built-in userdiff patterns to make it
more natural to precede it with a discussion about the semantics of
pattern matching, instead of assuming that it follows right after the
"diff.tex.xfuncname" example which now immediately precedes it. This
will make a follow-up commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e84e104f93..90992e2136 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -794,11 +794,17 @@ backslashes; the pattern above picks a line that begins with a
 backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
-There are a few built-in patterns to make this easier, and `tex`
-is one of them, so you do not have to write the above in your
-configuration file (you still need to enable this with the
-attribute mechanism, via `.gitattributes`).  The following built in
-patterns are available:
+There are built-in patterns shipped as part of git itself. A more
+advanced version of the `tex` pattern discussed above is one of them.
+
+For built-in patterns you do not need the "diff.tex.xfuncname"
+discussed above in your configuration file, but if present it'll
+override the built-in pattern.
+
+You still need to enable built-in patterns with the the attribute
+mechanism, via `.gitattributes`).
+
+The following built in patterns are available:
 
 - `ada` suitable for source code in the Ada language.
 
-- 
2.30.0.284.gd98b1dd5eaa7

