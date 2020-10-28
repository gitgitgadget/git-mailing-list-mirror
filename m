Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44AC388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0CA20754
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOyq1H67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbgJ2AJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgJ2AIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:08:31 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E06C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:08:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j7so1435887oie.12
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaitsVdltlfxnCrmXDrXV4Fy/0lAltTGxZvgLb+i2SI=;
        b=AOyq1H67MsnVi7uvdhGy5nzKb5kit36g1JEyraL3IVlK5QQt1ElMT/fAGpWhsgC7uC
         7Qg+a83wqvx/VK+IY9wg+cx3bNmaPUa+5DHiMxpol9z5liKuA58xS3q1TYHZ0f8Tl8YY
         kItiOk5shIrpoPFdze7w3aYU4voLm08JCwhweBU9JgFERkqelKyyWvegDPy8efUP1l4q
         D/KaDPz+ysMkiwHR2s07g2r8Iw487f3k+SfjTuUz92ENTSswjoMEYbCaFNyjYdxmiuvx
         Hr0QjrY+7Fr7bWEIn0BOg3bWX3LTIS1V2ACXWIq4Fzpy5jJWrrPvSzf7qIK0X7t/8wTK
         qiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaitsVdltlfxnCrmXDrXV4Fy/0lAltTGxZvgLb+i2SI=;
        b=jD7DhLY1uODM+1AdGFdOb1/Vj9oIQ8d0mfZUpsA31Kmtj8JXmjJsao7Rq6TFKubhXZ
         PwIVBb1C1vIXuUrY8IIHUP2XGgzIV9pmepe8+dlIyk4D1AmJ7JcTsLqIdbIQEdlFZsJv
         WRWQd+9W9INm4buhSrzi5neleAq7XE7rpKfal/74UN0TO8iQbIwYEvCGy29d6zpowGzN
         ITQ4e6DRSamtLWjxZwt6g3ER1YAexTwYjqSg7gTWTwbtT03ImkXZ051xMOEsCH2N/Xr8
         8Xyp5+oZKgmf822/9Wd5EklJuFrizjIzsPA0L2N55djYBJiWYy1PQHvzibIeX6eA0YEm
         jyRg==
X-Gm-Message-State: AOAM531pga0HCsgxfHq3tYwzaS0nBBTHbU3Ia7iq6Qx2sQZv81S+TRgE
        hl9IpS0p4oEE2lPmLw2vrnzcFD0Z+w3shK3b
X-Google-Smtp-Source: ABdhPJx95jsQlS6jf8iaAemrdhlfjLw/Iexx4XPKhoKvQaRIWtxHKdAkN8qSDid2ghbC7cVK0qduWg==
X-Received: by 2002:aca:5090:: with SMTP id e138mr3428844oib.37.1603850839747;
        Tue, 27 Oct 2020 19:07:19 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q139sm2324218oic.38.2020.10.27.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v3 03/29] completion: zsh: fix bash script extension
Date:   Tue, 27 Oct 2020 20:06:46 -0600
Message-Id: <20201028020712.442623-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5ed7cca3 wrongly changed the extension of the bash script
to .zsh; the zstyle configuration is for the slave script (bash), not
the master one (zsh).

For example it could be:

  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

The extension doesn't really matter, but it confuses people into
thinking it's a zsh script; it's not.

Cc: Peter van der Does <peter@avirtualhome.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6d451355fd..712ce2f4d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -9,7 +9,7 @@
 #
 # If your script is somewhere else, you can configure it on your ~/.zshrc:
 #
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
 #
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
-- 
2.29.1

