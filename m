Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CFB1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBFABb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39976 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBFAB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:28 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so121819pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4uB1HLdUIhqx5IUot2j+SiE+TJuCK2cXFlSIGUBR2F0=;
        b=pZ83ol0RkpfC6EOJTbOBl90N++wpsGVUQE2hnQsbe3sI8ltTjZ0hvhDmywr0/r27av
         1ITn0JSq12jwuXNB9h3I1MGg7Al7kncnI9hWsmzrdMOlEJKAAqW0Qm9i1xyBDctqNDtm
         obTIbVugkjSWN5VhPXWdKFU53WDHLkD6JIC2I0Niiqmw3Z0/kJpCOQAjYQLjaLqudCzp
         lbGVk2YvIaTxDxSVsBWfgXOkHeLOyGOmtC7rtlJplOoLGnxMbzWHbahqC28GR+8U86dR
         cMi5VO5dMY33xRaJGKD1pJMXgzQiRQpvu6hdLeZ0QpmX7ZHiIPRJf5vVpzN8Cb1U5k8a
         QSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4uB1HLdUIhqx5IUot2j+SiE+TJuCK2cXFlSIGUBR2F0=;
        b=EfoZgaeKvCvG8JGA1BD5AREswWjczReb3urVjFhMCRSBMm0Jej8IGA8RlYKCzUEF0y
         rRhRACOYS5NCPrDIj1asHI3ev3R8XQSiUI9EgndiUzxyhr92pXB5TB/jHV9tadSElQv5
         tS8PtvrZhg3W2VmYmjVsoWGIJG2btiQJKlu4xxsjc73JQfwcYtcIoNJE62snNnlgqVMd
         ViqbSvS6GFE067heL4lBObOMI2dayjaJOcrojfjxUCAIam/wxQExlqJGBqdH4nySuF0+
         WIET7QFbbJ486hTzScai7IO7jiweLRlCTDiFs5osSR5EwCDFvR5LAVpIRqO3+cxLsb6Y
         O4gQ==
X-Gm-Message-State: APf1xPBbTrcrmgmi1XO4SEzXgJA+b72arjDtsHcCKv3FE0Z3ketpF5Fg
        6vM2cnX3o2AirXoYCHYYHdUfyYDYa6g=
X-Google-Smtp-Source: AH8x225RhvBuwz0ONlnrgaXRSsXZEn7Eo8sej3JvPOtID09LdUjX0F9oYMnCeR/hpA+m2J162pB+EA==
X-Received: by 10.98.87.2 with SMTP id l2mr519152pfb.46.1517875287308;
        Mon, 05 Feb 2018 16:01:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k14sm18778927pfb.15.2018.02.05.16.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:01:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 038/194] pack: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:59 -0800
Message-Id: <20180205235735.216710-18-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
index 786e904eab..1e867bc293 100644
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
2.15.1.433.g936d1b9894.dirty

