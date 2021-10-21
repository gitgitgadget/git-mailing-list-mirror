Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0328C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6174611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJUQAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUP76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 11:59:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA12C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso7481610wmn.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpbXGpJIegqGLazy5lZkC3oSlZqegVglW0c+07pgA8s=;
        b=Dmve/UHu/0EHOO7pn6WMdnFg+STD59iyYj7DILMeDGfh59Tg/Xkv/ZL64lsX1XsfDY
         odyAgGrtAov8TDOg6SLHNjS8/rHzTAhN1aiOnDpX93hzrsx56A/oMKqueaxBndvFi5P6
         mXpcfkkHOLfxrvHuXosCLJ+JyzdFn8u9kjrGSQQcU/nr2Psga+JqwTdkIXB21XjMgnCY
         Kqnx2220OQ0kH5iZnYyOqPis69urrA5QNJKFcFgWrPtE3139cHbjnEF199yHC3tBFjXw
         /HRUbWG6F45LcMuu9tD6je6Kx4pSg3z+w47PlXAPjeplOhL6EZ+nVMjXy6mqpbhiVIeM
         4gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpbXGpJIegqGLazy5lZkC3oSlZqegVglW0c+07pgA8s=;
        b=fJL3hx/FbDWKqsfPcxN0NeL8jASfygxNO804QD+xb9vgu/G5dw0Yc2iDnpz9kWZdkg
         +SMkBFBXCUVmD4MiuPIZfAVg4Xp20/WQN/SFDceb7P4jA5yCw06RUPmzmczxA1vS91dY
         oI+ohGOvvrBFxT9dxVX7URjstYbP+68jdbsbdlBHRTj7CoMhn2SOJXAyj3rpIkU7rZau
         VOVfy2PuTcrCkY+oi3Y2u7eDDuJSkhJcUEVWRcZM6OUdrsUvM1vYHzHmJVhAObczn359
         VzpG3Kr+MQTiSpEfLAyGAYAiC2g5Znf9XC7SUy4wsVkCa3V0VKXkDV9F6V/7Ebg20OlT
         xQdA==
X-Gm-Message-State: AOAM531JIMK2F14L0Y7tvUoSbx0aaWSxII4hFrXCoU5N6i6/ReSLeQWp
        AMCt5lMUv4Zcie22mDqpI/vDgZAQ5q5VaA==
X-Google-Smtp-Source: ABdhPJyC5AVY/OfjfjGAYAmJ9xaJVrzGSmg3n1QAvK9W5sHcTLGShxZOgD8v+p9SNiwzS7t6vEVjmQ==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr446524wmj.77.1634831860830;
        Thu, 21 Oct 2021 08:57:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] grep: prefer "struct grep_opt" over its "void *"
Date:   Thu, 21 Oct 2021 17:57:32 +0200
Message-Id: <patch-1.6-2bdd21e4e59-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stylistically fix up code added in bfac23d9534 (grep: Fix two memory
leaks, 2010-01-30). We usually don't use the "arg" at all once we've
unpacked it into the struct we want, let's not do that here when we're
freeing it. Perhaps it was thought that a cast to "void *" would
otherwise be needed?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8af5249a7bb..fd184c182a3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -199,8 +199,8 @@ static void *run(void *arg)
 		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
-	free_grep_patterns(arg);
-	free(arg);
+	free_grep_patterns(opt);
+	free(opt);
 
 	return (void*) (intptr_t) hit;
 }
-- 
2.33.1.1494.g88b39a443e1

