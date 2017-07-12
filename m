Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F32B202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 13:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdGLNq5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 09:46:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36189 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbdGLNqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 09:46:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so5924400wrb.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZguaG4V15TYDgNVuB/OcjKQj9WK7074ckKURWOezifs=;
        b=lZiRvouyLgVQgd/DYqUzY26L13dMDe/mdJlYwPDL6OIJjhZZqJ9kL8SgAiemXkOh5M
         slK8iLABAOaK0tDXvLG87w4nHqYSz2Q4ErCcva98Z3vohL7UMDP728csVa9IcRZzoD0f
         MML52tlsn7Gu3WOy6Q789deJmGZmGs3ZItbqnKIoWlgsimlWu7mIA+EHj6kyzANCTq1z
         ke8PHenVrQC/OkQ7GDCEerqqaaRGpmVodD0natT83K+OpFO1joEZPJ56vNLFW6I+Xj4N
         Yz+s0TEu0FYDgVumLLpQufLIqCHuauH6kEXVVfNaAlFz27fbgSomkIPEz3LUg3EYaWe5
         rhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZguaG4V15TYDgNVuB/OcjKQj9WK7074ckKURWOezifs=;
        b=TBJBp9Zk11Fn3re+xxmhkf3q133IJatQdgTPL8JPrx58+OYpWeUOr5rcO6B7uqyH0P
         5dHXiPHiv3iMo9a3utVCnWbO6n1FHha/oNJYJ/clLRldDBlKHVL94UzBbij2eB6rHKTf
         eJ3+Fe08hzIhcT21X09M77r+zrrF7KDNty/epfqlaYJlpYs1AT5AdC2i/mCwwJGWpOBj
         4/na4aeDFqyro9P8nfK+z3r4NofWLEkRE/SCug+YiM5wXBHGJ/iuGkmmeRb0crQIZYg7
         /yDWKTDWcs7s0fD4lf7H4aqaNnJzdjRgFy5mXiHVP+MlFXVO9tRtqEV/tJMbLAo8yPuq
         OnLw==
X-Gm-Message-State: AIVw1112lNccwQ1puyHO9g5+9hTz+Dbpg9kuaLSK/5nUQqpthb2nrEN8
        Alr4OHWSIUqFzQyRPkQ=
X-Received: by 10.223.148.129 with SMTP id 1mr3183513wrr.28.1499867212716;
        Wed, 12 Jul 2017 06:46:52 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id 55sm3437950wrt.36.2017.07.12.06.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 06:46:52 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] trailers: export action enums and corresponding lookup functions
Date:   Wed, 12 Jul 2017 15:46:45 +0200
Message-Id: <20170712134646.17179-3-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712134646.17179-1-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Separate the mechanical changes out of the next patch.  The functions
are changed to take a pointer to enum, because struct conf_info is not
going to be public.

Write down the defaults explicitly in default_conf_info, since they are
not anymore close to default_conf_info and it's not obvious which
constant has value 0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trailer.c | 51 +++++++++++++++++++++++++--------------------------
 trailer.h | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/trailer.c b/trailer.c
index a3eb42818..558c52431 100644
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
@@ -24,7 +19,11 @@ struct conf_info {
 	enum action_if_missing if_missing;
 };
 
-static struct conf_info default_conf_info;
+static struct conf_info default_conf_info = {
+	.where = WHERE_END,
+	.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
+	.if_missing = MISSING_ADD,
+};
 
 struct trailer_item {
 	struct list_head list;
@@ -374,44 +373,44 @@ static void process_trailers_lists(struct list_head *head,
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
@@ -471,15 +470,15 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
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
@@ -533,15 +532,15 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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


