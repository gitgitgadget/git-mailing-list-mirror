Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18BF1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJQH3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:25 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42161 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:25 -0400
Received: by mail-qt1-f202.google.com with SMTP id d52-v6so26775218qta.9
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NWRQ5k7NvGE+k2jhE9BAIYBGNc5/3NVu7rXOJ/k2Itg=;
        b=AQafnxUrmuJRRdIj318mtVbhqvqfVK77wUZpe6EsU6BQ/F5o9SlnvaIxyu9G4lkI4o
         QsGz9tp3qz9l2UZPHDb/NGjiplMcFzcBHrgAlyrZDoGL9LfWxueO/sMTD/KULqJM58sF
         qvAehcAsNNVYCMySkfagO4xrQ355Y5IEMHW9JjZnjtyGs8ONYptNtvgWPvAs2D6XTtfB
         H2i2mY2hYotXwZ6SVzFZ42ttyRxzKbDbmDK7aN/SYjl5egazVyayRnUBRF7RhngiXZuO
         k2DR2MGU+9j4LrtuzMNafHBVCUlrYnJ2TiITAHj2rmAarUSljuZi6dTNbKVXAm47VJCW
         YQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NWRQ5k7NvGE+k2jhE9BAIYBGNc5/3NVu7rXOJ/k2Itg=;
        b=GCVjAMiEv8lcbMpZfjuVevuKUoQF8W3b/UIzdUaLO1rYT3v0wbvumW/hfYIrOkFPir
         QxypH9YGEHbgm3kE2T1Yk/VbrlsX3fdUEILKnjhGrP+FaF7gntxMqNBlXRKIV0m+AA58
         1Ts9ITXuzMGX7j5Y+kpSgQ372iOxPZnZaXfT5vBxHWKQdY7vA4ZugcXiw12aIR5G0L2/
         q1o+1YLu5ffvrgSQIjAvFl23EHECCACpJJwdzX+vyXBlMgyPbAb3Nc+oTX/OqEMhk6vh
         Rbr/22kguAImWZbXmkm7IFIEEXcAWToK4cOJcmQLwMQmA7muFazm20ovzk/RhKofdLhk
         wdRA==
X-Gm-Message-State: ABuFfohz6V6KjHWvgbAnB+lPf57ObKpeGMap9i4/cSmc57weJqinlQZu
        xHdavl5kGITaCWzimZxafjaq+RmKgYro8ItVb5deyN268YkOz0ELvjlcXCfC3tUiYm2zek15oSk
        eZWAZND9Gx4golom7jMAXAuGJY2e36mgLO9JiWQhdi89OoAgDZsP/Gj29hB08
X-Google-Smtp-Source: ACcGV63xHzZCQclVvWaciSUjoZdLSrGx1SIhSNeasLB0pBmkno8rXFNwvBKa/vqLlYKghZ2fXmXR29U+SuP5
X-Received: by 2002:a0c:9e2e:: with SMTP id p46mr12563391qve.22.1539732999654;
 Tue, 16 Oct 2018 16:36:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:50 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-20-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 19/19] submodule: don't add submodule as odb for push
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In push_submodule(), because we do not actually need access to objects
in the submodule, do not invoke add_submodule_odb().
(for_each_remote_ref_submodule() does not require access to those
objects, and the actual push is done by spawning another process,
which handles object access by itself.)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7305ae2e10..e623e6bf7f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1024,9 +1024,6 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
-		return 1;
-
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		argv_array_push(&cp.args, "push");
-- 
2.19.0

