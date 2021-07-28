Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFA560F51
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 03:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhG1DOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 23:14:46 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521ACC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:14:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id f91so845379qva.9
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 20:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auHNq0Y+OBLWtM4yWUoPORXJrpa6F/fMofzEuMWecLE=;
        b=zp7u3SG19AYan3GahhH1nHfOkM2jzPX8HtvunTD2m01D7EL3eXHkfThVeJ+40xZ3lp
         R8rOmSOQWbXY0HsfY/NvVBCtaSrfUQg2wNo2MoXTMwUJbsBxD8Dh3mvWSFNcOVM4J7by
         nUkp5qSgMXsEAI72EJ18wgmDsKEkAt9lVz4K+wTH8E5i+MQoTaS8g4sdA8Ke8jvEDjV+
         cbBDw1c6RQ0E1VCjOtBWlGGLkd8jkiuDAcexjyOfbKZBPemZ0hloXh+PbGFFoYf9TfrR
         eV32S3Jb0fgXHN2MO/rGunXLYwDg9aMLD5q4exqt2qBuY7o7Pkfc67XP4KBM5f/EtBZF
         RT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auHNq0Y+OBLWtM4yWUoPORXJrpa6F/fMofzEuMWecLE=;
        b=LIxmOxr54V6bHuopffPFrY3bjvAxSWbWdtpeDSM4vV0EIQkPguzmtKWhRx9dOOMUZD
         W1y2rTOpLW7caoW0O1nwpruEDWchInjRUJzs/PnqNWJH+IvSoxJo7nWS2KKnG1DbdONd
         2N409CUYgXU7YXI1yAgr2DwgViPQKl81vJT1RMRAiDifB7PZPD+gEH0yVl3FAoRqizML
         tvoOMZx3Om4+1jQVxBaseQZMyGEtSFeFVEX8cKziITbwNrVvPt747TLWbJsP7tWO7kFB
         2Ro4R4k6ckec8s6hAMr0CVJo+5cRcG3Dj22USrJK2gvK7dF35woBG2AUqjyxLnBtHuIM
         rqvA==
X-Gm-Message-State: AOAM533jzg7jos9wJcQW56KhTrtDGaU+ZI2mgBVbjacfle3SBU6JdpJb
        AABEbCDDEHetO6BTknndVANoeCkiZ6Vlwg==
X-Google-Smtp-Source: ABdhPJzQCCj/jllWhbxVknjQiKnq/nSBYlbEDZr6kNL3NrHL5t5B5VkrodkhyoWaVpmepMjqEWMT0A==
X-Received: by 2002:a05:6214:948:: with SMTP id dn8mr791151qvb.30.1627442081600;
        Tue, 27 Jul 2021 20:14:41 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id p19sm2225155qtx.10.2021.07.27.20.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 20:14:41 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] git-apply: silence errors for success cases
Date:   Tue, 27 Jul 2021 20:14:37 -0700
Message-Id: <20210728031437.14257-1-jerry@skydio.com>
X-Mailer: git-send-email 2.32.0.4.g29b9734da9
In-Reply-To: <xmqqwnsvw5xi.fsf@gitster.g>
References: <xmqqwnsvw5xi.fsf@gitster.g>
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
V1->V2: rebase onto master and rerun tests

I think I addressed previous comments. What
are the next steps for this patch?

 apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 44bc31d6eb..fb321c707b 100644
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
2.32.0.1314.g6ed4fcc4cc

