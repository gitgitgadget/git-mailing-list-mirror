Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477BAC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15499207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V11C2iGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHURA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgHURAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB315C061797
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so1130169plk.13
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuQL3j/CxAtIzAlHz61Jd677nfNIp//do6kxQlibmCY=;
        b=V11C2iGqrJSUVpgjpyGGak9IH0xNy8zwu1C13buJhgJe3ZsFiqQoyIMWtQjLzSPyIq
         pZb9/wr4noQNLEVAvn2wwCBEGHydLaaa8FZKMM5OZMXBbG5hqswnDvnXx9Bg+RSbyeA4
         FfqPgz1JnjcDK+6VHeBoXh9v1/5mC3TcRe3CSEyoYY2D+lzh2RET1rqpcNhwPMiLv/9J
         hONOVrU7QQkPxPFtfJNMuaXUDxSI3Tsobo0ZJ1lh5swDcd7fQceMGcpI0gkXub6mLgFu
         Za51yW8vKTqffErThXNVo1cMJHo3ZckYtntkRQ4seQyaugi7xTX8c/aXQ68+nvtuoagz
         6MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuQL3j/CxAtIzAlHz61Jd677nfNIp//do6kxQlibmCY=;
        b=iaGpfh4wE40Vc/DNWtvSr1OVwZNUaJV9JqlzAmqUyiU71FxYqBK2mtMNyGVz/QzzIK
         7fATkapfSHH2qQi3g0PbQIsWTbxB8lUh9hoWJMFQegvavaJJ+SGvLxMt91RBc0U75lZw
         FrOYQevjhgkTU2BzxzPukv6s3JpHAMuqysVRvl7J3jOSFU2IE4n+PtVWDJGKvZMeT7wg
         srOAQ/UwcQkSkaS3ZLcioLaRPASisYv1SrReo9Inyga5ebr8+JpAI4TbMYlQ9u25ex7N
         NfNOp6egtvpNvMTitfC1ahNYHzOfDUhLk+e98AiZsvsZPKl0Nn6lTZgwTIa+cAo5XkCH
         lHvg==
X-Gm-Message-State: AOAM531Q/G69YOan7+5fOMq3dvV17ze3ICWaDhDQ6D9lv+5WDKTVGc/c
        0cNj7nGmv5P2710o+Dt1c1Ltg+Z9bbm68w==
X-Google-Smtp-Source: ABdhPJw278PB/3ZYJfJc2qZ6NLW+K3oMtLfrKWHQ0Ie8l9GbIGVPPxZxzNKSAvSLpVgxw5qq/unWBQ==
X-Received: by 2002:a17:90b:3197:: with SMTP id hc23mr3199227pjb.60.1598029205955;
        Fri, 21 Aug 2020 10:00:05 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:05 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/5] t7401: modernize style
Date:   Fri, 21 Aug 2020 22:29:48 +0530
Message-Id: <20200821165952.14376-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
References: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in 't7401-submodule-summary.sh' were written a long time ago
and has a violation with respect to our CodingGuidelines which is,
incorrect spacing in usages of the redirection operator.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9bc841d085..07d4ba0b26 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -16,7 +16,7 @@ add_file () {
 	owd=$(pwd)
 	cd "$sm"
 	for name; do
-		echo "$name" > "$name" &&
+		echo "$name" >"$name" &&
 		git add "$name" &&
 		test_tick &&
 		git commit -m "Add $name"
-- 
2.28.0

