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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E554C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF67B2076C
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbhAACR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbhAACRy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:54 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA5C06179C
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:39 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d8so19295361otq.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFMYNsUY0bWAAlEv5whrrZD11q9+MPhECHL3R1oTBcM=;
        b=Gon2WG349j3SMFSDYUY6EhfmyC307bkQZcCP3klaLvtvs7WpzCQLqES02ezp22Pmdy
         Wxop3v3cfgF6uxTEDpCduagR76cdgGYnS2qtjn/lU3jDjzUvlWAglAPJNoFGmUJ708Lz
         m9C7Hm+kh2oD0LIh5HRgwrfhNhoCnXjmZN/pwdFRBPheE5QSbozJ4wW7Ty32LH4+A4JH
         2qnjFtofZQVsRFVlhlU/FRnyCsizbDzVLr2sTxrTwrlFN19SDOcEWUwjGsL5l68y2JCE
         rLvCuX8aFr2kvJKt6Txv8r6zJEqwHDwSaMkdQZ8YUjlrL8qjDn0DcTH6TZxSbr35QpBX
         vUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFMYNsUY0bWAAlEv5whrrZD11q9+MPhECHL3R1oTBcM=;
        b=U2qIAx7UJcuVPfesWqk28F/ZbDVXAAof8TXGF6B8c+yIHpF4zzAJnK3vCxupF2phix
         IYRg7hUzhjivXNVBSEIkEG/MRcm0ifC9033QeWxSoLRJeuvHsZhkaEfk5qp7Z+fY2OGg
         LJtzMYaMtVyjPdsg7z1xtOUzcPju0jwEjvVdPZq/zSbwF2fFxg22EWMCsuufwIvWXFR1
         dv6FtqA9hungDc5uUz1jUmcQwGg+KIHw0iJA9Wel/MYZhco1NbUfS7gs9k5YILv1OQN1
         SiJyysPKGYG32uZo+iP80J2Udj0bn49uORwd+XTL1RXyhCx4ZKieZuTFXWC7HrWNfyhr
         UsZA==
X-Gm-Message-State: AOAM531E6gCIuYmLQ2MJbDen7N49ee7TjZgncWO8zB2trBMN/RhCrcLf
        ErcyQr7EDaDnrohIBWDeln0e/dCZcPhtJw==
X-Google-Smtp-Source: ABdhPJz+TZEA32y6cMdklIXVTrlMyI8ehZOsNmriLjHRc9Z404e2fvAG1PS5LhowtZEc5c5NgvU1zg==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr43574678oto.243.1609467458619;
        Thu, 31 Dec 2020 18:17:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m15sm7255796otl.11.2020.12.31.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 47/47] completion: zsh: add higher-priority location
Date:   Thu, 31 Dec 2020 20:16:22 -0600
Message-Id: <20210101021622.798041-48-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bash-completion looks in /usr/local/share first, we should too.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 43b7c1b210..0024fd742c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -35,6 +35,7 @@ if [ -z "$script" ]; then
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
+		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
 		'/etc/bash_completion.d/git' # old debian
 		)
-- 
2.30.0

