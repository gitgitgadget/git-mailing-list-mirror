Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URI_TRY_3LD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB18C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7945F2078D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt2Uo7GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgHQMyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgHQMye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 08:54:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42EC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:54:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so17553752ejb.11
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Wlqi3sFtBlSbnC0TakA0LzAK3jX2N40lNR/8dAwKiA=;
        b=gt2Uo7GEUozCJUivet5wiE8NbqJQRWUrdBnvIHorkiXI4gyBFnjddeINkaCnZFnz5H
         BUW8DyXuHTZIwu0dLznflc0mJP22B1w392LwOAfCOH9M+sXIiYs+Gd4DiEHMMCHEvgR6
         B8Ll6HVGl0regGgOZqU3AVAQz91CicS73dayXArzxuwhEr4lZeI6B21/3UtPIypVCoKG
         P6W6PcpHcmNSW0D8s+j/AKwJkQFpz3NFkj4u2qQ5U+RtJ++uRp07D87dUbIZUgdYKXHD
         lEt1MkoYQcGEMQdF2fm5Fh8IZBIYHhG2gExVGZhTeL98WzEsrVdzgjmM3H7Kc0wjjMMH
         ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Wlqi3sFtBlSbnC0TakA0LzAK3jX2N40lNR/8dAwKiA=;
        b=CKLrzYKlsYIkVYVCa3F2HJFO5pfMQeMCUvEiljNPBvoudMHoSDSaIBhdQSc3/+W9WI
         MHfHd6u/yRAWwb1Ri7N0Fd/Yt/nduY4Hi/GZZt1KtghC/5PTASF4977OIVJDoep4QObJ
         7aZ7WEmAEXB6WWkNhXg18xpWDdIh8VmVsHLFU3NZVnyUfJqtBO4v/qWDH+gZOFdFnpJi
         wpJVf+t9ia2djuDVFip25Yixn4QLjZcgySnew86RYHveZCTbR/9TM9a8B+lcAJyI1Qs8
         5TDRlaooE0TH6DMvUqRQDHdAu9zi3OEQX0Hy6+8CMF4083GT0nVym6u89whwKNdS/J0u
         1O6Q==
X-Gm-Message-State: AOAM532fT0Xifb94KI3wScZlYM9kFPt1nTk3MIrGA1bA5KauCWDAcA/S
        glfB/tk8Vd343CFFQsIZXswLMZ7DlxS5uQ==
X-Google-Smtp-Source: ABdhPJwtytuegyQowK5IjeOjLcY6XxeYLlDbTdMr10UQyZFWdxe31O/sMFqcbiEbaC5QjH2AWoc2pg==
X-Received: by 2002:a17:906:4f8c:: with SMTP id o12mr15306474eju.69.1597668872925;
        Mon, 17 Aug 2020 05:54:32 -0700 (PDT)
Received: from glva-laptop.open-synergy.com ([213.174.19.120])
        by smtp.gmail.com with ESMTPSA id bc10sm13655878edb.5.2020.08.17.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 05:54:32 -0700 (PDT)
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
To:     git@vger.kernel.org
Cc:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
Date:   Mon, 17 Aug 2020 15:54:19 +0300
Message-Id: <20200817125419.1655-1-vvavrychuk@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like Google changed gmail security and now less secure app access
needs to be explicitly enabled if 2-factor authentication is not in
place, otherwise send-mail fails with:

  5.7.8 Username and Password not accepted. Learn more at
  5.7.8  https://support.google.com/mail/?p=BadCredentials v5sm13756502ede.13 - gsmtp
---
 Documentation/git-send-email.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..5aed3f5b1d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -494,6 +494,10 @@ edit ~/.gitconfig to specify your account settings:
 	smtpServerPort = 587
 ----
 
+If you do not have multifactor authentication setup on your gmail account, you
+need to allow less secure app access. Visit
+https://myaccount.google.com/lesssecureapps to enable it.
+
 If you have multifactor authentication setup on your gmail account, you will
 need to generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
@@ -505,7 +509,7 @@ following commands:
 	$ edit outgoing/0000-*
 	$ git send-email outgoing/*
 
-The first time you run it, you will be prompted for your credentials.  Enter the
+The first time you run it, you will be prompted for your credentials. Enter the
 app-specific or your regular password as appropriate.  If you have credential
 helper configured (see linkgit:git-credential[1]), the password will be saved in
 the credential store so you won't have to type it the next time.
-- 
2.23.0

