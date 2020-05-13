Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C8AC433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA1E20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7DdTy50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390017AbgEMSFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E559C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so132164qkh.11
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y19IbOuhZIRTyyoU2VZixeM0uKga7ZpB7g+fevshc14=;
        b=p7DdTy50zBynwwGBtH9/zHVy1mQhf/mY8w2wF08Jb19lIClsmA3SJIaVkMjsrGn6pf
         bKQdClr1nYZwF6Zd9h03XaIEWV5JM1xrXGQU3a3VF9Mvw5HlVH/2OEl6fMpRwF18RqG1
         QTUaxSi1d0RhGFBn1YMuiSVTtFxtJmnSFFdibaOuMA48r22dqFyphmNDK/LAYzmkdyMC
         e2gb5fXezLJ2X570CCCiACykm6Vg9+vetSvwA9TzO0nzAr1CHJbAWYAqxFvOHKWKXX7C
         cT8ZxCeRhIBoGPy84pDdWiN4rLJh8Fw2S4LtXnTNc6ZJi70FPQl7aRh8la0ow4OCNRyx
         7cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y19IbOuhZIRTyyoU2VZixeM0uKga7ZpB7g+fevshc14=;
        b=cUwdpziy48vq09pznFAmd1dnnHFNyJShyHvLcHIFZuDV5Sxws8Hr+VwbAmc9QZjN3H
         J7UKS0+t+Tajznwx8YsV2KiRizNyth84HewphT9Zdhgcpt51QKaOMstwqGDC1RY/qxLI
         hweSIw17HYulcVxkWcVnwA5hZtQhWvnnfiC6r8KPJ8uf/93wcylVab6ygomifGGDakrS
         yK/YIPosNobPuKsQSLl9rz01eUv9gXcpAatq3iLK8A/ecuYKpJ8NVC4JecWWfuXChkzF
         mqExLml1UTq5VYC7eXHNwjSjga7TZbsIXG+ajKku2umvg60JWbGLl/mwTaI2xU2ITGlS
         /mGg==
X-Gm-Message-State: AOAM533jpdNumdN14PGQPYIpuqxwV4NrGLwV/tI2SGIHi/OQWHDAMv0u
        T7I6Osmc3nL4qlfgqhiduBYU/y86
X-Google-Smtp-Source: ABdhPJzmB16CpbAbhXVhditc23XSudV6/jt6d3EmypNpeJU2IceW61+XsYCrcXlDG+INcYM1CiVifA==
X-Received: by 2002:a37:7dc4:: with SMTP id y187mr934271qkc.412.1589393111726;
        Wed, 13 May 2020 11:05:11 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:11 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/6] transport: combine common cases with a fallthrough
Date:   Wed, 13 May 2020 14:04:55 -0400
Message-Id: <c89c1841008dfc2d111369fb682b946a0c33b7be.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the switch statement, the difference between the `protocol_v2` and
`protocol_v{1,0}` arms is a prepatory call to die_if_server_options() in
the latter. The fetch_pack() call is identical in both arms. However,
since this fetch_pack() call has so many parameters, it is not
immediately obvious that the call is identical in both cases.

Rewrite the switch statement to fallthrough from the v{1,0} case to v2
so that they share a common fetch_pack() call. This reduces duplication
and makes the logic more clear for future readers.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 transport.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/transport.c b/transport.c
index 15f5ba4e8f..475f94564a 100644
--- a/transport.c
+++ b/transport.c
@@ -370,15 +370,11 @@ static int fetch_refs_via_pack(struct transport *transport,
 	}
 
 	switch (data->version) {
-	case protocol_v2:
-		refs = fetch_pack(&args, data->fd,
-				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
-		break;
-	case protocol_v1:
 	case protocol_v0:
+	case protocol_v1:
 		die_if_server_options(transport);
+		/* fallthrough */
+	case protocol_v2:
 		refs = fetch_pack(&args, data->fd,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  to_fetch, nr_heads, &data->shallow,
-- 
2.26.2.706.g87896c9627

