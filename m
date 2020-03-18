Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B2C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0720768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naupt8c1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCRHgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:36:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36543 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 03:36:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so8304871plo.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PcuICo2NfK9uMGnsnK+9/xBY0HREA6iqACvzRcj/UI=;
        b=naupt8c13D2l2rQRWh1zH6ZMM0aJNQTQRc9nkPwaQifUcOtqsYm/NxHzq2FyAtpaku
         CloQEXa6HGXKTkbLZ1bCeZs/QRiGqpb1NqgD+ERVm8uREmISqpBcTXiT5ue881yuqZJW
         KXAOWDLHs/ky7zxWHleYErlboTLygPVKivmBJtBn3ES0vBOoPikdodb+f8QNqY1VgQxd
         rfeF20lPlvEuqbw0yNVleRsPMuWG9basUFy6nDJI7Z5ASrN5JUFBKqW5HTuT9VW1Swg6
         0uW2CqApaDvBiD+OTFfZulUQiHHQHnFhpe5Bj7Ga/MMl8HDKDHJ5qr82TAlobKNFi5x0
         arOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PcuICo2NfK9uMGnsnK+9/xBY0HREA6iqACvzRcj/UI=;
        b=t67oIN1C2D+zy/WMLQYoylpQBOvnF/cziS40RCb25k/OuXorkuj6E9M3rTrj39OtKI
         1vMYv3ea80U1q1JnOm81nyz/4R0a9ZhBQti41CwqeB2d4C+dwfCLn7/7Aodp2HwtpRTM
         fod8UEEqjG3X2bl3nz0v8zMH+KFZOgKuTGHbOEh9mOyg2hmATxQYyDg2NLxdmIYjkJ9x
         ofRC/29H8ZRLm8p2pNY3vMOqGddbwSfLdKwFdLVt/UJDNxv33Bl2vV5Z599UY+4eYU92
         Mi7BSS81RQ8yIBxdQZMxQ79L9wR2Jbag9kfiqYo+MqnIRtW8T+P2CNmTnoe/yuYkeJR2
         r75w==
X-Gm-Message-State: ANhLgQ0fRBl2Wb0K7UZ2VePg/vBt3FaW4pFhAV3dtkH3saAhfH0QuNjT
        WqJUlUFEuWMSyoOmSA4xrXv2ZT9J
X-Google-Smtp-Source: ADFU+vtjxnaYEk7FJqzj72uO+Hj3xbxYU9kVe4F7QvJJxXxQGG7LJ/HmnPetvSPcKCXSdYEvIELmuw==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr3096154pjb.83.1584516997596;
        Wed, 18 Mar 2020 00:36:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id 129sm4674336pgf.10.2020.03.18.00.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:36:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/3] configure: respect --without-<package> flags
Date:   Wed, 18 Mar 2020 14:36:17 +0700
Message-Id: <cover.1584516715.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current git's configure script allow --without-<package>,
it rightfully set NO_<PACKAGE> in the beginning of the configure script,
but overwrite them with autodetect later.

Respect them now.

P/S: I'm not sure about the change to NO_OPENSSL

Đoàn Trần Công Danh (3):
  configure: respect --without-curl flags
  configure: respect --without-expat
  configure: respect --without-openssl

 configure.ac | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.26.0.rc2.234.g969ad452ca

