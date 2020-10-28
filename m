Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94240C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299C320780
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmNfvTQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJ2AP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgJ2APc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:15:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5846CC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:15:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id m188so719421ybf.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3Eaj81IkNG3n6OjleymDnw7o5F38a7rg2QPq/FwkGo=;
        b=GmNfvTQOf7zdcdTn8pmVrAjlZB8geA4ZVABSF6z06SiryMPVeRM9RDviv6IVu4mr1A
         iN9DQsZ3begMO1aQj+dnzb7/ti1/RW/5e0BFw3Az5aJugWYAEzspNvo1G1F2HaFcCgRA
         8fWtZB/r2Ptb1rnwh8AcvKoNZDJU2ssbRh+P9j5Z+ZP4DTw3vxYYse1GGrfZDSP2aavk
         Ka9P/EpI0Dsat0uEXjD9JymKBBehHH5SpaxeaCYa8R5UT8dGRHQAmsV9GWAVCX1cO84L
         X0h68HB6thUGIjkN1ANd8LUj7QT8mfKTdmYvd1moHSrEwvHVLEpR6kDq/9afBF0CVWlz
         /QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3Eaj81IkNG3n6OjleymDnw7o5F38a7rg2QPq/FwkGo=;
        b=E4jRo/VRALiHC5PyAT+xgddBjMpCxRYiUnquEsYO4LZ+lof/onrd5tJXu5lCR30+A6
         Er/T1Ns3tqhMjIwlTwK+BeuPlCLzscMNG30ZO6wOwV4NC5LHt1VJuWxTcZ2mAiaFZUBC
         AuqhtNatsmfhmskJ6PFpZdYYSgtC1gZQ5DhLqqvZ7qEQ5yXNHAlrX8Eigz1HBbg/i1r2
         oF8/p5634Z6l4jfHO6y9obgWJtjVEROM+W8T1ows//gL9kqHie1uFnsjy8KXltpXYQDs
         w3nTy6IEWk+VcGxRwq6s9iKSlQHYM25fjXPVpP/qXm78Dz4DZmThSpyM9Qw/ZzEAMZAT
         CR5g==
X-Gm-Message-State: AOAM5339BuFPWOGpVneUsRxO5ugokjjkzLsXe0XhazSM1w9Mr3OJ2hek
        KS6b/ud32qmlkQ8yEoXwWqaVOBUAI9UM3a24
X-Google-Smtp-Source: ABdhPJzVU3OotMvdMRL5rvvfVpu9G3deinc3soTLsYGiqHuXvkZZLhg4+CEHDWceUixj1ovc32rgwg==
X-Received: by 2002:a9d:969:: with SMTP id 96mr3327116otp.365.1603850873900;
        Tue, 27 Oct 2020 19:07:53 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j84sm2272472oia.25.2020.10.27.19.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 24/29] completion: zsh: trivial simplification
Date:   Tue, 27 Oct 2020 20:07:07 -0600
Message-Id: <20201028020712.442623-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From upstream bash simplification:

  d9ee1e0617 (completion: simplify inner 'case' pattern in __gitcomp())

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1204a55890..2956b9d0d8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -85,7 +85,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=*|*.) ;;
+			--*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.29.1

