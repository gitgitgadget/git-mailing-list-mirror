Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D549FC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772A820795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgDZxEGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIJTH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIJTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EDC061795
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b12so4169556lfp.9
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBUA3jj+YP61Y3WKAoytR+bVRW6HWGsJZ+tg3CvYGwg=;
        b=dgDZxEGqV4JXAxotNK5+6a3elE6TnahP4/ba64OReAWw9lxannAEjmyQjlyUwUpIgz
         UXX8fYgZ+s6OHMxHAFRvs+rbIiwt722RvQyD3UseDktR4UlW5DA5gesBMud8AgZi+xIU
         u3I48fFHrCtzv275iRitaGUSxbjqGUpttjylDXND+z/Ri1La9LcHb0R8RVIzetJ8wV8K
         aPIHTiQ95fYqabi86o1i8GfawfibsdzhyehUh/rJx+b+ryQFosyMFo8DwevM1TivbpMn
         oknb9s/AIyeCQtUgj/nNn1GFjE5slNBULgUcFK55CQNmUMDQM9KN6vflAqwmuewjeTb6
         flkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBUA3jj+YP61Y3WKAoytR+bVRW6HWGsJZ+tg3CvYGwg=;
        b=hnxvbHQJT9IuZCLuyvdERJYS6goxWHYCzHBbd7rsLpwone2w4ceGE5nXMABgu1S7G1
         2pu2cynCvJ7/0MCxeyW3oC7YPDKoeecpzssil/eIqvV5lkPApfqGFOlSREUCCNQ+JFiK
         ivI2UygovIIyjdDThDqwhSwkLYw2fr4vtSPGrejbIt7R84JKF/hEHJy83c2gXg8A85V+
         dbreJ1efzG0vlJxDN/BIn5q5JbfhcAK/yJ+Lldfk2KCuEaKwNwlzp7pMoCk0fyI7njHT
         UuFzqfCvNoQ+smDF9J1WZ0jdAqBuZMHhmGFLEA/yrb25LxyUGex5+2bAVgWArYLeSPCx
         XNKw==
X-Gm-Message-State: AOAM531TAEbCilIVbFWbgU4C2MIhi9VjaGxVUA0x0lLLZ4OBqSjY5CKY
        Piu4yMBBQKgCG4avraTGuF3kWlzEAzA=
X-Google-Smtp-Source: ABdhPJywZDoGK8VhECz3GRpeC86NKe6HHLD7CECWgP6ixz50FdVbW17xd4sjmgUlAc5X/raPGoTBzA==
X-Received: by 2002:a19:3fc9:: with SMTP id m192mr4944807lfa.36.1599764645695;
        Thu, 10 Sep 2020 12:04:05 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] worktree: drop useless call to strbuf_reset
Date:   Thu, 10 Sep 2020 21:03:38 +0200
Message-Id: <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to reset the strbuf immediately after initializing it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 23dd547e44..64a9e78997 100644
--- a/worktree.c
+++ b/worktree.c
@@ -552,7 +552,6 @@ const char *worktree_ref(const struct worktree *wt, const char *refname)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
-	strbuf_reset(&sb);
 	strbuf_worktree_ref(wt, &sb, refname);
 	return sb.buf;
 }
-- 
2.28.0.277.g9b3c35fffd

