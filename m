Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80FF1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeDFXWD (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33443 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id s10-v6so1532485plp.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3GCTzE45dxbmty7l7k6OXtAJ30QoQd0jEroVuyxfEQ=;
        b=BBgUhOaujrh7OPAp2JtpOASZKYaciupttm4s91tjQc5bkasBUoYwGZCDWEF5C66WZi
         9F0fPP4lYJcsLPb9A6Nkh9zc4pBRyLiRt2SzE74AicEYDf3BjZfBGowqsTjS7kVJfg32
         XWv/sDkNEBsPauR0cnj20g7+UWfCd5Ud+5ULBAjgHSu179r1OVggKgJQLAC56VDHM7WW
         5Eo6qqtZrnz7DBQKz7Gyq7N/FIZtYh85e6EzIfiNhYpfMXVSrQ5QSYvwmkcP+MrapQFc
         dArvd0iNqOQo+S1BC1W5Ek6/57cOiBK2xjTyd+skqBRz88cMNvhvrQPkOhjomIqYMVkT
         8Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3GCTzE45dxbmty7l7k6OXtAJ30QoQd0jEroVuyxfEQ=;
        b=V+xtZQ0cV2wxgPkwBRNTaBxNRGcFvoFD34V3+aQ1W3RkWJlry2oNEkxCFAbI5UKcNx
         dyMhMsUlRsDdOhPpNweTt9RvfgXk1zjx6wX57xbZeS0Vr4OOmL/JY92F+/feAy1+Uzn0
         Pbz9KLtSYm8QSegGZbuYyEUrFinMR35NDFncKyYZfAEGk1AynKt/5KVj3ApbrAHrm929
         /rxRp1qezp/IL4CDitaXGU/V7RnBGPoSbDgBKW79hpZO6tW58hHHrnrvTJNZigSFf5+8
         VFe+JDSwxpr04G4eDV4h1vRiY7/QoFJz4gU1vJcOPHXOo5sxJCEW2UMjyGXGD5a+H404
         9mwQ==
X-Gm-Message-State: AElRT7GCy+cRJu5MRgzf39+ELDW3uEOJipn3punLu9cBYI2bUjOb0R/+
        yxToHOMCBHtQpgH/OpU3i1mIHw==
X-Google-Smtp-Source: AIpwx48aUeoGJ/mXL8HwnnjqdLzGBEoQNNVsZuGl/X+trgkvklYQy/8489ZLzjcx1JI2u/NY0bLeng==
X-Received: by 2002:a17:902:585e:: with SMTP id f30-v6mr27234921plj.254.1523056921630;
        Fri, 06 Apr 2018 16:22:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b9sm20815173pff.13.2018.04.06.16.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/19] replace-object: add repository argument to replace_object_pos
Date:   Fri,  6 Apr 2018 16:21:25 -0700
Message-Id: <20180406232136.253950-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the replace_object_pos caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index a31e930cfe..52fc59c4f7 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -12,7 +12,9 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 	return replace[index]->original;
 }
 
-static int replace_object_pos(const unsigned char *sha1)
+#define replace_object_pos(r, s) \
+	replace_object_pos_##r(s)
+static int replace_object_pos_the_repository(const unsigned char *sha1)
 {
 	return sha1_pos(sha1,  the_repository->objects->replacements.items,
 			 the_repository->objects->replacements.nr,
@@ -22,7 +24,7 @@ static int replace_object_pos(const unsigned char *sha1)
 static int register_replace_object(struct replace_object *replace,
 				   int ignore_dups)
 {
-	int pos = replace_object_pos(replace->original);
+	int pos = replace_object_pos(the_repository, replace->original);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -103,7 +105,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 			die("replace depth too high for object %s",
 			    sha1_to_hex(sha1));
 
-		pos = replace_object_pos(cur);
+		pos = replace_object_pos(the_repository, cur);
 		if (0 <= pos)
 			cur = the_repository->objects->replacements.items[pos]->replacement;
 	} while (0 <= pos);
-- 
2.17.0.484.g0c8726318c-goog

