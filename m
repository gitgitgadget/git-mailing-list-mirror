Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4E31F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBFAGR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:06:17 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42381 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeBFAGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:06:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id m28so126987pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2xnPpn3mvBo6gTvlyzHEIomd0KuCajKAeCJF0/HUW8=;
        b=jMp9BNGi16PFdLr/zhyDVk/juzMjwBUp3Z2TQII/Ynrj23z9+KsVKdKZFAJsOKjXw1
         Be/LTffbdStxWiXprc5EAtgP0wrrlINvrgLBsTdfN2CjziieL54yvnfCAovM59EdivGW
         5FFsZs+Pd2v7Vc0lOKkX7KfY7dDg6wSwJBnXdJA714HrEQ+v22bWwIXHgxqOVcQk3vKm
         NzxgPYfaIKqt6zR2DLVLwvVzDGqWXHlm3Yegth6TbEQ26fuQlPOWGqDAlyM4Cvm+9ICJ
         7YmZP+A3l99j9Zl+XeDXVdorssUBtOXobXhNkC3k+5i+AjRSq2Don0iKVe+V7DBY5qjH
         cSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2xnPpn3mvBo6gTvlyzHEIomd0KuCajKAeCJF0/HUW8=;
        b=g8Me/Iw3xcMA+ixOHoGQOQ3EBa7DwGrHaku1oKUGoaWgpO3sNP7BrZ2yvKDg6gKK3f
         2bsp9WkQfieh/QNHyh4HDSI5rU24MBcLKjlCG25W6f/vZ0RnOen76YUxcWWO80DZcW6i
         0wSg/uuevHgIJ1RiL2BDyXjMDRtKEhSwTXyim3CnPozS86VfMocu8baA03WXBbNJD5iR
         5z99sIErF5FPjI7wHspS3QI+CI4KxwGiZVLP7rmzVyL2+H6x1UPwzmfbVybkqH5yupMW
         8WKkOZQwiIX7GQrO/OUhsZci/ePxGMJIPS0RNa4cWZVzkGLiqD8q1531Y7QhmdQ7vbu4
         gfRg==
X-Gm-Message-State: APf1xPCW3faFuvnbrCmakigEhdH/u58bRytAmTKl7y2vsFI+1YMNJL7s
        pGOvZZFJHO4LfvbtlMGWSuhQoxgUkcM=
X-Google-Smtp-Source: AH8x225J42uXxEdTBKEZvji20oRERhl4wKqCpHTYTNCdvvD1BTqUzAmnHxOVRA42uiVndWKpCX0gjw==
X-Received: by 10.98.1.7 with SMTP id 7mr490076pfb.87.1517875566382;
        Mon, 05 Feb 2018 16:06:06 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v69sm1769pfi.65.2018.02.05.16.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:06:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 058/194] replace-object: add repository argument to prepare_replace_object
Date:   Mon,  5 Feb 2018 15:55:19 -0800
Message-Id: <20180205235735.216710-38-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the prepare_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 31b6b3044e..cba88f50e3 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -75,7 +75,9 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-static void prepare_replace_object(void)
+#define prepare_replace_object(r) \
+	prepare_replace_object_##r()
+static void prepare_replace_object_the_repository(void)
 {
 	if (the_repository->objects.replacements.prepared)
 		return;
@@ -99,7 +101,7 @@ const unsigned char *do_lookup_replace_object_the_repository(const unsigned char
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
-	prepare_replace_object();
+	prepare_replace_object(the_repository);
 
 	/* Try to recursively replace the object */
 	do {
-- 
2.15.1.433.g936d1b9894.dirty

