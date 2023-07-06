Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C375C001DD
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 04:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjGFEBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFEBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 00:01:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA174199F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 21:01:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a0423ea749so333042b6e.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688616100; x=1691208100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxjqzbahwAmMYMH8V6k+OfDkJO8FQ403OSYtJGLtV3s=;
        b=YtoqaA7TPth5MrTOU6DDxCJQlP0MIoYe6pFpHZ4vcYnbdinIRfqoKn+EQAA3lDLtt1
         2HMYman54cgz0q5IxgbYLyKAmZv+h6RreerxkwUC90minefwW/LmUI8FUUyMMZSb/BU/
         RvIQuSQ6MgMKPJm28IUUeWti231U8mWuqFXd+EigkDKSdL6gzGjophXriG9tkG+9IqX5
         XxW5iznRnpyDKiCTjJixGq2HePoxfLGKmqWd1MQp+E63HwLe9f+Lvq4wP2gjSYgIKyV1
         dFAlA2bBzYbjK6jHBVSVnAj3j7LoSOJPonwJkfpVG2QB3d+WelvJzT2hSqVC+eRRgFDD
         vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616100; x=1691208100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxjqzbahwAmMYMH8V6k+OfDkJO8FQ403OSYtJGLtV3s=;
        b=PuOqhwL6OckeIdCE2bRTO8zpEBxvqLcocIIIi7Zt7CZgBP0r2CD6TswPWFEsESpL4C
         Ge6VkcPEg3T35lx+8g0ONEIfmfomfktaTmpQs+oUr/DheGzod5Rqok3CkX0VKzsccA6M
         JTegdBvbwUIde6SwxBiee83bnqY0gOf3PTPfJHghNKicjamlmKaaW/M5cqkqAVxUEjog
         OpPv3P5lxBY/3lXpoa07izWvx+lszxhU7/TNE9AIu7BS8mUaOT8VH2rV3mx/r+3LUHSA
         GLKYjHMRxxQ8h7vV+4MJbptMP5Ax7+Od71ceBSfE7HS7oQQtm1sxliqlui9+1EDqI/aN
         +fIQ==
X-Gm-Message-State: ABy/qLYKn93gsnXmdfH9pVQt/eZZSYlELTGlxiUApi7ixsirYUqRc6Qo
        kAwkd+vr3nsLnbClPN/gOgZhN5qdcAzq/Q==
X-Google-Smtp-Source: APBJJlGAq/1kMJwhz9CsxQMXUc2FLeZ6MvqlqUfQzYx1Rw0Aw+Ey6NzXjmppxN/1P27qk1wpO1DFqg==
X-Received: by 2002:a05:6808:e8a:b0:3a1:b28f:814c with SMTP id k10-20020a0568080e8a00b003a1b28f814cmr655025oil.1.1688616099880;
        Wed, 05 Jul 2023 21:01:39 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id j24-20020a63cf18000000b00548d361c137sm303913pgg.61.2023.07.05.21.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:01:39 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 1/2] remote: advise about force-pushing as an alternative to reconciliation
Date:   Wed,  5 Jul 2023 22:01:02 -0600
Message-ID: <20230706040111.81110-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706040111.81110-1-alexhenrie24@gmail.com>
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, don't imply that `git pull` is only for merging.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 remote.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index a81f2e2f17..1fe86f8b23 100644
--- a/remote.c
+++ b/remote.c
@@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			base, ours, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
-				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+				_("  (To reconcile your local changes with the work at the remote, you can\n"
+				  "  use 'git pull' and then 'git push'. To discard the work at the remote\n"
+				  "  and replace it with what you did (alone), you can use\n"
+				  "  'git push --force'.)\n"));
 	}
 	free(base);
 	return 1;
-- 
2.41.0

