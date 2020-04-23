Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8ECC55193
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF43C2064A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX2u0Qdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDWXnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgDWXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:43:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA42C09B043
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so8658768wma.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HYHS38Au6CtTuI2ZgtQFnraejHTl1h/lhxRvcPNe5rs=;
        b=AX2u0Qdz1tIpTgycQz8VCoOKRHP0fpV6/VPceW1SnH0psMYQyYKOxI8P/0dCqk9n75
         zqk1383L08a/h6x9g+DBkUs7/j8UbStkFunVmd/51ddIQATmCpcMmPta64RMxYudtzQS
         IEzoWikiT8W3FS7Ybd+n6ENnIei24Mb/y6jJ1bD8N6s5i3UVZTELh5wmpShSqgD042AA
         n+X4/ZsUWWkC/WyvLcycqNmD/XAsWCTvmuM54l+BuLL+qPo3ZqOdYnKoheqNBS1xOcGf
         m5vPPh8hyEs/dzv/H/C1RBKRA7edlJx5RZw+Lu28HsrLc/hj7N6d3Y2Q5KXZ64bsKDi1
         sRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HYHS38Au6CtTuI2ZgtQFnraejHTl1h/lhxRvcPNe5rs=;
        b=B/PACdY+e5Szibwryg7tB4K3fh9aWzDFOUMYZPlW27lQY4gLeUFxztbQMKIWOKKok8
         z+FyjmqHMEb+77zxvMLnfLZ1GujXLb6EoLDXNrpngXcefkfIgmkzW3D367J9r6h6OlDu
         WO8SCoDqgOmFA+cxo1N7PzJ/oeloRWI+7Cb8RNqxVYrFHeIvIwLzGnuKKnis2TY5rxIb
         VIadV560DIl0yjt7iLvWvelSOTgun8vgC5KIDt/oWwhSv5z09xaZscHEacl8EuqNyIqI
         QbxJzsaY/6NqqQbFFKihHjT1XHYQFUVnUeuVujLAXW8F72RI5viGCe8144lV4HyOcpil
         LJPw==
X-Gm-Message-State: AGi0PuabQrPJ+HHVLhDL8IsTIKs8ALV/eEL+fg73Hpl1bEMvLFVUGCKx
        Ej9VxnRmVK/6SnxzdiVivXmOD1pK
X-Google-Smtp-Source: APiQypJfa/pNH6FqCWBbgFLhb3Zwnzqa05Dvz9YH0SCK7aSLNqDMet8j1BUUzjwRJeQTB18J5+LzFg==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr6797846wme.84.1587685399245;
        Thu, 23 Apr 2020 16:43:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm516644wmj.14.2020.04.23.16.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:43:18 -0700 (PDT)
Message-Id: <2c1c0ae91eba2092b24c392786ca2e7c81ded334.1587685397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Apr 2020 23:43:15 +0000
Subject: [PATCH v2 1/3] credential: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There was a lot going on behind the scenes when the vulnerability and
possible solutions were discussed. Grammar was not a primary focus,
that's why this slipped in.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.h b/credential.h
index 122a23cd2f1..5a86502d95c 100644
--- a/credential.h
+++ b/credential.h
@@ -32,7 +32,7 @@ void credential_write(const struct credential *, FILE *);
 /*
  * Parse a url into a credential struct, replacing any existing contents.
  *
- * Ifthe url can't be parsed (e.g., a missing "proto://" component), the
+ * If the url can't be parsed (e.g., a missing "proto://" component), the
  * resulting credential will be empty but we'll still return success from the
  * "gently" form.
  *
-- 
gitgitgadget

