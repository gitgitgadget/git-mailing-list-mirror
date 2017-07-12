Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8EC420357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdGLWVb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:21:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35854 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdGLWVa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:21:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so7718808wrb.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fg/WJGqk8eNyoubhQO8DtwH3xUM8xaBuaa3WccI8EfQ=;
        b=Z/wD0LS4Bns2bRwcJmBf/H2lsU+J1/hiUPbttHSd8I/0Q2Xsast80NZ6LGvdinX2WJ
         CI7XsDdyNcaITiyWbER/AYJSRupeTu9F8t+ripu6l1sWQVui+ZnhSX91d6yYYpTp3oc1
         lqdsY3fNaNruYHFjJu5CFtE4RnO44WfYdOvntVbYooue0eEJmI5PHtU6AQhEe7fxXhtJ
         uMcGwlEQJ/4vPk/9mDTZ8UHPt5AovjSnqRVkYDlmP5b8xGNC7pwHD6ar+5xtqWu/uAhE
         uvuS0ZGNW7fx4ZEaJqp7mt8xwLBaJU/tS7rYC7CtnbsUb0nWhqjHWh6tXQAddMxw0N5W
         UQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=fg/WJGqk8eNyoubhQO8DtwH3xUM8xaBuaa3WccI8EfQ=;
        b=tvS/cVPND04xkrX4Svt7bQ8+vi39YVuYIV2xY3EcIv1JslB/F6V102yp5e/6TSApCD
         /V5fRnZlDtXOWTVpeJ1hxFrC0ZTydCAf+qFUVaNBLIAEeayqcDwBzLPHSEu/2JqFm7lD
         +u1vEXLLMxnIe4r47Y0z8kYXuoi1MwTraO1nH0+X4Misxvn29vymM4+XG60b0EDc6R0E
         abhbL9Kh4GUjZA+8xQIc2XEf8B7RjazT8C+YGZ5VrLPtS5nA68H/dqPd7pSy02FG/55E
         B+KVyfODWDMH+5y7hZBLSG8UPLppMytGJgbUgj07R6+L3nHZ7DvmRh3RGO7pv15IXd6t
         oL0g==
X-Gm-Message-State: AIVw111YCinDfht+9TXP8GHD+bee+/E7h5DTDpdUHHUctbWkZdZ4R04W
        w3qfa9j20YT03O1nydw=
X-Received: by 10.223.164.218 with SMTP id h26mr372564wrb.100.1499898083636;
        Wed, 12 Jul 2017 15:21:23 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id r200sm3444539wmd.20.2017.07.12.15.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 15:21:22 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/3] trailers: export action enums and corresponding lookup functions
Date:   Thu, 13 Jul 2017 00:21:15 +0200
Message-Id: <20170712222116.7095-3-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712222116.7095-1-bonzini@gnu.org>
References: <20170712222116.7095-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Separate the mechanical changes out of the next patch.  The functions
are changed to take a pointer to enum, because struct conf_info is not
going to be public.

Set the default values explicitly in default_conf_info, since they are
not anymore close to default_conf_info and it's not obvious which
constant has value 0.  With the next patch, in fact, the values will
not be zero anymore!

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v1->v2: avoid use of designated initializers

 trailer.c | 48 +++++++++++++++++++++++-------------------------
 trailer.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/trailer.c b/trailer.c
index a3eb42818..a371c7b45 100644
--- a/trailer.c
+++ b/trailer.c
@@ -10,11 +10,6 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-enum action_where { WHERE_END, WHERE_AFTER, WHERE_BEFORE, WHERE_START };
-enum action_if_exists { EXISTS_ADD_IF_DIFFERENT_NEIGHBOR, EXISTS_ADD_IF_DIFFERENT,
-			EXISTS_ADD, EXISTS_REPLACE, EXISTS_DO_NOTHING };
-enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };
-
 struct conf_info {
 	char *name;
 	char *key;
@@ -374,44 +369,44 @@ static void process_trailers_lists(struct list_head *head,
 	}
 }
 
