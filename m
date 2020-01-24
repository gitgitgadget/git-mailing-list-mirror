Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D416BC32771
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1D20838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dA7cx6/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgAXJZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgAXJZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so117920wme.4
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g88UAKgVv3SFFuCppcJ8SYygP9Rl3QVIODohy+UUug=;
        b=dA7cx6/nWNV+FpbXYluMCJHOxrw/gZiH5fIuHCm0TOLX/4F/funfu+IxzxXMo8UNNz
         eswsOGkMrjwmooYANkFXuNWbIbSsvGhvQ+9PNsXhiHhwSa1+Z1wzAM7+ZVXE4Nxu4Ue/
         c4/gIut0zQpJJyB32Q6lwd1kU3QRc0PTGsh7ArXbN0oaNFSnFQshxRUcEEc9h36UISCM
         8h4rA3zUU/AHz8FHWLmBDTzOZyUedZ4oOtc9QIlk7ZFmHudl+qfBES+iSKbXkApxCivR
         c3OJnGiTeS15O/iMtqE30eOueK8JPYY+Qycq8fHLv1B1DspRDwQykVy58Ctcm8PQ8VcC
         CNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g88UAKgVv3SFFuCppcJ8SYygP9Rl3QVIODohy+UUug=;
        b=NRiY2WUukVjn8EyfAsoPZO3LYUhoUcdtgDaMf0lx0FLbEj/YWY19Ptf/uSbXPrKH60
         58wVpL2Rb/A9nA0xD1FUCN+ZS/SLtl6HsOs8gVGMaWNjwgJFUgrjpgDUlP6KvXzY2QvQ
         zNDNWutnm8F49mPXib3yHpSRmqcw0mlobVkQc3Tgo11FwS+mRS7mHQMA7XLK0Fpm8F3t
         AJkS9JhKOWRniIb2ZYbT1HJtWSmzCQ7RZXFEVwzC98Mv3uOKsy51+6LV3bDpttxBx3Zs
         h1GMNog2SRq5EifyPC/9314YnqWGhQgdT3Y02DzBP9cDjtuj9pMY3AycYWrFNjrheM4i
         c36A==
X-Gm-Message-State: APjAAAXfMriCB1312ohhjIejAewyco5YNyifpqM7wr41z9DZony++ATi
        xmV5xN8No55Kz3a0cDg=
X-Google-Smtp-Source: APXvYqxZQcOdWYY0HCxCrEYjdZNW4+UsuxwdKaXqLOfxJQigmw9VDFaGx5gkC/0b02B9+dCzgj2Ozg==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr2502679wmg.79.1579857934500;
        Fri, 24 Jan 2020 01:25:34 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id f16sm6740918wrm.65.2020.01.24.01.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:34 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: [RFC PATCH 5/7] config: make `scope_name` global as `config_scope_name`
Date:   Fri, 24 Jan 2020 10:25:25 +0100
Message-Id: <00742e5cd2d5b44c256be3b14fd2dd07e306ffdf.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
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

