Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6687C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85AB20675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJKugMxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGRlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGRlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:41:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656BC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:41:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so46159767wrv.9
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m71lrX61e+aCQr+85KIVfoH5ZMC6+CdHbQ7a0/48h7o=;
        b=vJKugMxd9R898+gOd2QH+efeP330JzPBSvrSBzGjk9Wop/KcMJ1WjIB+YIyEz/tnHU
         CDOXg793IGGDeJuT4fzvwHWU7+qHehFxdg11wMrz0M37mqwn/Q7GQo6AKs7xguQ3PwTo
         5kUQcPOBwsb7lCCyLG6h0EY9QELBDP7MEHIUHafy9NrRD9KQQoTBKFhS1R0ZH3XUyw5m
         mqidu2PFvFKmsxXif6gfNjTe/CiUc1GGL6Z7wZSI2FXtTkpPoy8fn4FKeJ+q9Bfl6WEn
         lLYjp7d7P1Zz1jrdPamEcypO8lW6B0A5GsQpH6bAs3/JGoNtbbYgLxNkqaNFIdeXUPx5
         L30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m71lrX61e+aCQr+85KIVfoH5ZMC6+CdHbQ7a0/48h7o=;
        b=sMfmaKT8Kw5CCx+ZC1ePT/uSv0aSsTQKK/5t8jLjz1v9qe5oHHCt9ECodDLEyEeVYB
         IuMxWzexpdAUyYI+3pg16134917fuPvrl1wgFb4OSFlHNtQRYo4ZZKV3k6hV+cVMpcxP
         XqUzTvMrGazo7jFMm4TqJ3K13kbCd3gGKAG+GPPbbOmnzP5R+qsRUfj8bHoaywlczyFC
         zGbYOANisRygofXLpNyX6Bjrv2EAZAPTvM2uTN2QkY44Zhn+d0s0Bi8Pc72GN4VFKJD9
         o06nDvKi3qQjUnFz8GEv20Qy1D7pZQUig4po79Zw3oIvQ3O/QXWIAcimzrr8ICjQfy9A
         Uewg==
X-Gm-Message-State: AOAM531V3ucbIjiAIu6bAKKz/JB/cr4aAWeQYz8ZAhuIGhHKbb4zw25I
        Yvu6fbVKbKhVUgjE4tn90d21Xy5QgyI=
X-Google-Smtp-Source: ABdhPJweBPKaYPs+oJKOD+lYHGBcEgY0BW1tP61Ha8UPy0bOLimZby6+n/oXUEZXmm6eI252zpleLg==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr53441530wrm.282.1594143665363;
        Tue, 07 Jul 2020 10:41:05 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.97])
        by smtp.gmail.com with ESMTPSA id c194sm1977405wme.8.2020.07.07.10.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:41:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/4] Documentation: clarify %(contents:XXXX) doc
Date:   Tue,  7 Jul 2020 19:40:46 +0200
Message-Id: <20200707174049.21714-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.460.g66f3a24dd5
In-Reply-To: <20200707174049.21714-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's avoid a big dense paragraph by using an unordered
list for the %(contents:XXXX) format specifiers.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dcd39f6f6..2db9779d54 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -232,12 +232,24 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The complete message in a commit and tag object is `contents`.
-Its first line is `contents:subject`, where subject is the concatenation
-of all lines of the commit message up to the first blank line.  The next
-line is `contents:body`, where body is all of the lines after the first
-blank line.  The optional GPG signature is `contents:signature`.  The
-first `N` lines of the message is obtained using `contents:lines=N`.
+The complete message of a commit or tag object is `contents`. This
+field can also be used in the following ways:
+
+contents:subject::
+	The "subject" of the commit or tag message.  It's actually the
+	concatenation of all lines of the commit message up to the
+	first blank line.
+
+contents:body::
+	The "body" of the commit or tag message.  It's made of the
+	lines after the first blank line.
+
+contents:signature::
+	The optional GPG signature.
+
+contents:lines=N::
+	The first `N` lines of the message.
+
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers` (or by using the historical alias
 `contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-- 
2.27.0.460.g66f3a24dd5

