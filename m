Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC1C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB53611AC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhDQMyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhDQMyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8732C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c15so20296569wro.13
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7nkXpLvDQSmUmWxN8t07u+AqQcyw2Yv3pyX2SqgoIA=;
        b=Dj81mb/92/6e6HbHSTIFELGfXRQO75/4NUJwltuQ7zBJJAVi5yNfaICjwBKFYjkizx
         QVej8CLyvjPTc5B5v8wxqGyiyXRR0VxZwBDJhA8KCfD4mEHZMHBrN7JSKlk6OAP0By0X
         RslCVVoU4L/t6HkPyCqG8G4V2qKv9Ho+IB+M8TnNf/bfu2WZjwJhH0aEop2uCzziwX63
         aQ/2Xm6411Gtd3CPuL+XzmHpbJg48pXbInUeRg+XT5WI3I+SbU6/DQwRz8N/IKkT7CPa
         LWI9tsTw9oMwtAteJtN+EuNtz4X0B4TYBqwVk0R+k20ZuBXDRCDy08uhj64HTqqTXZBs
         kTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7nkXpLvDQSmUmWxN8t07u+AqQcyw2Yv3pyX2SqgoIA=;
        b=Nhz7TFg15GYiOOotw5xvumaD0h5qh1g/onDAANcWKeTTomkizHpe5HZ3H5/Jh8h4Y8
         Rfwr09NNTDtQ6JKKYB9NpDBBZVy6uDvVIYxvbkH9V8DDkqM6DcZRZBPnQvDTuuY+F+f6
         PWpQhWJhH7MUNsU/NKGXr6nJ567Am0a2aDQyuJOLVRgG8hyutWUeCU4OHRPlmubKyfb7
         2ce0OiBCKrvLHmguW0O2rPT8KZ58sk8O/p+1lFg+zCEAtANIgP4iZn58bZ08yGuRKOX+
         AEybdnJYmY/KOHkTee0kCbQuJo0dyAJScQmiEn/nbONmkpM3EU6DxjxN7iM278xFuIv6
         9j7Q==
X-Gm-Message-State: AOAM533aTcRa7ombKuIS0ckS2KWVusBbkBBkGPbjBCoec7gMy+djmG1z
        g8IKHNuwLI1sn/frdVQTz5F0Z8r76oHNSg==
X-Google-Smtp-Source: ABdhPJwphQbHcASUuJ6Ba/0wHLYzNgkeARRoWMGEmsiKABq3/33lBrCsDkOxq8S2M3UkLoUxDKce5A==
X-Received: by 2002:adf:a703:: with SMTP id c3mr4304987wrd.72.1618664020336;
        Sat, 17 Apr 2021 05:53:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/12] test-lib-functions: document test_commit --no-tag
Date:   Sat, 17 Apr 2021 14:52:38 +0200
Message-Id: <patch-05.12-c916d648e49-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option. Let's fix
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d169fb2f597..d0f4f3885d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -177,6 +177,8 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.31.1.722.g788886f50a2

