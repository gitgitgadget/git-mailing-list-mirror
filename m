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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712FFC4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604CD6024A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhHMJPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhHMJPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:15:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E39C0617AE
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so11110462pll.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQaM2pCdZ6/xsqjyfNVCIfzMUlR2erZA+YEMcVd+Bbk=;
        b=rgEw0sJd9iXzfR3d21DX4FAoLHRbRtiD4oF2dtH6fZUjWchDG6Pp51oeHBGmWqhYL2
         BuhyM8qvvyol5i9jIlB8vXhzQm9/3qHkYlQz5oHgt0GKfmHJ3TjFy7rNhhSIIVHLOADW
         aARdVbudGEK5/DfOBXBOdiMVKf7U0gYIIQWx2Ucd0Ol6+sPgoJFTEfifF+7+Uwo4WhzS
         Atr7CvbN2H8u8zW/vcDPqdiKzutF5vrHOnMKjdUXPQT0xf6cwktN0x82YNMS8xTJG5kZ
         wh8aslS4Ym4Sta48VXHvNiccnRwyLltVDZnJn55c4idhR/i+Ovjou6SQdks7n1q7kauT
         3/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQaM2pCdZ6/xsqjyfNVCIfzMUlR2erZA+YEMcVd+Bbk=;
        b=nN3imbZU/hFX3x8FnyTl2MbspACnr3CAdLq8I7Yox6f229y/MiN3AU/ClIpePGfe+b
         8KylrDeXjhOP90qqP491vBD7b90cQO8on5RPpKANUSxMpDu2cWAdxcR5LZNIOqk6ekvf
         j3vR9BXGGhAxEr+bruHdPiEoxibmHAHzpq3LXaij5YKXSgNDTpxLJsxxLU3AmDSbQU7i
         rkkXjvx+e0nNTv+hIXv2jkwkFArAZXk91Z7PNOwfFgZcpg95PdA787HcXxpAw4rtimO0
         3xwWTw/rLIpm/YQ08zsJAICow3aXJ4JwZNL0tvU8CZQq/J5CWs8YF7cqE652pYwiRTqJ
         Q54g==
X-Gm-Message-State: AOAM533hfDE03M3pO03FhrLEgnbqyvOu/AVpSXnatvP779KvILmAgDR6
        L6cFqMqDsG+ovOC4NnvvdAY=
X-Google-Smtp-Source: ABdhPJwqS8neR9qvIXz0kZl84GXmj/OZ2D+xSj/CRDECNUfnbmulx0oEKscNTW/gxn7I84TqeW1L3Q==
X-Received: by 2002:a63:cd4c:: with SMTP id a12mr1459973pgj.449.1628846120848;
        Fri, 13 Aug 2021 02:15:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.158])
        by smtp.gmail.com with ESMTPSA id p17sm1286968pjg.54.2021.08.13.02.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:15:20 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: [PATCH v1 2/3] git-pack-objects.txt: introduce `--uri-protocol` option
Date:   Fri, 13 Aug 2021 17:14:55 +0800
Message-Id: <307a1837196a1508963a70bf4c0c4ac5727e4d19.1628845748.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g0de8fe24d1.dirty
In-Reply-To: <cover.1628845748.git.dyroneteng@gmail.com>
References: <cover.1628845748.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-pack-objects.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 25d9fbe37a..16057b8c7d 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -313,6 +313,14 @@ raise an error.
 --unpack-unreachable::
 	Keep unreachable objects in loose form. This implies `--revs`.
 
+--uri-protocol::
+	Exclude objects which hit the KEY (the object hash) of
+	`uploadpack.excludeobject` or `uploadpack.blobpackfileuri`
+	config (See linkgit:packfile-uri[1]) in repository and the
+	VALUE (the packfile uri) matches the given option parameter.
+	If this option is set, but without a value, it defaults to
+	the value will be "http" and "https".
+
 --delta-islands::
 	Restrict delta matches based on "islands". See DELTA ISLANDS
 	below.
@@ -426,6 +434,7 @@ SEE ALSO
 linkgit:git-rev-list[1]
 linkgit:git-repack[1]
 linkgit:git-prune-packed[1]
+linkgit:packfile-uri[1]
 
 GIT
 ---
-- 
2.32.0.1.g0de8fe24d1.dirty

