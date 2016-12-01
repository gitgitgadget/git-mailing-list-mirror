Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8CC1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 01:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbcLAB2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:28:52 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34444 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754635AbcLAB2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:28:50 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so88321632pgx.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=C4vKMdI8y6k9rSHdtXAjeehTotLV0ZHwk+VZ4x1QEwjP3n8J33AgU85UO27Cy29Qi+
         Om1bKVKzxACX99VXc5ukK6NDH+CysJdXN8zNmHoYma+3gf5f2v7noL9oQC2IO3e+TPt/
         rGI9S7sA1ojUIaFAxbpkawYgK770WXL8Z2Jue7A5dDPuo0Rr3BfZmy0gDAA0c7dlca6s
         z3QkJMB5inTo/LXR80uSr6G+0USlAoen94L5tORK2AqfPOh55cAzUtaQYGtc7Uh8zWm2
         zmK2SxrqCIUu8b2aOHK+DK7z/SMBCJ+fdf9zfJlqbkA+s/eBNXoeln0Ywf7/vmhu8ntm
         qTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=BSd2Cs1fR6h6tMYMmIeLKpzFMOfIbnzT/BXA8W+FTEy7Py7u7A9KUpxGgtnI+4JMPu
         TBVNqNQhTGF+B/R+EJI8642Cy145zQnOjd7728kd1DYMVodqG3Jkbm9OcG2BXdObKcX/
         KBBeKK/d1B5ViStDd22Aqp1qAccKrLwPfmZJRYDeY6MCHMw+X5gyCCVrS9evtmwvLd+K
         /YCpU7LgqjPDNxDVLFbe2PMFo5/Zozgb/XSHACLcLUHadLap1ZiAxXwLxp+6nJbjJs/h
         aIArhiFXWs6LbHIOfGyUIBMZzPA5exGuR5zgBE7176jdCv1XYgzoPWAyK6B4D1pYPyGF
         0Ifw==
X-Gm-Message-State: AKaTC02GGMTsJfpKMzbSN80iY3bZ/v2ST7xw3ouzsjByeovTG1DRqBaJzBoeSlHt1r/vA/GQ
X-Received: by 10.84.215.138 with SMTP id l10mr79178341pli.166.1480555729213;
        Wed, 30 Nov 2016 17:28:49 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id i194sm87872386pgc.46.2016.11.30.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:28:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v6 3/6] grep: add submodules as a grep source type
Date:   Wed, 30 Nov 2016 17:28:31 -0800
Message-Id: <1480555714-186183-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
type in the various switch statements in grep.c.

When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
identifier can either be NULL (to indicate that the working tree will be
used) or a SHA1 (the REV of the submodule to be grep'd).  If the
identifier is a SHA1 then we want to fall through to the
`GREP_SOURCE_SHA1` case to handle the copying of the SHA1.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 grep.c | 16 +++++++++++++++-
 grep.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 1194d35..0dbdc1d 100644
--- a/grep.c
+++ b/grep.c
@@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	case GREP_SOURCE_FILE:
 		gs->identifier = xstrdup(identifier);
 		break;
+	case GREP_SOURCE_SUBMODULE:
+		if (!identifier) {
+			gs->identifier = NULL;
+			break;
+		}
+		/*
+		 * FALL THROUGH
+		 * If the identifier is non-NULL (in the submodule case) it
+		 * will be a SHA1 that needs to be copied.
+		 */
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
 		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
+		break;
 	}
 }
 
@@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_SUBMODULE:
 		free(gs->buf);
 		gs->buf = NULL;
 		gs->size = 0;
@@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
 		return grep_source_load_sha1(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
+	case GREP_SOURCE_SUBMODULE:
+		break;
 	}
-	die("BUG: invalid grep_source type");
+	die("BUG: invalid grep_source type to load");
 }
 
 void grep_source_load_driver(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 5856a23..267534c 100644
--- a/grep.h
+++ b/grep.h
@@ -161,6 +161,7 @@ struct grep_source {
 		GREP_SOURCE_SHA1,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
+		GREP_SOURCE_SUBMODULE,
 	} type;
 	void *identifier;
 
-- 
2.8.0.rc3.226.g39d4020

