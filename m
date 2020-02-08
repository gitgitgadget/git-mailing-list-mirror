Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33BC352A1
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086F422522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqLVWYK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgBHJI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgBHJI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id z9so1578197wrs.10
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnSjfJACvq4RHTwJYBCS7NlP6qBafuboKWIT7deLTUc=;
        b=PqLVWYK4D6uHC4gEUoY6U+Whs/brTFL9av8NAeeevnEPujkaibDnmtTxQ7YEMhMX7O
         ZQHTF7nQp61IizQ6M3eHkoidXoQVxcZCnsWpe9P8l2/MBuwvoj55qWOJl3DsMetGSTlb
         wWL2T6EpPYCp3q2YxsWuKzJSve8SSe85qkL1ARiWyGshUHkRqyIorUuGGDVhfIuLIr04
         OxrlYXMQfILLihIxJZCcEo0xGIpysSOvWqsJOXOsenNFV4VgHNJko3gVT3WPxM5uF1Nd
         BOf3cEGoz6dUHORXeNPbRrbzJEVstb971oyJ7tZODiTe+4r2lZ8wacK3SOslWwwGkRPm
         aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnSjfJACvq4RHTwJYBCS7NlP6qBafuboKWIT7deLTUc=;
        b=tB4Mrd/EGLxylLmMjdz6T914z6kNETTih2bumZC6HMBiiGvqwfpVsftalbuXCnHg9g
         aqRdSDytgHlWQxw0qM+/LCalBkmJCY9ADdDkTrM6/RYSOvDVPlgFUxWAZM0qRQMfBvg2
         n2RVnWdd+l/CzZlOqhKsnH9U5MBUL79xXR/hca92KStvIp4C4DKg/g/Sp0MIYfyPFfZg
         wey63vy5noQHkKBCypG8RYayDg5Ci1nKdPnOr9VDRRkOUGLl2ZVpOepIv0EKqrP7JWQC
         6OjRaVJF7vmm9HyFmxyv9jWdX8h6UObkF+OZEmPTRRLrw74NJfl/WYxWjJCS1zjLFETt
         YPVQ==
X-Gm-Message-State: APjAAAVkxqKso6WN+4oZ87KjSfk/eiVC/RisHqdk20eAyAPdNVoW+Xmy
        XHlYBJiNiPW2LCJXHLsuA7v62MAN
X-Google-Smtp-Source: APXvYqxX65eCi4c9aY3yVEruelxK8PiCRP1fM8tjSO/2Mxeyb5vw7K5xBqw8BOLYNHF9NnfDumVnWA==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr4297630wrm.89.1581152904959;
        Sat, 08 Feb 2020 01:08:24 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:24 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/13] bisect--helper: convert `vocab_*` char pointers to char arrays
Date:   Sat,  8 Feb 2020 10:06:52 +0100
Message-Id: <20200208090704.26506-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a pointer that points at a constant string,
just give name directly to the constant string; this way, we
do not have to allocate a pointer variable in addition to
the string we want to use.

Let's convert `vocab_bad` and `vocab_good` char pointers to char arrays.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1718df7f09..36c09b7238 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -52,8 +52,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 	terms->term_bad = xstrdup(bad);
 }
 
-static const char *vocab_bad = "bad|new";
-static const char *vocab_good = "good|old";
+static const char vocab_bad[] = "bad|new";
+static const char vocab_good[] = "good|old";
 
 /*
  * Check whether the string `term` belongs to the set of strings
-- 
2.25.0

