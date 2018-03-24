Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22CB1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeCXHZb (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:25:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37570 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXHZY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:25:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id m16-v6so17624251lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5ge+wSz70nxEp/mrs/C/Zn992ZE3B56lv15eVDwQlY=;
        b=DbE54G0CaaqpO0uEqh23hqjZYxyqLxcnULqTo5OpLPRqUnSkwDqjTdBBVBugs7Pd9v
         3ayJrjpYuL+bXgjC8gsIEeRYy24oi9LO141GoMQnw75GBsG/CEZeNAsktWugjIV+EAeu
         YrmXI2sRkevipwa8VADNU6UHOXQpjZlHMt5phdr83bAYEKCJ8futy7uftMvSQSSaquB7
         iJgktbaWrlYtHY3Rhf93qctBZpXV5lMd6IkL+z5LMkvJbC7+ZoaCV8HsT70kYNayrOTA
         lpn1DkEE1AMEc1pcUeZTijkxpF4JjWaDPOeBUsywrOMHCOCLCcsF2EWLDF3dsoGbO2Kh
         CLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5ge+wSz70nxEp/mrs/C/Zn992ZE3B56lv15eVDwQlY=;
        b=scGg7oS/GOtAOS21vAV8XU8OWrCKzRbJ19feG33+PXs/HRHWvuxp02u4Ui+i8tRtet
         ylWwWpIG+F5vU4Ab1atmxeQbDO8HbrGumYq15wOlbwhuLobzIxxoK6vmAh6efoVbPGtf
         aeQNSdsLGhF0Cp/yG4ycuqE6f4DpPWFnrnx2mxGP2OyH/YcyoAVhqc7s/7MYsduSAMmc
         JAu64wxjejrxh/bNxMrpXw3GRQ0coDHd/2y5Q9st7dh4wqWzf6SjY4vfpWqFEqUuZQvF
         7Hv7LGvA20mqgUXP6obRZMTDyAKWzBk2jxZkOO5NLvTGANQ/cyRQ/aBqpYrdcm9kOH1x
         Np7g==
X-Gm-Message-State: AElRT7G7kWepM8FLMBDjEaYig2MAI0IlVYi7U6+18xo2ftpgltD96qRC
        r1uTty9XWtWSGYxcYWzsp4g=
X-Google-Smtp-Source: AG47ELuFpdSGu/uTo4ZNmwFnxflouquAO5e3XjARV7lrkdCjSqp80g/DIbMPeLpCwaQUn1SXQ9IeYQ==
X-Received: by 2002:a19:4acc:: with SMTP id x195-v6mr22627518lfa.46.1521876322981;
        Sat, 24 Mar 2018 00:25:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b67-v6sm2684028lfh.26.2018.03.24.00.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:25:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 5/7] gc: handle a corner case in gc.bigPackThreshold
Date:   Sat, 24 Mar 2018 08:25:05 +0100
Message-Id: <20180324072507.21059-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324072507.21059-1-pclouds@gmail.com>
References: <20180316192745.19557-1-pclouds@gmail.com>
 <20180324072507.21059-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config allows us to keep <N> packs back if their size is larger
than a limit. But if this N >= gc.autoPackLimit, we may have a
problem. We are supposed to reduce the number of packs after a
threshold because it affects performance.

We could tell the user that they have incompatible gc.bigPackThreshold
and gc.autoPackLimit, but it's kinda hard when 'git gc --auto' runs in
background. Instead let's fall back to the next best stategy: try to
reduce the number of packs anyway, but keep the base pack out. This
reduces the number of packs to two and hopefully won't take up too
much resources to repack (the assumption still is the base pack takes
most resources to handle).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 6 +++++-
 builtin/gc.c             | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d63db3f12c..cf862d3edf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1564,7 +1564,11 @@ gc.bigPackThreshold::
 	except that all packs that meet the threshold are kept, not
 	just the base pack. Defaults to zero. Common unit suffixes of
 	'k', 'm', or 'g' are supported.
-
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/builtin/gc.c b/builtin/gc.c
index 53a0500898..74d3aaa270 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -254,8 +254,14 @@ static int need_to_gc(void)
 	if (too_many_packs()) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (big_pack_threshold)
+		if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
+			if (keep_pack.nr >= gc_auto_pack_limit) {
+				big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		}
 
 		add_repack_all_option(&keep_pack);
 		string_list_clear(&keep_pack, 0);
-- 
2.17.0.rc0.348.gd5a49e0b6f

