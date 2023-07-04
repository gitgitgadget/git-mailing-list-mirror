Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E2AEB64DA
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 19:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGDTsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGDTse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 15:48:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935710D9
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 12:48:33 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-767582c6c72so309180185a.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688500112; x=1691092112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDuz62NgS2PikJB5qCOUUTzK+wo0y/p7yZKdsSr2H5M=;
        b=gfNmcVB7yacSJmVwFYBryY9ibQTehi0oBiyxD/P/m1UhWy4zZucYpZwEISm8UuVISe
         /FzEbtl3toEYOSbHugHWjoiBxVb7OnA2Fgtm7SF7RCuCKJPPwb25cc2sW5g2HoZhWLY+
         4LDrsod5CM8jCy+5HT4yL/ujYzSVUaoi2YsF80WGrideg+Mj/alNdrU2/42iM5YGfPGp
         qrBZQLbUewK6EFSdBk6L/JvXNzwhYsa0IqyqIbngphY9/3rUQXSAtQTC3EfbOU+e8pRx
         K1w++/bHJlCg4ZQgJCUqHzpiURrJSmak+Jvwn0c0pZPKUpN3/N18ct4BxITGIQazIle8
         nULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688500112; x=1691092112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDuz62NgS2PikJB5qCOUUTzK+wo0y/p7yZKdsSr2H5M=;
        b=HI69eMtqMRbprg8a/JIZVMKCF6O33Pbn6+OlWzuKF/iCbN7KtpagHnx0f3dzVrqc+l
         SIs9fryPeTekPFAg9WVYyUW8NECbZZrIySdMUeCejEKUCAwLUSA5IC3AkY9ZS+IUK0Nm
         qEqxSuJzvZR63Z4MQvP7QUwFkPsIJIwgPRF18bg4FnCmchURw+BXrfgiskGMuDwcwgax
         yVRIe7Nj7V//seaVajMrxCR5wBYjadmcN2vNF6HDzGHrIBU4Dhxbi03bsxVlLdo9gZga
         Ms2wjI50URgCN4F+mMopyU0ep1j+kBPWuIlSq8h6kYyGTbuDRbIlhy7kkpokbcOkC7qs
         tYLQ==
X-Gm-Message-State: AC+VfDwsliyMOsYzO6maGPO3XSrZO/HWwEhXpYwtk84k2bPeCwFaHZsi
        +hffxXKkJteCW6Gv9HUO3lxd2AKqEmxVtQ==
X-Google-Smtp-Source: ACHHUZ7tfySYUya+Yg8a27C77cRyIt2RGVGPtulJaJnUJlEU0ITOzM19P7gD1PaAQhuChli0IjwbFg==
X-Received: by 2002:a05:620a:24cd:b0:767:26d:1142 with SMTP id m13-20020a05620a24cd00b00767026d1142mr15088373qkn.21.1688500111995;
        Tue, 04 Jul 2023 12:48:31 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b006579b062d5dsm9952938pfb.21.2023.07.04.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 12:48:31 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/2] remote: advise about force-pushing as an alternative to reconciliation
Date:   Tue,  4 Jul 2023 13:47:46 -0600
Message-ID: <20230704194756.166111-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704194756.166111-1-alexhenrie24@gmail.com>
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
 <20230704194756.166111-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, don't imply that `git pull` is only for merging.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 remote.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index a81f2e2f17..009034ecde 100644
--- a/remote.c
+++ b/remote.c
@@ -2323,7 +2323,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			base, ours, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
-				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+				_("  (use \"git pull\" to reconcile your local branch with the remote branch,\n"
+				  "  or \"git push --force-with-lease\" to overwrite the remote branch with\n"
+				  "  your local branch)\n"));
 	}
 	free(base);
 	return 1;
-- 
2.41.0

