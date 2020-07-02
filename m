Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C33BC433E1
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9652089D
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beLwnBkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgGBOJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgGBOJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 10:09:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154DC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 07:09:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so26948335wmj.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeJ1qdXXZJ07V18yqGe0PLr0LGSPSRulA/2md5U36lA=;
        b=beLwnBkAAGQRI+vnFv0B0rBrEuP9Cj/ZPXhOmEpZX+iMeYtTA7khNShAi2t7oxUdVD
         3E9q1nobni89usgM/V7FqpelrT5ftsY1kiN7MQHfMXdpjNemsqdeh91AEIDQFClTGWE4
         RTV4ndgURqpCxKTOxfHdCbLnYBEdD74NG5w12qLaboo6u2KFsYGzedabvQecPg2NpVg1
         6CsOq4fOyrvoathn6IEECllPIMR428MuHVMtDjNExiiL+B5jt/vUcBh72obUTL803lna
         Ifti90+HtToHqNImBVIxemzbxxZabJP2uRj2ORuAN/qEPbXtvmczKBPViqeGghZyxeKy
         T70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeJ1qdXXZJ07V18yqGe0PLr0LGSPSRulA/2md5U36lA=;
        b=oPZWSJgYubA5o+qtNi4mBBAeaVrEMrupkAI9SRMmw/Jb1Q6YNNu4VYtnExNr6eTroG
         cCKU/E3Gwem22bAfc7v20+mPpvaLUr9bINOAJ3e65lEX+v0Dc2qZVbUtH3mN2E/nVc6c
         n1UxKfAZTHqTuikkkab4gJjIL8BAZ1CasQcXXzQtCpMndcp536ecj9p27W+EdXvND0dq
         tcDCDM9y+RbMWARjD5ZEh6rgwjJCgEvL4dgF8SoRng8bBDXVKCDzV4n1s0TDIMgKLDpW
         Wv7p+ib60LXs1zC4p94NSFUCFYRNlT6EvoYROB4Ug/u3rmk1YUIGYRoqNy7Zc61TxmPi
         pCxQ==
X-Gm-Message-State: AOAM532Atw603q26eYtB9OgGWCJK+67iMIO0TjWk3qfZeHG9OcSPPNy/
        B8ueaLa2tChZeOF9vabrTsPCv+92TcI=
X-Google-Smtp-Source: ABdhPJymc8Azd0zjDr3lybEdpmwaKXOGVW3N7+/ckhXD9/qv1geamrDrBOaTltVCFKl0rimO8F+yDA==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr32903019wmk.149.1593698940955;
        Thu, 02 Jul 2020 07:09:00 -0700 (PDT)
Received: from localhost.localdomain ([193.57.125.121])
        by smtp.gmail.com with ESMTPSA id p17sm10265038wma.47.2020.07.02.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:09:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] Documentation: clarify %(contents:XXXX) doc
Date:   Thu,  2 Jul 2020 16:08:44 +0200
Message-Id: <20200702140845.24945-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.221.ga08a83db2b.dirty
In-Reply-To: <20200702140845.24945-1-chriscool@tuxfamily.org>
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
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
2.27.0.221.ga08a83db2b.dirty

