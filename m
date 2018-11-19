Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C9A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKSSnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 13:43:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41251 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeKSSnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 13:43:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so13495335pgh.8
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 00:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LncsoxwLCVJfkUq2cI0P64SKX6yAtaLQYN+Ae+epVQw=;
        b=WRkR8t/aym/Ce9kHKB40G1IBboEdTHliCrsDmcKgtp/ovx77TAAnEgAc0IWQG5ln2t
         ZwPB9sNJx7f4MpvayuQfnX3DAz45ECGpjFR3SlsEAVWYbbQCnireYEP72WVvjS6KA78l
         r2zj8MllNtJESV2Ab1FGt/YnpFKRSnd/EAU97XOZiaTY2Utn6JEgUJ9Yw/MA6cYHTks6
         W3rFkGz7NbbUNn8zJg3J2SxgL8CvJdhX1QRpNlA0b7d0mAyAyJ44WnT9akTB458ZkiWr
         ZaqKKz5O6JRe3ikqR2tRrbcdCIO4j88y/hFTNw3NjRJAa13PKbDizZl2fNbGaLufmG3V
         2Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LncsoxwLCVJfkUq2cI0P64SKX6yAtaLQYN+Ae+epVQw=;
        b=brske05HhG3/+k3PAV1+ZeaGDDUrJQtAm9UnXpre6jYcVABfQdQ0laovnXCbFJ4ft2
         vcgIh12PkG/jgMWLlPWnYataaC0hZYrwCp6gb5CPrtrGmmPqKmarQactTf0W+yS8WY+E
         JmacHonQ9gxTBFplSPH0R77aWFVaHlOo9gTbGm0rPP4PbpIM/ob8HCPk57ZvEQEsquq7
         sLoQ8rggzEEtMFg7NDKmtaP4OUQIytpildNZnLeQcs7wUxlOq6mY410Gtx0H5n4u3UMO
         XEWlekppKkGyJv4R7/wkIsFJh3Xmys/UzVbcrunklvfza5F2+2bfDvkD4JbZebcJ6MPi
         SUuQ==
X-Gm-Message-State: AGRZ1gJwuzTP51l6D8GUVr/2Lv2GJIe+IizT0d6pd8STwMs95wPAYeGE
        qJailwinT6GtBew+72Wj5yDWqxpI
X-Google-Smtp-Source: AJdET5c0fZFy25w0F/p4WswwMFdRY7hIeqYZhq6Nj4rONblc/Gd0oFIaZW9TEqthdf9h20FAVXPAfQ==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr19116142pga.202.1542615618848;
        Mon, 19 Nov 2018 00:20:18 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n23-v6sm68672072pfg.84.2018.11.19.00.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 00:20:18 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, git@jeffhostetler.com, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
Date:   Mon, 19 Nov 2018 00:20:15 -0800
Message-Id: <20181119082015.77553-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0
In-Reply-To: <20180817161645.28249-1-pclouds@gmail.com>
References: <20180817161645.28249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I don't have an HFS+ volume to test, I suspect this patch should be
needed for both, even if I have to say thay even the broken output was
better than the current state.

Travis seems to be using a case sensitive filesystem so wouldn't catch this.

Was windows/cygwin tested?

Carlo
-- >8 --
Subject: [PATCH] entry: fix t5061 on macOS

b878579ae7 ("clone: report duplicate entries on case-insensitive filesystems",
2018-08-17) was tested on Linux with an excemption for Windows that needs
to be expanded for macOS (using APFS), which then would show :

$ git clone git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
warning: the following paths have collided (e.g. case-sensitive paths
on a case-insensitive filesystem) and only one from the same
colliding group is in the working tree:

  'man2/_Exit.2'
  'man2/_exit.2'
  'man3/NAN.3'
  'man3/nan.3'

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 entry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 5d136c5d55..3845f570f7 100644
--- a/entry.c
+++ b/entry.c
@@ -404,7 +404,7 @@ static void mark_colliding_entries(const struct checkout *state,
 {
 	int i, trust_ino = check_stat;
 
-#if defined(GIT_WINDOWS_NATIVE)
+#if defined(GIT_WINDOWS_NATIVE) || defined(__APPLE__)
 	trust_ino = 0;
 #endif
 
-- 
2.20.0.rc0

