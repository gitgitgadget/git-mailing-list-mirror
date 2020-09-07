Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E21CC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BD3208C7
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYTs/un9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgIGRRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbgIGRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 13:16:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA0C061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 10:16:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h1so6602116qvo.9
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZWgA49iezxD9RYRT/DECOh/STh9FvUqkA5WRLlXUbw=;
        b=JYTs/un9SXRR0xygUNjJwhipIDLtufL3t3N+372Bf6/vVozJI4+y0+UD3acvA0iCyQ
         p7OtXZnQY6b5R0Nxz9HYCVtZNoaKy033lWP/ScKUGF3yXcDS+GNyNVLWZjBuO2UG8AnE
         8iK8LhHJ+jIttTGNtMZQ0OB+TV7U5ZcsDFAVaYbCIExVuF3wxo9sDHaWd9bzBFgEQpN+
         e/DfRxKX/vsKfJMqxlZtSuCJTNKrhOK+zBvlQ11MtrWw/dXtTNvWs0AhepgtApmdGVKA
         UQHEijKxFGi1A9euAlWDXl3HweyetnX3LBzLVBOpnh1A855Rvy+uWGbsMD+kBTzCrfh3
         XCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZWgA49iezxD9RYRT/DECOh/STh9FvUqkA5WRLlXUbw=;
        b=Mal+MB2oFXX8bTadmGjuCKM5TZDTD11Tx8qIohqcltBS0bB0r6dUA9J0hf+6/5wC4o
         WO6+4yNTI9+pHIst+u1Y2jm/4ddOVJgOhemzHpHwdLEXdQ2f5Zn9zvUh1eVk0xtPbUka
         MvMnWRSqI8fIHovUkUWIBxUC6MfXdYgJON5fXE2hTl5zyl9Py6lgHjx6+1F6MK5xA/9D
         qxbpGkd/SKhNNADL6Su4YsFXqCn9N8ZMsDZwsd/9MteC1iledw65reU+ED4s4d6+izFw
         R6Xysem8x/Uf8VzR6U9ytCwq6TNU2Tdw2AfUj3Kdo7ERC2fZeIzvmKacq/ZFd8KSfwZh
         YITA==
X-Gm-Message-State: AOAM53346/Ep5P/HNEPTmUQ6rMMyV3eCME7uvHYFIRhG3lekoHx3P8ms
        n5m3S0+nyiLj3iBSV/BPEiA=
X-Google-Smtp-Source: ABdhPJxpbyc0rdlKVNEr/w54/5JezwaaWYzkgB982uKBQIzPJ4oBX6Fo6t+XFRNFwlXAI0uPZ6finQ==
X-Received: by 2002:a0c:c712:: with SMTP id w18mr19677310qvi.7.1599499009089;
        Mon, 07 Sep 2020 10:16:49 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.194.42])
        by smtp.gmail.com with ESMTPSA id s17sm12293087qte.50.2020.09.07.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 10:16:48 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     whydoubt@gmail.com, git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] blame.c: replace instance of !oidcmp for oideq
Date:   Mon,  7 Sep 2020 11:16:39 -0600
Message-Id: <20200907171639.766547-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index 1be1cd82a2..b475bfa1c0 100644
--- a/blame.c
+++ b/blame.c
@@ -1353,8 +1353,8 @@ static struct blame_origin *find_origin(struct repository *r,
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

