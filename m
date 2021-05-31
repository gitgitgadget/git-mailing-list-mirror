Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517AEC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329F560232
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhEaTxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhEaTx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630CC06138A
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id b25so13301449oic.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0DXeCnh9HhrADX+XgqelUhO7gy6X8yn1spfFru5JxI=;
        b=ZFaGwqfDEAINFpuSbSzFW3eQ0Q7lNUVH/vNTfNzDUoUp0tpM3HmLqJNJ8KPKuQYNep
         bLwThi/kptnDEFh+CvEUQ4qziNtMdVpPSaJNpmHoACb9WBV1bRnxjhLn/iCYlAukDCRo
         vaKQ48BSfRHF+r/sW0XyLrHQeKS0hSJsq7CA9ukeiAmImJLf2wJA3fWfKFp5J+tKvgkN
         JDeAEJJIaLPkST2lElMrry5HcoWZwpNix2gGlnfD4nfFZOGTLbYxqPEYUmvc8zi3dA74
         soUOSkuce30Ar7ljv2HvcEUIHolrUMTxyTwxhi8NJ79yAH9B59uXcga/AsktJQ5wJ2MJ
         AKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0DXeCnh9HhrADX+XgqelUhO7gy6X8yn1spfFru5JxI=;
        b=VdtTG8fsPjgGp0d/Ikzl3+tby7J9yj35ndb4YlHf1UlTuCbFjRdl24gCsxcjN8z4EO
         OMYExpk+/KNCN7paRECVvyGu+Gk0PXANT509ckB4BABLxBIrxANGXvE2j3Ba94VRqJUp
         y8Vay/aWzQsCCmyJJumooWml+Ns4IXXSkzaMLMvuNuY/vzFCS85n67gOrtreBinW5Tcq
         tX+y36q8r8i/CRXqiIVqvpBtBKZ1GbaRjLamJHQg/rKUxqdwOG0BaIlDSU7EaORsoOb9
         rxKlNKGK/9huWuKrGM2MLfa1JNuDzKtLf0tppDMumT97nAdFYuwAZ+I7OXgjpxkesStx
         VbuA==
X-Gm-Message-State: AOAM531/y8f7GQGyiwyF/XXBD+zI5POf9C0UXExNnTj1W+LQ+xRP3bRR
        EvbYpO5MQteucDWDw/k5MKWR+9TwXkffSQ==
X-Google-Smtp-Source: ABdhPJwwJH8HIJMqyOkqyqEPgNysuJ2mfOI1L+nssX68O90m6bIacaYjn6eSFI1ifxeMIs9mkE59uw==
X-Received: by 2002:a05:6808:1281:: with SMTP id a1mr15042979oiw.143.1622490697437;
        Mon, 31 May 2021 12:51:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e29sm2990588oiy.53.2021.05.31.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/13] push: trivial simplifications
Date:   Mon, 31 May 2021 14:51:18 -0500
Message-Id: <20210531195124.218325-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 933b1cc6c0..43c039a2e3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -205,14 +205,12 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
 	int same_remote)
 {
-	const char *upstream_ref;
-	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (!same_remote)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-	return upstream_ref;
+	return get_upstream_ref(branch, remote->name);
 }
 
 static const char *setup_push_current(struct remote *remote, struct branch *branch)
@@ -222,15 +220,9 @@ static const char *setup_push_current(struct remote *remote, struct branch *bran
 
 static const char *setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
-	if (same_remote) {
-		const char *upstream_ref;
-
-		upstream_ref = get_upstream_ref(branch, remote->name);
-
-		/* Additional safety */
-		if (strcmp(branch->refname, upstream_ref))
+	if (same_remote)
+		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
 			die_push_simple(branch, remote);
-	}
 	return branch->refname;
 }
 
-- 
2.32.0.rc0

