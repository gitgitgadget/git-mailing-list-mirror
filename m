Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830AC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4920867
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgL2Wol (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2Wol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 17:44:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F23C061574
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 14:44:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m12so33966013lfo.7
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 14:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjEXGk0E3sqNbBRUT4kYKKu2S9bqJUiK5YfbOh96Tbs=;
        b=bIzE0sKEYb8JvqB7coDqIlyFjbuoZnf1LSnQmVf+f4DpiQ6r7Hy3pJLjRaCFuKTALx
         mwrEoE2nAbbTkShXAxISQmhaMD6vjw/yuqVI95ddkxyuvThl77WbztEQRdjuXqmeT64h
         4gfT3KipBTYT0ulaHg+7hDLfUtfqCO6l577hRuz4XMjfDwgYFPd4TmoKrfe2c1zs8i3g
         I0cI9jocYSUmEtNK1QzMSYGNHVgEJBaJLOUFXxeSHHHsaYg+YNZmxOyLSIxCYrcgqVtp
         AssMax8Eh9YL5JwujwffyDlhzMxKhXOV2x5ns08JctGo7wMTx4K6v0Jak+/MKrgb2mIK
         GpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjEXGk0E3sqNbBRUT4kYKKu2S9bqJUiK5YfbOh96Tbs=;
        b=CKj4xkenrqzUMWqq9fQLk/2t1Kz3RH7Z5T+ZeDQEElZVRFfdTWanOAAAu7yFd6GKJO
         UdpLfbEbowwu1ZPpSch/xpPOJKGlThBXJCjXZCeyKgx8HLzEcHFPxoXVXXAKs98r0Jmu
         lmKYagXvrot9C4ze5sl5yeM/He1l7liM0ya9iU9DB+lCs4z96WUAAWeI3qEqaW+Ffjlv
         rKm5VEKMdnLzXMuArtjP/+Jq7D/pMKMghxq6qTC54x7PRL6gCgbf831yWye0rsN4jRul
         7DLOpIByvdSRsWsxm3LVgCb3xq7LJ+nEl/YGdkJmtqHDxq+wVY+aN6NawEIMtGwx4000
         SR6g==
X-Gm-Message-State: AOAM530BnRdYJOGDYL9kFLj3ncBNsavIp3UFLQf0oS1qFzehHXrKpuq/
        zSvCou+h3j4jW+DEjmliU5of+LNl3FA=
X-Google-Smtp-Source: ABdhPJzkVDimnipRUgCYtzGTaYSGf5P+EZMxHqnpK250klqSUxt74vMdyrUYRuHz8UxdiV/MGNObMw==
X-Received: by 2002:a05:651c:1031:: with SMTP id w17mr24007616ljm.92.1609281839186;
        Tue, 29 Dec 2020 14:43:59 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id o6sm7019341ljc.124.2020.12.29.14.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 14:43:58 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Ross Light <ross@zombiezen.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] pack-format.txt: document sizes at start of delta data
Date:   Tue, 29 Dec 2020 23:43:35 +0100
Message-Id: <20201229224335.8989-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1608537234.git.martin.agren@gmail.com>
References: <cover.1608537234.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We document the delta data as a set of instructions, but forget to
document the two sizes that precede those instructions: the size of the
base object and the size of the object to be reconstructed. Fix this
omission.

Rather than cramming all the details about the encoding into the running
text, introduce a separate section detailing our "size encoding" and
refer to it.

Reported-by: Ross Light <ross@zombiezen.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 v1: https://lore.kernel.org/git/cover.1608537234.git.martin.agren@gmail.com/

 Documentation/technical/pack-format.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index f96b2e605f..96d2fc589f 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -55,6 +55,18 @@ Valid object types are:
 
 Type 5 is reserved for future expansion. Type 0 is invalid.
 
+=== Size encoding
+
+This document uses the following "size encoding" of non-negative
+integers: From each byte, the seven least significant bits are
+used to form the resulting integer. As long as the most significant
+bit is 1, this process continues; the byte with MSB 0 provides the
+last seven bits.  The seven-bit chunks are concatenated. Later
+values are more significant.
+
+This size encoding should not be confused with the "offset encoding",
+which is also used in this document.
+
 === Deltified representation
 
 Conceptually there are only four object types: commit, tree, tag and
@@ -73,7 +85,10 @@ Ref-delta can also refer to an object outside the pack (i.e. the
 so-called "thin pack"). When stored on disk however, the pack should
 be self contained to avoid cyclic dependency.
 
-The delta data is a sequence of instructions to reconstruct an object
+The delta data starts with the size of the base object and the
+size of the object to be reconstructed. These sizes are
+encoded using the size encoding from above.  The remainder of
+the delta data is a sequence of instructions to reconstruct the object
 from the base object. If the base object is deltified, it must be
 converted to canonical form first. Each instruction appends more and
 more data to the target object until it's complete. There are two
-- 
2.30.0

