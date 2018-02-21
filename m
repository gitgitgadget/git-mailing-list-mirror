Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463761F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeBUBz2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:28 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46860 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUBzY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:24 -0500
Received: by mail-pl0-f68.google.com with SMTP id x19so79127plr.13
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsaBq8H+JZBtbuQAuEjki4xlSBO7ykdWOKYuxnz8Z+Q=;
        b=BtUNxODQQ4I3mBqctbHujtSCPcRo5BavMoGmMKUPiM+FuN5hLo+pPKU6morqYiG3mS
         ww2R+hFRRUDZOO9UjyLW05HUkPZ1YjKHKZM8pO4zLx5hPZMsIYLbq69I/6Bjrc6xbeOW
         k2tBDMa4xc+yyEonrHpklfa8ybsbSL8gw0h61BA0XCS4AR7hOwNAxwUHEifgqtVUDwRI
         7pTFJydtuVlzGRwjjqFUWaTZRYEU0YZo0yxMg7t7RH+m48amsUF8c0HG/GoGe+QDI9XX
         2Fen7kys78CEkM/ycsDgNhDmFJDqZEzYR5gRzRoyYypeOgj2TcCB7rF/xT/iLmW4/Z7k
         e7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsaBq8H+JZBtbuQAuEjki4xlSBO7ykdWOKYuxnz8Z+Q=;
        b=Pe/RRRPoL4F5xcnFnPJ62FkPaffQLDzcAi/d1HnDzmN8sOE8r8LppcPwHV9/KjHvwv
         1iV1epOn3DKmakQIHWcMv6lvciW2jhDqEEi70BrWKrCA85Evr2vGieH+9mbAIhxzpLKo
         +uAYgOHPDKg6+TGARG1T4pByPnJstrZIl5xpcJRmq5/3Azu6G4RNFQOMaXKYC84nb5DE
         yCfvlqmw0s9cc8g1+yk0pUBV0MX/BrR3Ao0KblN4rzMxTnKAi63/tFbAq8pOMMUj69jq
         rT5AGbdYaB4H1s/B1Y51Ab8s1Bz7/dcyCIQ+dccuF9j94pIRSS+a4O0nUrm/8TTGcsih
         6Alw==
X-Gm-Message-State: APf1xPBkYlxbz8UpPvfZdEulwjJe2qI0SKpqPDITAayPF6oa9fv+t/lS
        nr8QYXZT4Ll8HpDptWBkDTGLkA==
X-Google-Smtp-Source: AH8x224WHfTCa1SaGWK3eIjx92QrO4YCafGnnuB1eQL+dvdqp3RjHTNpt0o7TRhBlMPCYSJ6OXlFGQ==
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr1511402plo.105.1519178123960;
        Tue, 20 Feb 2018 17:55:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p9sm56365064pgs.35.2018.02.20.17.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 27/27] sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:30 -0800
Message-Id: <20180221015430.96054-28-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a20f811a07..36282acb1a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1156,10 +1156,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
-static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
-						 struct object_info *oi,
-						 int flags)
+static int sha1_loose_object_info(struct repository *r,
+				  const unsigned char *sha1,
+				  struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1183,14 +1182,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
+		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(the_repository, sha1, &mapsize);
+	map = map_sha1_file(r, sha1, &mapsize);
 	if (!map)
 		return -1;
 
-- 
2.16.1.291.g4437f3f132-goog

