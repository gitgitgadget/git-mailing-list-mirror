Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8905DC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C6120842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H3qmNI9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgA0HEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45199 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgA0HEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so9695274wrj.12
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VioHTgfINTvhFE76YlABnD+yX5PQ9Vaf7mE1yd8IO6Y=;
        b=H3qmNI9E7IdRFFEyy235X2DQrlKyJc7FUEc1kbCGZkLI/pBy71E4xrmNf7rZ+MkFU0
         J/pkIi4jKBtUCsVs7ZTb5wCzbrpWHiSF7vrCjV02rJa61vjXQoOa1Nb/AgDz8rzFjwja
         UYOf9jlclmx9ApgifNS6qaUSxe53yjRxo8MqAMnQjx4+4v5vIEqbZhiGaYMN7I4IxAcV
         tlx2m5ir8dDFar9q0Oly0xe+IZjCb5gqq6/ILANgufkA6OczYL3SxLzzZADCLJZteOkB
         LTsaiGlEJFgNHg26uN8+MIhprqlw7xTruvsJ8e8fkADJvs6E6ckm0+MMUqKw71gqQWJz
         ZJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VioHTgfINTvhFE76YlABnD+yX5PQ9Vaf7mE1yd8IO6Y=;
        b=ASNcoEMHDMZ+KnIqUzLPFtRhHu+Qxp9nzCk/ioEqITmsk9kHiMiuWb0zyA+tw89avi
         r3DwT54/OYMUcr8CyKY55qKtYR2sjR/hFnldMjea8dLYUjoPmtJ4tcomZlXGXUveciZM
         pOAcyyjwbYy0R8FDpi3gjPZKPVT8gvjb+VZLkg0VcoMXziZg5dI0h3HDirLyiSCO8Ofv
         kg6OsMurwugHPRWYYdRWWjR2MeXbvg3l9izfo9rUlbjoK2H0fsIa6kTQ0IJPw/cUJz2S
         0mjGuDIS+fcyovr/i/rCqTmQhT3OGrGFGnXA499POqotwBIdq2Sk1CX/9nx2AxfQ1ti0
         0e3w==
X-Gm-Message-State: APjAAAVW0mx1R/BmXJTnpTkZqO67OH1unQr/dJIJmUJDf7NV4B6jQ766
        QMTKtm6vO8hW4qXRrQ4=
X-Google-Smtp-Source: APXvYqxcwoATsrhAjglY02K3k1fAqT74du331tALi4t48Ppu8WxIhf0+3cQ0j83XO46lOG14XYWzuA==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr19497974wrt.256.1580108679442;
        Sun, 26 Jan 2020 23:04:39 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id j12sm19210366wrt.55.2020.01.26.23.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:38 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 5/6] config: provide access to the current line number
Date:   Mon, 27 Jan 2020 08:04:31 +0100
Message-Id: <d4b981673d64a958a1298ce87219a0f65605c4d1.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
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
index 18a6bdd9ff..222e49a7c8 100644
--- a/config.c
+++ b/config.c
@@ -3338,6 +3338,14 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
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
index fe0addb0dc..9b3773f778 100644
--- a/config.h
+++ b/config.h
@@ -309,6 +309,7 @@ int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
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
index fba0abe429..3a527e3a84 100755
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
+	scope=local
+
 	key=foo.bar
 	value=from-repo
 	origin=file
 	name=.git/config
+	lno=3
 	scope=local
 
 	key=foo.bar
 	value=from-cmdline
 	origin=command line
 	name=
+	lno=-1
 	scope=command
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
-- 
2.24.1.497.g9abd7b20b4.dirty

