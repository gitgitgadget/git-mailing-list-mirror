Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842FC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7E061A81
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJBJVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhJBJVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:21:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B3C0613E9
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 02:19:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m22so13910137wrb.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yj58g5H1DIwVZqx73iEpbd1wBmLLWMXekbyL2wD+2RE=;
        b=Gc+a21cbvvth+yLMzKABp9DUbBCnNRM0yRp44IAJAG2ns6B4qEzzoqIXGPoUFlDMRa
         I60wM0MSG+yUMPd08cDJlrFDlEiQ04AY5MjMOzUdfUoEL/gnjlM0AE+e91O01pTcis8Q
         AeWrQLujPvXIIGyPX3UNPWTa2gL5rxko30lhoROUFamzUGLYymyDfRE/RCmD1jLdd2LY
         J/ie/5lysgQmV4DKqGtZfJsfB3oTVkPyhAmVEtvays9WmFWaJWHtCmBX6oOfL+MgjafT
         3Xl/dKfR+ZBlRls6cNwk1Z5wavl7cHik5KWLE4HLMIlirEuRtayw0+wXawcLo7I2Ojtq
         tEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yj58g5H1DIwVZqx73iEpbd1wBmLLWMXekbyL2wD+2RE=;
        b=WJqCzmPbccECO1Yg465HnWoAoH94DXAUJb0DpqUeKQaCnjcy5BI/piatrMzh6Fsj0c
         StgXJXKU7RgK8YW3YImphkV85iDLA9VCJdQlznnTfwvUZr8SU+ibcSABx9MaMS31KJBX
         Yfn3JAw/sEgQ9E8BVsNFLdY7sG3cNxUz+tenqCjDNCz6K5prY8DtWuG4yh2Q99BuHfWT
         lgHv/PwVQzVHUKcl4+9wRm9qN6n4Wr3P5Wbtoik82ywSa9tF7ZzExPhQWWYph7FqSZqv
         M6jmzw9hYnDfg38NvpUUhTvEz8rRbrrKngLFQ5Ur1du25dVPccPlMAZsUTgxGhb4CZNI
         m93A==
X-Gm-Message-State: AOAM530ag589xUnhOqgOHOaBqP++CFqMciqRMp/J2e6q0rXZYX32KBs1
        2cBW2boeNokeI/x+8Ty4aVue2RGzLIK5rA==
X-Google-Smtp-Source: ABdhPJwgNL2ksHVrQ25fEP1SyjLZttxnTkPbxnHcBeurJfrchp6BSiTnmS/QrgCKivGsOkOhtAbPPA==
X-Received: by 2002:adf:b185:: with SMTP id q5mr302337wra.213.1633166370191;
        Sat, 02 Oct 2021 02:19:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm6735805wrv.97.2021.10.02.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 02:19:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] GPL-2.0: update to byte-for-byte match the FSF's version
Date:   Sat,  2 Oct 2021 11:19:20 +0200
Message-Id: <patch-5.5-0545fd06cac-20211002T091212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Retrieve current version of the GPL-2.0 file from
https://gnu.org/licenses/old-licenses/gpl-2.0.txt. This is a
whitespace-only change, but yields the following SHA-1 and SHA-256
hashes, which as an online seach will show are the well-known
canonical hashes of this file:

    4cc77b90af91e615a64ae04893fdffa7939db84c  GPL-2.0
    8177f97513213526df2cf6184d8ff986c675afb514d4e68a404010521b880643  GPL-2.0

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 GPL-2.0 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/GPL-2.0 b/GPL-2.0
index d511905c164..d159169d105 100644
--- a/GPL-2.0
+++ b/GPL-2.0
@@ -1,12 +1,12 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -56,7 +56,7 @@ patent must be licensed for everyone's free use or not licensed at all.
   The precise terms and conditions for copying, distribution and
 modification follow.
 
-		    GNU GENERAL PUBLIC LICENSE
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -255,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -277,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
+                     END OF TERMS AND CONDITIONS
 
-	    How to Apply These Terms to Your New Programs
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
-- 
2.33.0.1380.g193143c62ce

