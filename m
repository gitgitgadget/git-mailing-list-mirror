Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE4C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B086220659
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7e/2gpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgIHVLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgIHVLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 17:11:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D1C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 14:11:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so456871qvb.8
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e42kIQGXdSq0mgENgbOtWGh3sGhrpAXfeG95wndoifA=;
        b=X7e/2gpI1+2WlSaK3lrLSjlE9fLv29N1TF7J7808SVZYPBHIumm871CSvaTFjcMmsm
         hAZru+qLlkasGw8pAOgVHgnb3WUpU641ho47JpheL8jiDpw8eikAO9UofLLFdkwXKY0h
         Q33fRe2g2Oic4p/0GhvgAuHLbm85yg2R1NyH2UJ+FyTlr4/UHznez4YhDyU5G0cXsSje
         k4+ISZw/t48cKqxu2kZvNXdcYGIycI2Iz5uJyl2a+Y/YNnGF+BOaFNsVg0kUKjWpYgJS
         0fjs4ByPVtAL4BtkR3/dsrm5RMMJV/IzK6dJtVTrSWRx3VLSt400FGund4x76lnRcDvl
         ZQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e42kIQGXdSq0mgENgbOtWGh3sGhrpAXfeG95wndoifA=;
        b=udmOvfoBHAZQGzuvMb/NU4meadPiyRPe57Ikb1mVoRya6VyFGu8+hv+H/ipDly9GTF
         4Ul4WOUtFt9SbuFmVP25zcKMR8u7MYsXes88VDQGNHEYqe9xkvqTEEOoRaAlmFbK2FqM
         34BKDZ+eiOnwv83bMajheZhatF5lulCINz8j3zgdRwYrKAhMDG0UQ8RnxASqo0Fjk7VY
         zZZGz+q1JSgOcBw/ftLhM5oMpBJV+lWIpypa6/tZEz2be98RiNkqtdT9f1lDsCmx0Nw0
         1LU+2NBKIvecFJGgZIO/JhKe1zTT0H34HW8aWCT3EE9wTAf2vRTJU6qrxE8b76n7haU1
         PFpg==
X-Gm-Message-State: AOAM532OrUPbjtxl8k6ep/le1dFLlt5Jkprc8D/KRJCHn81UGZtkzP9U
        qhfbScBXhO7wWRM2yO5Go+Y=
X-Google-Smtp-Source: ABdhPJwg3Db3C0ofrFKaJV7Ea8EmvO7y5NPiZKWtAkfwhTOxjxrSV5W4ul1kncfErKI27FdPf+nwZw==
X-Received: by 2002:a0c:8001:: with SMTP id 1mr1126595qva.21.1599599493592;
        Tue, 08 Sep 2020 14:11:33 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.194.42])
        by smtp.gmail.com with ESMTPSA id 192sm449735qkm.110.2020.09.08.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:11:33 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     dstolee@microsoft.com, git@vger.kernel.org, peff@peff.net
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
Date:   Tue,  8 Sep 2020 15:10:53 -0600
Message-Id: <20200908211053.807194-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0906ac2b54b introduced a call to oidcmp() that should be
replaced by oideq() (the latter introduced in 14438c4).

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index da7e28800e..a8abe86ae4 100644
--- a/blame.c
+++ b/blame.c
@@ -1352,8 +1352,8 @@ static struct blame_origin *find_origin(struct repository *r,
 	else {
 		int compute_diff = 1;
 		if (origin->commit->parents &&
-		    !oidcmp(&parent->object.oid,
-			    &origin->commit->parents->item->object.oid))
+		    oideq(&parent->object.oid,
+			  &origin->commit->parents->item->object.oid))
 			compute_diff = maybe_changed_path(r, origin, bd);
 
 		if (compute_diff)
-- 
2.28.0

