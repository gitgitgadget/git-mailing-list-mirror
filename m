Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44231C7619D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0AB2064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gctrySRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgBQIlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51746 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgBQIlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so16201938wmi.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnSjfJACvq4RHTwJYBCS7NlP6qBafuboKWIT7deLTUc=;
        b=gctrySRpckAd9KlKZzXATLcGLHmVZbOw40AkLYUnOExbGfAK69UyRk1syIXX7csoF5
         GADbg4Rs4fRhKX5IcwzyKiSmqeIC3yjUYv0wAl5acObqPsLsVfjOvCw1wy6J2uJJiutH
         ThbpELiZIjUQycU57uTANV3CeaWarL91I9pu39RKGwM3Q43F7+RWW1jNqSfyDJa9ayOi
         JBOP/iSxLRKRY/hSWkva2NQP20PVVNlqBZJRKeMOXrSwHCLtMrK7CkCdL/oqO8HknZ1M
         E0bR9U4WWJlprOTmnoaWzkzgKjOlix3O7Q+QGyB3twuSFCvc4PLC6rvrmbtCT6qavvnw
         5lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnSjfJACvq4RHTwJYBCS7NlP6qBafuboKWIT7deLTUc=;
        b=s7JYS9MtaFcjl6K+AAyywx2Mm09GQiJNnK5sgOR1NkJooq89GEZKnQ3J4/f/1YZOzV
         TmPDYPbZTiWSGRuKvgNIRsPmqXf+NBCk8UnrlOZCpdnNtooMd+2hjbSMHCfcfNoxYvCM
         P5iPGqzwCwdpiSGhZtaDtwI9ONkai8QvU8GV8gZp1xHvkD9eb4hIx+Ar3KCD0NBtCK9p
         9/BOLt/keMiHrBjwV1HRc7Wq+0K0ckOLjjXZY7jSShUu3H66h7IqtaNhLA6+e/yjPG9P
         HIvhf8koEufyZSCWlnUJq1RBJEmkXVCHu8Dm7ZDokEzBWNrsQPFPrmaIkxtZbUhq3lSi
         SlWQ==
X-Gm-Message-State: APjAAAUY8pkENM5Y44R4cpEe6383Pw2nVWW7PfSJCeg6wwFPc5wei803
        cKj9l18tBamrHN8kuDxHMujo4/X6
X-Google-Smtp-Source: APXvYqzQLJERPHxNX8B66igECbRTYjR9uttCEkc2sRg5EaE4cYCzHBdpL37jBKP2kIQ5/pXQITW8jQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr21297390wmi.116.1581928879422;
        Mon, 17 Feb 2020 00:41:19 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:18 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/12] bisect--helper: convert `vocab_*` char pointers to char arrays
Date:   Mon, 17 Feb 2020 09:40:28 +0100
Message-Id: <20200217084039.78215-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
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

