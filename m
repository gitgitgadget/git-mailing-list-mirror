Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79403C2BA83
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5039B20870
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCZZ0w2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBJAbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34032 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgBJAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so7270591wme.1
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S5xC/P12VNHtpjPFt8lVuD5oVQFR/XnHEfUnxYChP+o=;
        b=cCZZ0w2haDEj/6Xrxrpqtrvn5rrcVZz2QwAYtqwr0CNYGzzWz2TnRxpMlJT/Xe6gxz
         YJ8/7fs6zzFKYB8gzFV95CS6pM/lZDkUpoqtWPqepUO48UUjqb8sBO7KZ825l7qTYjzW
         ehpeWi0ZwrdF2YouEF19KO9nwaUeQvjOmUhI9N+0Mz+1MbA4Bu/lX3cM1LJR1dkaeqpt
         ObZGVRfFQRAJwRWgSD7g+6CdoZNeeMReXc6MOc5y9K0M1o3UwIDjezVOI88JdgKjKN1e
         59HHygSDtO+NpLdgawitgiv6zXCDUzBJJetLfEv5Gq6medswc0O/nrejCtCI+iYjl2vr
         rTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S5xC/P12VNHtpjPFt8lVuD5oVQFR/XnHEfUnxYChP+o=;
        b=A1R7igpu+cI9cywKXqT9XfEu6JLwxzzmQiglpjSxTV3y7mxQf63Xn3DIEdVBsMJcAh
         QyOn0ttSYfQdlI1SDSfGi03+OOXDjhPprtk0R80qInZydHLR9JlPxfhDr42uZSWx0JNA
         GvmOyg4E2aDVGraIv7ZlSo+DZEbpQrimoiIaPZFxAlc2rSf0kYVa9ONEkWO1jmXoZXhp
         PfD+rStXERhbWoeoaGBxy6bLB0ihyxJvxA3+Vil8zsXg+Irpx2tR7C5r+HnDCThJdkXV
         Lx5pY4nYiBbgynJ3j7vEr3ppn5pFwJltCglu/a/dKu+fXV6MgkcG6NBpNKFw0VW/ZQEn
         iMgQ==
X-Gm-Message-State: APjAAAWTr2+KYXgTjPT8eGQJGXWo4zSmkNQtUqTIGiUt0BO99GaOEFiK
        bBzQOwru0nKvZySRlR7i99UNMMbn
X-Google-Smtp-Source: APXvYqyNOF5iYNylZmR5/Gui5CRZOGrh78DUA0LskxCY4ruZ3L9oNYDW+ZQlx1/X+k6E+trgpVEP7Q==
X-Received: by 2002:a1c:6085:: with SMTP id u127mr12192866wmb.144.1581294664777;
        Sun, 09 Feb 2020 16:31:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm12581939wmf.1.2020.02.09.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:04 -0800 (PST)
Message-Id: <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:53 +0000
Subject: [PATCH v7 04/10] config: make scope_name non-static and rename it
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

To prepare for the upcoming --show-scope option, we require the ability
to convert a config_scope enum to a string.  As this was originally
implemented as a static function 'scope_name()' in
t/helper/test-config.c, we expose it via config.h and give it a less
ambiguous name 'config_scope_name()'

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 16 ++++++++++++++++
 config.h               |  2 ++
 t/helper/test-config.c | 17 +----------------
 t/t1308-config-set.sh  |  2 +-
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index d75f88ca0c..83bb98d65e 100644
--- a/config.c
+++ b/config.c
@@ -3297,6 +3297,22 @@ const char *current_config_origin_type(void)
 	}
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
+		return "command line";
+	default:
+		return "unknown";
+	}
+}
+
 const char *current_config_name(void)
 {
 	const char *name;
diff --git a/config.h b/config.h
index 91fd4c5e96..dcb8c274d4 100644
--- a/config.h
+++ b/config.h
@@ -35,6 +35,7 @@ struct object_id;
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
@@ -301,6 +302,7 @@ enum config_scope {
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
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7b4e1a63eb..5f3e71a160 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-cmdline
 	origin=command line
 	name=
-	scope=cmdline
+	scope=command line
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
 	test_cmp expect actual
-- 
gitgitgadget

