Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793CC7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 22:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjDTWie (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjDTWib (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 18:38:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8061BE5
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:38:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a68d61579bso13617735ad.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682030308; x=1684622308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+j7PvGXvd6jmGaHJLs5EcA8pUti1ugVsrCiQFIeaXw=;
        b=PPeEXdQ9OIRprO1iS4O5r7e673+dT6iFdTuEAFzeffo0t9FsoTodnf7GCqzzoGJ2hI
         9FrR1Nb2y67IYyKESiLhkoj18wCWiAOgPjQYPZVyWxFm2KwlTqAuHu8nceGolp907u+0
         yNtjv2Uza95sbcPvtJ1JCObZe6AMKPWRYeQ6pWxKYeiSRGDFmo9CH61EmJJkTf53Aq3i
         GdmPEedJcPLcNXGd4fC6YFGUIO4RneF0yE8gCG2q1Gu5E50Gq9gqkNSey4JuRprVll0J
         g1noAD4CTjBhqrA77qPwOIwomqk/SrIWV5zCQi7ocOu61swoTUPAMNsu6VONNiahD+3G
         stkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030308; x=1684622308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+j7PvGXvd6jmGaHJLs5EcA8pUti1ugVsrCiQFIeaXw=;
        b=RVwJ8Yrwhrpk35V9FQUjcf8rtTTxQFWigAsXb9U8v3CB113MHGwP6TABJVVQb2ifJb
         dnkvAvFSLlZK+PDtc00pGaQsuoTZDOe4L9gdrp9kELiPUsNCPmh/76E+PvPhlm3Q8d5a
         +UuOdfwu9Cc/CKPzxuQmoV2QcmvIS5bk7euedLBBXFrOEoa35qslXeXpziI76FbkryqU
         aGJaJD1P+RBxHStL7uA0SH9+6vl2TnoKNcIExd3cokuZrGLBzlwR+f5WKANUaVjnWwxB
         /sH49Ird1VLTMcOVkdU9P3JzWrrHbP9dlOvHxS4ywxKZe6QZllLaZ6xDIp/y17tLarF/
         QKEg==
X-Gm-Message-State: AAQBX9d7uQsBK6NIcR9IjIU02buhthKDDTRhTWEcxOTi7yscWxCccd7I
        8EzoQVHiH8JtdKIrVSBd9DQ=
X-Google-Smtp-Source: AKy350ZvFhXunuquZQd+fCcQrVBpRI60bkzYS5puRfDJnauGWhw56KcQ0vhZd6N5Iro9rYLqbozGXg==
X-Received: by 2002:a17:903:41ce:b0:1a2:19c1:a974 with SMTP id u14-20020a17090341ce00b001a219c1a974mr3444624ple.68.1682030308082;
        Thu, 20 Apr 2023 15:38:28 -0700 (PDT)
Received: from chatoyancy.. (fpa0565fa6.aicf508.ap.nuro.jp. [160.86.95.166])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709029a8100b001a66fd54dd4sm1567618plp.258.2023.04.20.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:38:27 -0700 (PDT)
From:   Koichi Murase <myoga.murase@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>,
        Koichi Murase <myoga.murase@gmail.com>
Subject: [PATCH] completion: suppress unwanted unescaping of `read`
Date:   Fri, 21 Apr 2023 07:38:00 +0900
Message-Id: <20230420223800.1698197-1-myoga.murase@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAFLRLk9aLXx-j=W++qqiu5-Z0TpqdnyfR35+QA5aMZM=YRZvGQ@mail.gmail.com>
References: <CAFLRLk9aLXx-j=W++qqiu5-Z0TpqdnyfR35+QA5aMZM=YRZvGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Edwin Kofler <edwin@kofler.dev>

The function `__git_eread`, which reads the first line from the file,
calls the `read` builtin without passing the flag option `-r`.  When
the `read` builtin is called without the flag `-r`, it processes the
backslash escaping in the text that it reads.  For this reason, it is
generally considered the best practice to always use the `read`
builtin with flag `-r` unless one intensionally processes the
backslash escaping.  For the present case in git-prompt.sh, in fact,
all the occurrences of the calls of `__git_eread` intend to read the
literal content of the first lines.

To make it read the first line literally, pass the flag `-r` to the
`read` builtin in the function `__git_eread`.

Signed-off-by: Edwin Kofler <edwin@kofler.dev>
Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9c10690a22..49dd69bb84 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -298,7 +298,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
+	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
-- 
2.39.0

