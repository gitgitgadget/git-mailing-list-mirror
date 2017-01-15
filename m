Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0D72079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdAOSr0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:26 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35508 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdAOSr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:26 -0500
Received: by mail-qk0-f196.google.com with SMTP id u25so13831522qki.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nREu8d5+OXqh7JRgrmxVduL9V8kcsmct6d4DQOBRMt8=;
        b=rHbpmrI1H4ZsG7eG2/NldQxvoj7rvkxh9WuyE0A6996jhfzywFqplSAYjFOyPMU5cy
         XIzXZVumqTY0VDyDPOuVxVU6/5BPbvicFJxhgaCTgrDq8a+dwiCPwIMUotUeyGBUqHUn
         UgYLkt6hLHefU5ySt+wXUrtpR/hL2lzUymYoS5UTrRkv4wB7IamOeVoPUAJanfaH0/Ai
         Cqj8EkIEu1/cKZygGJMTpwgQWjVehJLVP68IzQjne3RKhgWNvG6mu1HfOX5tmgZrUKJ4
         CB+KktdBGrI2LA2pazTSTHLjS6oJ93A1x4K8u2wXNxfit2LJ9kH6EiUGqg/daEip1ww/
         +tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nREu8d5+OXqh7JRgrmxVduL9V8kcsmct6d4DQOBRMt8=;
        b=TVNPBtQxugx/8vNJI1QsJdTvt3zYXI4AU0HoggaEkwsNuxCml5tn4y4PRHBzr+nYgz
         BtSKn6H4ruf5gPZvWHSMgbNc3khORFKnkAYr/ujW0X+suCwvHYyVhX+O2biJ6kljOraP
         /meFtsxkLtuOC6WlCSE4NDVSZRnqNtjZIBuBc0cKEdPOaYsblhHDsTOeW7YaPcGhFej3
         Zt6sTJ0mZuxjEDnt2NaXIHIl60Hk4a7AfcDdQ+RCmzhzBaN0UuSw2c5HwcHAEh3I2se1
         8oK1sUbTvLQUTvI261XCv4RQFnYlr05mptjRuRKG9BFtlXJs2U136I7oWPlVQ4uIucRh
         nBMQ==
X-Gm-Message-State: AIkVDXJlRZeRXxNKn3iYjWAhnushEEVGN0yH3rsMVhTxHYiIiR9H/xQQ0X7X5tyGlxVl6yPH
X-Received: by 10.55.70.76 with SMTP id t73mr26623701qka.195.1484506045181;
        Sun, 15 Jan 2017 10:47:25 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:24 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v5 1/7] gpg-interface, tag: add GPG_VERIFY_QUIET flag
Date:   Sun, 15 Jan 2017 13:46:59 -0500
Message-Id: <20170115184705.10376-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
print_signature_buffer from being called if flag is set.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 gpg-interface.h | 1 +
 tag.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885ad..85dc9820d 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_QUIET	4
 
 struct signature_check {
 	char *payload;
diff --git a/tag.c b/tag.c
index d1dcd18cd..291073f6e 100644
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
2.11.0

