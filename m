Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB610C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CA0217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuz/mJSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgATOie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39332 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATOid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so14953418wmj.4
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2IfjAS33MrmsZyy2B/KfIloY6ksKTkGV+CHSOBHGjw=;
        b=Nuz/mJStIaff3iRsnQraUC4hdl+NMPBmLfEhIZtnX0bAlMdhol58lsHeBER3b1OV2r
         QMW2WbFzzA32+reCyFDTzfzhMtJxzNwKICspkhScckQEKNmP3PjaYBjzE03DjG1pIkFN
         E1Wukn9ixhLlQe/eIEYdBXqbidipJnnmqh/BvQNHw3xlz4gTaUkZ7/d/E5Sk5JALQmEg
         7TFXQBKD5ngeX3WdStMWuxqjcbFC2KFTLljQDIRu7aLuSy2Qx28ILwWA56wu4OSkImQg
         F2sEIANFMUnQ/k5LMR1ynD09EuRXbWgjt9k4tpbfVbt/7SS5LJZcsrFxqQBFBZ+rWNll
         Gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2IfjAS33MrmsZyy2B/KfIloY6ksKTkGV+CHSOBHGjw=;
        b=dZFGvggzk+Jvc5Gv3Ni457DuiZk15bYLiLOfQob4UJZ0HudRaADYJbwpPTlOOdzdKQ
         GdR66XTrJWUMGzX1cKquBaK3yBM9n4R7PYtbGF3oX2X5jDInqNAEd2GNIxMJ1TcL0mH2
         OIJPBcnyQ31u63T9pbDqWyX4DOM5LX+NbOO69TSMbP7EQHU2ZaqVhePvANB+4n9CwjUD
         JuSTQ/6FCeo2pxP1lqE5Ow1QCF+aghBJnW28tiZRazJBvnP2g7iAaFdyXuyP/2aXPE15
         k5dbMtDqYXqCF8r+KK7VK4yJdFyFsw6lQ0mp9wxx3CcTCTPPdlpu/4nyjmv2ct+TQb8m
         +S8w==
X-Gm-Message-State: APjAAAXVtCiw2R+ESZaWudBNFNuaGL8dTDxH89a09xH+aiaHUC61oDZ8
        bCZCQbc2UU+w9Rm4fE7FJHPypbxB
X-Google-Smtp-Source: APXvYqxdOlK0N19Yao1GLqKYXtuJw1HwhEX4ASML+CdFJtGKI2dGBQl97reu1X8LFL8xRMS9L7CReQ==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr18978167wmc.173.1579531112178;
        Mon, 20 Jan 2020 06:38:32 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamil.org>
Subject: [PATCH 03/29] bisect: use the standard 'if (!var)' way to check for 0
Date:   Mon, 20 Jan 2020 15:37:34 +0100
Message-Id: <20200120143800.900-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using 'var == 0' in an if condition, let's use '!var' and
make 'bisect.c' more consistent with the rest of the code.

Mentored-by: Christian Couder <chriscool@tuxfamil.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index e81c91d02c..83cb5b3a98 100644
--- a/bisect.c
+++ b/bisect.c
@@ -572,7 +572,7 @@ static int sqrti(int val)
 {
 	float d, x = val;
 
-	if (val == 0)
+	if (!val)
 		return 0;
 
 	do {
@@ -869,7 +869,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Bisecting with no good rev is ok. */
-	if (good_revs.nr == 0)
+	if (!good_revs.nr)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-- 
2.21.1 (Apple Git-122.3)

