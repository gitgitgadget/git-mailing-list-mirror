Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3031F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162425AbeBPRrH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:47:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43578 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162410AbeBPRq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:59 -0500
Received: by mail-pg0-f66.google.com with SMTP id f6so2949281pgs.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJ16rVe/yJiQkdoUn0B8J2lXrNKT+FSGlO82W55VQIo=;
        b=hnkidy28Lrq9dsVTIewlZ8oygZ6T5w7f+B0RBX2udPGaPNIPib/nwjf/lCLIeeO5RX
         H6Q+5SKDYIqP7utlWEF0soMCX8glnO8nQf1qiPouFg1Z0jVQ+Pv6GnNk6W7ou+VD2Uz4
         235yzh4o6VhZb+08hQNziKSmmuUs3QIyIbRocu0V+0Me19zFxIgsSy/qMgZEQcLPxPPw
         Drx0UwC4xIaNEfmsXAQ02tuFusXMrwXEiTcKY6DAeQ3K0gZoWcpXz28LdG2b4dcBQdmr
         wi9oRNPwc92HyvOK4dNfFEj6Hl5QO7nXRvcngcT2XDVgivtyOeKNmEj2nyW949vFN56Z
         hpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJ16rVe/yJiQkdoUn0B8J2lXrNKT+FSGlO82W55VQIo=;
        b=U/IgqCT2yanTtrhWbPJ+fIY31FJZLwxJbjWdLRwWXJTUuO3bTdaRkNVIni0X8L1Bnx
         vtr1XnAbKyYcLTPINyKOev7mFrT4AfLb0GGVmGRSqGhf+afR86gUwz+X3n5Ud6WAryiF
         Pi5syoWooKwpWjhCVx57qRwdid0j1zunQIsntnh6ZKpsGDDt6vhS4MMjg4uYrLomec2x
         ABXhm+gOy/427XB4hdJX0ItYbd+0Eyedtq7+xQkg5RD0DMFsWY+cBw1apIimogYAIi9H
         c8HHGymQViLmCrARHQg4jLi3X+AdFp2wi/Tu6pcY/4LvLWACqCL09BC5xAHaG2JA3i5h
         5yjg==
X-Gm-Message-State: APf1xPAzgRufpyA3ERKmNfmlnfGIPEa01l3B8sMni33iBivXjJ/eXCOM
        LKHuaYjaJr0a836eJvaFLfL7aHbJdKU=
X-Google-Smtp-Source: AH8x225zPzwW/wsUUfch9y+/yrTyfhmj4PAOfX1jfO3X/X5DRStS43bvglAcgbcEQppj/n9MZabyMw==
X-Received: by 10.98.130.206 with SMTP id w197mr6880158pfd.40.1518803218451;
        Fri, 16 Feb 2018 09:46:58 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p189sm48677247pfg.186.2018.02.16.09.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 16/16] sha1_file: allow sha1_loose_object_info to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:26 -0800
Message-Id: <20180216174626.24677-17-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4cbff471a2..31be57249f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1154,7 +1154,8 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
+static int sha1_loose_object_info(struct raw_object_store *o,
+				  const unsigned char *sha1,
 				  struct object_info *oi,
 				  int flags)
 {
@@ -1180,14 +1181,14 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(&the_repository->objects, sha1, &st, &path) < 0)
+		if (stat_sha1_file(o, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(&the_repository->objects, sha1, &mapsize);
+	map = map_sha1_file(o, sha1, &mapsize);
 	if (!map)
 		return -1;
 
@@ -1275,7 +1276,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(&the_repository->objects, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.16.1.291.g4437f3f132-goog

