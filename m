Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213F3C2D0E8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F332073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju94PuxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgDCK2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:41 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52315 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:41 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so2811619pjb.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7WgMkvwrxf20l0c/uKCm6S3ymQE2OFAOzsR/7Mu7x0=;
        b=Ju94PuxWbZci2vFpYFXRmnFfjtGEbLvn31tZBUvnWzyRhN10X8NegXJvbXuFsqjj/w
         CcowXjC2njhHM1SfLrytRSirkJO+eRhjUp4iK5Df61jJtCfPJNAG1gEvClZa58qwRcG7
         hRkdyK7Maz40/pBV4Q+E6UDMire4qtx7mNJwAbEBzyjxQFqk324A/pRci7svS+KiAuR9
         /A8UtG4jlFfRt120IrfIinjDvCP8RpYRsa8NVNj8Rj2YrUFABDUG7Lr3R2qJiLwYAfVb
         e1ms9gdhFmQKzrWU8r3Jq7yGK/xKg4i59SFkIIxzX3nonTGgIF8sMZ29/EMWfpK63phS
         9zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7WgMkvwrxf20l0c/uKCm6S3ymQE2OFAOzsR/7Mu7x0=;
        b=cV3Y7HWFV9GwXX3kMqysuPAqCgrAfWbHTG31jBmDHUB80LMaPNR0jOG8OzuM3fsw71
         6rFdL8yl8lAfCInGgPM/qgcHYMpYc7x4HEgeCT0AA4aussJF/T0L24dmj6kCMllQsLH5
         RomX4sj144No5tTkkw+yuQmVplSftC+jO389AT2W/FisLmNTfXCBoTw3xrgITG41wh2e
         WpjIo4glVoOqutYGGolUTJboZAm0y3IBOM/HglQe1E7rZ11UeBetiwqpNJAWyODTHAXi
         yDLGmrrDsEAQL1mj85rT/7PC0zulXvRxvGzgh9jvy93HgGBYbQHPLVsJWzwELfJl2suU
         weew==
X-Gm-Message-State: AGi0PuYRY9BZ6HYdmswY/jmKRUthz8NqsUWv+RFHznzVonZX84yK6NHZ
        vzO0qmlbvlNCvYzI2ShPD8z9IPCa
X-Google-Smtp-Source: APiQypLhSMOokWXpPNnyD9vKnst7t6L1lc6hC7GUW5nqCh3jWfdlgUiNtpu1E1VV6oX2t7wc7fj+CQ==
X-Received: by 2002:a17:90b:34e:: with SMTP id fh14mr8847611pjb.76.1585909719987;
        Fri, 03 Apr 2020 03:28:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 5/6] Documentation: merge commit-tree --[no-]gpg-sign
Date:   Fri,  3 Apr 2020 17:28:06 +0700
Message-Id: <685832b06965225fa2a7cefd5955cacdfb44d5fe.1585909453.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585909453.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-commit-tree.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index ec15ee8d6f..2e2c581098 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -61,13 +61,11 @@ OPTIONS
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
-
---no-gpg-sign::
-	Do not GPG-sign commit, to countermand a `--gpg-sign` option
-	given earlier on the command line.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand a `--gpg-sign` option given earlier on the command line.
 
 Commit Information
 ------------------
-- 
2.26.0.334.g6536db25bb

