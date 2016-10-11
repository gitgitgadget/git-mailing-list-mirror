Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09452098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbcJKAV3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:29 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36848 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcJKAV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:26 -0400
Received: by mail-pa0-f49.google.com with SMTP id ry6so3883808pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=09/o4ZBpzSUSIf66eQeq2yO3OfWSSTtjULVW5NvX6G0=;
        b=XiFdIuHsehaoo33ZToDKYekCeK1kEd/xrQczn5dQOBz3ZalshF3RkhWmI/OkgwnW0p
         0zBcIStGPks4bhvE/VrcgldrIvMa6yJFDfeycW8Pbg8xfI0XYM38HiX/sBroEj2Gchct
         58W9wPXtuN5d6cvATRmLCTUylri6J1EAmLCCux5b0JVHs8GgNoGGfyTewoY5GglGGEU+
         Bwif1E4mYJb0kYiwssr6/ceb6XjRLkbA0O5DFGzBsaZbsmsSuXbVXZ77dxls+Z/xcgZ/
         4hKo48sG/h2Td8fRTN2HLbXg8vOYEZEvytzG5wwu0GLGG6oWhXh09If1uQIY1JyXbAPW
         khZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=09/o4ZBpzSUSIf66eQeq2yO3OfWSSTtjULVW5NvX6G0=;
        b=Ep5aCqhgcrDxtwXPBTLe/8LyWAGV1LOX1D1OzYI7VcVSvFPpVx+Nzrorf2Bf035+QQ
         rVqw8jyF8b565t38/1r/VoyBXe/hsNF3u5ZNjNrfAUF6AhFIUc3mNXDu5gD5bh7w2Mxs
         0GPQ2jPSQCbtm4duznMTwknGy7jkRVRYq/rNRUZ3WhpeuHhU1EJmD7tlrNCmjeVDhhnQ
         FEb3js5Gx6XJu1TQttwa5cROB2SNbyTxk5mUaaCr12jmEDqi1oYfQkELkbsro6pm463+
         P9/LYB/uwuOTfsZ3kUFewS572yNhOyBt3sa6LMiA9E8HczlgoaVryJ6wPCUdPUZch67M
         HBYg==
X-Gm-Message-State: AA6/9Rn+mKs10ozKvcE0G9i4Ps7Kv7PHIZEJDk8OynNyIrShaSVuGViTzIVOIS3IAmWDa/yK
X-Received: by 10.66.49.197 with SMTP id w5mr1654015pan.73.1476145285878;
        Mon, 10 Oct 2016 17:21:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id f2sm506914pfj.68.2016.10.10.17.21.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/28] attr.c: use strchrnul() to scan for one line
Date:   Mon, 10 Oct 2016 17:20:49 -0700
Message-Id: <20161011002115.23312-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..45aec1b 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.10.1.382.ga23ca1b.dirty

