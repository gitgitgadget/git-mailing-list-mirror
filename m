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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5241C43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F10C61244
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhDLLCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhDLLCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:02:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2543C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so19516398ejy.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmZ5YGrd3NsGG2QZL+DaIkYxH2bDqPnaZaD2RJHjrnY=;
        b=TBze66Ha4CBZGqZNyuG+uYX17YSIbDaHDyTkdNh5pk0cvdC0T/OblMT3QIKMQO5OHd
         RKydByjoPy/Jyj6TPwfGkuPdCSkIOGkzEghHBkaxfZkCUvDoYAUQ48dY1HAwGXmEtnLl
         EYHGPkeZtwopc1nSv/mFiOrZ4/ZETqEPLbH4mCDASVdVghz5p+grlffXXXuWVDAdB42x
         6dDrOU5LxghVtBG8N9nAUdarT49q7NJe2rJPjGrSfnyk7OF0r9CBDv5UOgNrmbFq5wqm
         DQTL5MSCmUaj/Jw9Yn+24FDENYwr+WnxsWf+gEPTTU9MQkD6zn7gYrTkJgU/cHzfBdyK
         D1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmZ5YGrd3NsGG2QZL+DaIkYxH2bDqPnaZaD2RJHjrnY=;
        b=p3k8jf3OLXoVQ2bBaLRIxmlakTaIUgOwMOr5CDEaQ8MJYaOZAdwwm3eWUGu+V2Vj2a
         zzAw77mhF3O8iBuN84sTfS9JDv9Iim0wPnZVpo63lScwBx/IqKMjHpCcEBpaGKYTtQlJ
         8+rXK+Ip16mikp4ToTRcY8b1FBEMTcvLKl/0Kr7sLcsyWsrqI5YKUYggCL3eUatpfJCM
         ZxA/CsTzWSXxW7yn1Vus52PACIj30kLMdocR9ACQ2a+TNtzgcaGYCAesYmewk9U5NGLf
         ljVUYsgrw5Yq01VshBC7vlRQeFogYo09P+Fad8Flc2E5rOnfpvBP/OrpgIg28WcEfnQ/
         0Mng==
X-Gm-Message-State: AOAM530qfE7+1w1c3PRnm110QV7EZg1r8pb2I0Ppd0kmwzwfa+ldjTcV
        0QhJdJSR6hw2qwGRCgVl4KwunXEqYhfgFA==
X-Google-Smtp-Source: ABdhPJwScibTehf54lgDJaGRw5HfGjRpj+nrz0OxjUfsI1tQwFH/MY0n+X7yPRyVSyQIIderaIQXIw==
X-Received: by 2002:a17:906:fa83:: with SMTP id lt3mr908861ejb.299.1618225342219;
        Mon, 12 Apr 2021 04:02:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm2691765ejk.102.2021.04.12.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:02:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git-compat-util.h: clarify comment on GCC-specific code
Date:   Mon, 12 Apr 2021 13:02:17 +0200
Message-Id: <patch-1.2-a8cc05cf56f-20210412T105422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net> <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a comment added in e208f9cc757 (make error()'s constant return
value more visible, 2012-12-15) to note that the code doesn't only
depend on variadic macros, which have been a hard dependency since
765dc168882 (git-compat-util: always enable variadic macros,
2021-01-28), but also on GCC's handling of __VA_ARGS__. The commit
message for e208f9cc757 made this clear, but the comment it added did
not.

See also e05bed960d3 (trace: add 'file:line' to all trace output,
2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9ddf9d7044b..540aba22a4d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -480,10 +480,15 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 /*
  * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * gcc with -Wuninitialized analysis.
+ *
+ * We restrict this trick to gcc, though, because while we rely on the
+ * presence of C99 variadic macros, this code also relies on the
+ * non-standard behavior of GCC's __VA_ARGS__, allowing error() to
+ * work even if no format specifiers are passed to error().
+ *
+ * Since we're only trying to help gcc, anyway, it's OK; other
+ * compilers will fall back to using the function as usual.
  */
 #if defined(__GNUC__)
 static inline int const_error(void)
-- 
2.31.1.631.gb80e078001e

