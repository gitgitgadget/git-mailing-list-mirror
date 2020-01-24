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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14235C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA1420838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lYD/SrKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgAXJZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35444 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbgAXJZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so1012374wmb.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wawsmq1he+hSgRdUpR4y74QZa+9pSBu3ypishV7dzzE=;
        b=lYD/SrKz+aVOvB1pJ2K8/2WEwfqTT3ei17pminsPEv/zxh5OtwiYolGBkCSew1bu2g
         yq/NEXjNEcv7iGBTn/JYo5xWHEG9c8zH3ayOCZAiD5s9NF+8H89be6ibzxXT8JVzYclL
         HZMs8rVcWkmpI1v+0Ep/kQ6XSXRvimUoyT7JGmMwc3YQSNLFBCIk0r6nLNS4e5+MginV
         MYicomJu8GETELZs80zlTWqQsrdHHrAZyUtq/Ll39POQAJHx2KgOpJpggErmcGe9y57N
         EQBQtMkH2plzBwXwYm4ZgxR+d3I7nYS1w2gl3icV+LS3JwcwddOYgFm1ER5MheOfmeKL
         g5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wawsmq1he+hSgRdUpR4y74QZa+9pSBu3ypishV7dzzE=;
        b=W1ryxiM1QqYS2qBQdgxlYeRpOGcVUAKcP51WTJo0h48nj4CjH9aWexrRVFSXT2uFzA
         l5AN33cpGvgaEmhmtpzb5jMgTve2AgEGNjEgWLIkoqIuSXHdfASqd6MuJ7yDW/br6M9Q
         717hxLy0hxmvnbMDACImXtFW13s4/w0YgR5+y8wdr/Yur1PL+XEC9lRrTq+APYqpJ5V1
         A1f/alLJjZOB31mXSecUSGq9Pzac1c5xSmq39Gxk7l3/hAS0B82XsL4FCUe3UkTFWbHl
         6DrPItbTa9bD167PlyqZsujpTzUip57DMEP3BTG3sQEQUmlPIjvpzhHyUDJVzbfyGXFN
         WtMQ==
X-Gm-Message-State: APjAAAV2ZtRXda6bTaMqFRVnLdDedQv5psbzuj7izfJYxzV2e0qhkvuI
        NFl9bn/w8d/9fvQKmwc=
X-Google-Smtp-Source: APXvYqxaEl/PjpK6D58V7Zbzn/tWza+7ctVgEy7KSWAy9TbUZsj8OPYOvbbNwZ5ZnBJOirsyZQEYSw==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr2543936wme.121.1579857935546;
        Fri, 24 Jan 2020 01:25:35 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id j12sm7258685wrw.54.2020.01.24.01.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:35 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 6/7] config: provide access to the current line number
Date:   Fri, 24 Jan 2020 10:25:26 +0100
Message-Id: <2442c6d6b7d12d73f98ba1c11d3f62915fa124e6.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users are nowadays trained to see message from CLI tools in the form

    <file>:<lno>: …

To be able to give such messages when notifying the user about
configurations in any config file, it is currently only possible to get
the file name (if the value originates from a file to begin with) via
`current_config_name()`. Now it is also possible to query the current line
number for the configuration.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 config.c               |  8 ++++++++
 config.h               |  1 +
 t/helper/test-config.c |  1 +
 t/t1308-config-set.sh  | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 4c461bb7a3..5d1d6b5871 100644
--- a/config.c
+++ b/config.c
@@ -3333,6 +3333,14 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
+int current_config_line(void)
+{
+	if (current_config_kvi)
+		return current_config_kvi->linenr;
+	else
+		return cf->linenr;
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index c063f33ff6..371f7f2dd0 100644
--- a/config.h
+++ b/config.h
@@ -306,6 +306,7 @@ const char *config_scope_name(enum config_scope scope);
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
+int current_config_line(void);
 
 /**
  * Include Directives
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 1e3bc7c8f4..234c722b48 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -48,6 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	printf("value=%s\n", value ? value : "(null)");
 	printf("origin=%s\n", current_config_origin_type());
 	printf("name=%s\n", current_config_name());
+	printf("lno=%d\n", current_config_line());
 	printf("scope=%s\n", config_scope_name(current_config_scope()));
 
 	return 0;
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7b4e1a63eb..9e36e7a590 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -238,8 +238,8 @@ test_expect_success 'error on modifying repo config without repo' '
 
 cmdline_config="'foo.bar=from-cmdline'"
 test_expect_success 'iteration shows correct origins' '
-	echo "[foo]bar = from-repo" >.git/config &&
-	echo "[foo]bar = from-home" >.gitconfig &&
+	printf "[ignore]\n\tthis = please\n[foo]bar = from-repo\n" >.git/config &&
+	printf "[foo]\n\tbar = from-home\n" >.gitconfig &&
 	if test_have_prereq MINGW
 	then
 		# Use Windows path (i.e. *not* $HOME)
@@ -253,18 +253,28 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-home
 	origin=file
 	name=$HOME_GITCONFIG
+	lno=2
 	scope=global
 
+	key=ignore.this
+	value=please
+	origin=file
+	name=.git/config
+	lno=2
+	scope=repo
+
 	key=foo.bar
 	value=from-repo
 	origin=file
 	name=.git/config
+	lno=3
 	scope=repo
 
 	key=foo.bar
 	value=from-cmdline
 	origin=command line
 	name=
+	lno=-1
 	scope=cmdline
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
-- 
2.24.1.497.g9abd7b20b4.dirty

