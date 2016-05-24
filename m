From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 30/49] builtin/apply: move 'limit_by_name' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:07 +0200
Message-ID: <20160524081126.16973-31-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Tk-0001WB-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbcEXIOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35685 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbcEXIM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id f75so3656422wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Yf7woGPt5yxOuOZ+omRltf0rorW6EV7ot/C5k2EyrQ=;
        b=rGb0AzopknnnIK1aJR4JVHj6vJt1CD7+wg1pSpphklbJeBH6uI1RflJtN08uyJM4g9
         u4viOb7DDbHbfCFNoGi6chphn45Q4zCBt4t104qeJF5FKDll82fvunzZLc4zSjJLQnri
         hCAe9FEGt6XR39Qr/AR2Cskc1jJiOmYrosUEitIFVf4K/rrW3+NjmGVUUB/5eC5tyrTF
         Nhfwsoa3/0VWthBBhJHys/hyuGyrtnIK78oVFxkXwtfPOxcwhKmqzS9XmR8ap/QS9gqJ
         MPDEVo25ciWx+9zgIZ59QG+XplaALUVEkb1NA0T/7Tov3pGQ5jdpsD/uhsgU/CygnY37
         NbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Yf7woGPt5yxOuOZ+omRltf0rorW6EV7ot/C5k2EyrQ=;
        b=DZXbdymBvFYUVlSxxKgKwo3c7eXOVjpjGCSi0GNJ4x2043jmfPGdvY2OiZlo03XdQL
         DWilKgR89eeSXtKQjf8WaECs3x46ay+eFkKuOM7E1OGzOIhnWTcAbV6hFh+fEBK5Qs3g
         YAhG7EGIFHpmvElkUndDMXw/WgJWwsNv7zAsdu0eyh+d/93zMLpz7su1UkBhqVIth3c5
         r4o0QJImJ18ZMA6KndRNrKJ/OzNAybWHM0ki+kVOF9fcqNcgiutiGOPHLaRpuG6fRjfY
         q/bhownF9ZeiU4QfSMFLS7xf8EJeKbUGdIPruEFnVC6BUnqLK41G8T/cdLNOvCTerY3c
         5oVg==
X-Gm-Message-State: ALyK8tJjCo2fTh6ODOgPlg88sllUIK+fy+ZIJQrSm9Rp015mqUzw+yTYzsJyVBdoYfwSUQ==
X-Received: by 10.194.112.233 with SMTP id it9mr3129097wjb.22.1464077546580;
        Tue, 24 May 2016 01:12:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:25 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295456>

To libify the apply functionality the 'limit_by_name' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fa90028..0e3de17 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,9 @@ struct apply_state {
 	const char *patch_input_file;
 	int line_termination;
 	unsigned int p_context;
+
+	/* Exclude and include path parameters */
+	struct string_list limit_by_name;
 };
 
 static int newfd = -1;
@@ -1958,13 +1961,14 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static struct string_list limit_by_name;
 static int has_include;
-static void add_name_limit(const char *name, int exclude)
+static void add_name_limit(struct apply_state *state,
+			   const char *name,
+			   int exclude)
 {
 	struct string_list_item *it;
 
-	it = string_list_append(&limit_by_name, name);
+	it = string_list_append(&state->limit_by_name, name);
 	it->util = exclude ? NULL : (void *) 1;
 }
 
@@ -1982,8 +1986,8 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < limit_by_name.nr; i++) {
-		struct string_list_item *it = &limit_by_name.items[i];
+	for (i = 0; i < state->limit_by_name.nr; i++) {
+		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0, NULL))
 			return (it->util != NULL);
 	}
@@ -4520,14 +4524,16 @@ static void git_apply_config(void)
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
-	add_name_limit(arg, 1);
+	struct apply_state *state = opt->value;
+	add_name_limit(state, arg, 1);
 	return 0;
 }
 
 static int option_parse_include(const struct option *opt,
 				const char *arg, int unset)
 {
-	add_name_limit(arg, 0);
+	struct apply_state *state = opt->value;
+	add_name_limit(state, arg, 0);
 	has_include = 1;
 	return 0;
 }
@@ -4587,7 +4593,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 
 static void clear_apply_state(struct apply_state *state)
 {
-	/* empty for now */
+	string_list_clear(&state->limit_by_name, 0);
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
@@ -4603,10 +4609,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	const char *whitespace_option = NULL;
 
 	struct option builtin_apply_options[] = {
-		{ OPTION_CALLBACK, 0, "exclude", NULL, N_("path"),
+		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
 			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", NULL, N_("path"),
+		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
 			0, option_parse_include },
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
-- 
2.8.3.443.gaeee61e
