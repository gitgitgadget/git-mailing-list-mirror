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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B0C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE8610A4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbhIBHjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhIBHjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 03:39:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066FC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 00:38:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a10so1069551qka.12
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYWTrztepuM7x0gZrmNsHIqdNBTesY7SF+4hIrF42QM=;
        b=GmoJpctUkRfsDl7ZC5OQCxddkRlSlB/fgBchNASdpCGq97MrrthcT7T9bwwjl1QotB
         OGsUCYa84HyrVOkUw4W5kXc8xycvAs0kraoSxn1aCt161h4gziKWJvgu0GT3ikwF+lga
         TqW4q+MXOJ55AW4w2wALokJtdrxT1bdO0YiSlIGHOEyTT+6SFkeQzjuFcVbhVycEQuVf
         aCGzEVaYWB42UiezFA9t453jDKSnf3/9rc+DXxarpThii+guAiHzDos60qK3Tz6mSSHJ
         P91AGea6BVIUCBwsZRFQW3hyKp65GrWJudRw0QJ7oY4bx2oduA7/QcztAYuqXg9FKYGB
         WRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYWTrztepuM7x0gZrmNsHIqdNBTesY7SF+4hIrF42QM=;
        b=lBQGGHIb9xYM6Hpi9hUhbjpfPEZTmwM1entS0YQq4Sw6tN2VM93h9oUnphEKXFiIDT
         i5OrjIBfgprc0eNk/clfv01uVSuhdqCAcgGB8gSI6RcVnUhc1ylQK38APKTkCuaPhlst
         Apxq0dlKxOHQ9IW0fygcoP+RMOCl1kixHFButkNO4Lj/AlGJpWQnwK9NbRVZsJKHnzfr
         ogBspcB03p3lqp0SdnST1BNhqJTSfiC/Ndrn/TSwrfnUtPvBUQxaRyK0PviVDbSDI8Jn
         qqA7pzE9BY4Cu6hwh2KGlXMvbhIkQvRJhmCUnI0aDJQFKMk76gyfqaFqQTwVWoAHhqjx
         V7Iw==
X-Gm-Message-State: AOAM530XljHICbxsqwRIMPSL5upTsnPMSNJpM1VvP126BsWqAKPvl6NB
        mGfXdhXIL/7uXwO93pFoggVad2b+IxA=
X-Google-Smtp-Source: ABdhPJwS8WO9zcWr+8SsC09HXcZSN1iFRE8YN2ILbWLyTt6MxDS3x6Vi/Vv1/cuucd1M+yzQ7cUjGQ==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr1976529qkn.128.1630568288894;
        Thu, 02 Sep 2021 00:38:08 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j23sm564790qtq.84.2021.09.02.00.38.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:38:08 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     patrick.reynolds@github.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG
Date:   Thu,  2 Sep 2021 00:36:31 -0700
Message-Id: <20210902073631.50062-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d0da003d5b (use a hashmap to make remotes faster, 2014-07-29) adds
an assert to check that the key added to remote hashmap was unique,
which should never trigger, unless this function is used incorrectly.

this breaks the build with -DNDEBUG because the assert gets compiled
out and therefore the variable used to check is never used

remote it and use instead a BUG(), which just like the assert is
not expected to trigger, but will stay put and report regardless of
how the code is compiled.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index dfb863d808..ab9dd35582 100644
--- a/remote.c
+++ b/remote.c
@@ -135,7 +135,7 @@ static inline void init_remotes_hash(void)
 
 static struct remote *make_remote(const char *name, int len)
 {
-	struct remote *ret, *replaced;
+	struct remote *ret;
 	struct remotes_hash_key lookup;
 	struct hashmap_entry lookup_entry, *e;
 
@@ -162,8 +162,8 @@ static struct remote *make_remote(const char *name, int len)
 	remotes[remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	replaced = hashmap_put_entry(&remotes_hash, ret, ent);
-	assert(replaced == NULL);  /* no previous entry overwritten */
+	if (hashmap_put_entry(&remotes_hash, ret, ent))
+		BUG("A remote hash collition was detected");
 	return ret;
 }
 
-- 
2.33.0.481.g26d3bed244

