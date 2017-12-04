Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34D220954
	for <e@80x24.org>; Mon,  4 Dec 2017 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbdLDM5R (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 07:57:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38325 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbdLDM5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 07:57:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so14047037wme.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 04:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IYeLCAORhQ5uCE5k6ft8U7glLyX2ABFVX26TTvwD2tc=;
        b=pCgnp1jeGOdJAoLiLwK+w+EXSUt9elIbYTRLdmF4ATa4+4kyVUisYaKy3BMVnEV3BX
         bfcAkiDqiNLZrQxsZmuFwjoxxipXW8BJCSSTRYtWaTpWpn7J1neBYe9COBmsj1fnpXxA
         DUarJopRaIQbJUOmwhioVSjsc7zwVuGIC7ulD/UFAcWm2eWC68uaaeR0FTSloXWf6cSG
         3GMIf2+xxt5kGYMKG7qivXV1F6Md32iq7HYG6PEqlJAjs41ssKtITr/wstP5u/dWXNml
         lcns7BRoIEFFMZ8cxKdVvH00bNm/ZW1x6H7q2ZMoURb7DRBwOLGmGFjWA+qv6mqNGEtI
         56lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IYeLCAORhQ5uCE5k6ft8U7glLyX2ABFVX26TTvwD2tc=;
        b=YchvUWA7Ulo8V3GcvGqKHJqR7hbsd6lUxoQVUGVZAwz3SMZ6nwC0d3ujh3T2NBM2Bz
         NnO5NKrrnU6UJjNnqpm19uDa4hy+0J4gYOgKj/uu9AKB/xOKLn2uMwyMUllOsSNYnmBs
         fbPB7FsUbh9+5IP64zEU8lSqrSrVsSRgJk+3CGkB92GtIJoDziIqY27NI8ueridWJMFy
         UtrH1TcoIkoJ+VKaUMYXU+nLgTfNQcdFI0mYtgEArGw1FCS1gSR+sMXStu8Wx581LxR8
         K86STuazkAOxbftIIkczwPBezJ7BgwZcv11mFf1kSiwnGTdDzNtRCuye1xl2E66ES/zy
         73ng==
X-Gm-Message-State: AKGB3mLV0UCwYnmFCf+f9FazNnFGVQuN4W5Z4aG+6gi92DGttEIXV/KF
        6uPNdQspPeuixzh46GveMnLGuEoC
X-Google-Smtp-Source: AGs4zMag92GHLyq/SE1UHvrN4aA2MOK88EHqnAVEmimk4yIwJu9rayOE0yYFyXE2XgCBTJbCKaTy4Q==
X-Received: by 10.28.72.9 with SMTP id v9mr7624913wma.102.1512392234737;
        Mon, 04 Dec 2017 04:57:14 -0800 (PST)
Received: from localhost.localdomain ([195.68.12.6])
        by smtp.gmail.com with ESMTPSA id 30sm12456948wrl.22.2017.12.04.04.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 04:57:14 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] git-compat-util: introduce skip_to_optional_val()
Date:   Mon,  4 Dec 2017 13:56:14 +0100
Message-Id: <20171204125617.4931-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.274.g3f22e311ce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We often accept both a "--key" option and a "--key=<val>" option.

These options currently are parsed using something like:

if (!strcmp(arg, "--key")) {
	/* do something */
} else if (skip_prefix(arg, "--key=", &arg)) {
	/* do something with arg */
}

which is a bit cumbersome compared to just:

if (skip_to_optional_val(arg, "--key", &arg)) {
	/* do something with arg */
}

This also introduces skip_to_optional_val_default() for the few
cases where something different should be done when the first
argument is exactly "--key" than when it is exactly "--key=".

In general it is better for UI consistency and simplicity if
"--key" and "--key=" do the same thing though, so that using
skip_to_optional_val() should be encouraged compared to
skip_to_optional_val_default().

Note that these functions can be used to parse any "key=value"
string where "key" is also considered as valid, not just
command line options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 23 +++++++++++++++++++++++
 strbuf.c          | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+)

After thinking about it a bit more and taking a look at the
current code, I thought that it was probably best to have
both skip_to_optional_val() and skip_to_optional_val_default().

The changes compared to previous version are:

  - 2 new functions instead of 1
  - "optional" instead of "opt" in the function names
  - the big function is not inlined
  - more code in diff.c is simplified using the functions 

diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d581..2858d66f85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -484,6 +484,29 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
+/*
+ * If the string "str" is the same as the string in "prefix", then the "val"
+ * parameter is set to the "def" parameter and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "val" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "val" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+int skip_to_optional_val_default(const char *str, const char *prefix,
+				 const char **val, const char *def);
+
+static inline int skip_to_optional_val(const char *str, const char *prefix,
+				       const char **val)
+{
+	return skip_to_optional_val_default(str, prefix, val, "");
+}
+
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..3430499f9e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,26 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int skip_to_optional_val_default(const char *str, const char *prefix,
+				 const char **val, const char *def)
+{
+	const char *p;
+
+	if (!skip_prefix(str, prefix, &p))
+		return 0;
+
+	if (!*p) {
+		*val = def;
+		return 1;
+	}
+
+	if (*p != '=')
+		return 0;
+
+	*val = p + 1;
+	return 1;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
-- 
2.15.1.274.g3f22e311ce.dirty

