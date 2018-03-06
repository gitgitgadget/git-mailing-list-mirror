Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B500B1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCFCRo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:17:44 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43908 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeCFCRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:17:42 -0500
Received: by mail-pl0-f68.google.com with SMTP id f23-v6so10988165plr.10
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wnv6UqR7bU0SFtC40t7RFEcuxX2I5qmqjy/e+mMLNno=;
        b=r4s1hErTi/wWKhoYMzq9LdEWikmhyHgqQvbt8Ocps/qt5URHIdW8DPCBkSzt53ORtu
         RiqxYOzYfXLWyTX/cH2bGe+Y9N+sRaKlgreWX24bCKpik3mM6qlEE3TVSd0HtDyuHWsw
         AZlGvgdcDMCatoxFCbz9AQO5jbHQQNyprm5ikcVWbr/MO5QT2g/U5WUM27VI5j1yxSQh
         0UAY2vFvHir1JxByIFSkmdHxtoIu24Mo32tVcuw4gqxOQib3RZ0MQTv/ix6Mt2TDdF/E
         2q/2T/h+Z7/p4xwAPhNxqMbnn0wA7vqnvrTCpyxq5crzSdP0/v/4l2ikqc12gphs+R+F
         tOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wnv6UqR7bU0SFtC40t7RFEcuxX2I5qmqjy/e+mMLNno=;
        b=cnKn/QMRExIscklM46rlb8OyPF4ExJZcZ9rLujW95l5pSkUx5at7VqLC9rIas+2y+Y
         iBHWqp3o78Y6/7Xnu2B/ZhO5Y4zduqpwINAyp+/6noELSNTwQhAoKnlgTu3omG9Q2oab
         +gQNmXQrBx0hXrUB+gsWkwuHLgwN7jZQSwVR0aW8F1nQG1tHT18kBIL2H85u9iJatXle
         OIEmRGiC8eVAHqdop6dB4dAnLOJNYOcUVoPe/R/l04DhwPP/Qm0pH8MEJrxCfh3LRbVs
         GiTWke1yWcHfRkBeWx1+yNWSaro//YGE6LWUqNkogEjmZRfkF6lCm+vLA26HnKVC6I0U
         ssxw==
X-Gm-Message-State: APf1xPC3bPJITraLhAN5RlT79DC0iwztAJPZkso+3ueJ9cFyFvzfiBfX
        f0k+DMmmO5p70h72pNTxxX0pt0amPwg=
X-Google-Smtp-Source: AG47ELtoDb57I9U9Yphe0S/9bRzajLqEKG8g/XtbSNKbGKJ/WiBeiAyDCUbpP1DeBV6QC+OdXlrWkg==
X-Received: by 2002:a17:902:768b:: with SMTP id m11-v6mr14997792pll.185.1520302661858;
        Mon, 05 Mar 2018 18:17:41 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id j83sm30125375pfj.18.2018.03.05.18.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:17:40 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/4] config.c: introduce 'git_config_color' to parse ANSI colors
Date:   Mon,  5 Mar 2018 18:17:28 -0800
Message-Id: <20180306021729.45813-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.15.1.354.g95ec6b1b3
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding `--color` to the `git-config(1)` builtin,
let's introduce a color parsing utility, `git_config_color` in a similar
fashion to `git_config_<type>`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 10 ++++++++++
 config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/config.c b/config.c
index b0c20e6cb..fb1f41ab3 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
 	return 0;
 }
 
+int git_config_color(char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, *dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index ef70a9cac..48f8e7684 100644
--- a/config.h
+++ b/config.h
@@ -59,6 +59,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
+extern int git_config_color(char **, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-- 
2.15.1.354.g95ec6b1b3

