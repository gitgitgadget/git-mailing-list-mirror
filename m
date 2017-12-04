Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975D920954
	for <e@80x24.org>; Mon,  4 Dec 2017 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbdLDM5V (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 07:57:21 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42949 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbdLDM5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 07:57:17 -0500
Received: by mail-wr0-f194.google.com with SMTP id s66so17151218wrc.9
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5VtlZn8S4zys0soTj+wy5coicqrWcLnf4XXNWDxnVII=;
        b=KFGtqacwLy9hL3UHIToJhWleAHPVIj+OzohUd8ZFEmvqmQifNNO3NZaVSHB7HcmigD
         hPNnmuiETc/t0gKL09UHrPP51k4Ajh+tPXC6beCxGdP/8g0rNVrrDafyPz5v5XISmXSo
         +SaOd1ft4HPoaQlx3gP48CjD4eDWHy31ZdJZE2Xxuc/lbUAIDtcpsnEqvdrf3syBXL2e
         Ne8SJwH+nJJedHawXWzZKsHSVCJFKgmUVYfOvdnsg4c9f1QWl3IY6McDDd7iRHLb9xJV
         VWdWo6cUHQEVM3gHllbsS6F3TWvQmEy0Evrh11Pk+IdKogyT6zFrvIenExt0WqWXLJJ3
         sLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5VtlZn8S4zys0soTj+wy5coicqrWcLnf4XXNWDxnVII=;
        b=OxCBfXo3PrFZMoBmg3Tf1OPUSj1bBJNZeCKDzx3t2c6l2G9HaK/9P6/VX2gNLtOi9T
         n01NlRz8NHhkilczx1989gGAb206MKke3tscB8w+/5TgeZWJWA5Vb4NDtocOemNMtT7w
         kgdAFX7s//KJSC5ZBpGAOLbILqhYA5h31MDe/b3O/HKkd8HFQL9twFWYP/HwtyQLGfPA
         YgJKUkixZqd1JC8xBapuJa8ExDh0eQCO57jup44Pn0HEBp8laB0nH13oqrcty8JE+d+/
         mP2ejlDB13+SDCIFR5FE8tjFN89zcJaonZXil6hZaYbxtdL+fAnX1eTkd73FVNUm5Tkh
         SKrA==
X-Gm-Message-State: AJaThX4r9AU9CDxqpNIyyNLnsQIQ7iOeAP0qufuWjE1jnpNrGQiVb1Cb
        0Z98XSPEAgdLxyq8yswrSlHj+NNz
X-Google-Smtp-Source: AGs4zMbTU5hdhTkdT2ChFgRUxwu6y467wrEMeY5Ti57SYUwMpXA2p9CaIbVyeXLweHiPBHDpl9bwYQ==
X-Received: by 10.223.135.243 with SMTP id c48mr11913177wrc.140.1512392235941;
        Mon, 04 Dec 2017 04:57:15 -0800 (PST)
Received: from localhost.localdomain ([195.68.12.6])
        by smtp.gmail.com with ESMTPSA id 30sm12456948wrl.22.2017.12.04.04.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 04:57:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] index-pack: use skip_to_optional_val()
Date:   Mon,  4 Dec 2017 13:56:15 +0100
Message-Id: <20171204125617.4931-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.274.g3f22e311ce.dirty
In-Reply-To: <20171204125617.4931-1-chriscool@tuxfamily.org>
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify index-pack option parsing using
skip_to_optional_val().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/index-pack.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8ec459f522..20b4b85a6a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1660,10 +1660,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
-			} else if (!strcmp(arg, "--strict")) {
-				strict = 1;
-				do_fsck_object = 1;
-			} else if (skip_prefix(arg, "--strict=", &arg)) {
+			} else if (skip_to_optional_val(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
 				fsck_set_msg_types(&fsck_options, arg);
@@ -1679,10 +1676,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				show_stat = 1;
 				stat_only = 1;
-			} else if (!strcmp(arg, "--keep")) {
-				keep_msg = "";
-			} else if (starts_with(arg, "--keep=")) {
-				keep_msg = arg + 7;
+			} else if (skip_to_optional_val(arg, "--keep", &keep_msg)) {
+				; /* nothing to do */
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
-- 
2.15.1.274.g3f22e311ce.dirty

