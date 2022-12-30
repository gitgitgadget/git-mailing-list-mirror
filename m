Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA0C3DA7A
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiL3CTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiL3CTE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:19:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DED17882
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u28so24034778edd.10
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh6Ftz+AHRDRNG/GOzECG9eiAz7D5GORQnv+60g4Vqs=;
        b=UM3v2nT2Zi5Fr0M3RJZUgMPbqU33WFt5NuBRU2EUjSVjK+HJChJFQqCkw48+Sj+ZKU
         +Wv638oCQlA8KrnfCbRwbQYAzSCbFbcf9tAZ1CrRj266FlHyKHFTQNck4HD9yu3p3Ssw
         ZFB4sg8h08XS6G9Y1oLQB1i8t1xR+bzIzqoeo3rAXhXdqqPGUU9d9YFr7CNYdBtT3PR0
         57oq48vJT1POMiDYYNEeBY3VU2RHg/zgjgOnK7CRMAYSzAVjdetmST1jrEcLJsJi5/C3
         5qzOmavz/tROZt+Z0w0InJw8MBZyh3pG/50o9B348D2Ar9wHLxOJDlIyCEpLQprg3cTj
         Ynxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh6Ftz+AHRDRNG/GOzECG9eiAz7D5GORQnv+60g4Vqs=;
        b=5O8T5uAi6vjJAht1FUKkj+H3hC/aIW50MW477v2l1kU9wgI4QbL3nIqzHCeiwlEYEd
         P1IebANvaWFcEUfB5GlaOEypvL+cjF0r7SaIuAwVAhQe6r/WULFIbxvIILwhQ7EMVID0
         2oLajKcyCFzbcnAzybC2HTj+NncQ86q8rfbyPIktRs9W202E0Twm+/ejaLxPArZSSYry
         pL+f9jpH3Gp5FoAVFhSz5xLmoJ9XuFxeKqjamqHzJJF6O7RsCaoxac9cfyUSCB61xRya
         noQMy85pvs0O/6wSlWXr3xtMNVbm3XHx72W1qpHwiWk1+w+bs4bYAub6t/kEM2lPZ952
         zkFg==
X-Gm-Message-State: AFqh2kp7pEcnC34g16KFt6aB74FbQI374Dupvt+W7Dm0PEZ/NXxp/CUk
        nc9EX4pxJ5STQ2WbMj5J5+MEsqfWQBN5VA==
X-Google-Smtp-Source: AMrXdXuHSqj9KTrpMT7hC8R7YoCgOh/EcBFrjCCnLJ8by1wXm4nB0RNzJ1cwis0oeafjDloj7pde+w==
X-Received: by 2002:a50:ee8c:0:b0:47e:6b3c:931a with SMTP id f12-20020a50ee8c000000b0047e6b3c931amr25226245edr.10.1672366735812;
        Thu, 29 Dec 2022 18:18:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/20] grep API: plug memory leaks by freeing "header_list"
Date:   Fri, 30 Dec 2022 03:18:33 +0100
Message-Id: <patch-v2-18.20-3fcf7054708-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1] it wasn't made
to free the list using loop added for the adjacent "pattern_list"
member, see [2] for when we started freeing it.

This makes e.g. this command leak-free when run on git.git:

	./git -P log -1 --color=always --author=A origin/master

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)
2. b48fb5b6a95 (grep: free expressions and patterns when done.,
   2006-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index a4450df4559..c908535e0d8 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.0.1153.g589e4efe9dc

