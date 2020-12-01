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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1755C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F2320857
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2llBGEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbgLAArk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbgLAArk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:47:40 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD5C0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:54 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id x16so9515oic.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DopMMy+2qUcp0dkDTtyCKQQ8s1AtEjNmYwhRWV0mMFI=;
        b=f2llBGEVzDaEOPVthXS8GcIEf9ylUFdfnltMSQCd0ye/B5ESXfZGkwmHTMGy9YEDad
         7Oq0jF4QGJ26iUfGgVr5uIX0s6tm1XHvO74pR//HoNKucSCjScAXcw2wDAfbuZYnpmQd
         ZtSbvbVL0n0vKqDsdrfzyaudiravX9y0OoE9jFsiZbqGZ8inc2e+D5yIjU6ml3fhQFiY
         lMnX/cBcR6JdnKxqk/uvJtv+j+rtUHmc6nz5ohEuxGelVRWodIQPNyfUw6zhoAsd+IWf
         yiCai+voPlJ1ZJJUiyYg+MwfxbeS5eAtbkIezx0HAqmzAvDXtvsAqTs7tiRECjdy3dIc
         m0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DopMMy+2qUcp0dkDTtyCKQQ8s1AtEjNmYwhRWV0mMFI=;
        b=rFthTq/IPmGtNrLltOGPoefuW5/CIcvV1cyzuAGpDR8mMzlKiOLnRFJH6NLeqJF16A
         Tygm81vz6g8r/Sf+kiN7UR77aWeVAVRjB4+T481xVNkRBLr+REmdT/v9HZBlHibeJQrz
         KL5QOzGqL5p88ZPfqHEgktuDfB2/cnVibw9gZQ3Q3+tVeT4dl2Ll4dgk7ZI06x2hT1vZ
         idnRomFM5eMD5CoTI1bGKP0qLeDCsKsmfwludBg/eeMiqyOH4R9cUaptdWOzrYiZJgEi
         KSUcVxl3pqYwgActYAZmMeAVG7p+rIpDUY+PJjhEfPhBgrOusXeqhEgfQIUA4A7McpvN
         awVg==
X-Gm-Message-State: AOAM533dtL5ng4T5X+V3GveakMkmY3+d9VJvafO2AaaN7Cz4a9Sic1It
        Fn4D57k96Gqw2DYnHpQCyjLIJgDzbM/t5g==
X-Google-Smtp-Source: ABdhPJyva2RxvCjdGDwjvRt8SQ8bPLq/S6onbbTlTqXI9urzvRZLgvuB9YbepHTTszCtahpr1i1FiA==
X-Received: by 2002:a54:4608:: with SMTP id p8mr182996oip.5.1606783613290;
        Mon, 30 Nov 2020 16:46:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d32sm6619otb.24.2020.11.30.16.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:46:52 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] refspec: trivial cleanup
Date:   Mon, 30 Nov 2020 18:46:46 -0600
Message-Id: <20201201004649.57548-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201004649.57548-1-felipe.contreras@gmail.com>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can remove one level of indentation and make the code clearer. So why
not do so?

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 refspec.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/refspec.c b/refspec.c
index c49347c2d7..d4823dbff9 100644
--- a/refspec.c
+++ b/refspec.c
@@ -272,15 +272,16 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		else if (item->src && !item->exact_sha1)
 			prefix = item->src;
 
-		if (prefix) {
-			if (item->pattern) {
-				const char *glob = strchr(prefix, '*');
-				strvec_pushf(ref_prefixes, "%.*s",
-					     (int)(glob - prefix),
-					     prefix);
-			} else {
-				expand_ref_prefix(ref_prefixes, prefix);
-			}
+		if (!prefix)
+			continue;
+
+		if (item->pattern) {
+			const char *glob = strchr(prefix, '*');
+			strvec_pushf(ref_prefixes, "%.*s",
+				     (int)(glob - prefix),
+				     prefix);
+		} else {
+			expand_ref_prefix(ref_prefixes, prefix);
 		}
 	}
 }
-- 
2.29.2

