Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024F9C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51D820657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECX56nhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgERPrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERPrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3AC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so8404785qtn.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=ECX56nhOsfs11x/oqzEoLl2qFbDsyEUAH7PnWfB4U3xSaCnBUiN23cNKt4ZuhhwNR0
         6EU+7x3d/1wq+o49EeiqvHGw7FzEx0HvFvIlHL7eWoCUBEyVTjYQxezP3JFaqZAy2e1g
         mdSWzp6gcE17yfJTk5WIULey2I6du95iyJHuku5vcSPgIf5E0W568/Zkq/pxypx1scyu
         Spq0nG4CXEvAbcredi3xxrK4cPWH8VEe2cPFzjvhZy664APDFRVfr7pOWVhSOc+lS+7M
         Gj0OEPwdxr3uPp7dbVLmv4sfP4c8Y2kStCeIO66K/58ln32SEMocAHtdxNSUo65XEKjO
         53eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=MTORxLQ9JhyP7uURUnkrQK26SrD9czq1AO93H30hSNvFN1u67J/x0/0yKbzHGgR1LP
         6rVHdXZ5phcPlg6h4ANum9Gqo2ybuyxN3TQ9RxDM9ZMZ2n4P8JT7Zv32iobzObkXmU2e
         1wD4IdFK8AYd9lVnoc66BAg6otVsaxACF554bPItP9NArBl0ezVUYJUJeoDzZOddwqrz
         YIKX1FM16nzESWRZKCy/nQIs4FQwsylvynGjDEl3+eGL/jKs8h2LJIGBkZsRGnNyye08
         cUQd1D3JpEyjI1+2aaAkLrtXp62ZYJlX5lxroT2Xp8NqEI0z/zilSUEejCVjrVMr4OB3
         G4qQ==
X-Gm-Message-State: AOAM531bkDj/CslH+eTUJu2CwyI7jA0Q4Shh2vx18uC3roH367y5iXst
        T9Li5ixc2x6P4CEhS67avgIGg7oC
X-Google-Smtp-Source: ABdhPJx8IqSFSwsNCdhQ69UetduGOnNrlOaZnbL1y/KevrKn8mqn1pR6ZvYOUHw/sBzsRj2JIUhL+Q==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr17420317qti.157.1589816856399;
        Mon, 18 May 2020 08:47:36 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/7] remote-curl: remove label indentation
Date:   Mon, 18 May 2020 11:47:19 -0400
Message-Id: <a2b28c0b28bb972f164ff0a9e48ae6b623a2a125.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the codebase, labels are aligned to the leftmost column. Remove the
space-indentation from `free_specs:` to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6844708f38..da3e07184a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,7 +1276,7 @@ static void parse_push(struct strbuf *buf)
 	if (ret)
 		exit(128); /* error already reported */
 
- free_specs:
+free_specs:
 	argv_array_clear(&specs);
 }
 
-- 
2.26.2.706.g87896c9627

