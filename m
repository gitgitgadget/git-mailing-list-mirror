Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9277C1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeAVLEo (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38175 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeAVLEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id 141so15890235wme.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=Ikj+HPC67nNA4NwOjLzxMh5FPYIlcNEuvZee7eiUx8D0gjPUZ11Y9pM8QkPkra5ygx
         2qKYAe27iZg72pSH0eLV1pc4nWncFT6/7ePkF9WtzFSERLZdNJssrFz/mUsG5B3H7DPS
         w50BQfG4uhhV3st3JZT+9ibS2aD48alzfGHcrZCinTtvvlCIFx5z5slpxTa4qjTNg/tv
         N0sJeDbQ5tJlKwFynuPkjAOzVV5ShzJqRMFRTG3SRSZ/J4+kTeYuYItwJl9u1cmwCS04
         GkGUGiFn2jxBfPJCnd5EXU9JppP4adwAWsxTDmHjdtoHAN5ALJRnGTD9Zt5NDDKmPzUb
         9V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=sMKa0cSNcCEawokdVrqJ+QvnDVHVrqee0HKVfaxSlNwho6BzunxPN1RjQgtoyDvE7P
         VrnU/MqjvBwfgqyWS+lEzN/XxGCZyK1gZxLIK3EMwn4/BWfrnPiuo2RHO/pvwKcPm0M5
         Bog9hJOlZfLp1Q0BXCajvBjDGtWQvsZwJGy6xrNGn18c3o9SfPNxQ6ZXH76Bu2BEw6iy
         j+2lsjPv8rAqgVFfsU6VMn5Wa4sONO6hJLOZlebHbiMFytlmgFfzo9IuPtHCZcU36fpq
         WfexJ64JUBOx7mHadChpQaQEVLJNW0N4UP28fGOxcuK5ku/W/k/2c0IuGBsN60/GbzFj
         mR2A==
X-Gm-Message-State: AKwxyte3B2F7UDCMCbEPzBFVQ4FKQFf/2h9AG1kXx2qAMvPL9etPw08R
        LPHyUGNUpbAsDfdPUKWv4e5/IX3F
X-Google-Smtp-Source: AH8x227XmXkvdDMdeW5gMYgKrb8qFYhzeRfsi+jdZiavFLQ2drg0BWwyuQ4CBKW+x7CG0kFfZgeQwA==
X-Received: by 10.80.157.73 with SMTP id j9mr12636454edk.200.1516619081249;
        Mon, 22 Jan 2018 03:04:41 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:40 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 01/14] http-push: improve error log
Date:   Mon, 22 Jan 2018 12:04:24 +0100
Message-Id: <ecb68d9a16b01258fbccaf5c765039f28199b480.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git push fails due to server-side WebDAV error, it's not easy to
point to the main culprit.  Additional information about exact cURL
error and HTTP server response is helpful for debugging purpose.

New error log helped me pinpoint failing test t5540-http-push-webdav
to a missing Apache dependency in Fedora 27:
https://bugzilla.redhat.com/show_bug.cgi?id=1491151

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 http-push.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http-push.c b/http-push.c
index 14435ab65d..0913f8ab86 100644
--- a/http-push.c
+++ b/http-push.c
@@ -915,6 +915,10 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 				lock->timeout = -1;
 			}
 			XML_ParserFree(parser);
+		} else {
+			fprintf(stderr,
+				"error: curl result=%d, HTTP code=%ld\n",
+				results.curl_result, results.http_code);
 		}
 	} else {
 		fprintf(stderr, "Unable to start LOCK request\n");
-- 
2.14.3

