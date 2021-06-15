Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC403C48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C42616E8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFOQVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFOQVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:21:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20716C0617AF
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y7so18966977wrh.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWdRKor0LCe6A+fJrLCyA0h/u6xzQyjAIHZFUG3e56k=;
        b=Xh1sHmZmQQJcFvJSl2R/rgoJUNJEXaSIliN5sck12/TSWEdomATu6KDPcJUZOk7VNh
         9bwREgLgiwwMWZuCcqASv76lI45CNLbF1MU3ARky9Q7R3s3Z3zCmJPRbLl2GnGFQkQ1z
         HrDFEHO8QlkG9Y0goLHU4xgH2yTlfEco7CzW7jX6/EDG/FvXrRAlyGI73DwnNSm+jHoa
         e38Qeaygd0F5Cx/WtceEM1Zc9eq9RWVI+CvBPL6eeivs3ykrYrAd78Ywpy4b5bCoNCvD
         9cwEppJZzbKrZNz897np5TuhMIlRIit2b0rLE17zYtFDo0Wk97actz58+9rqilX93qr9
         q9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWdRKor0LCe6A+fJrLCyA0h/u6xzQyjAIHZFUG3e56k=;
        b=h6CSh6M2PkgiqxVXTZ/0kGwqbLqw4sABlZHH29T78yA8C+OlCS0GjmkabBXi+XdKBO
         gMKwiJ4ERaIDIR5LMuTizY/DpYHL0HXLIc+sQBnJ1Gir5ifkO4IWg85H1pTeZ4DztKdn
         mRsm2qKz1kgfIyoGh7G0Z8vD4g9iZQgeFmpegBX380Cog+EYG1G+vxqOY/xhOoUyIwgJ
         UoSlkxq6GG0RN4wEOgxFdwF/8JKyZNHGz4dv/bpjNbpznzmY/y7Mc5l7jnT1giYafgBm
         wg8IkdsyK4ggHw5MCPDA3eXSF5qvniSVKr4+wjBJyKPPrda7SefJYi2qhmCFu93WQKBH
         wvlQ==
X-Gm-Message-State: AOAM532wGRXe9jAeWB8XMgkjTOOnfNG2zbCX6kMHLUhqf4bzvQZEoF+X
        ovFZcAl3naWQJbd5pIe5E5NVPpkWSvJIMg==
X-Google-Smtp-Source: ABdhPJw55DLN9QSJJt2YvP6DFrMARgI7ZpiKzcqH7xpWIDRFDyXOLvcTWG0Um33P9RbeQCBLAPho+A==
X-Received: by 2002:a05:6000:10e:: with SMTP id o14mr26421702wrx.76.1623773951530;
        Tue, 15 Jun 2021 09:19:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:19:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] pack-protocol doc: use "www-data" in place of "alice"
Date:   Tue, 15 Jun 2021 18:18:03 +0200
Message-Id: <patch-6.6-9c4a7545cb7-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the example of "alice" in the pack-protocol.txt documentation
added in b31222cfb7f (Update packfile transfer protocol documentation,
2009-11-03) with "www-data". This is now consistent with the recently
changed examples in the tutorial and git-daemon documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/pack-protocol.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index e13a2c064d1..0f43a290e59 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -136,10 +136,10 @@ directory, because the Git client will run:
 The exception is if a '~' is used, in which case
 we execute it without the leading '/'.
 
-      ssh://user@example.com/~alice/project.git,
+      ssh://user@example.com/~www-data/project.git,
 		     |
 		     v
-   ssh user@example.com "git-upload-pack '~alice/project.git'"
+   ssh user@example.com "git-upload-pack '~www-data/project.git'"
 
 Depending on the value of the `protocol.version` configuration variable,
 Git may attempt to send Extra Parameters as a colon-separated string in
-- 
2.32.0.555.g0268d380f7b

