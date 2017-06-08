Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3CA1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdFHXmL (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:11 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34262 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdFHXmH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:07 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so22174113pfj.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDm3dEM8pcam1I+J9K7ZAkEo0hit9hxW3CE6eFzGqJI=;
        b=MttCD8nR+eu9iBQq3JuPBMry/SwFDX9NVcc8QoRkL/Uav81eXLA1+ByiYYvbksJP+9
         BnrcD/HZJhY05TqES4hO0JS53VszOo+w2uTiuCMKChKf/EkKFaPFhMsRVXg8O1x3Pnj0
         TuY2EA0gf5Wj1JJzmG0KRacZgVnJYH9W0CMdbx2h8k53F2s8/hyWMNrGY1L8/7jF9z3z
         V5hfv16jD7aUBrTLl9P6ZtMUkLY1nn/lISSA/P+JraAUtlRsj72QSaOexHrZGdQKA4Jm
         nCLodDo39sq9RgC+oZ/hOU1rNXpJWEFdc3J+CQBlPTQLHDKvWYW/bXHlpMyehL7wBQ56
         +ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HDm3dEM8pcam1I+J9K7ZAkEo0hit9hxW3CE6eFzGqJI=;
        b=qWnX+hz2K4AVWvnB0RGyCG9c7MAuIIWuwRyAXY4dCiapWUzRPzX6oII6A1w7vNrU5I
         SDZcpYl1SfcsicQOM+C2f//GJKhu0nk3b3mj6lXsu02T6T/e1/sRREvxqTyB+O4tVZzK
         0fvlB/g/Du8W1x2MtiZ1PvqWpxGLWy37hFb1MGHWNH29V+KJ00WAT/uaW3px5b3C7fEt
         /fdRjHuDTBR3X+yv8BmmbxkCibuoOy+fy0nAXXr42rU08EvKIN7mX2mOvGBJIcxOZzS8
         mbkk9KkMW4MlyYc+ycF+ut0kCMftUPPDWHgSyX+qZEJDXSX53voElFVEP+XL9a2hdG25
         TChQ==
X-Gm-Message-State: AODbwcCORDgmwMdavXmvRPImpTgEIgpONX30qOsC+iG9DYYNvc0ODxsr
        bRr//EYMKYYy57V2swOhnw==
X-Received: by 10.98.236.133 with SMTP id e5mr34207063pfm.190.1496965325303;
        Thu, 08 Jun 2017 16:42:05 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:42:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 30/32] ls-files: factor out debug info into a function
Date:   Thu,  8 Jun 2017 16:40:58 -0700
Message-Id: <20170608234100.188529-31-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3061af2c5..2849c9a65 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -94,6 +94,19 @@ static void write_name(const char *name)
 	strbuf_release(&full_name);
 }
 
+static void print_debug(const struct cache_entry *ce)
+{
+	if (debug_mode) {
+		const struct stat_data *sd = &ce->ce_stat_data;
+
+		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
+	}
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
@@ -279,15 +292,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		}
 		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
-		if (debug_mode) {
-			const struct stat_data *sd = &ce->ce_stat_data;
-
-			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-		}
+		print_debug(ce);
 	}
 
 	strbuf_release(&name);
-- 
2.13.1.508.gb3defc5cc-goog

