Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DEAC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6304960238
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhBHTpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhBHToS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:44:18 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5315C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:43:37 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z22so11219456qto.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvCWsvX0e+YyiTPTnAT4gz5MGlq/WfrHGA6L/iYsrgU=;
        b=MHpht3s8b/03rJGSdzEaJ2bgNJ/feN6i2AFKag9w13oHcqeGSbN78Wx/BxkfFSF1tU
         gNO46+Y1OUOwwC+HW7OgNXkFurj/S9EmssijAiQjH9sBMBdqmAZFgilFYZbpmihBh6zt
         9OP7lsOWQxfKAGWzH0aX+1Ctihz2T/KwcRwUFW1Zy6gE6VoKPLMbuiIL2JDpAlaq/4Zg
         5Wa0pUuzlG5dkZ2fQhilyPParlseuyOUtrwu2FoboimrfK8DEoFdZ6us/e56qZ1o4ozq
         ctJw3qXMCzCmXyEc6oBWFaAxgO4aMim9pjLP4emgal/BsrNT/JU4Yxgf1hVWDtEqqKYs
         OvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvCWsvX0e+YyiTPTnAT4gz5MGlq/WfrHGA6L/iYsrgU=;
        b=hnwtZuU0JU3Y7uh39yT2xIaA3/QEey1gQT6hLv4SL0FIXwYcmUPqlTRvg7MyDHuc2p
         GgGl5DBz8C9qShS7cYEnAF8CheWMB5ZdzoE7WCds/8VyBHKTjnKq68Jn9ZoVTLsfh4L+
         ySHCOuLlqLP7ipRQse+gGpPwYJQdzYVLecFwc/nuAHSSXPchjjYaj8es49aUixVTQ6yR
         918gPLA/VD3Lgfjge2jpnEKH7m0U699aw0mqzO31fYgFq8i5V4hszMfnTQ3zXnDYI0/Z
         tbXu0HBTHKDnPU7u+/xBVx8Xg6Ru7O53zvsLmcjlawpcew9OOKs+NC7r64Le9JNevr7a
         vjRA==
X-Gm-Message-State: AOAM531xNXpxTSb/Ynd0iN226gW2lOLTJeqbgAJAMLhAh5FChB43Z/EI
        /oZBWmA5mJnaM98VxkbBAlfGD5lpFtT8Kw==
X-Google-Smtp-Source: ABdhPJwv/UVoSolG3y5MCfzjIK4s/D3gIN4+IzjyxfbiEuEnEq8gZQbHBSggBUYekpFIZpEGucD5Bg==
X-Received: by 2002:aed:2847:: with SMTP id r65mr5199280qtd.79.1612813416708;
        Mon, 08 Feb 2021 11:43:36 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m190sm8005930qkc.66.2021.02.08.11.43.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:43:35 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH] grep: error out if --untracked is used with --cached
Date:   Mon,  8 Feb 2021 16:43:28 -0300
Message-Id: <5bd9dce8f611c5fe380c9f58dbdfa2dc6d2fd51f.1612813249.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options --untracked and --cached are not compatible, but if they are
used together, grep just silently ignores --cached and searches the
working tree. Error out, instead, to avoid any potential confusion.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index ca259af441..392acf8cab 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1157,6 +1157,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!use_index && (untracked || cached))
 		die(_("--cached or --untracked cannot be used with --no-index"));
 
+	if (untracked && cached)
+		die(_("--untracked cannot be used with --cached"));
+
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
-- 
2.29.2

