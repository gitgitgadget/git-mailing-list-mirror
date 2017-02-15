Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E01F2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBOAfM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:12 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:36082 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:11 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so56115533itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gvZxAsXpUltHrUME9DxZGeeJ5Yceze5DbEmf+C3kkuY=;
        b=f6+VKCvi79c7zPEumH7B8znlt/7WNbjhFo0gkgeZmZek+c05q37MY8m6E6Ze/VQ3PC
         Cnw0JJ/yXj8KlFMzZNpa5pPv0cmMak06GUi/oENcMhm/L8z7q4MNB0jXbKFN1wspD8si
         w1l4edTvdZXN7vEb0W3YfEiM8HQcmwuQ5jPVlBXDjme7KOpI/JgSWOebg+2zx7D+kJNe
         Gkwv3rk8oHA2OK2oKlTZs+23MPP2vfID+4deE9xv8X9mBmk+bLhE35b1VEZfUUY+7p5v
         Yyj5ZPcJhjFZJMrflgGNDFFupL8qKEpywplDRnCfjod0VDuMce74hA8S+fdyrSMW/o0L
         6pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gvZxAsXpUltHrUME9DxZGeeJ5Yceze5DbEmf+C3kkuY=;
        b=aexvBy1wKk4vbHIFNmZqwbYiPURoHErvdgsAWmTh1+ZV/n6EkILDRtii3Rb88sWeZp
         foSifeqO9FT43OlQCU6Hu7sfsOTpaCBeyK6wR8H0hwo+5BJJKvLdPNOAJcz8Fl8oLjqA
         90BzFB8USeYBGRhW2laRKjwI0GpXNRqzKfNnaIhRGtfWzcvQJfOPQvYDHW6Hs45M3Gay
         WI+oGJLdA/gi8P2gi7Hw/xwciRFyeLd1yS4KGuUIBRPc09NduBcKmicdjF8SlZF2Tb7l
         h2+WiMZhgfACCYtCHeofglA2VIYoumMEDlzf1Okiryfwkte8Z3bzWjqLsjR7XouRRuIO
         k+RQ==
X-Gm-Message-State: AMke39nSuAHlC5WUIdHav6l/pADs8Cb5mhjL7S/e4jAUAwrSub3Zyz/3wYrr3FMFYe0R0ErQ
X-Received: by 10.84.236.9 with SMTP id q9mr36059969plk.96.1487118910167;
        Tue, 14 Feb 2017 16:35:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id u129sm3250484pfb.130.2017.02.14.16.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/14] update submodules: add submodule config parsing
Date:   Tue, 14 Feb 2017 16:34:14 -0800
Message-Id: <20170215003423.20245-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
index 93453909cf..93f01c4378 100644
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
index 70f19363fd..d434ecdb45 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,16 +22,17 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
-		const char *path);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_or_tree, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_or_tree, const char *path);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-void submodule_free(void);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.12.0.rc0.16.gd1691994b4.dirty

