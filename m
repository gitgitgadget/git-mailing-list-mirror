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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5DFC5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F37B246B0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unpgyZZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgKSBwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgKSBwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:52:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10FC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g19so3803467otp.13
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWoZtF1VZH47/ZAyIkPbPGCGbViAu090DExcf75tZRg=;
        b=unpgyZZdHn5L6URJm0dqNpGiM2Wa/8aCWs/kGYwOazMhaZxeHlg3GGvEXkI1Eq/BwC
         LW7ZEkG0i3VUltsCnwiT/39aPcsvw7cvpYmemFQaFvOT/6m6fYGKSXRy9XXz7ly7pThW
         kPnmhDjX+3Q2EvbYSTeZ/zCiTUbWz8zz4pe5rBjO4Fq1MvqDmETmH+uXO4hqKrz/K3O6
         ky/d6CR3ehfUCc+6otmdZhpQDlwgAfLNChQhsESyR/v58X0G+uv2Dw+EYJQzTS6f4AIJ
         4mxuBwc3P5X9bwfQUM+p2HbNjrWfAywmbZUP9lnx3nxxDXQIGDXtx1wWw4f37dMUcFai
         H3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWoZtF1VZH47/ZAyIkPbPGCGbViAu090DExcf75tZRg=;
        b=DZX1Ch/seks7jASWiVAf2LVFMQshKdnUir1K2l8PfiI37PaUyp+3HtqJSIkiZ45hY1
         GQy/5Y5Ovn54U78oGb9i7GLmDLs362dB1a4JHvQGPit8ypKF8lUui2f8QupxpdKWjXBY
         uCnzFRfOLHrYGQsqOImHis6spxyWAIeg7zIK6fd4UBaBl+hUOaOnm5qwnMHd+xK6L1wY
         ch8zJQNSGty2RtWgDlM9ltF+jcUqvqhz38Dmq7MiQJsemTYOE3It0xFb6GisEe1/TmO+
         1OtO5Yu0pq9/7PqATDhDoBdSQOG5pp+RtwptxJNO7/0PwPA7xr0XgIurqbg9cZUfVGHm
         VjCg==
X-Gm-Message-State: AOAM532/Gj428AckszY1uGZz7rdZ7paJoNGFBMpAAhpJhS43OBTPtYOe
        1rAZcPkXx9NVcGFsRXwF2L425xJ52Ca5vA==
X-Google-Smtp-Source: ABdhPJxwSyt8cT9684BAouMA9l/iLqKaN7WuR5ura5D4kKV76gU8r+NLEHLbTb1hOlyOFCe0t7Zy/Q==
X-Received: by 2002:a9d:67d8:: with SMTP id c24mr8678418otn.356.1605750739130;
        Wed, 18 Nov 2020 17:52:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x69sm6805363oix.1.2020.11.18.17.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 17:52:18 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] completion: bash: fix for multiple dash commands
Date:   Wed, 18 Nov 2020 19:52:09 -0600
Message-Id: <20201119015209.1155170-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119015209.1155170-1-felipe.contreras@gmail.com>
References: <20201119015209.1155170-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5b2dff150d..7e893abf43 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -412,7 +412,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.29.2

