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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8297C2BB9A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AB523C18
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403946AbgLJTEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390475AbgLJObL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:31:11 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D4BC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:30:30 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so4391934pgj.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKgz0zCpdr5vhn4a1Qj2+HeQE70qszUVaGsBeRrqs9k=;
        b=rDhLNI0CPpo/G6wrMYtIrlZNFJ0fuY3Emg2slA83ZaRfX+Sdn+BfWh51E3oyTJzR68
         74rO1AXJESumaQjkQZo0CCcAmFawGrcEtQs3QonqM/S5oPXOcWDrfYgS6VFjdyd8+YZz
         idsEKukaiocEsekYvj64aZUExGGJ0OMX+h2ChmEXSTexUPYEjFs6cvUs3v47HbvJvxFm
         uWErrFx5Oh9jPi1gP8HH8XzdWtQOlGucXxWCSVxS2XTSIBvIsO3clVXOzCjyoa/wNICC
         U2RSjfJuEAY3+PnsAvfHVPi+0+3c3stM86L+kHBQ7cuJgfMD50n5mH1EdxnzhSwxguvw
         xa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKgz0zCpdr5vhn4a1Qj2+HeQE70qszUVaGsBeRrqs9k=;
        b=iRiZ90RcnMOuclNDNRu0acHyopcr/7e3zPQnhu6l+9Pr9dCSnVrBZC/qHBcUMOyhHZ
         zCqclAzlfvJoXrp8w1R1lZeWlsrptK8nM7+cgMC6PkKbN4CGeS6UwaBaBCEMSUi7J2XP
         BOvCuMfeCTYVe0hF18qqKIUaK8O8VVDek/zpMjlptfuM5GY1S0z5W8z5GdopqlpFOTYw
         qeL/JgAfaxlSpCoN6C3VXYA7eQ5SD2sg0SvCdUnTacHX2gbJe92kVFwYUSfXH5lPsGyd
         /QEOzhe8Wbv3qSLf8NLs80W5Fug0Kh8xBw40wXFEgx3UMun7DcAITmUUfcWlUVLqT9ah
         0gcA==
X-Gm-Message-State: AOAM5301T8Ja7MdYAqY5Lwn0Ahep4hrcTWCf2nsJtTP/xbJr7JYJT1NC
        ZBs6+vYzdbviDmTNtQihw7OXw0jbZkYmqA==
X-Google-Smtp-Source: ABdhPJybd+WJ2fBk+5P8M1xEIW0emLrLYkBVjBtv1jRBBXkl/p0K1WB0eEY3rSnNrtbo+t+q3YbiaA==
X-Received: by 2002:a63:c26:: with SMTP id b38mr6878036pgl.333.1607610630095;
        Thu, 10 Dec 2020 06:30:30 -0800 (PST)
Received: from athena.localdomain ([2402:800:63a8:f620:b9b1:54d8:784e:d28b])
        by smtp.gmail.com with ESMTPSA id u6sm6637507pfb.197.2020.12.10.06.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:30:29 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] doc: mention Python 3.x supports
Date:   Thu, 10 Dec 2020 21:30:17 +0700
Message-Id: <20201210143017.24615-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0b4396f068, (git-p4: make python2.7 the oldest supported version,
2019-12-13) pointed out that git-p4 uses Python 2.7-or-later features
in the code.

In addition, git-p4 gained enough support for Python 3 from
6cec21a82f, (git-p4: encode/decode communication with p4 for
python3, 2019-12-13).

Let's update our documentation to reflect that fact.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 INSTALL  | 3 +--
 Makefile | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index 9ba33e6a14..8474ad01bf 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,8 +165,7 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
-	- Python version 2.4 or later (but not 3.x, which is not
-	  supported by Perforce) is needed to use the git-p4 interface
+	- Python version 2.7 or later is needed to use the git-p4 interface
 	  to Perforce.
 
  - Some platform specific issues are dealt with Makefile rules,
diff --git a/Makefile b/Makefile
index 6fb86c5862..a751065b24 100644
--- a/Makefile
+++ b/Makefile
@@ -303,7 +303,7 @@ all::
 # modules, instead of the fallbacks shipped with Git.
 #
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
-# but /usr/bin/python2.7 on some platforms).
+# but /usr/bin/python2.7 or /usr/bin/python3 on some platforms).
 #
 # Define NO_PYTHON if you do not want Python scripts or libraries at all.
 #
-- 
2.29.2.299.gdc1121823c

