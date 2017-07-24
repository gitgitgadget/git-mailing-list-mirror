Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B331F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 08:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbdGXIWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 04:22:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34544 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdGXIWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 04:22:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id 79so4160342wmg.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpDMc+Hp/BZXgi4jLH/CNhbdnk3kOINwF6ypl2MXXVo=;
        b=uP8KTKUg8mDfY805MeMaqERcdTrser0Je9g9DtRoywO/6QUNt5OhPoG5v3m+aBpH9I
         2SGpKk833a4g6PLjYFq4RNCAlL3RQARU2PDQoVlMu7QuUVmb+h7xeLUnHO5DzH6/aaKR
         VoYil6zCGfP94UaSWiU025BOJCLtKodwQmLZI87EJP8dVatKPxZGYkDcoHJ98f+Epcsq
         nV9+f0smElCvRtWha1C/E7Peh/oTcubztk+fs6zkXAdQj+t3C+xpwKbZh1g3CC1KXwbC
         zPa0exGJAG6kvjkSufrwbvmFBXSnVBl9Iz03s0SNLSgQSqKKyvA715CknAKDt0K6o3w4
         jzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZpDMc+Hp/BZXgi4jLH/CNhbdnk3kOINwF6ypl2MXXVo=;
        b=Cu3EKuT9xFPo4BhsT25fuNjgg6Cg3B317aINHNyO3sciv0NhIkv/nlVmyu012xVIt1
         uO04kxvc0L3pT3yocXs4H1Lpk1+t7JgPTkztwC+HUX0sO454LB2bFcrSxApgmLE0+Pqy
         NQEhPNyqgfatESiiRduUZVVr0BxtDmR1QdpLkrs95SEYzMzCVoLWZVeSooHRqpPRYNj7
         oI33h9+7zSylcc1Ac3xcrtUAfKk0VUYOGVuijVaIN4KmcQHqgNcMKPTQs9168i1/n4HB
         pRwYr+IsL0TyazSepxAKKjr8/9mw/adebytf6AZT8PWja3GIwrfd0kOldsq//rsugf2S
         t+kQ==
X-Gm-Message-State: AIVw113JrSRuw8IRmmi7egbtt+RZ9GywNdApp1BnLQYYANkoguywk/bF
        WfKIefCsdlvPlT0ZNwc=
X-Received: by 10.28.157.205 with SMTP id g196mr4410938wme.84.1500884568740;
        Mon, 24 Jul 2017 01:22:48 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-195-172.adsl-ull.clienti.tiscali.it. [94.39.195.172])
        by smtp.gmail.com with ESMTPSA id r129sm7911476wmg.42.2017.07.24.01.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2017 01:22:47 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/3] trailers: introduce struct new_trailer_item
Date:   Mon, 24 Jul 2017 10:22:44 +0200
Message-Id: <20170724082245.26496-2-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170724082044.26199-1-bonzini@gnu.org>
References: <20170724082044.26199-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

This will provide a place to store the current state of the
--where, --if-exists and --if-missing options.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 builtin/interpret-trailers.c | 41 +++++++++++++++++++++++++++++++++++++----
 trailer.c                    | 21 ++++++++++++---------
 trailer.h                    | 14 +++++++++++++-
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 175f14797..8f38fa318 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,17 +16,50 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static void new_trailers_clear(struct list_head *trailers)
+{
+	struct list_head *pos, *tmp;
+	struct new_trailer_item *item;
+
+	list_for_each_safe(pos, tmp, trailers) {
+		item = list_entry(pos, struct new_trailer_item, list);
+		list_del(pos);
+		free(item);
+	}
+}
+
+static int option_parse_trailer(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct list_head *trailers = opt->value;
+	struct new_trailer_item *item;
+
+	if (unset) {
+		new_trailers_clear(trailers);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	item = xmalloc(sizeof *item);
+	item->text = arg;
+	list_add_tail(&item->list, trailers);
+	return 0;
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	int in_place = 0;
 	int trim_empty = 0;
-	struct string_list trailers = STRING_LIST_INIT_NODUP;
+	LIST_HEAD(trailers);
 
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
-		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
-				N_("trailer(s) to add")),
+
+		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
+				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
 	};
 
@@ -43,7 +76,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		process_trailers(NULL, in_place, trim_empty, &trailers);
 	}
 
-	string_list_clear(&trailers, 0);
+	new_trailers_clear(&trailers);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index f02895373..aed5fa1f8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -669,14 +669,15 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 }
 
 static void process_command_line_args(struct list_head *arg_head,
-				      struct string_list *trailers)
+				      struct list_head *new_trailer_head)
 {
-	struct string_list_item *tr;
+	struct new_trailer_item *tr;
 	struct arg_item *item;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct conf_info *conf;
 	struct list_head *pos;
+	const char *string;
 
 	/*
 	 * In command-line arguments, '=' is accepted (in addition to the
@@ -695,18 +696,19 @@ static void process_command_line_args(struct list_head *arg_head,
 	}
 
 	/* Add an arg item for each trailer on the command line */
-	for_each_string_list_item(tr, trailers) {
-		int separator_pos = find_separator(tr->string, cl_separators);
+	list_for_each(pos, new_trailer_head) {
+		tr = list_entry(pos, struct new_trailer_item, list);
+		string = tr->text;
+		int separator_pos = find_separator(string, cl_separators);
 		if (separator_pos == 0) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, tr->string);
+			strbuf_addstr(&sb, string);
 			strbuf_trim(&sb);
 			error(_("empty trailer token in trailer '%.*s'"),
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, &conf, tr->string,
-				      separator_pos);
+			parse_trailer(&tok, &val, &conf, string, separator_pos);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
@@ -969,7 +971,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, int in_place, int trim_empty,
+		      struct list_head *new_trailer_head)
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
@@ -987,7 +990,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	/* Print the lines before the trailers */
 	trailer_end = process_input_file(outfile, sb.buf, &head);
 
-	process_command_line_args(&arg_head, trailers);
+	process_command_line_args(&arg_head, new_trailer_head);
 
 	process_trailers_lists(&head, &arg_head);
 
diff --git a/trailer.h b/trailer.h
index 2b39a1bee..b83b249b6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,8 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+#include "list.h"
+
 enum trailer_where {
 	WHERE_END,
 	WHERE_AFTER,
@@ -44,8 +46,18 @@ struct trailer_info {
 	size_t trailer_nr;
 };
 
+/*
+ * A list that represents newly-added trailers, such as those provided
+ * with the --trailer command line option of git-interpret-trailers.
+ */
+struct new_trailer_item {
+	struct list_head list;
+
+	const char *text;
+};
+
 void process_trailers(const char *file, int in_place, int trim_empty,
-		      struct string_list *trailers);
+		      struct list_head *new_trailer_head);
 
 void trailer_info_get(struct trailer_info *info, const char *str);
 
-- 
2.13.3

