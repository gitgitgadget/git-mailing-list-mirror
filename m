Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCEFC43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAE22211
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVcIWcQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIRCWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgIRCRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:17:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F9C061788
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so3769375wmd.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t/Wf5B3c64BOG4DIMyzJX/2uRun/yH/SNs+CvfXQ65w=;
        b=GVcIWcQ5oNqD6RiS09euHV+mjUGgCquZRuSXl74HWYI6/asquIs/g75sQRdqt9lAWR
         VyseK5NjBKq5bWfZ6M8qaH2ELXg9I37+2C45xaI/Qk66Y/wGcwIPRnGbG2vpWUXvSwJt
         b8fMWAQ5WD7qCV+o1qP1o1ZjXjQtvZgvSlGMj1croKCiKgzJdnqrWvcx85TNmTaPYN9l
         VQfausxMum6Yb/c8f+WBIpWuR6iUjcs8KFUM1bEVwVUZijg+yLxZ7FXdYJEtRJNJEI/i
         7xNMZz36dch4ggpbPveeGfLHtswic6Td23lMdq+v0nKwfdjNokgL1GBAIoZEKJjWxWHn
         VSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t/Wf5B3c64BOG4DIMyzJX/2uRun/yH/SNs+CvfXQ65w=;
        b=USZgFMixgZkksSEYi5kiwhqCdwfAC36hGt+62DF4k+8WIEmV2GNanFquCrZf7m5IpJ
         GvFmHE1/iFmLcNw0+m0LVQJUvAt1rda2SbQOaG2EGjPvllJ0+uj1tPqaM5YxdTIj/h6f
         +keKuPFQwOLtjdHgCc6akhd3j7hO546YUQ9evncJ+eQR4I+9a02bUCjNJlmxCxxBgsJR
         nXtX97l6/wGXBV7aT4pL9PXruKgirvxh/Sn1hfGptvXFfIzsynepgVbLloOz0SbeXoes
         L6iJK6Jd56IeXxama2/Im28uLTIY7VO2CveK9HrqPhEbI/TcqScbXfiYhW+i1XNATnlZ
         0gEg==
X-Gm-Message-State: AOAM531fPXSsOAyd2zIilpb1dVR2wi23aRZeTbR28hVNQplIxezRk12x
        UglMuAULC77UZpol3sfnuJEF0FR/7iU=
X-Google-Smtp-Source: ABdhPJwiXmWiJFMtHalH8UypVVf2cj7iUB2G0q51mBggqIGWY54kzpPTcmOXXXTBcAS4W57vOqSSUA==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr13335647wml.67.1600395429941;
        Thu, 17 Sep 2020 19:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm2197719wmb.17.2020.09.17.19.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:17:09 -0700 (PDT)
Message-Id: <1e9caf1911d3b2663365f4487016499f47390333.1600395427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
From:   "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Sep 2020 02:17:07 +0000
Subject: [PATCH 2/2] formatting for error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Klotz <agc.klotz@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Klotz <agc.klotz@gmail.com>

we no longer need to use `N_` instead of `_` here.

we had been using `N_` instead of `_` in the case this function
was being called by with `GIT_TEST_GETTEXT_POISON` leading to an
infinite loop.

Since we have moved `GIT_TEST_GETTEXT_POISON` out of
this function, (it is evaluated as a boolean, not an int)
we no longer need to handle the special case and can use `_`.

Signed-off-by: Andrew Klotz <agc.klotz@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 198d0d3216..624fb30fdd 100644
--- a/config.c
+++ b/config.c
@@ -990,8 +990,8 @@ NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
-		N_("out of range") : N_("invalid unit");
-	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
+		_("out of range") : _("invalid unit");
+	const char *bad_numeric = _("bad numeric config value '%s' for '%s': %s");
 
 	if (!value)
 		value = "";
-- 
gitgitgadget
