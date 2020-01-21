Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F9C33CBA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F8722522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RG2Z8eDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgAUJZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:25:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgAUJZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so2146874wmj.4
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g88UAKgVv3SFFuCppcJ8SYygP9Rl3QVIODohy+UUug=;
        b=RG2Z8eDbz+uCqlgJUr1uPAosXAStcjDw0rbFn1W8ENYnEv+0DLGCR2Bit+S4B7OEPu
         e5lXTO0iEt6gc/80osnH5HJ71p29voc6bm6Ng0V9DeZx7u8JaShHBzCV6PxYXI5Ob8ZN
         FV05rlkcB4MM3PnNCCrQzDzO3BwrYBTt3anN69eGgk7GHX0dFAH/ix38MtzHqRhseQEK
         qp8iFzKnko3VNLv0A0owDeIf4vfmDbDCVqS5twhWepC0C2AKQeqMD1ijrzvEMC2BsIeA
         DojxJ0IVfmNh+IVJuAhLrr3qlfXbvYClQz/1wYfW8FpHDNX0jDqE27CZSmoGWIZcMKqL
         6eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g88UAKgVv3SFFuCppcJ8SYygP9Rl3QVIODohy+UUug=;
        b=PFwetLh4/MCWmsmfm/YVXtc10e3x5BnN8GJKhlpCFBE5GkwwkuhMMS5E053XM7ydyQ
         PldWFEy+hLmk7ncTnp8KoltpNM98U2F6xEGkCLzjubNkDiSYwjpExUW9xrIzo5bJJ+d0
         nueobeAK/lBurvYZpYEovJLE9IIXMHx876AbWqVhvrOPIVwBBB1JnJXaZ6pSbAm8rz1m
         svVIOjP57Ef32gbVWcmjUWfPmnR3DogGufNLUhJai+SRSEGmrcISVPFqR3JQs7BxpFNj
         R3Aw+7zjzV6FEx7EvO7RLZg7zGuCxnA6tAOI3euQyYTJXR8YCbL0BG7PspRBlKftGqAQ
         Elpw==
X-Gm-Message-State: APjAAAUeK+cbX0EdObueQdzcYuv8w84Pa/FjHnnyKmQVwKfk1wKUGyMW
        6WnSqXn2BCiX/UeYtzE=
X-Google-Smtp-Source: APXvYqy3oLXxLhhLOfNcziweiDUo2F2dzJVWwjpBSo/h/4eP97R2ecY0uh7nLJUTlY6OZoh6+lz5gA==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr3423963wmj.68.1579598701904;
        Tue, 21 Jan 2020 01:25:01 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id h17sm53399499wrs.18.2020.01.21.01.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:25:01 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [PATCH 5/7] [RFC] config: make `scope_name` global as `config_scope_name`
Date:   Tue, 21 Jan 2020 10:24:53 +0100
Message-Id: <04eb98389880c96e1dc18131031e9d6ad5830a40.1579598053.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Will be replaced by Matthew Rogers.

Cc: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 16 ++++++++++++++++
 config.h               |  1 +
 t/helper/test-config.c | 17 +----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index d75f88ca0c..4c461bb7a3 100644
--- a/config.c
+++ b/config.c
@@ -3317,6 +3317,22 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
 
+const char *config_scope_name(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return "system";
+	case CONFIG_SCOPE_GLOBAL:
+		return "global";
+	case CONFIG_SCOPE_REPO:
+		return "repo";
+	case CONFIG_SCOPE_CMDLINE:
+		return "cmdline";
+	default:
+		return "unknown";
+	}
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 91fd4c5e96..c063f33ff6 100644
--- a/config.h
+++ b/config.h
@@ -301,6 +301,7 @@ enum config_scope {
 	CONFIG_SCOPE_REPO,
 	CONFIG_SCOPE_CMDLINE,
 };
+const char *config_scope_name(enum config_scope scope);
 
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 214003d5b2..1e3bc7c8f4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -37,21 +37,6 @@
  *
  */
 
-static const char *scope_name(enum config_scope scope)
-{
-	switch (scope) {
-	case CONFIG_SCOPE_SYSTEM:
-		return "system";
-	case CONFIG_SCOPE_GLOBAL:
-		return "global";
-	case CONFIG_SCOPE_REPO:
-		return "repo";
-	case CONFIG_SCOPE_CMDLINE:
-		return "cmdline";
-	default:
-		return "unknown";
-	}
-}
 static int iterate_cb(const char *var, const char *value, void *data)
 {
 	static int nr;
@@ -63,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	printf("value=%s\n", value ? value : "(null)");
 	printf("origin=%s\n", current_config_origin_type());
 	printf("name=%s\n", current_config_name());
-	printf("scope=%s\n", scope_name(current_config_scope()));
+	printf("scope=%s\n", config_scope_name(current_config_scope()));
 
 	return 0;
 }
-- 
2.24.1.497.g9abd7b20b4.dirty

