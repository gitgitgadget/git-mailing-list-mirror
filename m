Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07A4C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC33206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1nNBbbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgKJAxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:53:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27264C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:53:39 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id c80so12399268oib.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yZJp71wQBVmMikEVj3tXsR+7lfj3OMfW7PAqKL86tk=;
        b=M1nNBbbSU34QTU8O9f6L6ot/GAxYAwiF/aUkTOIvYCWfSA0m0X9m+3BhrL40IyDsxT
         LTS/lWdpglGbvU3fBHZyzUl/CVoMIiaTjXPapuo09W7VgvWL1JbSpzT3/K302TuzYBCs
         1zN7BfBW9hwWwPIRrxceEiqSyBz+HynX0ms6Qoj8XW2wchEeoYP+4hu6+qBjpNHbaL0N
         wdZnXZ0CpBYB9050AEPJtM0TDDLfEEU3/T7zcCj9Dur5DdAIMKSPcOFdhrDHXk6uw9lU
         XoxXIHEBzGsvV8WRGedkgnwsMLen99Sofj6s063buMCJR2fr/c4EE13nPh+a+TfSHl7m
         tvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yZJp71wQBVmMikEVj3tXsR+7lfj3OMfW7PAqKL86tk=;
        b=sCJ0rCAunpaT4YONlXnFg05IWXFG0037vF1IA1yslzbp24zxTmNAlOvWSPtav2u2uK
         18IOdUEOlFVc6QZv4GG0WvwVee3zdrndO9b6ETJTn1TyN1KXdVzxwz0kQiHmRGhKVcuq
         luFVuhOO8NZxXluy0zwLca4sEKkzK6v2JO8kr7KGiapkGDrtqzVE6ShiwzJAwqX4K7FU
         CvNWEhEgDHHOT42lW5/pQBVKHbSuBHYHWCPVuwg0N46VBeaksScVvPYiNjVJAX7hPu46
         PzwED3dbhWmSbKW/OLAwHVVE/bgHV9oqfYVGukON/bkxKenS4WgNhtSXm7xow/IqayJd
         KzGA==
X-Gm-Message-State: AOAM530cUWW4y2qSE07DKaGJjf9R0X3KyPb/SqOdvIdGXLlvzyUBSF/4
        pO/8S1I+rj1oIhHrg24ZH08R2YDxJq1e/g==
X-Google-Smtp-Source: ABdhPJw5NHTgh4RA2jLpGYrLJom2ictqwmBpvGO2RGxacGUVW86ZQU4Kc7ewVQHJoABmYankiNNFKA==
X-Received: by 2002:a54:4082:: with SMTP id i2mr1289361oii.28.1604969618359;
        Mon, 09 Nov 2020 16:53:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 8sm2861669oii.45.2020.11.09.16.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:53:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] completion: bash: simplify __git_aliased_command
Date:   Mon,  9 Nov 2020 18:53:31 -0600
Message-Id: <20201110005331.532678-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110005331.532678-1-felipe.contreras@gmail.com>
References: <20201110005331.532678-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bf2a59f95e..ce0dc1e0f8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,17 +1121,17 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local cur=$1 last list word cmdline
+	local cur=$1 list word cmdline
 
-	while [[ "$cur" != "$last" ]]; do
+	while [[ -n "$cur" ]]; do
 		if [[ "$list" == *"$cur "* ]]; then
 			# loop detected
 			return
 		fi
 
 		cmdline=$(__git config --get "alias.$cur")
-		last=$cur
 		list="$cur $list"
+		cur=
 
 		for word in $cmdline; do
 			case "$word" in
@@ -1154,6 +1154,7 @@ __git_aliased_command ()
 		done
 	done
 
+	cur="${list%% *}"
 	if [[ "$cur" != "$1" ]]; then
 		echo "$cur"
 	fi
-- 
2.29.2

