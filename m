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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B83C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C110664DEE
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhBOQC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhBOPry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B34C0611C1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j11so6588965wmi.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUCKl9yC1C0kc66VAZCmVD76YM5Vh4qU7Lwg6ageSZc=;
        b=WwxYeivdv7jxTOh5SFFWYd631+vsYIH0fQlFkDYC9ALrYAcY6oUDtNXZ19V89yNvkW
         93U9BF5/Va9UTuOTfzAqPsJI+Jl8//21Tg6Gf3WqRNiMvPBq1lcLtvUmkyr1trTN1zz9
         vRO9qGU+JbyUFhO6M+wbrI2u+HhbiMeO0SlCBYTxFrUCHD6IPwgNPnuDx2VxBqLpOO5M
         I4sTb3RtmJW8cQ1UsrfVZzCeg5RKFRnsDZ9/0Y6mGpJqOEm/I2XdkySLO4O6POEIYVEH
         +lC9uKfJJT7TT+/nIGjwGSSRynhFr7dXWX16mDcMYKTXEnOqH5NVi+tUrZwjZntsr0g9
         v1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUCKl9yC1C0kc66VAZCmVD76YM5Vh4qU7Lwg6ageSZc=;
        b=cH0wDqHNMlVing3bSK3aH75vq8R2vb5WMmoSmizyGahxBMWB6UHDYnXwjVfxNpGmhP
         2mzwv0H4YEZ5HD8w+Fu3K6B/k+E4STz0dF00osEYOKSlZ9KWWSDWn41HwpQW3L16lrPl
         tTTsKOjaItBet2ho6j0SkqLfL+CcllsP1Hef+0lY8H1Y2/MbGWo+kSTTf8oPuaYszMUh
         HZfROGB+/GX2EXzmUeV48/FYtktrV6ClWyqaovNnb2Ds5MH29C6YIORxr9+wDYG3TvzZ
         PX2ZwA3/JhfBVrHq9ItEBQWpl+Gktenc4UIgdJPFqe5aar5ar39zOdLFU0V8LMaSSk73
         OzTA==
X-Gm-Message-State: AOAM530C6A4BeCXen5PNWpMrRbDPvJ/JYztJ4acxYtxaC8lIDxaXjfPB
        XtzmULHIWkGvhM/bS4X1tBQ3DKbWX81Iuw==
X-Google-Smtp-Source: ABdhPJzxntbeGre87b3707+6HWE0pxDUN+wxw9pFgr7Z0VPoos0upoMwQ8YRl+osMdyYQu8gLEyp3A==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr14636782wmb.53.1613403901144;
        Mon, 15 Feb 2021 07:45:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/27] gitattributes doc: reword discussion of built-in userdiff patterns
Date:   Mon, 15 Feb 2021 16:44:18 +0100
Message-Id: <20210215154427.32693-19-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e84e104f93..62c1147ba9 100644
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
+For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
+configuration file as discussed above, but if present, it will
+override a built-in pattern.
+
+Nevertheless, you need to enable built-in patterns via .gitattributes`
+for the pattern to take effect.
+
+The following built-in patterns are available:
 
 - `ada` suitable for source code in the Ada language.
 
-- 
2.30.0.284.gd98b1dd5eaa7

