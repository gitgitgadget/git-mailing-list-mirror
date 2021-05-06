Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E884C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC405611AE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhEFQxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60827C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so6369716wrx.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsOLhCThGciT8IlLf93ZVtFXDGUr0WzgXEOka7x1W7c=;
        b=ClN+a0jKSYrd18EkWfY/QynoEflcLxeRFfEGp7gGRxPN/UC60jsqu/Jkn3Fv/KK9VK
         hsaovMd4Od6ztsC5NkHykHy4XINGtAsbQR4Sqvqqg+1GJr1AdgKZAtN+FqhwH0uWyMdo
         XZXugj4BWO+8P/ciFiLvPmJaqytW9GpVuVIR5ou2RIKe8j3RmeLUXhoMsqRKXZti5pLd
         6bIlIzx8jTzGyIThc1Tuo/hciCHpM13HuyTbJC8E+SLSv9sPmgpbqrJEUQTXgOAg8+IP
         mVXl8f/mPvEh1ZmjNESwebOk/dxHNvbJ2VahzyvGmFtAxXHCu7pMPKIyTgWvM9y+CXjJ
         UCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsOLhCThGciT8IlLf93ZVtFXDGUr0WzgXEOka7x1W7c=;
        b=QQuo4zZuu6ly2xYWlV2iAhLUMCqX+dMurrC/H2PRC66Xb6V1tYF0mA4iH5zQ6IWLFH
         AWwUQgMOg6NucfD2CBnZHD/GTSSVk/Y+24KXsTYg2+5ET43s+gRV7wY92SoS/eI/fQl3
         dOO1eGSR01fFdzGacIY3HAq7tsoOfikqoKNIfOri1rKCRADdX67n0RGQhy3xUqYV8zud
         0ay/6eWF5vdy0X3pSrFsLhP6aPtsfL108r3uAai2iWP0yGKPczMjJDm2Z/hNW50BGtBn
         v+pFP9oIvftnZy/cZXRgvlE0RP8GDB0HEr7rI45DA5lacE09bxyNia4aSFQ43xiYfQxb
         4AMw==
X-Gm-Message-State: AOAM533a3pv/mg1BxpwSrhOhhdKBPXmm2l0o928KL7hsXX85355FO53w
        xe/ZVO0HuRq5esdSeyk5FYFaxYGpWSDobykR
X-Google-Smtp-Source: ABdhPJw+gyycWJRq20OplB3IH9zP/MILTYZaDz9B4uvGJ4eHX6UOvg4igPu6Qx6uBSrMCheJJzoRnQ==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr6438571wrc.186.1620319963123;
        Thu, 06 May 2021 09:52:43 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:42 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 3/8] format-patch: add config option confirmOverwrite
Date:   Thu,  6 May 2021 18:50:57 +0200
Message-Id: <20210506165102.123739-4-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide the configuration option format.confirmOverwrite. This option
will decide whether a confirmation is required to overwrite cover letter
or patches issued by git-format-patch.

It accepts three values.
* "never"/"always": never/always ask confirmation whenever cover letter
or patches are subject to be overwritten.
* "cover": ask confirmation only if a cover letter is subject to be
overwritten.

format.confirmOverwrite defaults to "cover" to avoid cover letter
being written be overwritten mistakenly.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 builtin/log.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index bada3db9eb..ec9848da70 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -816,6 +816,12 @@ enum auto_base_setting {
 	AUTO_BASE_WHEN_ABLE
 };
 
+enum confirm_overwrite_setting {
+	CONFIRM_OVERWRITE_NEVER,
+	CONFIRM_OVERWRITE_ALWAYS,
+	CONFIRM_OVERWRITE_COVER
+};
+
 static enum thread_level thread;
 static int do_signoff;
 static enum auto_base_setting auto_base;
@@ -827,6 +833,7 @@ static const char *config_output_directory;
 static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
 static int show_notes;
 static struct display_notes_opt notes_opt;
+static enum confirm_overwrite_setting confirm_overwrite = CONFIRM_OVERWRITE_COVER;
 
 static enum cover_from_description parse_cover_from_description(const char *arg)
 {
@@ -844,6 +851,18 @@ static enum cover_from_description parse_cover_from_description(const char *arg)
 		die(_("%s: invalid cover from description mode"), arg);
 }
 
+static enum confirm_overwrite_setting parse_confirm_overwrite(const char *arg)
+{
+	if (!arg || !strcasecmp(arg, "cover"))
+		return CONFIRM_OVERWRITE_COVER;
+	else if (!strcasecmp(arg, "always"))
+		return CONFIRM_OVERWRITE_ALWAYS;
+	else if (!strcasecmp(arg, "never"))
+		return CONFIRM_OVERWRITE_NEVER;
+	else
+		die(_("%s: invalid file overwrite setting"), arg);
+}
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -949,6 +968,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		cover_from_description_mode = parse_cover_from_description(value);
 		return 0;
 	}
+	if (!strcmp(var, "format.confirmoverwrite")) {
+		confirm_overwrite = parse_confirm_overwrite(value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -977,7 +1000,10 @@ static int open_next_file(struct commit *commit, const char *subject,
 	else
 		fmt_output_subject(&filename, subject, rev);
 
-	if (not_prompted && !access(filename.buf, F_OK)) {
+	if (not_prompted &&
+        ((rev->nr == 0 && confirm_overwrite == CONFIRM_OVERWRITE_COVER) || 
+          confirm_overwrite == CONFIRM_OVERWRITE_ALWAYS) &&
+	  !access(filename.buf, F_OK)) {
 
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
-- 
2.31.1.449.g4a44fa8106

