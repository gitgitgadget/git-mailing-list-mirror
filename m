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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B81C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3A920760
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 13:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDbHM0MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgKVNdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 08:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVNdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 08:33:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4EC0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 05:32:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 10so15358294wml.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcbi/5OC22znXRw5QZEWvv3YMSImiaeO6HYW/7Q9KFw=;
        b=tDbHM0MXeBW0iDQeFRc68oTyidG3/E7bkLT2ITnnLvSTJAn+FgwhcviGp/lZk+e/vg
         wY1C89j0UikNBAYAmLQdr4pgRN1k0gMh11dLFeeVI+bqTekfohDVh367MrKPwuT8QkYE
         zb7h8gNpasU5kqIsQL5cug3KXd4yRA7ITyLJQWDmgwMVV+UFzgoUz0um9A8YpB3uJYv9
         o9Xb7PMJy+A4Xvbk7rUaWudvmHIG1dyag72Kl+bplT7ZDiNsmaNA36ATQNTe8WILc+UW
         xIuaTTuDCgtzIY5JAtoRL7sdsXLWnbh8OEd93UdOiYe8mqAjXRCxWuGbq3qZXWYA2U0l
         HQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcbi/5OC22znXRw5QZEWvv3YMSImiaeO6HYW/7Q9KFw=;
        b=IZTqTZmSQPyTFMq1FYBzpfforZp7hRU+cL1UXCnXAoevYysoZX35L09k4kumkH+UBm
         LamFkOysiu3fguLphPtTpO6BSgb6HaorPMAfKeb2jS5aONKwOr7af29zujMn4+47tjo7
         Us4FrD0/rFcMhXyKnOk3g5iQrmeC6JA35eGBXo3xLSpXS0G1Dv+r3ASQyr3nZZlr7IHQ
         /C62xV+EQFydpppmJWEUMVdzGQSJpJ/gdnhsIhdWnYHDsNcfdq/grUfC1Tm8iq3T49nm
         x+IvYDtuJqsCee58vCRu6/grDlhbEO1RF7YwuB1pnt6/AYyMdc0FpN9opo0ZH2ru5o94
         l6Jg==
X-Gm-Message-State: AOAM531nuxCYUBuGyiz3CpJSWCIZt32vrT4EFeWTAmH6GdEHDO6lcLsc
        ToGGVzt/vlD7uRel7kTaTCE=
X-Google-Smtp-Source: ABdhPJyBlb+jqyWe+HxiClt4wyQrTCC1adDSkM6VtMjKHIbUJcvkx3S34vCEe3PwDB4p0uQM4vDX5g==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr18225448wmk.125.1606051978515;
        Sun, 22 Nov 2020 05:32:58 -0800 (PST)
Received: from partizan.lan ([46.98.123.94])
        by smtp.gmail.com with ESMTPSA id s2sm11102105wmh.37.2020.11.22.05.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 05:32:57 -0800 (PST)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     stefan@haller-berlin.de
Cc:     git@vger.kernel.org, me@yadavpratyush.com,
        Serg Tereshchenko <serg.partizan@gmail.com>
Subject: [PATCH] git-gui: Fix selected text colors
Date:   Sun, 22 Nov 2020 15:32:33 +0200
Message-Id: <20201122133233.7077-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan, please check if this fixes select colors for you.

--- 8< ---

Added selected state colors for text widget.

Same colors for active and inactive selection, to match previous
behaviour.

Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
---
 lib/themed.tcl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/themed.tcl b/lib/themed.tcl
index 83e3ac7..eda5f8c 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -34,8 +34,10 @@ namespace eval color {
 		}
 		add_option *Text.Background $text_bg
 		add_option *Text.Foreground $text_fg
-		add_option *Text.HighlightBackground $base_bg
-		add_option *Text.HighlightColor $select_bg
+		add_option *Text.selectBackground $select_bg
+		add_option *Text.selectForeground $select_fg
+		add_option *Text.inactiveSelectBackground $select_bg
+		add_option *Text.inactiveSelectForeground $select_fg
 	}
 }
 
-- 
2.29.2

