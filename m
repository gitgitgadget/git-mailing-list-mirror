Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98CC433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D90E208A9
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isJpz59S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgH2Pjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH2Pja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 11:39:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C832C061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 08:39:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y2so2126597ljc.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urhHZG0hAEfBjSdKoLa54fiCeZQ/hafTo5FjUcWLqPQ=;
        b=isJpz59SBiHFvY7ZqHKL/R/N0PYaaYrbCTqC0eA1lL7YOKXK7wFGz939O/UHv3SKi5
         +pNsVPrBhIdrOd0MxlakeTh4NO9Vq4olpvYl22QA00E33Y9qJ16dqjfz03vXfKmYL/0w
         vybKaHlinC3ZIX+lJvqBTtVmsQ8ddYhpnkYKgCPOGBHINnPIOtEJpWV0Nb6Vid/Jat+p
         Yczo8Kc//AQ0l8nq9qrLTp/7vjDq5P8PAfcdVMANJxeTj84pCzYeHVS9mqQk9r/ogv8q
         tQ4fRGuu2bxXm6KL2BfKjN4aUAAjoa7+oww4ii4Q59FBpd7uyjY19FxwEmeYPHoWnyO9
         LcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urhHZG0hAEfBjSdKoLa54fiCeZQ/hafTo5FjUcWLqPQ=;
        b=BjLJpPjG1weBWZj9VOOJ41yE3HqkdEocTIFddQb07w1Exvb5YLvokzOObWdlADbzec
         rkKiw7FPl2SNcjClSRWUgnl64OrpT3NBQBQtHA8VhQXruWQnOiFXH5ZpGIQWxr516ilA
         Pt1iK2/+lSMENMm6XU6hxrB6zqMZLA3M+n8ij8z6jqhCsdHffIZaGVPr+VxcuaX/mP0a
         2n+XXuIhQd7J866DRv+5W3bm87F7VLTpoPMuSANSK4kAq3ePIXKNSvYIgICMFdAB17Bf
         mvLSuYxcATV43bAN990c7XlfX0CbN6OZy/matICKey2Id0yZTQ9+7uyzheiRlY9QYjrl
         pvDA==
X-Gm-Message-State: AOAM533h4lz+qrqQGPQaLjgLjmA3fN+j9CWShKvpJA5BzsaoxXvAzIEm
        KRigRAixn9R3v9zTp/HHbCM=
X-Google-Smtp-Source: ABdhPJxv4zJd8xXAzGEUzNyEgKCBEDYOhYbaoc7YUmuMC9RmvCniKfTvjH3vkJU4ODdwFILjNGgKGA==
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr1625111ljj.461.1598715566891;
        Sat, 29 Aug 2020 08:39:26 -0700 (PDT)
Received: from glva-laptop.open-synergy.com ([178.212.102.126])
        by smtp.gmail.com with ESMTPSA id h19sm685591lfp.39.2020.08.29.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:39:26 -0700 (PDT)
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
Date:   Sat, 29 Aug 2020 18:39:20 +0300
Message-Id: <20200829153920.17155-1-vvavrychuk@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
References: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like Google changed Gmail security and now less secure app access
needs to be explicitly enabled if 2-factor authentication is not in
place, otherwise send-mail fails with:

  5.7.8 Username and Password not accepted. Learn more at
  5.7.8  https://support.google.com/mail/?p=BadCredentials v5sm13756502ede.13 - gsmtp

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 Documentation/git-send-email.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..06953fd1e0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -494,7 +494,11 @@ edit ~/.gitconfig to specify your account settings:
 	smtpServerPort = 587
 ----
 
-If you have multifactor authentication setup on your gmail account, you will
+If you do not have multi-factor authentication set up on your Gmail account, you
+will need to allow less secure app access. Visit
+https://myaccount.google.com/lesssecureapps to enable it.
+
+If you have multi-factor authentication set up on your Gmail account, you will
 need to generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
-- 
2.23.0

