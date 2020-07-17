Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE54C433E8
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED309206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQHhLJkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgGQKym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGQKyk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8402C08C5C0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so16361084wml.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJBqQyCyaifjDmIyIOSXfw9cRsG6/XuqaQklreu6lS0=;
        b=QQHhLJkNFinu9sOENnWFbMoW9YZFr7A4TqB6isAZ0s/k+bmd6bt7vHGnU7UPRuyRDh
         I594ZoBaaih2HPSew6ZAH8rjIg4pWKmmQOywPxqpmaP3EacneXj5seR1FjrejCo7IiK1
         3mkEgoyiCVJesU7R63n8hG8RyDT+N1n54ByQF+smBFbK7aXKVOkDVqwV+R8PPFS6zcNL
         5MiusVoKe8TiYBLlkhF0ZukxvBJ9JNiMbALs0monQKJShgToKWVudNnP8pV1a0sbJgeN
         yz7ELPDKz/lXt3zqjInllun300wlgxbftNMfVwZnOotb2untFoAcNXvcujmEBD4Vf2oU
         zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJBqQyCyaifjDmIyIOSXfw9cRsG6/XuqaQklreu6lS0=;
        b=NnPWlBediiTtnOs399eYgjkIs+TIzsy99KaPg1s22+2cm3/V7TQgu0IWtlM7uk32Xj
         JE7QXJciKFIZjZcUS8jfBCny+ZglR0YDK2JuDl2tlZlmaIQ5qkImoV4u2Lh9qwrukjIl
         Wtzvtxw+2L1pFWM5yThpRnSDj1lkP6nvSQ+mbBO+AHebbenjADbq2F0QNfyEjHreyWJ2
         lBTF4N6fY7Ip3Y08NaYs1fNkTcon12bCE9NutVzHbz9oNQJ+BM0ViJJldrxkp1bUt5Jq
         JBkbP3nErSkXG/k63UwJZZbJqmLy9bMtAOsQ5xrcHNYydMG3+9xgTDJx4SfdjoxpY/sl
         wmhw==
X-Gm-Message-State: AOAM530d2bynopn1MGC9rN/oSpELMHAhVL6l9u/8hk2he80xF21PUBrF
        9jpqvIWOnJcJctu6lZ3lcP8DG3fL
X-Google-Smtp-Source: ABdhPJyLVxRWfqroKPVOLevOWMteYH/5xirs+Pimpcz+3KczWtjjrs8bqwBEDOhXW3U6F+gex7yRzg==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr9107654wml.183.1594983278407;
        Fri, 17 Jul 2020 03:54:38 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:38 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 05/13] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Fri, 17 Jul 2020 12:53:58 +0200
Message-Id: <20200717105406.82226-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there can be other revision walks after bisect_next_all(),
let's add a call to a function to clear all the marks at the
end of bisect_next_all().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index d5e830410f..db00850065 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1064,6 +1064,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

