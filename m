Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8921F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDXV71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41342 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDXV7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id m21so8832057pgv.8
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLaOBXo8sMUkIz6UeLQzKCXGK2J0scXOZSrw+BfoTTA=;
        b=U92lHFvur06v4XHyrckVfrsSUCHqiZMeNWkgd7gOCRG6Ugdwov4i6CwBA2y+eRPtlp
         TFs9NmzoxxHhdrxgHfxb4/2Kd8djvo0YahSHG/1wgvtwBXNGkrSPbyp0O2zG0ww0dZEr
         /a81WNaTvPYCnvIcxnoeN5lomYNSkEF+/ldkOOBPSq8so2N80dZUxsptvXHapnteg4xh
         a+EaDsaeqMG4LCcbtncLJRDlWij30bFSztUAgJSjvj12wzNYcIFXiUdMqzxFqAKY5sk9
         0yW5yedWz+CuP/2oqWGV3HHPRPalc6JI+HsXdU14VRBPBp1/Pwd4T523VtsWdDUW19sn
         llfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLaOBXo8sMUkIz6UeLQzKCXGK2J0scXOZSrw+BfoTTA=;
        b=CYm2cvhYBqUg8Y8ZUyYl1/654fIulB+jr5M9TGIwv7owJtJ3wy7fW5TziwVGJE020r
         dzjtGru86YPeQdwTVd/rFruRXxj7fV8XcXy3PIiXHdJiM9uX9I0mLOQksOFyQftsMnPh
         7jitT16OphJsfvrf2vXI5RuXnQpUDyYHFGY2Cb/FHOTJrp4xIlNIoaRkWSacLgytLfZT
         N+7eeC5YiHwvLKcYOHucPqlhpLqR3ZX5oQEINiJDIoCaadS9h5ffT4njZReDCOtPzeLa
         ospvvo1FYbQifok9DdDBiGFFIyZen9CYIkCZDjxnuCP/WwbqFYW7r0df6z4Wu6fdCOUN
         ACOw==
X-Gm-Message-State: ALQs6tCmNywBFDGo+R1B10KcGRHT0vr9WAZnKyKL21miKgBIGUM4xOiV
        ovIn+UKEPTREvJA9d3xNty5hmPRMHcQ=
X-Google-Smtp-Source: AIpwx48/snzj1F5dNboF7g5UJ32bUfxYsFpDHuR7ut29iWlnCIfo4WeMZZVeRrdOfGBJa3fdifgbDA==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr26757060pla.125.1524607158482;
        Tue, 24 Apr 2018 14:59:18 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v187sm29281870pfv.21.2018.04.24.14.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv2 3/9] packfile: add repository argument to retry_bad_packed_offset
Date:   Tue, 24 Apr 2018 14:59:03 -0700
Message-Id: <20180424215910.22201-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of retry_bad_packed_offset
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 80c7fa734f..d2b3f3503b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1104,7 +1104,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+#define retry_bad_packed_offset(r, p, o) \
+	retry_bad_packed_offset_##r(p, o)
+static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1153,7 +1155,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(p, base_offset);
+			type = retry_bad_packed_offset(the_repository, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1181,7 +1183,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(p, obj_offset);
+		type = retry_bad_packed_offset(the_repository, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

