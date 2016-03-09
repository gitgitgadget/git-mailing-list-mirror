From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 30/48] builtin/apply: move 'limit_by_name' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:58 +0100
Message-ID: <1457545756-20616-31-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIk-0008NP-So
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbcCIRxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:33 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38595 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933743AbcCIRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:21 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so82003610wml.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OpnpjkOJjIrvplrLDlQPfWfPyS/Q9nrEhrCJC/jayE=;
        b=fRS7JqJPZE8IL4RXdc2D3TuqSS8MKBVXtvHManJ7LTCVuRSsGVr6GK/EPk8fCU3vRl
         y4ntWj/n9utjJnuiIU+CdKPxIbGaXPvEa4j5g5OV2+oeSsht8MbPCjiSts2+T8egrTEe
         OChWlMU1eN76DhqWjlh2TM42NeiOtrkfbgU05EiTgLw6hmATu2J0FiFEib2kEWvCCqPn
         TeQ7SL2dDq1TiUccF5XS0xqoiuZ9PrRY+lwMrxfTxDodIsoSZdwlC9FWGAjHgkZkgq70
         nYR2EfCpAAyLVaU+slYW6df9IIv7qf16dsqDfJfTlXSRXCNpyknP/BMnAWHTySsYE9xe
         exDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OpnpjkOJjIrvplrLDlQPfWfPyS/Q9nrEhrCJC/jayE=;
        b=SEkZFa/jZBrs8WwIbzGhGZGfgQR19QuzlP/2QV6q94fogd4pnd9QlFrkAcdoT8UalK
         X+C2YdGB/6WZj834USyaD5n1oQxlyknZEsWnKHZ3FzKkvo48hechl1kRX4O9eLpF9ros
         5DmZALHwbwdyrp49RJZiDvwZuVfHJXq+6xS9HcMEj7OZePlHNd9Zh8M26SyhZpSIct9Q
         ml3k80VitI+ncWzvUKZAx+YwwTGaUwfsYd1PRAO9DEZLeyeqqf39oVHUjkccUE4aQwNu
         nj+nmUw+E0q/ejph2GfqN7xbfe9DijxrIhHd+AFHjKicWMRYSDEz+Is6wf+Y0cyTcnp4
         c5GQ==
X-Gm-Message-State: AD7BkJLrtutPbamwgnkYCi4rUXlhJ/UD/5rkp25VlmShuFUrcZ7ft1xCbR7W1x+D5mfTQg==
X-Received: by 10.28.107.9 with SMTP id g9mr6022006wmc.34.1457546000477;
        Wed, 09 Mar 2016 09:53:20 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:19 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288518>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e94594d..186e451 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -71,6 +71,8 @@ struct apply_state {
 	struct lock_file lock_file;
 
 	const char *patch_input_file;
+
+	struct string_list limit_by_name;
 };
 
 static int p_value = 1;
@@ -1979,13 +1981,14 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
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
 
@@ -2003,8 +2006,8 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < limit_by_name.nr; i++) {
-		struct string_list_item *it = &limit_by_name.items[i];
+	for (i = 0; i < state->limit_by_name.nr; i++) {
+		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0, NULL))
 			return (it->util != NULL);
 	}
@@ -4534,14 +4537,16 @@ static void git_apply_config(void)
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
@@ -4596,10 +4601,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
