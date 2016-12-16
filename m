Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7511FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757714AbcLPTDn (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:43 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34251 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756909AbcLPTDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:37 -0500
Received: by mail-pf0-f174.google.com with SMTP id c4so15498654pfb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OUfIvLn9E7JKPhptMLt0Ja6Tt2PC703CFnlticc+sQ=;
        b=Ag7f8Mt0ZLyaB1o2ua4x569zGMA4+ZWAlNoldG5cCGmNtDIubvitvsrZx+8eX3QdpG
         Shcygk4lELLiOOEmsb3eTsrl7cd0bmqnbR2FeYcrKums7iavp8p9W/uiany9DXyi4Jmt
         B7nXN+DC5H5p0fxjbviutJQJ1Uc/wD0YtGZJwXUY25lNRJ/tkA+i9K/PFazfxrBjVZwX
         Eom/z038bOp++f6vlO1REFSoM+1gqER9Gk37fbCgsl9evttz7ZD+CXx/N8Ow9TK/TU9c
         rGnmIwEIIDvKydZrZSwleYMdHwnTCeOfZFH/y+l09j4JfWag1RFnfsGV4aONX8IobQS9
         8HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OUfIvLn9E7JKPhptMLt0Ja6Tt2PC703CFnlticc+sQ=;
        b=Xjx7qinzCULQkZRruAjmM9smJXN3vZlSi+lMg9UXvkojOvj7V9Reo/xAPA4P5cT0T4
         6QgVNKK77F+20VrG/S/69JnGLjAmGMB31tqeiD2gTYDobzUzVFUaqyljgrdapgL+/rVc
         53ak2icWWQ+K7PxOp8KzW3z/U5HPbJKD9HTeCVU9NnolCKgjlrrsabB/8WxBx0xyqhwD
         G0NvIfG6yVwN60kHm6VaKQHHXTaZtC1W7kTjJ2Tvj5ByxHE+iMdn4lszAzdyHuo0Fmy+
         FICHAI0K4YIzwP/VypRGYr8DfOjJfqlL6XcRWJuz1RuA+9SxC/4IB3uVlN+1fC/U1AkN
         X2Jw==
X-Gm-Message-State: AKaTC00EPDnWaAUlih3IUjUUhZAL32E9vlQcxxE7Gl6WYg1dhfY8BkaiSrerrxegp5PA/+Rf
X-Received: by 10.84.131.36 with SMTP id 33mr10073656pld.1.1481915016339;
        Fri, 16 Dec 2016 11:03:36 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 2/7] submodules: add helper to determine if a submodule is initialized
Date:   Fri, 16 Dec 2016 11:03:17 -0800
Message-Id: <1481915002-162130-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1481915002-162130-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the `is_submodule_initialized()` helper function to submodules.c.
`is_submodule_initialized()` performs a check to determine if the
submodule at the given path has been initialized.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 23 +++++++++++++++++++++++
 submodule.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/submodule.c b/submodule.c
index ee3198d..edffaa1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -199,6 +199,29 @@ void gitmodules_config(void)
 }
 
 /*
+ * Determine if a submodule has been initialized at a given 'path'
+ */
+int is_submodule_initialized(const char *path)
+{
+	int ret = 0;
+	const struct submodule *module = NULL;
+
+	module = submodule_from_path(null_sha1, path);
+
+	if (module) {
+		char *key = xstrfmt("submodule.%s.url", module->name);
+		char *value = NULL;
+
+		ret = !git_config_get_string(key, &value);
+
+		free(value);
+		free(key);
+	}
+
+	return ret;
+}
+
+/*
  * Determine if a submodule has been populated at a given 'path'
  */
 int is_submodule_populated(const char *path)
diff --git a/submodule.h b/submodule.h
index c4af505..6ec5f2f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_initialized(const char *path);
 extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
-- 
2.8.0.rc3.226.g39d4020

