Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CFBC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7671613D5
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhDUAsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhDUAsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:48:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E99C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:47:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s20so4810604plr.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXEQcvM4yc8bQn/WgDTKIOpP9Bzx+EKkzDl24/Kzlg0=;
        b=07RtrABsSL6fBjhsli3iy34Y0/jPETATab1hy2cuU2UQGY0jOLVzQjTOCRMYSPkKOk
         qG4mhfW2VM/m5KovH6OJVAm3jmdtPP2A9U+H2snq1FE4n6DLJR/DqSzld5IRg21UuliS
         SHQjrfeH4rWfOVh/uEBo7L1w/8rnFLEBnydEqOcAqbUMS98QJBZH4Izfau+ktbwhkMgc
         CXvn34RgZaAp0b+c5XM9I+HaSroTRr6yeGqsuOar9g9nMkAmCpoBppzmMEbVzo7+TaGR
         4st7FpGaIa/tQ4PgP3UwBW79qx0pU7EGPgio03tcFJW9kC/K7fG9K65Ae/7O0r6UjQBj
         P5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXEQcvM4yc8bQn/WgDTKIOpP9Bzx+EKkzDl24/Kzlg0=;
        b=WwzBipvvHmaNMQI/hMYbHx7KxPZpRNCi9svzq1uVEnLvm0VJWZAVHwtmkGvTpfZRRZ
         e6DsBHy9hUCPU9ddWT3gkRO/2cxV3r4svxb/dCD5JxjaxvSE0ZWj/2I2fDDaPB64kKPP
         fREBovG44GMPZtKLWemNp2zHhyntuGFjwgMTzKTj8mUEf2+vy7zcj6z1jKtvDZ9eGtyu
         klg7GXbl6BEqOyJ0ElTu38rbEYb6q4HrZXKd2xd8zHmvE8naUAb+yB8Y7bx94xn30qWN
         8Cchki6OJIlc+Dkj+fQfZwhHKknjpZzomWNermJJx15HUFCFSoKx3pliDiFpFdY7ft4f
         H33g==
X-Gm-Message-State: AOAM5332n3BGdgdETYIzXfveA4pEk6954SL7r2+XwSI1w9qBRLCVPV1h
        cuvqawvt0aqeyqLAZXU1Rt6coyA3FtXcBsPJ
X-Google-Smtp-Source: ABdhPJwnHiBuHZcibKB5QCU+HIfgFuyys8kWuPRmeoa4CfCjbCNSwiNfZXzevRjfz8/RHHN6awX3Eg==
X-Received: by 2002:a17:903:185:b029:ec:b44d:7c3e with SMTP id z5-20020a1709030185b02900ecb44d7c3emr7862149plg.44.1618966062815;
        Tue, 20 Apr 2021 17:47:42 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id w4sm244603pjk.55.2021.04.20.17.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 17:47:42 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: silence errors for success cases
Date:   Tue, 20 Apr 2021 17:47:33 -0700
Message-Id: <20210421004733.22395-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.333.g1dd712761c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Certain invocations of "git apply --3way"
will print error messages even though git
is able to fall back on apply_fragments and
apply the patch successfully with a return
value of 0. To fix, return early from
try_threeway() in the following cases:

When the patch is a rename and no lines have
changed. In this case, "git diff" doesn't
record the blob info, so 3way is neither
possible nor necessary.

When the patch is an addition and there is
no add/add conflict, i.e. direct_to_threeway
is false. In this case, threeway will fail
since the preimage is not in cache, but isn't
necessary anyway since there is no conflict.

Only error messaging is affected and other
behavior does not change.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 8c5b29809b..a36d4002ca 100644
--- a/apply.c
+++ b/apply.c
@@ -3560,7 +3560,9 @@ static int try_threeway(struct apply_state *state,
 
 	/* No point falling back to 3-way merge in these cases */
 	if (patch->is_delete ||
-	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
+	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode) ||
+	    (patch->is_new && !patch->direct_to_threeway) ||
+	    (patch->is_rename && !patch->lines_added && !patch->lines_deleted))
 		return -1;
 
 	/* Preimage the patch was prepared for */
-- 
2.29.0

