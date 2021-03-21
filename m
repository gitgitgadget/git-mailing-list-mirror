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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22623C4345A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1012961937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCUAC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCUABo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F321C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so12860402wra.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2fQmiAYcWUUvS/92SmfRXI2NcSVSZCns4taAESp/0o=;
        b=rtylKM0tsXFJq+z2HHWlQMOUKUndf0mYIUgpovy4caayCDAraGxBMJ47uCgFIENbff
         5iFex6+fOo48A+2XUXAZLNnAnatlrlD80+tF1XmUq3khQGAO+CXXxXjFnkfeshoLvdfR
         2i6HjCbzseFrpc1tf/lJkqKOHtJxHy1aR4BaVFFqXQKRgF71i03Qf3VJWV7Ue6kvytmG
         9odzV8Eq13TdtUBN9Z2M3gMIE30eeWjISpN/kK+KG8GJhF9h2jkjdHYxE9pQc0a6Fecd
         JCvML36l9c3VvSIuHmfq7a1LdAupkfUACMqn8rZvYgQZmPNmwSwl2ZaX/i8X3y7YLdMO
         GxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2fQmiAYcWUUvS/92SmfRXI2NcSVSZCns4taAESp/0o=;
        b=WQDk8G+WfQFK+4jglFAAoHU0pHqXjx0yEC/LXjOYn7NuyxYia718+fBnMo5dLU5Kr1
         dfgcNvGOX81q3qZVlhb4+tZOENiONg9j4IqLHjIeSfwASEEQhAEEpqGiOGgpm/0bot2+
         3VcJfp6VRpwSlZuHLxsS0mHEF0QxcHY0N1gS7RdXnORmcedBvpg1CuqVx/fNTJ0rGTOn
         GTrO5G0EFXk0fmKF2cm88A8g1zC+MGGBBO1n8IUHL6twrZtlC2TITsa0+1yyVAR4z9Rr
         V9iF3ej3VXdgqr0XMHS36HdS/WJyluy0Lewl9CJUAMfGFlf6CdZq4U3tZExVWIh3QV+L
         51ng==
X-Gm-Message-State: AOAM53349zLiOymNGc88ayCPHo3G66XqBVWlzBfxxbJVB+HqX4PWH4/l
        rKNpZPVwn87HWXnPfykF6nOhh33DsSQejQ==
X-Google-Smtp-Source: ABdhPJyBRUTgNV1mxRJz/1eerpMEIQP4Yh/apC8gYUdvMiW7gOSQw5CouCAUmFDEpSLuFL/L91SdyA==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr11065845wra.103.1616284902697;
        Sat, 20 Mar 2021 17:01:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 21/29] match-trees: use "tmp" for mode in shift_tree_by()
Date:   Sun, 21 Mar 2021 01:00:54 +0100
Message-Id: <40f37e99cd9a5384330a1155f6892b0d64b7bc49.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 85e51b783c3 (Make "subtree" part more
orthogonal to the rest of merge-recursive., 2008-06-30) to make it
obvious that we don't care about the "mode" here outside of the if
statement it appears in.

That's opposed to the sub1 & sub2 variables, where we use the two
object ids later in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 0faacd8f4ae..e84f993a460 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned short mode1, mode2;
+	unsigned short tmp;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
-	    S_ISDIR(mode1))
+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
-	    S_ISDIR(mode2))
+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 2;
 
 	if (candidate == 3) {
-- 
2.31.0.286.gc175f2cb894

