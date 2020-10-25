Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3DFC2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A48D22260
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG9HY9ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766836AbgJYDN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766825AbgJYDN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C73C0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m11so5075115otk.13
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gM21t5RNgX6Rw833LeyYvcWvxBjeRN/KBdYwBcavsbQ=;
        b=eG9HY9ejLDL1GYG3X8Tr29VIE8BazUNcu1G9Vp1N+hge9kAnx+bghmyn3gnwrdz+wH
         /RhhZrxyIxwUF+JNI/wO0mqEF/1W6rJJHl8bfhYT2GEpaeKHWS5bZGkQSFf5H2KMS9Ez
         AAs+ltPd+NzhUowejvX4yENTHEUNFx0rC8haU5rrD7QJV36h99O8QDD4uF7oC1oAFmYd
         pbAWdON4hzJsaMg5/jlZFnSuZoqPnTHgu+8+hQz+IyKvUGcTSTrVs1oGSyEZQyyA1gT+
         Pvlt9HojC4H+k9pDOYwQjKiLo25d+lIY6RrzY11ANM210Hl1P/aUFgiAEfB+iEuMID6O
         TX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gM21t5RNgX6Rw833LeyYvcWvxBjeRN/KBdYwBcavsbQ=;
        b=heOfOw7WaAT29xk9bBCJFZ9BmaHPBq2/uFYs00siATqA7XzxLbUme/vku6mAGAY1lM
         C8scADkYd3jRSw4YCC8dpU3aghj/o+qNaWQ0rNgejBfspLI2FMet5VnqexYPvX5D7fcA
         n6jEuQ3PfmKTTY1/66MuZKCmdqdZNPCkVbmUbOuoEoHkSb7GJw+zZt0ygVIGJ6tfqtCc
         4nQDg3jrtl76iKSd8ZVtZVBVy4TWHsbGk3vTF0Jml6ABqiBB3tnuNjbaI2YOknyBADfa
         1q3eYGTHIZDx51hU8GcMTEEOzqAQK7LqENF/iCmT9F/nf4XN0nZ1mctOdl50rz1j8mIe
         FLhQ==
X-Gm-Message-State: AOAM533ZtQa7U/YDWm4c3Tr5aVA7QguRx+L49J5VwYJEyz1fXOjNmJ0s
        c43YTEKIKPV/rjrgz/0qS1T6OiGDXUy9LA==
X-Google-Smtp-Source: ABdhPJwXIHGDLbTxPOXWL1+8w3RLjUYvXGr0yQE0nAG4CVnYUPjJv1TqOUR7aMkE5+SiKWNbpYpIpQ==
X-Received: by 2002:a9d:3e4:: with SMTP id f91mr8810581otf.244.1603595638212;
        Sat, 24 Oct 2020 20:13:58 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 9sm1647161otp.72.2020.10.24.20.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/29] completion: zsh: fix for command aliasing
Date:   Sat, 24 Oct 2020 22:13:22 -0500
Message-Id: <20201025031343.346913-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of people want to define aliases like gc='git commit', and zsh
allows that (when not using 'complete_aliases'), but we need to handle
services that call a function other than the main one.

With this patch we can do:

  compdef _git gc=git_commit

Additionally, add compatibility for Zsh Git functions which have the
form git-commit (with dash, not underscore).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index ba41525373..17041d0b23 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -240,8 +240,12 @@ _git ()
 
 	if (( $+functions[__${service}_zsh_main] )); then
 		__${service}_zsh_main
-	else
+	elif (( $+functions[__${service}_main] )); then
 		emulate ksh -c __${service}_main
+	elif (( $+functions[_${service}] )); then
+		emulate ksh -c _${service}
+	elif ((	$+functions[_${service//-/_}] )); then
+		emulate ksh -c _${service//-/_}
 	fi
 
 	let _ret && _default && _ret=0
-- 
2.29.0

