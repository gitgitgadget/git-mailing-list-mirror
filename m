Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623131FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbdEOLGq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:06:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36853 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbdEOLGp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:06:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so27277649wmu.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YvN8ui4p/OE30uPBusF1N/UTzNcIQZETNYq+aWvyOEI=;
        b=nv+9IgMu9cJvolyajR3PFS/zRBOZYrg+JNGej79jRwrrrxfjDO3Le+L17wddigYcka
         IHt5MIMMkrjNXL1lsdRMzRTx8N3ZYC5BlcNlDX7iuz6WA/Z4o+3AZZCzOvs5BN9PiERu
         xrXUY9NIPlcyvE89U8p18uetJxcMTaw3aIug0WGl09M/ldAntIRIIt369wbMWugpc/yX
         lzTTlQCyg7tUuX+yZTLScp81s2BAq6qj1V670uBtVBnIkuFkHjwZ9sFjPM5zYBdxheE3
         oCwgQnYUdtClavFMTsxw8TNGrUshVDkwNKOaZoUIeHFbefRcR2tW6HokGOwtfZ1XWf6p
         ehIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YvN8ui4p/OE30uPBusF1N/UTzNcIQZETNYq+aWvyOEI=;
        b=MDRljShNT6r2Hu65dNo086oObIdIVTJ9rZ6ZU3RWG78EZmduYFbvpHGv4l8dHwjUnh
         +hOJ8+wh/VSQh++0Gm/9/FPgKqzqdAJcuDDhNdRSzSlkstP5Fk4mrvj5q2whuKIX8Ng9
         j3t14IgsRy5IN3Tw4eo+/VlwcIl87BXa+r3/mqpQb+zZ3JpPi8cgmsXutSIKMYu6eLIx
         pJuY5x/gnWpHbsk6RINEZ9JlKGUwmjl9UR6oVFIwmMTRQlsc2irFzhPV6lnjHnSXiiUL
         ySEx3R/05GWsORHFJfhqGCHvxdDrx+QOGpxD2KSbVwyLyhWZaq/rwsupihzuWDGeGfu8
         bOyg==
X-Gm-Message-State: AODbwcAc2y2s/L8gs77esg8XTeHoGGST90eBzNFPkHGwK1GVgBS9vevl
        RnZsvJ/q+toaog==
X-Received: by 10.28.158.76 with SMTP id h73mr3781395wme.140.1494846403908;
        Mon, 15 May 2017 04:06:43 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-151.pool.digikabel.hu. [62.165.238.151])
        by smtp.gmail.com with ESMTPSA id 20sm10363191wmk.17.2017.05.15.04.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 04:06:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCHv3 3/4] remote: drop free_refspecs() function
Date:   Mon, 15 May 2017 13:05:56 +0200
Message-Id: <20170515110557.11913-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170515110557.11913-1-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We already have free_refspec(), a public function which does
the same thing as the static free_refspecs(). Let's just
keep one.  There are two minor differences between the
functions:

  1. free_refspecs() is a noop when the refspec argument is
     NULL. This probably doesn't matter in practice.  The
     nr_refspec parameter would presumably be 0 in that
     case, skipping the loop. And free(NULL) is explicitly
     OK. But it doesn't hurt for us to port this extra
     safety to free_refspec(), as one of the callers passes
     a funny "i+1" count.

  2. The order of arguments is reversed between the two
     functions. This patch uses the already-public order of
     free_refspec(), as it matches the argument order on the
     parsing side.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/remote.c b/remote.c
index ad6c5424e..7918e0dac 100644
--- a/remote.c
+++ b/remote.c
@@ -473,26 +473,6 @@ static void read_config(void)
 	alias_all_urls();
 }
 
-/*
- * This function frees a refspec array.
- * Warning: code paths should be checked to ensure that the src
- *          and dst pointers are always freeable pointers as well
- *          as the refspec pointer itself.
- */
-static void free_refspecs(struct refspec *refspec, int nr_refspec)
-{
-	int i;
-
-	if (!refspec)
-		return;
-
-	for (i = 0; i < nr_refspec; i++) {
-		free(refspec[i].src);
-		free(refspec[i].dst);
-	}
-	free(refspec);
-}
-
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
@@ -606,7 +586,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		 * since it is only possible to reach this point from within
 		 * the for loop above.
 		 */
-		free_refspecs(rs, i+1);
+		free_refspec(i+1, rs);
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
@@ -617,7 +597,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;
 
 	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
-	free_refspecs(refspec, 1);
+	free_refspec(1, refspec);
 	return !!refspec;
 }
 
@@ -634,6 +614,10 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 void free_refspec(int nr_refspec, struct refspec *refspec)
 {
 	int i;
+
+	if (!refspec)
+		return;
+
 	for (i = 0; i < nr_refspec; i++) {
 		free(refspec[i].src);
 		free(refspec[i].dst);
-- 
2.13.0.35.g14b6294b1

