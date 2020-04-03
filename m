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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC64C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B217D2073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz+BflgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgDCK2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33124 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390580AbgDCK2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay1so2554219plb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VJ+ghKNYZisJ+c88OB5GwMi51ao6YznAWZMEpkchz0=;
        b=Jz+BflgRcTYiB+fZXNLgJltT6WKpooc0ZbeC08T0UyMfLbiIZ7riI5yDNn9EPdgnwQ
         ZRbThzhFQzeSYfCPH8TJGIbiXCJ9FFV67PqcRnC3akkW7Nh0yRqh/VZ/+pkXwT+7TeeT
         qqtIlkE/h/cn+wOk5o+kmPCwcxh9GAMWLKGKVS6+NhxKeyMoDzTRfbStxcZ1X24ngHXV
         GFb96umJtaA3rbYwxVNKTWY0bKH/o21/cMUP89iuppcHfUfoB9DTpvc2bUrJo/MdeFa8
         fOjW5PJEssaiFX0TUp9Zbip4TCUwMrtH/0KIlit3x0JmoVGHuOyuMB5xyi2ro4nvvbqn
         tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VJ+ghKNYZisJ+c88OB5GwMi51ao6YznAWZMEpkchz0=;
        b=Qo6pqpPw15wYn5R42sus1hfzp9FZrxjHPBkyb05DERoeN909FVJIz7SMIXn2EWzlIH
         8BFan1rKVk50l6cpGLrn2g+OO0DdHqS/vr5iddJpRKMAB7VYI8ouYLItKOYQBH/SeXVH
         vJz5AttPQFGEQhvcNsRz78HENlNhNpghYfw/f+oBlyfbap/XiHeR9BrtNs5NX53GBLIB
         9aBvEQiBO47QR7gyhtW8Rhx5soahh4D9S5TdqDiZzVvSNxXHTBoctN+o3xE7Ui6eb0Hp
         87+jt35woPPCytxd9eDpVHf/W/YgP1UexLJe5or8QDHd2nC2jEZOhCEYoMde+s7CMQ+y
         lXSw==
X-Gm-Message-State: AGi0PualyqdHJgboqbmQI2aqVHxwkZpOQTEXLlitKub6EC1C+dsj9gHw
        3TjMA7EpC2lPTKGpEtkDEG4IzAky
X-Google-Smtp-Source: APiQypJAgDKjlCl/qIo67vTdFb71o3qoZo4+G4qxgNSClTJC7hCMbVCMw6OkaCARxCzyLI+BH4EUXg==
X-Received: by 2002:a17:902:5989:: with SMTP id p9mr7296006pli.279.1585909718516;
        Fri, 03 Apr 2020 03:28:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:38 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 4/6] Documentation: reword commit --no-gpg-sign
Date:   Fri,  3 Apr 2020 17:28:05 +0700
Message-Id: <1b952f7348c285ef50594a3b29907daee56ed2cc.1585909453.git.congdanhqx@gmail.com>
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

Merge with --gpg-sign option, and clarify that --no-gpg-sign also
override earlier --gpg-sign.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-commit.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 13f653989f..a3baea32ae 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -348,13 +348,12 @@ changes to tracked files.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
-
---no-gpg-sign::
-	Countermand `commit.gpgSign` configuration variable that is
-	set to force each and every commit to be signed.
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
 
 \--::
 	Do not interpret any more arguments as options.
-- 
2.26.0.334.g6536db25bb

