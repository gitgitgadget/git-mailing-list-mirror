Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD30C433FE
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0740C61159
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhJERDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbhJERDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:03:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0EC061753
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:01:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so38586055wrv.9
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv9NWIantNeSeWsASFiP6ARAEgMnyzP8YIXJfCz/Jt8=;
        b=OaSFA/I/EEiqKbQmn89A8qHLvOTaU26fBTqfwp3jT/LW2HUEW6qowlatiWgZviHl5t
         lzz4GQQxT60IXB2BsiGeRRPjBzM/1kCZc6cT7sO+Xe53ZOQeCJepyxvAzFGCXdMS0Pre
         vppIpMBHrj+UdQM9EQtx+O2Scbt86OzmsrMlwV3+pwVYByn2G5lImh+pEr+hMMO5IWlV
         6/Vpom3y6PUhfJxgmgUCcFVZ6loHBIN7ZA5brrxoopW/93aezmE0gYvM2+EqazhQYUyh
         yiFR0Q7apM/+PBUBY8njYWVDap6+wa1v4YgVWiE8Ffw2QcrlLaRVZdiPQy+GaC2QAuj0
         bjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv9NWIantNeSeWsASFiP6ARAEgMnyzP8YIXJfCz/Jt8=;
        b=6Zq08bGlpWMxj2kyRdvyGQ6qUvQHGMPve6oAVG0Ro4Up7rqqXGE9puAozNleft68pC
         FmKSemRMP7dVfksKv/memCy8flsYWlagXTUodS14zXN+wyfX2IexTs4YTfm/aJ+UH3t6
         vtzQH3deXjclivUdAnFjXNEr5ueVQDxRMOW7MCcczCaRHrehSG9Lb7lC9XVxn+OOrmLp
         7ygDt0KOaox6vIzpn5YTmgMHRxOXrapgcKVnOedwBTzrhURH7v+moIg/zRmhW3RgWRlp
         nPo3mwyD0uK6tW1Ho+hqTpT49hDdN0T85t3g95PCVO3do7BSpP3MYm8+/x8+Syysxfzo
         nQ5Q==
X-Gm-Message-State: AOAM533F8EIXRsubN2ZDLc+/W9C1mAiJ4GtSW4W4Mn4SOlaNGUfB7dF3
        BXOGMjBJaXRQ13woteoSZr3mjTPnvsE=
X-Google-Smtp-Source: ABdhPJzfXHTQQ/qh2bCQn6BXyD7J9xvN4nWnrA5/5DZURunpfU1/n5Te4wZWkBaNPUXaSiY1LxUJPA==
X-Received: by 2002:adf:bc48:: with SMTP id a8mr4149890wrh.397.1633453292810;
        Tue, 05 Oct 2021 10:01:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z79sm2551261wmc.17.2021.10.05.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:01:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] GPL-2.0: update to byte-for-byte match the FSF's version
Date:   Tue,  5 Oct 2021 19:01:17 +0200
Message-Id: <patch-v2-5.5-6fe2e601b13-20211005T170031Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
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
2.33.0.1441.gbbcdb4c3c66

