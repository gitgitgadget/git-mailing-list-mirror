Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E9CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbiDRQrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346383AbiDRQrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:47:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A932ECA
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:44:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s25so17598394edi.13
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLfTU7IK/zN6SksvUEgg7EaQhTBqXSmUdFVRsfNYDa0=;
        b=UIlfr0pIP7O6xouVgYB4/Ul97MSD8VE/w6JK6ewoNVxAgCaNSJsV/BggGBzomiMwGB
         jxzdid69XlrOKxEotozcJIXTqYAQincjfagpJJBrSwTjg4NC/nOLZ9U+7G1zchvSqjfY
         7as1+mcXv5kd0HI4Qu3IzcyT0VZID+chb7eIL2v960x07sZaRTPRnTWUhv7cojkbkAnC
         dkTT5Er97ioj6ZjCoQCsBw2oTyzqgntJBRCjYUXgKBJ6qsNu1qb+6aVzOMAgjBSCFltj
         M3zb4Z+okePmlG58gxjOdnsKAY4NvwuFnTA0Wi39JeP3WnverYoUyny0VERSKAs5BVte
         2nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLfTU7IK/zN6SksvUEgg7EaQhTBqXSmUdFVRsfNYDa0=;
        b=kh6uzsIDYJ7elc+UuFQna5L77Wd2aiYWTw23HgBYvj3iYpuU36DM6wP4tnWy1S/PZS
         +pNpAoEnUDMedytqHf0XQVXQYwFbKNTany51jYDbVWJGaaaHnoH8m5mXS0wiNQmAgIos
         W+qIvQZHvrUl1ERn1eVkRQacbjXouj2lwFZ25htvXU7YN0r4bA+5N9opqeGCgIXHKdAD
         NqugogEQy9V9xlw1vuhYxw9+OzGpblexbYvoX68ZpIoYJEtKiW6JAdBbyiYbWfIjUJp1
         wVuDwEe8yDKkqFZRdJSkJBogG2TUAwgjIfbJYC+wJzG/r66jyrXDwD+VmcKnoKHSlxKT
         w1KA==
X-Gm-Message-State: AOAM533tjDxFpq04MdInVkR8bYOBlh4ReIyXy3QIA86zPxQmEY81CiFP
        tgdwaLw7MzX6NreQ/L07SPQoie4nvH0tUnbJ
X-Google-Smtp-Source: ABdhPJyzfcTTtnFGjud5+BdfyYVvZd3UwqujuSV/ZMwOT1INvSTNdRk1XM1RaRCp2t+42gPUQMtIOA==
X-Received: by 2002:a05:6402:2693:b0:423:e808:4be6 with SMTP id w19-20020a056402269300b00423e8084be6mr5177110edd.358.1650300266254;
        Mon, 18 Apr 2022 09:44:26 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm4728415ejc.42.2022.04.18.09.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:44:25 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] rebase: simplify an assignment of options.type in cmd_rebase
Date:   Mon, 18 Apr 2022 18:43:59 +0200
Message-Id: <20220418164359.205723-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an if statement where both if and else have the same
assignment of options.type to REBASE_MERGE. Simplify
it by getting that assigmnent out of the if.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/rebase.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27fde7bf28..d2d63bdef1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1187,11 +1187,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-			if(file_exists(buf.buf)) {
-				options.type = REBASE_MERGE;
+			options.type = REBASE_MERGE;
+			if(file_exists(buf.buf))
 				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
-			} else
-				options.type = REBASE_MERGE;
 		}
 		options.state_dir = merge_dir();
 	}
-- 
2.35.1

