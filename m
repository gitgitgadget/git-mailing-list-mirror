Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644EC352A1
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AF422314
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr2W6O+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBHJIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50410 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBHJIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so4868736wmb.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7LEZGJjRIfYsumNABEw6099v9waAI03KQWY0SNTAtY=;
        b=fr2W6O+rK3tpz0lKqY5Z23vkLkPSOuiRoNTCbcyFGLS+H4rc9EPIRkPESc9WarqIHt
         DwFc7tcBZwPfQYTQ7xzliKAY22EBKs09NMZU2LDRMi/kaPw/aRDS9pcwYezRpepv7gMR
         aMdYO7GThxQsh+9b7uR24X+nLmSw8UvXEAU7hPZ1T+MCjAhL3HtcEx6UTH+JWZ7SNyBG
         ELZEWs7ttJPzAcl3h84+fPcVaLOmhNokh5XRWunFa6owXoPUs4PCEOTTnSsnkBefYzhX
         sn7FjUXmNXQ3rR3DcI3alBkNcAGReQoZNqnTJ4gGJsRRBq2nnps86uFgLEzQ8z1JRZuZ
         Cgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7LEZGJjRIfYsumNABEw6099v9waAI03KQWY0SNTAtY=;
        b=bIIGCkplwYn8/7IOWYeEsfpgeh1IsUxYaof+O76nJ0S+DExZFbmKPIS/U+06pTz7IK
         d8v3GBgOTwgGgh9pmLg2ehHG7sodLFG4tsRhkrIMaKhN/eV5M0JFeL/44Pd4X7pEChG4
         wJQ5EYqMVLU6g3/mIQ5X3f9vUmzPWiHGW0zZ+1uKOQH/MS5TlzPS8PUt7+o66a4CzQ77
         l34q1fDfOJvUZ2beY9ITQsM2FHMl4/0VxLNheSilD8LEaQCZ9cbmQvbwsSoDRpve6tDr
         TY5gqta4KGRorZX+BIpWWpwthaLu9gtinIrmWPITiYRxkYB1Zjzf4ybXghiQeqvJUR69
         ezZQ==
X-Gm-Message-State: APjAAAX/ePXSAN5Nxqb4n7UNDx7fmWyZ/6TtLa6vv5kXOA4/cC/gs6Yj
        QpQmhCK6j9ukkzTWjybW7LXPDDUK
X-Google-Smtp-Source: APXvYqzclBXWmG+zAypPYmkHfJ38fLxEn0Yb7Ix5osKCi5FWTwTQW8gFlzTTpU8KQvAKExhkcdulZw==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr3456704wmb.38.1581152912023;
        Sat, 08 Feb 2020 01:08:32 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 07/13] bisect--helper: return error codes from `cmd_bisect__helper()`
Date:   Sat,  8 Feb 2020 10:06:58 +0100
Message-Id: <20200208090704.26506-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary
to convert bisect.c exit() calls to return statements so
that errors can be reported. Let's prepare for that by making
it possible to return different error codes than just 0 or 1.

Different error codes might enable a bisecting script calling the
bisect command that uses this function to do different things
depending on the exit status of the bisect command.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e21d3d1a4c..e6bd4d6645 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -713,5 +713,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	free_terms(&terms);
-	return !!res;
+	return abs(res);
 }
-- 
2.25.0

