Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FCEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjHUVot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHUVos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F279132
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:41 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58df8cab1f2so42577757b3.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654280; x=1693259080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFVkjvLL1z2bJFpK4xCHS/gzkxsTrBHG4zxDSPjI0po=;
        b=NoIrxPK2S8HURDBFRbCQj+U286jicn81M+IP8TswOlt8h1N8t+xZWFeUQOyJHNW89s
         kEV0Exn0faENr59CUfn1rApBnnVCU1Ll0eI1xLMBrpv3dKS7+MYFzMpV2IQwNxESSrPE
         XnFiQzFgjaxs/7aWk64HKmLeN/Ug7QNitbHWCanKEKMWoYoQVfGb92HELrD29Tc1DHBE
         eevIgH5J7tIypDZZVn28tXE9wDZ7t2uuNP5UHWuS5udYCZtRvoZ1tK8sKWBsoHkTtpc+
         +wJE1uAdw145e0Sv+jybQ+hwNBig0V9rhJGm+iz0jnxNM+aKOkmrICy1uihqduo2TUTR
         RWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654280; x=1693259080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFVkjvLL1z2bJFpK4xCHS/gzkxsTrBHG4zxDSPjI0po=;
        b=UevN0x/O7tlY49s+jYO1p33hyZba5gvxMRgqPiq+9fCTBvxSAbjgGAaz2DJAqwZkih
         s6zW+29y6J17knkiYy/jEJgpAJWxz2OVJ0gU9h6zcLhdDG3xNCayCFfaVKfvBW6uYRe3
         8sMenl6wo5lu1YjLZ9fZ6A/MvaSbwX9g13rdQgSFNIJMLFdA7W+/4PLdfk8I1N84uA0A
         /GtB2afWQPPcdiOpwZ8lizsVrq7TGik3ZdQ7jWy+flwyatTcmgCds6AemtEQh7Kty2cW
         CTCM99Q7esDtIAnkfd+6mhmQyKn0e1vu5iukIdg3lb3g3JBbNDBe5pocFLp/QSv0HcVh
         oe+g==
X-Gm-Message-State: AOJu0YyknuxsxESsmqvMEXvet13MHKoxoc4yyh7EApBc0sbcyypyZR36
        V8J16wTddjTFjfsfOYNr0tx/uJ9+dJ2U4GXdP3o45Q==
X-Google-Smtp-Source: AGHT+IHw9CzzC+Groq83F1udp5zX50+QFEWoFD9lxjV7FzbMqm0Bo9rYPGmywP7MWRO2blo4PSe00g==
X-Received: by 2002:a81:7106:0:b0:592:36d:7430 with SMTP id m6-20020a817106000000b00592036d7430mr6079897ywc.39.1692654280695;
        Mon, 21 Aug 2023 14:44:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v22-20020a814816000000b005922c29c025sm459207ywa.108.2023.08.21.14.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:40 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 13/15] object.h: fix mis-aligned flag bits table
Message-ID: <a86f7259b66dcb5a2bc26e9a59397213d24313e2.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.42.0.4.g52b49bb434

