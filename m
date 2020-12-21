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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B98C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6061F23103
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLUSGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLUSGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:06:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12502C061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:05:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so11983028wrc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHq9AMo3CFiCCxTUtitw3dFzzmnOH2TkWTdN8FLeSi4=;
        b=Xcu6inlvCPZ7lpZtGokuvPALc8YiY1VBa+TyOIBrpI5GDRGBamjMAi2wROjrSnc7Fe
         2auCJ8NzegQ5hEHuz9HJ0N2WTlU9vXa5FkH3E9xq4zh7U6DEyL3/n45NWY8x1Qh74mKx
         uH1MVQ23PH0QEMNyX3Jk+doZjIJdulFbRm0tFIXJ3VIfG2ScnNfpROwhKSv4JdHRXesd
         VGurxuaGzvWhzU3sKdASMrz7bhGqOyTFYKUc3eXQySNG+Nyk9mnZceIDwW3fRSJVSNFK
         HcAe/JePeXdd8rwkK5NqJg95GKOSgzb3T0RciHRPcTPoDvo7ITODOupdIqhOZys5EAOo
         808w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHq9AMo3CFiCCxTUtitw3dFzzmnOH2TkWTdN8FLeSi4=;
        b=ShLZByr0yN12s3mxTadNhE0hOUEs9sS34b3oJdC7Aqp85r9xf2FZKEiQHSF7I3szkH
         MM/uTF7Z+13R0dBqfp0fuo6UQta0tqoRtkxILm4Grr0PibnixVSA9lcyE3IcITyaVmik
         Kq5rkbXbaW5WLNZBxCuw8GhWxYWn6Zqm3U9VJi3MLAf1D5KhB9Zv9Q/C5qN1ePtE1wHv
         Ru5RBHPPDJSwJqOjbVwdRC/fI8OZ0hForf6I8Pol7yI7WhbBqFE9Kk/88uL535Slmacq
         tho4aP5cV8Bk7g54ulqaPAVmSp0GmmNcH4wj8JE3sC8UbreqsW7BYgzRiOmBtJSIqMi5
         Vl5g==
X-Gm-Message-State: AOAM533SFUAPwLh8jzg6Z6qDUM/MhDnXAtr8PKA2BSMJKjHetLgO8EQ9
        AasDyfzKY2fc61rREDkvdBbuuQ/c45Y=
X-Google-Smtp-Source: ABdhPJwUXyNW0ddI18EBhWHerCXqswVTE1JaVomzY3AORu/1ZxezmXeJJNQopeIkqdjxHEjM7S8dpg==
X-Received: by 2002:a2e:535a:: with SMTP id t26mr7369293ljd.455.1608564058505;
        Mon, 21 Dec 2020 07:20:58 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:57 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 22/32] diff-merges: make -m/-c/--cc explicitly mutually exclusive
Date:   Mon, 21 Dec 2020 18:19:50 +0300
Message-Id: <20201221152000.13134-23-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-c/--cc got precedence over -m only because of external logic where
corresponding flags are checked before that for -m. This is too
error-prone, so add code that explicitly makes these 3 options
mutually exclusive, so that the last option specified on the
command-line gets precedence.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index b8fd92adcf16..e3c0190ebd95 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -8,6 +8,7 @@ static void suppress(struct rev_info *revs)
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
+	revs->combined_all_paths = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -29,12 +30,14 @@ static void set_m(struct rev_info *revs)
 
 static void set_combined(struct rev_info *revs)
 {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 0;
 }
 
 static void set_dense_combined(struct rev_info *revs)
 {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
-- 
2.25.1

