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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF8C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F761029
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhDQIog (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhDQIoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:44:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDFC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 01:44:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so5384751wmf.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur8hZ4nABbWxQzlDgZt0xiQIG4Uono1AG12C8A3yo40=;
        b=HNwqv0+Bal/TZ3I09B0hd90chYc7tmoXAbTDcf7ZPB7wOIN1fspA9IhZXX8Tnh/ecb
         kN0aM7dhbAEzkw3Ybol6hJNvQTiapz31VzEZpSP67wvV1k0afGb+s1zvdWc+M7yyfBPm
         J97oMQto8oIWOpn+c2Z8kFs6xsxEmN4LIg8jmrwKC9kojLP+xbxlKggBtzNk8s1Udq8a
         seCr19ZY5k3CHQIfl1N9NipwpgkFcfXxNfJlYv5Z9cLOC0JWPKJxMhOXSSHb1xjuWiJ+
         Y76/tSDzywhVBSXsAc9+lbTFWO+Q8uY0jbtY80Da+PJJlrE7/z5+W1bFqvu3J9aWuAuh
         3g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur8hZ4nABbWxQzlDgZt0xiQIG4Uono1AG12C8A3yo40=;
        b=gvy7f3IPvhQy3iCUnQtvcIY4yr1h64TkGOGp3fC2xQBPX9DGSb9RDHb6PjtjYxOCjS
         g2u3kgYm8wFtOq9+nqjrkag0PqN9moqpNC1H7Pfkvm0s6IrojxlC43KuQY3o2+XFjBVC
         hHuDPvLHMrEqlAakCozRhFxwYWZiMSXqWIxIdLdPpGdnmaBZXXYpLpGx3CnKnbus86H4
         s78MxFIPdBXojRZ/BUlyIMy/4bKj1GbIxeDeY0ht9aNuRv3MCKTLzteVksY1qO02HlQz
         njheVbsuOGqwNVsipdxP9OeadOFkhiku5NwhBz7OT5bBnTal9re8uzBbtAN54jRbV2ne
         bPXQ==
X-Gm-Message-State: AOAM533uN5m7JBv+QYIz7yiVcIJvk5CZP4J2QZn2Rio4GBziNPKLEWp7
        8K8uhzlMXaHKqexYghHHdMHaYlAd7Uo=
X-Google-Smtp-Source: ABdhPJwBfttUpUkkqcWseUl3A9LL8Wlad68m8GnAyQDwlG3qNEfmuOTNP/znMV1EbNuUW4gUamjYLg==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr11507609wmb.183.1618649043924;
        Sat, 17 Apr 2021 01:44:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h2sm12109947wmc.24.2021.04.17.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 01:44:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-2022-JP?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CodingGuidelines: remove suggestion to write commands in Perl/SH
Date:   Sat, 17 Apr 2021 10:43:54 +0200
Message-Id: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.687.g1d87aeed692
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a suggestion to write new commands in Perl or Shell to
experiment. This advice was added in 6d0618a820a (Add
Documentation/CodingGuidelines, 2007-11-08).

Since then the consensus changed to having no new such commands unless
necessary, and existing ones have been actively migrated to C.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c98..b9cd55db6a8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -416,11 +416,6 @@ For C programs:
    that are made available to it by including one of the header files
    it must include by the previous rule.
 
- - If you are planning a new command, consider writing it in shell
-   or perl first, so that changes in semantics can be easily
-   changed and discussed.  Many Git commands started out like
-   that, and a few are still scripts.
-
  - Avoid introducing a new dependency into Git. This means you
    usually should stay away from scripting languages not already
    used in the Git core command set (unless your command is clearly
-- 
2.31.1.687.g1d87aeed692

