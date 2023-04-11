Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B7C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjDKHn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDKHnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E889440FD
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so7171508pjb.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198954; x=1683790954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDkFC4ro6m/4LhM6gyX5iZa/VbILenGdTiLcBhfe50g=;
        b=Vj/PEizSRPyO95n4AftvZwn9lKcfj9gab8xs2CqaX6/m70sDvHJG+BaasfP1QVhWWz
         M7uCsMbkEhSaWf6LYokQmFB+y6iY2qHGG2Alxyxd/Uwyb/4vaWN7Q0wDgJqNcax3vZng
         GZF1+ADHLOLCdY6Eg3sDg1gozt/XVLuBajcf1wHwsUT2rqavcH6Dx1LPs+S1OeQHOtcn
         4htZe0I7H7mR1hjEWVsbpD2vJ/dg8EHza0xMkTBEP+QueJuCqq9TVGrGrOGKxyrrtdCx
         0ejKg/uLSZegPmUrPBKFCOGkCV6oaEOkLcdVGslbNGgbICtyhIxKax7pVUFhrNr6yCNU
         JuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198954; x=1683790954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDkFC4ro6m/4LhM6gyX5iZa/VbILenGdTiLcBhfe50g=;
        b=PfY9eCHG6VQ1VOK5Zrx7orXwi5h0HofL4Zai29UJ/+6xirVYnRcCxkHsp4paZSojKl
         SCLjyT8qDcunjKS+UT6vWx9mg8bcpJuAqJ6EwrXchIsgA1BwmiL7Axwj6GTERCguHBbi
         aVQlLBzwT2N9cAdoEVKYiygb4of7xj2cDuylOBs1g3FpJzkqzKvESb5xuIJqwBDzAqK5
         onwZ7sk0MbohU/x5EdGDPz6aoBvt48lPuqRyRcyfhuJZ8517JTzbyWKBuDwA9JZhsS0e
         MZuX+Mg8twqpz0jTusWxWZOzi9+d27/5CEUvNOzR6a6jAWzUrqFbuGbbhJyJJPzOiy/N
         NcWQ==
X-Gm-Message-State: AAQBX9dDvljc3rR3cxNGeTqI95bzfUCBrBJBAjvJ9qDBptr3pD//D5Po
        u22tYIWwDGAkW22r/48xS0qi5MTbByA=
X-Google-Smtp-Source: AKy350Yljt7hRQdurNFbQeTY/Qid0KEn/KVMMHnsm+dgeF3mDtCIOkY1MN+WuDE/AdoGCIwZK3ZABA==
X-Received: by 2002:a17:903:2950:b0:1a5:1a3a:692d with SMTP id li16-20020a170903295000b001a51a3a692dmr10868583plb.22.1681198953721;
        Tue, 11 Apr 2023 00:42:33 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 20/23] cache.h: remove unnecessary includes
Date:   Tue, 11 Apr 2023 00:42:01 -0700
Message-Id: <20230411074204.3024420-15-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cache.h did not need any of these headers, and nothing that depended
upon cache.h needed them either.  Simply expunge these includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 cache.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cache.h b/cache.h
index 21fd520b045..16b5fc9fa31 100644
--- a/cache.h
+++ b/cache.h
@@ -4,14 +4,10 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
-#include "list.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "hash.h"
-#include "path.h"
 #include "pathspec.h"
 #include "object.h"
-#include "repository.h"
 #include "statinfo.h"
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-- 
2.40.0.172.g72fe1174621

