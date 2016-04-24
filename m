From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 29/83] builtin/apply: move 'limit_by_name' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:29 +0200
Message-ID: <1461504863-15946-30-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEl-0000sg-KH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbcDXNfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:34 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34978 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbcDXNfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:32 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so60532539wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBVYhjLtt/aDUgYt7iOzseJtMHbBJux3hzpJNQDfhJo=;
        b=zGMGu5q6/CXij/pgawWR2gtuoEBA5aKz5JnH773J07B/LdPaOCyyq/rpQYXjpMkBeQ
         OVHJ+5g3YgKcQM3QG0gag4bX1yQStDNDybY50v8CO0ZISgCOvtuiCIr3wIpROlvZGOUb
         BQj1GD99LVEOfZOliUq5qnVNaY6JftDLc8kCZ0Ir0PPUrmNlu8ckGYJtcnJiMAVzBvKe
         0vRit1hhVI3Hm+g1CrTWB4RRNHhc4UVxdz0XKlreLSMtSZ5GLEjZISEs0vjSnz1mS6E3
         ijb9f1HaIdVb3ejItct0v/FKq3MAbdt9cilHixwftF+y8TFq3V4zfraJXoGi1dezxOG6
         URDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBVYhjLtt/aDUgYt7iOzseJtMHbBJux3hzpJNQDfhJo=;
        b=je5EYZNIMeOASFSpIG05PJMinD+m3GpMQokNToCUzh8+DKRZzxTjuN1N507KAc3RyD
         DZu5SAifa9Ygcs3B1W5UMYdDNHbyAim7gQ69VPrGgikX06dLUMZzfwRvkxtmOiZUF6EB
         DSEcX6GQFe4zFtSEidTnHQTOufyG1zUO/8htVOEzdQoKG9LjhrMnVZgtvDEiFeMQ/TO8
         QY6i+x8akqti/9VdsG8cKhurEVVeVwvDCtWeHi0tfycCovB6+lr69hAcPfBccvqSRVGk
         i3mvdIycuvhq1n4CUc65cOVjG/iimlow8s0biDMvsGaYPAFmac9+22hA01oevmTjza29
         QCuw==
X-Gm-Message-State: AOPr4FWid0/cQkz7nqnmZ6z5KJN2pbuaWmWEm7fH96c/qe8qW7l1YuUguCU9Edf+hzxzNw==
X-Received: by 10.28.54.69 with SMTP id d66mr7474959wma.94.1461504925842;
        Sun, 24 Apr 2016 06:35:25 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:24 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292385>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ab311c1..c8b9bf0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -68,6 +68,8 @@ struct apply_state {
 	unsigned int p_context;
 
 	const char *patch_input_file;
+
+	struct string_list limit_by_name;
 };
 
 static int newfd = -1;
@@ -1974,13 +1976,14 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
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
 
@@ -1998,8 +2001,8 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < limit_by_name.nr; i++) {
-		struct string_list_item *it = &limit_by_name.items[i];
+	for (i = 0; i < state->limit_by_name.nr; i++) {
+		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0, NULL))
 			return (it->util != NULL);
 	}
@@ -4537,14 +4540,16 @@ static void git_apply_config(void)
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
@@ -4599,10 +4604,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.1.300.g5fed0c0
