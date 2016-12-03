Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5CA1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754661AbcLCAbF (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:05 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34015 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754141AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f47.google.com with SMTP id x23so112893084pgx.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzByiAVezi15fGRHyQrHQMBCKn/c0j8VFj0nUDu8WjQ=;
        b=lMPOHYtroQoOOCf3X8rxPq0P4XNy5Ou5FNvPzG61w2xrIJcLmsTETN10JSIO7cGBeh
         zTqHqU3mOKNIDhGDuaST4PEjpYdnjA2lbLQnZhdUrJA0PJK1KRlYF6Bf5wEpsTqPWqly
         Frt6263snMl6caIVWtA9VtU3UHutnJEJPwvXM++uPy+xpOdZ+Jxrhc7yOCQO1TRBl2qz
         cwuzN8CE3fqPg6sTXmlDf/obyGPOYJVxmT8EUakj62WLL1D7+tw1RHe6zudwkavQO40X
         bKLE9i2pM8wa58LLCgiJ3w40jmkDPfehGvjWCB6JbpZYCDWTzQluax4RerpNJLpF4eWK
         d4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzByiAVezi15fGRHyQrHQMBCKn/c0j8VFj0nUDu8WjQ=;
        b=gjqP0PbDWqrwIFC9znDd8aKvS8T5DqzNY5RjrM507P4Bd4ef5BVVOJSXkYjW+8GjB9
         OEDFPveECWEsMPZkNC4UDvV6a9XPzl71uXIDaYBv5sPWWzBbwXkJuFbaSqKmPDX0xPWu
         HsIBUsBeuI+fjkYmLtEs/UjB6V5TSRzX7rG2Va7eWhuu2ChJbEPbo4/iiFilqrrkjwGU
         +Yk/Ie3foKJoafTzdsE5Mc/VWK906bY2QG4tyqjiwD23r6H9aWeNr+JutYF6SvvNG6ye
         r1hVOb2OiYsA1HtMFxDJqhoz+064osVvExhH4tzyWfoQHYQBIm67rHp1YR1J9nydj0OA
         yufA==
X-Gm-Message-State: AKaTC01nI0qwIxbh0gVw36QjK+6Zxzg7qwY4F6wXv14ECCCna2BJlQF0AdAj+4Jhf3GQTINc
X-Received: by 10.84.216.8 with SMTP id m8mr101634005pli.116.1480725039398;
        Fri, 02 Dec 2016 16:30:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id a7sm10153499pfl.87.2016.12.02.16.30.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 05/17] update submodules: add submodule config parsing
Date:   Fri,  2 Dec 2016 16:30:10 -0800
Message-Id: <20161203003022.29797-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to b33a15b08 (push: add recurseSubmodules config option,
2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
that is later used to parse whether we are interested in updating
submodules.

We need the `die_on_error` parameter to be able to call this parsing
function for the config file as well, which if incorrect lets Git die.

As we're just touching the header file, also mark all functions extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 22 ++++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085be69..4b5297e31d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,28 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+static int parse_update_recurse(const char *opt, const char *arg,
+				int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "checkout"))
+			return RECURSE_SUBMODULES_ON;
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_update_recurse(opt, arg, 1);
+}
+
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index d05c542d2c..992bfbebc0 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,13 +22,14 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
-		const char *path);
-void submodule_free(void);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_sha1, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_sha1, const char *path);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.11.0.rc2.28.g2673dad

