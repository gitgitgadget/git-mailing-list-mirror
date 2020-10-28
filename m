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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23637C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EC7206DC
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuOWz404"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgJ2AXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgJ2AXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:23:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842CC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:23:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x1so1456457oic.13
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHRU2BEFrAgvQg4uU0wWjwvAdoxtstGONimXMKR4H1M=;
        b=LuOWz4048hwiJD/ZsnA7B5Fy6Nt6gELvP1+0FcXXXw06R1dboF6HvEQTeQGUW/0eC9
         pKFiPDRLIlrUq+APAtCDiY0TNSmPWcImprujNGzVF7Ivz9oL7L+xXBD+QdqYsp0d4tt1
         0WMj3cKiI2iErurkj3wVcwleHPh+XFUqxY4CoupUJqpEskRVPFqxKkLOB4JcCOLQSgzH
         9R1LRFYHxFFej0Ziv9JMc22xUKocMVYfGu0Z78M+VcXjwfutfqCrhnUHt5ZRdNzEHgLj
         eHJpxJikhealbvaKeTM/ochwF8vm/X/9lC37gebfWydMwboy5QVVEug7R9PSnqrDRCK7
         umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHRU2BEFrAgvQg4uU0wWjwvAdoxtstGONimXMKR4H1M=;
        b=dQkt0JoWeUKavNdNyf7lk9XGlnpbfGra5VrH4HeoqpiC0p2JXGh/LzzIdWnBeHxKLx
         Nf8PtHkgic/bWZQdsom5DIUFW7W406QRY4lRaS8zMfWOa4o6ptkcoCrrSEizD4Muu1NB
         2j6FiYgMeEMJkjwcag4HnyNsw+lZV3SFAr846utUP3XUjtDYZ0RLOBiyDbHMV44D9ziG
         PvBrOko3PewjRr5wwDqQpHZhkZyYpiud7oTno3z1bcKn3+XPZ4Al8cpLnvzYGzk+TnSM
         lY3HXgqgHtNRGZNeaF/bI0oVq4x+JieTMd4IdweF119l6aO1cdNDJ+luFAaiRRpIEMRG
         HTtQ==
X-Gm-Message-State: AOAM530V+3ZvHhskBgAqwm1Ie3OuL9L1eqoyH83/L0MJEnI2WHE9hgEG
        SEX2O02H4edGo0JhSiapBa2ft/J7uBKod4Zq
X-Google-Smtp-Source: ABdhPJz6nge7V5pv2NPLFxev2OkBZNbHA/m2W7AQN8VZ6L2Yb6bqdMH/UoyuqsuSrX43xKBN0Vp6Pw==
X-Received: by 2002:aca:b744:: with SMTP id h65mr3666568oif.149.1603850877079;
        Tue, 27 Oct 2020 19:07:57 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l23sm2304249oig.12.2020.10.27.19.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 26/29] completion: bash: trivial cleanup
Date:   Tue, 27 Oct 2020 20:07:09 -0600
Message-Id: <20201028020712.442623-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to set a variable we are not going to use.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 26d6ee20b0..ed059f35c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -416,14 +416,13 @@ __gitcomp_builtin ()
 	local options
 	eval "options=\${$var-}"
 
-	local completion_helper
-	if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
-		completion_helper="--git-completion-helper-all"
-	else
-		completion_helper="--git-completion-helper"
-	fi
-
 	if [ -z "$options" ]; then
+		local completion_helper
+		if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
+			completion_helper="--git-completion-helper-all"
+		else
+			completion_helper="--git-completion-helper"
+		fi
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
 		options=" $incl $(__git ${cmd/_/ } $completion_helper) " || return
-- 
2.29.1

