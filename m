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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537FC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED78561A06
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCXMbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCXMaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 08:30:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC62C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j25so17204508pfe.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFrmTRm9LjfQ2udU42UgiYhQZLOYOIWYgf2r13I5TZM=;
        b=u/+oW9us4Ja8+rsxLdt7IF2IkfOKbzZL8/sq5AF6pz/yksGeRyZnU0eOx78cvsojMc
         ZGFpaBJuLRgKsMNWFFBLiQXBYtLKht+XtHedXo4qXfNyZ2vdVUuZVx3YXkWSG1E0buDn
         V5I5JIGfsNSgxuYswCpi8Cti2cZ6jAIdZ3PnRBE7OBWaIXxfZgX28VauBzPCAC0wWe6m
         3ikwCLtlIS5VO8kz0Bj51qdXb8+JLrrsH5A/LWePD5cxYfCMMOffkNQMaf+K6JoUbf3e
         +yla76JldJRfSshl3zQyr8DQRpqPQTsVIkLSMmdMm7gZGZFUwuysZKTa1LboZiTaQi3G
         XAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFrmTRm9LjfQ2udU42UgiYhQZLOYOIWYgf2r13I5TZM=;
        b=FNADr/6rZ4h6PdSUwlDPvkmfYfqxAcJRHKRet2T8eOPo5HHcK85sfwiwmvfojAacoe
         NrbIfILvCnhas4KLzC92GAM9EdoMaw1Z8e0XtbzExqQXryLEU6IiHYTd80xep8Nyskzo
         ErZn3bNh852DEK7Iv2UTqewBpk3rhuw6A8iOFzaVT5Va1QMxDDH/cwrzc1NAOhpEs1hg
         cQR/LnhHEA4Jzbtvbrh4uUQ48Gh73WapZ5rLJVmBWcaMDVx4UIdxlNR6ger9LX94h7fs
         oWtk+RX5nYbRmWALRXSae2sFQbChwNJKRnj5BUdai1g9/0wgMTDxIGmjUXunIpTS/hn5
         51lQ==
X-Gm-Message-State: AOAM5328kciC00t7hYWXmXfkaI2lMSbDfdTy6WSrhHaRburJQ+KsDTVq
        p00FhjLXKVxFAOfVDdgPKl4MDhnL+bf8oQ==
X-Google-Smtp-Source: ABdhPJzEaWosQuSs5yzY4zFc+hibeNlPDA+SOwMl4rRVmoGgH1vfbdAUlExwaak6KTjms573VTQl3g==
X-Received: by 2002:aa7:9ecf:0:b029:1f4:f737:12d6 with SMTP id r15-20020aa79ecf0000b02901f4f73712d6mr2835181pfq.8.1616589050373;
        Wed, 24 Mar 2021 05:30:50 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id c24sm2443299pjv.18.2021.03.24.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:30:50 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] git-format-patch: Include diff-generate-patch documentation
Date:   Wed, 24 Mar 2021 19:30:26 +0700
Message-Id: <20210324123027.29460-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210324123027.29460-1-bagasdotme@gmail.com>
References: <20210324123027.29460-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff-generate-patch explains format of generated patch for text files.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-format-patch.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf2210..247033f8fc 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -718,6 +718,13 @@ use it only when you know the recipient uses Git to apply your patch.
 $ git format-patch -3
 ------------
 
+GENERATED DIFF FORMAT
+---------------------
+git-format-patch emits diff in generated patches. For text files, the
+diff format is described as below:
+
+include::diff-generate-patch.txt[]
+
 SEE ALSO
 --------
 linkgit:git-am[1], linkgit:git-send-email[1]
-- 
2.25.1

