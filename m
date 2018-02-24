Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744A71F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeBXAsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:39 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43530 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeBXAsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:36 -0500
Received: by mail-pf0-f196.google.com with SMTP id z14so4186689pfe.10
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMolSo0EhM1cGaw+wq/dXCvInnMLMd7IO2VtJ/0FOAs=;
        b=DX+Djna4vD68jzINNwo//FV8KH6wn54WmOT23CUESt97JBYZDyuWJG2eeerVJJBses
         miOwzVD8P6HifgHnaXYBhCd1iosYGLcfTLsCDIpC3l8S4p3KwlNdyGczMsB7VFUjH9Om
         4RkPNiiBhIUNmFM+qcK0cL5Qha9jawJkOvh0zwZVcpP+BAHoLJI2YzysV5WowL7Ukr2Y
         6bdl5x9KAnGq4qFR9Wc2eS9zBGwcZ6/gjl/ubj6H4efBID6sGzo/O7sP/PNB9lUFCE60
         k7I9U5IK7IbvSKqU+OZ30RIYtjIY5ld1m3q3oxHBgarZ0O5T8vzmYAi/VlZ/1lE0DorW
         W4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMolSo0EhM1cGaw+wq/dXCvInnMLMd7IO2VtJ/0FOAs=;
        b=AGJ0OoNTw93lwR1zcr9HQsKywZeoDd/kh0PGIvOO8hV3stINN4fnkPL2Ut8yNoKNH7
         YQvjONIAc03P/jTzTYLsYgDwlg6okgOF+nlExdoqVBxISfdt4kygusgb9sI9wQfroJN3
         5vNZw1Xfco7mvFteR1B8zlHYq7giHCwwyxDQSSZKcd9fZj6vZfe7ZdoCcBkNV6/hEFDf
         YGmrHnd0ZN/FISGP+zB6EZaMRdVwjXDgEzmITAp5ODcp6DsNtJEUvlCWlI6Py0k8f6Su
         HtkBXJx3yq/ZS7olgn7aOHIynX5ET2qRZJltGOQWUSgnh2zcYe5GUeN5gYpXnfM+0WGg
         HZ8w==
X-Gm-Message-State: APf1xPDIRNK7/AumR6WPu15+xeD89oeI3+uNO7RW7ZgHdZoOlez7EZTR
        WKJXox5xN/ykVayONjBWpFlAcyPEkME=
X-Google-Smtp-Source: AH8x226iVibRwJaYhhAyeLAQgCntnHA1l9sPJ0BdR+54MnZ/8WKFjMzfwk+PMCSmi83yz2oiNn4wBg==
X-Received: by 10.101.101.204 with SMTP id y12mr2810751pgv.450.1519433315252;
        Fri, 23 Feb 2018 16:48:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 80sm7410441pfn.114.2018.02.23.16.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 27/27] sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:54 -0800
Message-Id: <20180224004754.129721-28-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
index 902cba42106..dfc8deec38e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1151,10 +1151,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
@@ -1178,14 +1177,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
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

