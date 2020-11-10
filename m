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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67610C5517A
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1461C20789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCKD9Q8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgKJAxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:53:37 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF30C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:53:37 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id y22so10911254oti.10
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYYOAoWvmF237MFx0dlAMV00xr+Fu5tQZOKl8pfDlGs=;
        b=iCKD9Q8FdJbkAhrEBbRXLH4x7pxOI6oSc6NxgJAesMgcl4EJA3YWy7Xvu3jR9SUpqm
         j0AujPv9J9Wb/xXpGftXm1nJHqMdZFN7tOiIRYUOshN2RwAT1wRxYio2/nQGZAh4YQ6f
         4h/3v2npkjpopsYNKZMNSx3nprFn9oJE/Ta7Vea63edWi7m53QZrwGz887inNlNJYx/k
         jZko9FrzFwEzCDT4ilQJIX4QYOt5tz3RexDlpO8IxOy4aEIhjiVtINC4pi15y8OFIvcr
         5jj/IOTJQyUUO2pwEKR3GbsOkuW72VHw9OOLnDLg0gNjEu/tJ0tZa9JbQSOhjhNE5FW/
         Dc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYYOAoWvmF237MFx0dlAMV00xr+Fu5tQZOKl8pfDlGs=;
        b=UDLwKeSIedHmY66OVfuA+v3R6I5NUpFLN/JU3mVdfeuEB7O7dlUxt7lu0sopEL0QL2
         B/chZwTB9FjMe2ZG5mJS18EW/6sTVAy20uiHyT81LS++TgFe2ddMQkvDDFXzICwfxIp8
         8keB3Rs2mmzFkmvzmtGMHT0JpeFu6oKDwkrhvCADU6fhs8Aw7s1//ZYVfetrMk2MJ8PZ
         0XMcPv8sxxEXJRW7oEh7Lw/Is22xGUmdiv2xngjqJdx/VlCO0+6YdtEj4t2VTOJXoGCG
         v/U8Ejx9l5tzZBBuTZ/kdh4cYfZf/XehS+7elWKsccX8pV8ZfnMkbeFREfyFMG0tunrn
         wnOw==
X-Gm-Message-State: AOAM531xgo0RletplU5hmARumDYuRUThR8PMmPl63aE0yiPLxdkZwnoP
        ve276POtqQxSLMFD57RQgofZVxDZlcgmpQ==
X-Google-Smtp-Source: ABdhPJwzetkCxjcsIkWswVfCYGLnVrO+RskVL8a/rRNM7NJOlX2srRkFe/v9+AebUHiF5ZjhohCbFQ==
X-Received: by 2002:a05:6830:18d5:: with SMTP id v21mr5299678ote.136.1604969616499;
        Mon, 09 Nov 2020 16:53:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v144sm2766018oia.21.2020.11.09.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:53:36 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] completion: bash: check for alias loop
Date:   Mon,  9 Nov 2020 18:53:30 -0600
Message-Id: <20201110005331.532678-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110005331.532678-1-felipe.contreras@gmail.com>
References: <20201110005331.532678-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to be stuck in an endless cycle.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 59ced25641..bf2a59f95e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,11 +1121,17 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local cur=$1 last word cmdline
+	local cur=$1 last list word cmdline
 
 	while [[ "$cur" != "$last" ]]; do
+		if [[ "$list" == *"$cur "* ]]; then
+			# loop detected
+			return
+		fi
+
 		cmdline=$(__git config --get "alias.$cur")
 		last=$cur
+		list="$cur $list"
 
 		for word in $cmdline; do
 			case "$word" in
-- 
2.29.2

