Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AE5C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAC761214
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhIUPyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhIUPyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:54:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D837C061757
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f130so16796574qke.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=N13slBNxmpgFuai2uvvsQsLdRUO9/57yzRUiAVFXC8Dore6gvJxOH7Hg3dqH2naVgw
         F+QOioiGUM7YhhfX+c0jMq58jvvYq1VocB/8oya3w0O/Nt3SawnMJweqlld8RS2D4y67
         2W6qwHyfzVQUbqhFkY99Unn3PwCtnmuf6WE4LBTvGOPtO3iGcg1/xW6JCETX/x4o8ezz
         k+QkAb3L4bPJ+csaMvfkFZBd2J9CVqVujmj7m51F+EElCDk+wa97qNeZf81lLrje28Al
         fhM4n93inZgj0yDFNi5fg3w6rKPZSBRR9if4TCokb0LMtwcOp40SODKXSvAtAJiGF6FX
         68vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=VL5g0HQ+INldRJF3wg1SZqYzmonrrfa5Im9nmVyVgOAg6FjX9jhlQMnoIvTC01CC3V
         JfguawbWk+mCV10A6wWfhHGhxi9SyZKzlzzF9OAOec+ANF7KLBv35IJKdOWuIMO0ubBX
         ZmBVWuehcokNeou8KDCq5TgKkzwoNvDDXV9K4RM1lCimvApIUHybH/vA7C5zQcfOKzrK
         3DuKbwxweLHrGTOfpORIJOu7rWHbLzp/Vr1LLxqB59D5zmdfH6qcsCAooqEZp6nyDZDw
         QyfjUPHrRBQcDbKcKnHMkN02/DLpPxBNRnbwbpL1KJJedcTsy6tpWRBfr85oT+0F06Lf
         t2cg==
X-Gm-Message-State: AOAM531owQUVStKN+TevMk5C2FxpzzoQIBFUZ0wM7SF6arQRF3kVIZtZ
        urbVgGH4mMuEMbsgzv5T5AJSvtWGTcI=
X-Google-Smtp-Source: ABdhPJxeji7qVTvafXgd05e0V4sPLpXT1lraexaMtPsVu91C/eCD9LLHn207L5QbTN7ArZBJ6/7aDg==
X-Received: by 2002:a37:6241:: with SMTP id w62mr8075275qkb.444.1632239554969;
        Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id z9sm4956124qtf.95.2021.09.21.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v4 3/3] send-email docs: add format-patch options
Date:   Tue, 21 Sep 2021 11:51:52 -0400
Message-Id: <20210921155152.4215-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921155152.4215-1-tbperrotta@gmail.com>
References: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
 <20210921155152.4215-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email(1) does not mention that "git format-patch" options are
accepted. Augment SYNOPSIS and DESCRIPTION to mention it.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..41cd8cb424 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, as well as options understood by
+linkgit:git-format-patch[1].
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
2.33.0

