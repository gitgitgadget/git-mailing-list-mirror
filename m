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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0708C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C31206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5R8MaCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgKJCDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJCDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:03:50 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D3C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 18:03:50 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id m143so12555944oig.7
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 18:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJSkwb+nnp1+3X42t7IHCAJsrcS87w5cD2qLxBum8Bw=;
        b=J5R8MaCaaVKzbnwbz+aJasu+HIcTcSXS2jdsPgNW/q4J8R39dNu795tZuESoxLVcCP
         WD5j70/ZxjcvNuG8HAiKEL7Im+zijf1D2WTXPSX/hGun0gmfDJbixnBXJh9iJZYNntMo
         pvUwfM6aPyibtTA4NSaiEcT6zDLW9uVZYvTGF36yyMZXe1qCxex+/zJyWZ8fxslDJmrI
         UOwjhgLuzGlykvvpjXDv5tFmOEUThKVIB69q8d6HqMCvnYkB6TwDH1MpX+GtVzxs5yQG
         vYhvTOguQ2W7qaucNfDNir9Yj3+6AJE8yHv7TNhi/QKDr/2N2ix5F7CK4F1WTxUM9d4+
         k/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJSkwb+nnp1+3X42t7IHCAJsrcS87w5cD2qLxBum8Bw=;
        b=o3PwAUciE56lQuRnsTWDZFVG13Qr9p5otfNRrYWvJF9RMrio8c/3l3iD1wWDhj51vq
         HLD3iZyd3OS8HsNfAueViN6kzFmkHA06ISZqltbyBfmXjzjfiKd0K80Oh4fRgii6KxaK
         8CPF45wKAlGtadShnHPWlDqi8u+EzXNgRTwTCbwbfJECuq+GSCzrHBkSzCaNWWTRGPik
         eUIysOHhVNaeWGmvmkPlWQadSeHoGA8K0pZ7t52d6HJ3HtaAuAzfeWA9twbF3aPB7h5p
         x1JdudDiD0rPluxFFPi/HcdS3O3dHx/lM9Wgh8WGKU6L0ASwZ0LXnhcjVkjrSskCCP42
         V9oA==
X-Gm-Message-State: AOAM530VA9HPQenrYYBYw9nEjw1Ta+L03/oiRTkkss5Hai5XBiP3PVX2
        uyT16lqRq5K9c3wcemil726I2aF2empNXQ==
X-Google-Smtp-Source: ABdhPJzD09wTDBQLYnZLm266Cu2YyclrABlpQDwRll+4/aQRpzqRw7gZroy/mB2JBcglM7Nt+jTvyA==
X-Received: by 2002:a54:4092:: with SMTP id i18mr1455853oii.62.1604973829674;
        Mon, 09 Nov 2020 18:03:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j21sm3018971otq.18.2020.11.09.18.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:03:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] completion: bash: check for alias loop
Date:   Mon,  9 Nov 2020 20:03:43 -0600
Message-Id: <20201110020343.548848-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110020343.548848-1-felipe.contreras@gmail.com>
References: <20201110020343.548848-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to be stuck in an endless cycle.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eb00d9ba22..ce0dc1e0f8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,11 +1121,16 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local cur=$1 last word cmdline
+	local cur=$1 list word cmdline
 
 	while [[ -n "$cur" ]]; do
+		if [[ "$list" == *"$cur "* ]]; then
+			# loop detected
+			return
+		fi
+
 		cmdline=$(__git config --get "alias.$cur")
-		last=$cur
+		list="$cur $list"
 		cur=
 
 		for word in $cmdline; do
@@ -1149,7 +1154,7 @@ __git_aliased_command ()
 		done
 	done
 
-	cur=$last
+	cur="${list%% *}"
 	if [[ "$cur" != "$1" ]]; then
 		echo "$cur"
 	fi
-- 
2.29.2

