Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018AC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8F61ACE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhKRPqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhKRPqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 10:46:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B4C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 07:43:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so8516678pjb.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 07:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2wTPGdfWGbXqoNzODZFzp9rwCYUOtYrl4DzjQYi8gE=;
        b=SwanUy/C7wJRFBltk0P7KDP05vNMW+4y41gsUPgi8kh0AoL+ugQJz7Hb+fu+H/0db2
         SCkaMYFVnnY3XhZirzIRCdY3pRJtIeutVE0gUaZ09EMagZfhZ87sBAki9uJTlaGjpZFj
         GtB8Hh/l8UzUP3XYMxjBXu3UoSv4EbOtQuG7wsCAKYAR74ZFozfEkWp2JkhF99/JXAxZ
         iB9PpBjGXU3GVL8/gbCtjjcfZOWAVZFKEA3PPGkhVXRV6st1pN8lQp5oWgbXIJqvjnPL
         dgGrrQ5h1pUTPAUdkexNYjAGHLZ88R1bs74zEEjQoubb52s6EIunNB4OQNfCFRPSoFOB
         6jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2wTPGdfWGbXqoNzODZFzp9rwCYUOtYrl4DzjQYi8gE=;
        b=b18fvippah43wuc7glyHIDRd/7pP2ZTnRdNDqTRnvJAUguL+CYIlMIbFd/EMmXRzug
         eD6cH+tsiti9PkM6qwELYtRxnWJeBW5yxCLdJvb0/W9r1F7zoCZtVZELHj2GetNvAlgz
         Bx/FDPfq8cjCLCfq3zHyiPOchIEvIBTa088ff3z8VNmhLpLU8hN+KKtbYZrcWi7gXQRd
         2XVG77DF9tQRrOOGAiJAr7nCF/GVMvMUeqXo4kq375eHJjXg8LIGXZw7aNx/UNyDmK8T
         Y6PLHk4OochdmzXizRZqQw4RE84grJPjQHN+8aggeOIt2rTZzLQ8cXYvVDkiiT5RSEPt
         vn5Q==
X-Gm-Message-State: AOAM5317Sjna3wZ8WUKMmMW8wEm2FPiRT1RakRoUNIt+Q3v9M54AMnU2
        B1PlkQNsnHv3XJdeyaKgMOLX3OyQVEE=
X-Google-Smtp-Source: ABdhPJy7j1aBjGt3yRSy+2kMu+HuY04xqlFg8ImjT2VW4IqSn3e8CtVs38hfQR85H6ct07A3rpm3Yg==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr11904886pjb.236.1637250202356;
        Thu, 18 Nov 2021 07:43:22 -0800 (PST)
Received: from xavier.lan ([166.70.246.164])
        by smtp.gmail.com with ESMTPSA id z12sm26687pfg.186.2021.11.18.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 07:43:21 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        sluongng@gmail.com, matthias.baumgarten@aixigo.com,
        sunshine@sunshineco.com, avarab@gmail.com,
        johannes.schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: don't say that merge is "the default strategy"
Date:   Thu, 18 Nov 2021 08:43:17 -0700
Message-Id: <20211118154317.639118-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git no longer has a default strategy for reconciling divergent branches,
because there's no way for Git to know which strategy is appropriate in
any particular situation.

The initially proposed version of commit
031e2f7ae195069d00d21cde906fce5b0318dbdd, "pull: abort by default when
fast-forwarding is not possible", dropped this phrase from the message.
It appears that leaving it in the message in the final version of the
patch was accidental.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pull.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 127798ba84..590f15bf9b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -970,7 +970,7 @@ static void show_advice_pull_non_ff(void)
 		 "You can do so by running one of the following commands sometime before\n"
 		 "your next pull:\n"
 		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
+		 "  git config pull.rebase false  # merge\n"
 		 "  git config pull.rebase true   # rebase\n"
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
-- 
2.34.0

