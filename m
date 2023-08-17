Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997EC64EDA
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355453AbjHQVys (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355460AbjHQVyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 17:54:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C626BE
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:54:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf24089e4eso4641745ad.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692309275; x=1692914075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RscP/u1Niq7ceUQbOsCpKRSBVTPw6me2fTJAEr2g4Mw=;
        b=bioHTgYncuytW4oa7S4kfT6pj01+Z6o0NkCajdVIwuK4pXeB0volUIOrDftoneDtj8
         Z4KYoXdsUSx4muBDpeE2wtXYMNifIxTcN41HpLTrB1uNu1/pSE+a0b+4B3bUXSGXsJ/A
         qTDr+sKht1gl2gQxjwyxUFnc4mW677Izl8Y5e9pHBS078apolVIa31IjM4FGtz2j/PxK
         pOOyCEZyI62jZsKGlVkeuY25Pu4jaInZfCrhlgzlb6wRa30+/3P4F2472F8wybjiXkUS
         SCjM4AhTqe+hZLZWW5F8fTFGVx4sdu9U/k9BJuw90FEiI3HkM4TbE5/DtMkhwnaJYoL4
         A1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309275; x=1692914075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RscP/u1Niq7ceUQbOsCpKRSBVTPw6me2fTJAEr2g4Mw=;
        b=dfmAIeNtCxT4KdSluC1ARYoZ2Dw5M8h7+On29RMzZ8gmTLDixRVQeRYrRwZPaJKIMi
         cL501SSjx3dsU1kBQeHXAR6X+gTYNTkfTEJVtbwJjZ1Mp8eVKpE2rEDj1/6n5Ttpf7WY
         lzainw3HOj45JUiyJL/mhEkI1qxYprSltm8Vh6fIHCkpJ5831npp9OAKJsCQxu3x2Dsx
         LCLGldCXmQJJ3iZvFQcslNM4/cn9XN3SOnAQpyJu2pwm1JHVRYPJ1v/CGf37/a4phUVb
         pDsu14o1oQIZjIVZNLA9NbKwKNErzJ3hEPw5xgJPH/1UlR7YoKS/5jfMcUoQn9TqtS0E
         JjGw==
X-Gm-Message-State: AOJu0YwKQMt7bW19Q1jGZJQBBlV8oUzgLBxISs0r7R1od6D5/HxvK2F/
        Eb/64CMl9u0pzs/5zAwtj4A+WKuI5NbXyxbIkAtQMeiocxfve4xtkWGsPZmK7FNZsbij1U7TWtU
        /oI90VSUvJtmJaqopZxfFjDeRYQrChonft6OOSNl5s2M2Rnxd4ma15xkROjK2kXmYGIPe1PiGmI
        LeVFY=
X-Google-Smtp-Source: AGHT+IFxnISqP0+Wt914JViSyCIePn0anmIt3A+Vks1ymGoDNYK5exf92C/qb/gqc+VOu8wENyJS64au6tmKSmyHuoP/HQ==
X-Received: from taylorsantiago.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5c64])
 (user=taylorsantiago job=sendgmr) by 2002:a17:902:f353:b0:1b5:147f:d8d1 with
 SMTP id q19-20020a170902f35300b001b5147fd8d1mr198175ple.3.1692309275324; Thu,
 17 Aug 2023 14:54:35 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:53:25 -0700
In-Reply-To: <20230817215325.2550998-1-taylorsantiago@google.com>
Mime-Version: 1.0
References: <20230817215325.2550998-1-taylorsantiago@google.com>
X-Mailer: git-send-email 2.42.0.rc2.1.gb06b9712e4
Message-ID: <20230817215325.2550998-2-taylorsantiago@google.com>
Subject: [PATCH 1/1] Fix the order of consuming unpackLimit config settings.
From:   Taylor Santiago <taylorsantiago@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Santiago <taylorsantiago@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for fetch.unpackLimit states that fetch.unpackLimit
should be treated as higher priority than transfer.unpackLimit, but the
intended order is currently inverted.

Signed-off-by: Taylor Santiago <taylorsantiago@google.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 65c1ff4bb4..26999e3b65 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1911,10 +1911,10 @@ static void fetch_pack_setup(void)
 	if (did_setup)
 		return;
 	fetch_pack_config();
-	if (0 <= transfer_unpack_limit)
-		unpack_limit = transfer_unpack_limit;
-	else if (0 <= fetch_unpack_limit)
+	if (0 <= fetch_unpack_limit)
 		unpack_limit = fetch_unpack_limit;
+	else if (0 <= transfer_unpack_limit)
+		unpack_limit = transfer_unpack_limit;
 	did_setup = 1;
 }
 
-- 
2.41.0.694.ge786442a9b-goog