-static int set_where(struct conf_info *item, const char *value)
+int set_where(enum action_where *item, const char *value)
 {
 	if (!strcasecmp("after", value))
-		item->where = WHERE_AFTER;
+		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
-		item->where = WHERE_BEFORE;
+		*item = WHERE_BEFORE;
 	else if (!strcasecmp("end", value))
-		item->where = WHERE_END;
+		*item = WHERE_END;
 	else if (!strcasecmp("start", value))
-		item->where = WHERE_START;
+		*item = WHERE_START;
 	else
 		return -1;
 	return 0;
 }
 
-static int set_if_exists(struct conf_info *item, const char *value)
+int set_if_exists(enum action_if_exists *item, const char *value)
 {
 	if (!strcasecmp("addIfDifferent", value))
-		item->if_exists = EXISTS_ADD_IF_DIFFERENT;
+		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
-		item->if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+		*item = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
 	else if (!strcasecmp("add", value))
-		item->if_exists = EXISTS_ADD;
+		*item = EXISTS_ADD;
 	else if (!strcasecmp("replace", value))
-		item->if_exists = EXISTS_REPLACE;
+		*item = EXISTS_REPLACE;
 	else if (!strcasecmp("doNothing", value))
-		item->if_exists = EXISTS_DO_NOTHING;
+		*item = EXISTS_DO_NOTHING;
 	else
 		return -1;
 	return 0;
 }
 
-static int set_if_missing(struct conf_info *item, const char *value)
+int set_if_missing(enum action_if_missing *item, const char *value)
 {
 	if (!strcasecmp("doNothing", value))
-		item->if_missing = MISSING_DO_NOTHING;
+		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
-		item->if_missing = MISSING_ADD;
+		*item = MISSING_ADD;
 	else
 		return -1;
 	return 0;
@@ -471,15 +466,15 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 	variable_name = strrchr(trailer_item, '.');
 	if (!variable_name) {
 		if (!strcmp(trailer_item, "where")) {
-			if (set_where(&default_conf_info, value) < 0)
+			if (set_where(&default_conf_info.where, value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifexists")) {
-			if (set_if_exists(&default_conf_info, value) < 0)
+			if (set_if_exists(&default_conf_info.if_exists, value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifmissing")) {
-			if (set_if_missing(&default_conf_info, value) < 0)
+			if (set_if_missing(&default_conf_info.if_missing, value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "separators")) {
@@ -533,15 +528,15 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 		conf->command = xstrdup(value);
 		break;
 	case TRAILER_WHERE:
-		if (set_where(conf, value))
+		if (set_where(&conf->where, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_EXISTS:
-		if (set_if_exists(conf, value))
+		if (set_if_exists(&conf->if_exists, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_MISSING:
-		if (set_if_missing(conf, value))
+		if (set_if_missing(&conf->if_missing, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
@@ -556,6 +551,9 @@ static void ensure_configured(void)
 		return;
 
 	/* Default config must be setup first */
+	default_conf_info.where = WHERE_END;
+	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+	default_conf_info.if_missing = MISSING_ADD;
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 	configured = 1;
diff --git a/trailer.h b/trailer.h
index e90ba1270..f306bf059 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,11 +1,33 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+enum action_where {
+	WHERE_END,
+	WHERE_AFTER,
+	WHERE_BEFORE,
+	WHERE_START
+};
+enum action_if_exists {
+	EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
+	EXISTS_ADD_IF_DIFFERENT,
+	EXISTS_ADD,
+	EXISTS_REPLACE,
+	EXISTS_DO_NOTHING
+};
+enum action_if_missing {
+	MISSING_ADD,
+	MISSING_DO_NOTHING
+};
+
 struct trailer_opts {
 	int in_place;
 	int trim_empty;
 };
 
+int set_where(enum action_where *item, const char *value);
+int set_if_exists(enum action_if_exists *item, const char *value);
+int set_if_missing(enum action_if_missing *item, const char *value);
+
 struct trailer_info {
 	/*
 	 * True if there is a blank line before the location pointed to by
-- 
2.13.0


