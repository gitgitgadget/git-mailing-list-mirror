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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EDC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0F623A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgLHA22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:28 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CFFC0611D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:15 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h19so14383802otr.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omRN6cu9jlXBiqEmC3Q+sivLK1sz2Rnpfu7HmctbeU4=;
        b=gePo0YefrPeiLEtO6BSpzUWMdEsKhEZPUp7GYOSsUdi8D+HWyi4eknQvId4T7qvV68
         Vt0q3sskEQ6sU6frc31fvieG1muyxja+/h0eQOX7ID6Aojj6pu7RSL7A0RoExwUqBtDP
         ftsht4wd/Y48vJhC3RITkivUNxwlO2Xn+WLjkpF8zE6FnaZTLQnji1Lz+Qm2qDjMJUyo
         Aa9JX78GA5/IBtIqIUEoD99heYUn5VuBeo2vdakbOi5JwNqc6IhOyKJT8nyitrYv+C/B
         BVoS6cBk5fkz2jeNWq72wcHsL5JPrshLGSnDn4RxsaSRbI5AM9vp/9r85tp06vAPKFVM
         vcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omRN6cu9jlXBiqEmC3Q+sivLK1sz2Rnpfu7HmctbeU4=;
        b=fOZvs0ee8TcDeRMpqGNhSwg5yI8Eq89+jFW9uETrB6TzZGMiNXaOx1pL5oCvPSOr9u
         XJvvDgYi6JWap51lhbzRG5Ff+QkEXzGwZZoU8OnniZM45JOo6j/VUI6yMyHJsVPlUZlG
         aYeT6SJ9xwJk7fj4RSJhLQewPOj/hrRNQGICBQiIH8nPdb8VpYI5eaESoh+pZ4rYW/z9
         Yuq5hruTYHR2239ryG8ixleyatKfdr8MntMGEqtSpfOGo9Ci5/AoKuvLWrulSkfFXwIj
         Ae9fYQBgrLOVW8by7iP0DY/pqI5VVGAWFEF7Qv5yA/CWI7Aai/HkpyAcFsVHvQeeXe+H
         KiLg==
X-Gm-Message-State: AOAM531TXr8uix9YMoReeWU3wz7cvHIIoGCLGfGOPWL/WHweOpRWTnib
        6fnSP0hOz1jPmer9mfAKvBeMeeOGFQpK4igC
X-Google-Smtp-Source: ABdhPJwMA1+xhxScbjbOBn02E68BxxyyeRsOMdo1jHoV9Llhsz6mYEE4EmzsSNorNvDEajj/LodGag==
X-Received: by 2002:a05:6830:1458:: with SMTP id w24mr2151473otp.66.1607387235031;
        Mon, 07 Dec 2020 16:27:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m109sm3018542otc.30.2020.12.07.16.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:14 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 15/19] pull: trivial memory fix
Date:   Mon,  7 Dec 2020 18:26:44 -0600
Message-Id: <20201208002648.1370414-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The opt_ff variable is supposed to have an allocated string (strdup), we
can't just overwrite it with a const char *.

Functionally it doesn't matter, since after this point opt_ff is never
freed, only accessed, but still...

It's better to be consistent.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index addb454e63..118fbdeb62 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1056,7 +1056,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
+			free(opt_ff);
+			opt_ff = xstrdup_or_null("--ff-only");
 			ret = run_merge();
 		} else {
 			ret = run_rebase(&newbase, &upstream);
-- 
2.29.2

