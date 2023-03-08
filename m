Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D06C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 02:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCHCst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 21:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCHCsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 21:48:39 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597B91B4F
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 18:48:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id e21so11230446oie.1
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 18:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678243716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoBLLgJbr/8xkHUtVW8dNOECVBa9MMPVckleJlY4oro=;
        b=i2ApE7fLVELsYRKcKFsvy11hWjQYD/6gpOUvQzrBhqFAjmdbEx9DKKtzjqHwaECA5i
         wS9Cs2tg/eC24G5mBuz0ExR2ofoxrpnwv4tistMQx7HHbLV3oDBCYMp8fX3m2owsBjYO
         TYy5UW3FH0lJuvQ7yNWqsjpkyvpOgqylaov18SdRr2eEwkkNhkPHZhFyGN/2IOOBW1Ch
         28zr5OLkEdoCOgTszWIwPrB8KB1eREwTw3rjdO+mUN64WVBuW7ntIi/rM8uDHLkaYG5c
         LWEJeuDMxrzfJeojfQuGjbrqRxG90BC6u4Qgy0sm2cbTXvu52S23Jya8GxEzKVZXAPfa
         aHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678243716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoBLLgJbr/8xkHUtVW8dNOECVBa9MMPVckleJlY4oro=;
        b=IejbVbbokmTUN8KKKXOMb/+bXLBq3nC9c9tx0pWOzsZAXGkg+xo4kaymm7qzU3CLCp
         LQUJtV+MtUdF3nm6EpDddhy1NIakqFSxA/kOkBv56L69W87E093B4lR9AVpMaQH0wzhZ
         JQBOVBxiJuu1NIK29vP6Re/K8h/36OlME4eYngEbbE/fIAWpWhlNi96We7j3bfJMlFRi
         1Exk9UsEouiSwtVV5gONg5heQ5LMlMfhv5CBXuqIe2Nxuv2D7DnQweozmKG/QIGXRyiz
         v07P3kstkiJHgK2U8+JmhOt4yaDOvAbUPfByUUEsgbbkIACpYQD5EsoktLHhSLi0BAmq
         YmuQ==
X-Gm-Message-State: AO0yUKWw1JVxBJcs35XWVLqXrE1xdTnlLZp+3GDceo/YbTqfYzVsmuON
        /Sc6ICd5HLA6XfHGZDlPYhubFvjLIfg=
X-Google-Smtp-Source: AK7set/VowEQByQGynciKPRNsWSfqleVDITbPGZuOD9fijC2b0XDn/bzisDUjqdRHc74/waY2Tk58Q==
X-Received: by 2002:a05:6808:5c9:b0:384:3695:b6d5 with SMTP id d9-20020a05680805c900b003843695b6d5mr6654290oij.19.1678243716766;
        Tue, 07 Mar 2023 18:48:36 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i66-20020aca3b45000000b00383e9fa1eaasm5854406oia.43.2023.03.07.18.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:48:36 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.tavb@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] advice: add diverging advice for novices
Date:   Tue,  7 Mar 2023 20:48:33 -0600
Message-Id: <20230308024834.1562386-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308024834.1562386-1-felipe.contreras@gmail.com>
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user might not necessarily know why ff only was configured, maybe an
admin did it, or the installer (Git for Windows), or perhaps they just
followed some online advice.

This can happen not only on pull.ff=only, but merge.ff=only too.

Even worse if the user has configured pull.rebase=false and
merge.ff=only, because in those cases a diverging merge will constantly
keep failing. There's no trivial way to get out of this other than
`git merge --no-ff`.

Let's not assume our users are experts in git who completely understand
all their configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 advice.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/advice.c b/advice.c
index fd18968943..c3fb631f93 100644
--- a/advice.c
+++ b/advice.c
@@ -217,6 +217,13 @@ void NORETURN die_conclude_merge(void)
 
 void NORETURN die_ff_impossible(void)
 {
+	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
+		"\n"
+		"\tgit merge --no-ff\n"
+		"\n"
+		"or:\n"
+		"\n"
+		"\tgit rebase\n"));
 	die(_("Not possible to fast-forward, aborting."));
 }
 
-- 
2.39.2

