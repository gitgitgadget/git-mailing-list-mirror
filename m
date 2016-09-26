Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD15207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbcIZWmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:42:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36157 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbcIZWmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id 11so6215839qtc.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvvD8giTVjsc8Te4tOUXQgnSw4t2XlyI9yWSBSfxdP8=;
        b=gRNKPZYxY/M45ZvdlIYo4P9r3uxUAIXT6PVeOSNlZFQopoogHgylkWqAcODh/9zWhs
         mVP0FyhtnDS5X7LEaAX9gIFsUTzj/8+t9CvYA3D1HL0whe73HA302Si3MiyS2CYsJW8H
         O34R7+IX5RxYMESvxVYu6FAbkvJI4DZktrU4qhNR4VN2QNntfBZ2oYnR3Q7jiQxoqzcs
         fN4Zn6bngAYnI3Ao+K9PqCxYVWkBfGMIBCy+e2c5LhfLwBPWPsm2uaoeslBN8ax2MNgO
         34KSdXnXh1ed7K5k2n0Xn8D2NY/0Z6EMblsHNUdfkjdyIE2mWB4bAER1Ac0aQ1VjBB5T
         xqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fvvD8giTVjsc8Te4tOUXQgnSw4t2XlyI9yWSBSfxdP8=;
        b=lmye9cgxHlXZwk3cQ4hLhyn850emWdWlx6NofQEs7JqVzNO+sjNORnYY7DpXNMvTCB
         Ze353ufA4vQV6ESvO3bYYlKAhoVB29FhTaztfFwktR3ZvoMmBYH6z1KRzHvVxbVLqrce
         HA3JINrKV3u77Fru4XMw88QREUpWmZlaSaurIQdj3rZs5Fit8pcN4r5W2dQ7HXoTf1xf
         uiQRiJ30pFcxBzHzpMEEwHnes8FgVrVqGqxw0C2dntY7epKiXPy7meJSiqlEIVqEtLeY
         5zvm2/HrzKJvlFgEYhPKpyawEuprep8ShYg78EvEN+FIuA7sEwHdGl6mf9gNppvkoibI
         a/Cg==
X-Gm-Message-State: AA6/9Rnns8oJc3R3gwlmpi5+xGDJd04tszXUY/kTT3PSrqb4jUQ9FNq0AoIACLe53msBvcpp
X-Received: by 10.200.36.204 with SMTP id t12mr499642qtt.0.1474929768764;
        Mon, 26 Sep 2016 15:42:48 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:48 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
Date:   Mon, 26 Sep 2016 18:42:29 -0400
Message-Id: <20160926224233.32702-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160926224233.32702-1-santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
print_signature_buffer from being called if flag is set.

Signed-off-by: Lukas P <luk.puehringer@gmail.com>
---
 gpg-interface.h | 1 +
 tag.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..85dc982 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_QUIET	4
 
 struct signature_check {
 	char *payload;
diff --git a/tag.c b/tag.c
index d1dcd18..291073f 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 const char *tag_type = "tag";
 
@@ -24,7 +25,9 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	ret = check_signature(buf, payload_size, buf + payload_size,
 				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
+
+	if (!(flags & GPG_VERIFY_QUIET))
+		print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
-- 
2.10.0

