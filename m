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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ECCC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C9C64E9D
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhBHTcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhBHTaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:30:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78961C0617AB
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:29:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so8353520plh.12
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=uuSs55hsuD6Q75EV2Z7d0KuJmgqHEr3jrtosWQ0BbEyO4USOG05bmxZglxYBfy3RMM
         Y1ue++mteimw+6HEystJaH0yvyXPNby+jJatf3exVoxm0UQx5rxPv54LcDJgYX8lq9ak
         B3AGOq9ogxcr+YzAsg2uuudE59A0JPjiTJYGQwqBJZ4kmeT1FX2QJmqbJs71C4dnFeTK
         472rYHS0fexJWmVY3YHumyNVwb53y56gJO0dtunFYAlS9Afv9TxpGhb1irmXwqWTuzMH
         kS58Lt0h7mFrHSLl3H0hi1JrDVLjpz8+sVZ1WkSHXAPhvxzFxy0vHMDFXk/jMteHshqV
         lVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=LoxzMErTZeMMHYdYorPbe3OnZCYYEVeJ86Sla90aPOGvJx1AZjwFuZxV0EwmRr2y3+
         8w5C8RpqGJQ9G7SNcj8lmheZZkBFLOMfqiWEbJSKac54ysmWoOTvRekj9o9YxQo/JUT4
         cgK0FbbXOXpkBUpRMDqyFi3g0CTHtJ+XBevICBJ3hn0WIQMkjcqCdAt9IMscSWdT/zD5
         y5AcdFgJqOFsuXM3xHNJ2j9wAKKEl09Rm3PkajjYoOpHSqfSAxq/opR58XeqWbhVc3nY
         kcMzXutmyzABODM2Vo/8BmhIE21yqE1hXGISnbaH+NxP6jk2XQHYjLeAQw7jRIKyElbG
         gTyw==
X-Gm-Message-State: AOAM532hOu5eitgqgbHM1oQgkht464F7QV7YO/Q7XMHfDDkY3LTxt/H8
        76MCQjZBf+sdDrCedPRjkJz4CV98Lm/9Sw==
X-Google-Smtp-Source: ABdhPJwmOmVJVag193dRnW9wXxq+La3vOwhXBtmQnYRydLvQHOHh6O0kXXvIHyuQP4p+tc/dNYEOlQ==
X-Received: by 2002:a17:90a:5287:: with SMTP id w7mr364554pjh.52.1612812561908;
        Mon, 08 Feb 2021 11:29:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:29:21 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 11/11] doc/rebase -i: fix typo in the documentation of 'fixup' command
Date:   Tue,  9 Feb 2021 00:55:31 +0530
Message-Id: <20210208192528.21399-12-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a6903419c4..8bfa5a9272 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -894,7 +894,7 @@ is used.  In that case the suggested commit message is only the message
 of the "fixup -c" commit, and an editor is opened allowing you to edit
 the message.  The contents (patch) of the "fixup -c" commit are still
 incorporated into the folded commit. If there is more than one "fixup -c"
-commit, the message from the last last one is used.  You can also use
+commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
-- 
2.29.0.rc1

