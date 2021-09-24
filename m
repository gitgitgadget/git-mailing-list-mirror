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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA2C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BB6610C9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhIXCsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhIXCsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 22:48:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A49CC061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t13so2344214qtc.7
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=Wp1iQPwIkMOUfjuJIpcpJ6gLn1lSCD53lgZSvxASQFoCdZNyw6PDd5UuFcdz7Wz6Tj
         EKH96Jvh1I+RvrYbNHgDRarHbyqGxtlm5yd/lLoTXQv9qJ3pal/5D+5za8GxM8jFBLVK
         lRehWrSOVyDahrikBXoEJ5jsHq0OWvgBWNH9Pq1YO97z1NnHUteOKqJsf/n/6yA11N2v
         isBc05PEtCP+w9v285as6+dqgijQceo9p/O/wnMZD5CIA5rX+m4qQlIicuga7UEhtS5o
         eD/J6us6WKTWN6jXVE81uw89NWtnJetU+DPkKbNMyDsLml45Uv1ao83DSqnyQltNQIyo
         qUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=zGp4ejPe8a+vKrOYzTRtda2+JnouizaFE9EhJe2gIcdqX2W6VnuaepmQZnfm9qTrXy
         1zQJQbAJpBR2PsVsYlgJFV6Fl/QWwq56d3TG2t/wR8p8H/n+QZS9yKtgSAFShBFx+ANk
         pNSdvpG3kBTUTkooTy/+dTP8CJEum++o0JW8keAqS/qMEVDnY8uBDp0EkWPs9jeUmkbc
         rMdnIjb3IhEUQ9wCRNliEFi3JZBfti/ch3oRgEsK85Oht5DZqiFNKx22YFttMNgjPstX
         pChPYEt6kRmeccrIZHVpm0d50QHzJByw4YK9ya+PTITlnWsdawzgKLAB5bxMJ7zKpYVN
         9Zsg==
X-Gm-Message-State: AOAM531Ek9eBjHGJbuVj77QcQYS/0cI21832VqLpkZs+cvVU1BOX50/j
        V95PrsO4PShzZCAMinTBcio=
X-Google-Smtp-Source: ABdhPJzXe9X3wCk2Z512rzqBvFG2jHQOXSHXGKKmYlgv5Dj7hK3LoM5Lp4XyZwfHVITyh+qaOZvjCg==
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr2075357qtx.282.1632451624752;
        Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm5698011qkh.17.2021.09.23.19.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v5 3/3] send-email docs: add format-patch options
Date:   Thu, 23 Sep 2021 22:46:06 -0400
Message-Id: <20210924024606.20542-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <87zgs34ccx.fsf@evledraar.gmail.com>
References: <87zgs34ccx.fsf@evledraar.gmail.com>
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

