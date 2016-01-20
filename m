From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] submodule update: Initialize all group-selected submodules by default
Date: Tue, 19 Jan 2016 19:34:39 -0800
Message-ID: <1453260880-628-4-git-send-email-sbeller@google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:35:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjXv-0004fk-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935042AbcATDez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:34:55 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34142 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935036AbcATDes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:34:48 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so192075187pfb.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Rq90SuT/YsINiyGOPbGJw2WMMm49En9RYF05yyWNq0=;
        b=RdshX6kyTOT604loPuJBj699GVmyZ4QlPwZ55Xggy/jQzFOZtGvTq3AkVoZZe/etjz
         bZEBjICLKYU9PFfB+Ll5c5Aj/bSSuMFYNbeBorIzDs8HTledMmiKk9/awX3oAr3KQq/G
         WfSYsPOdwGdRRvovpF+N9pAqnm6m4aBP3Lxx1O6umOY4Aw8f3+iEskaCt1tA3EdupBUd
         MpcgkpiqVRlgkfSt+Ousnc9xOdv5aPo0CkNFaxsTnadwjOpaxlPoZbOiarCKtPsygjds
         Wu9c9buRTVOaAlz1bTUtvNW+o/MqdKuhjFGSjHGqHpnY4IkjowaYqfOG2Fl8rFqhjPjA
         Mzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Rq90SuT/YsINiyGOPbGJw2WMMm49En9RYF05yyWNq0=;
        b=g2tbv+2Gmy2Nr8Ntl5jAkm/DBCActy8z+q1V4kn5UdsDWcsWXUUYZU2wU8nt0RVlvp
         cPVH6dyRqYS3WvRtMdgBgD7cCnUf5pI/cg+fyF/w/r0lxnJAkLrYeK96EB9W7Ub6TLx4
         bM6694ICr4+HGgINpGp0Ljn2t/fxnFu2dOlQLdzZW3rXHxO+wbZ1nwnBgEON5m4XEIpq
         +fK3oqHcRrIIYW30iVM443FFVn6XF4TaEOLlnZJuxt0KDw05E5zg9yfIFP8k4NJVkUQm
         FIF6fe110om61ahsgsFLgAAn1GSuBnGBsuifvNfAS6aDOkcGsFxw3s+CevsMdoMJrq9R
         d0BA==
X-Gm-Message-State: ALoCoQna2Ejm3VDH9D3RuwYWIzk8gvRdJf4PvNjqpc66QGEunnPZA3X57n37rtdb/+slOwHWZX0nXhmsrwQi6ucMYNAvP7mIIw==
X-Received: by 10.98.42.74 with SMTP id q71mr48763526pfq.18.1453260887825;
        Tue, 19 Jan 2016 19:34:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id b28sm44660233pfd.24.2016.01.19.19.34.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:34:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453260880-628-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284423>

All submodules which are selected via submodule groups
("submodule.groups") are initialized if they were not initialized
before updating the submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 30 +++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh  | 26 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4684f16..def382e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -577,6 +577,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 struct submodule_update_clone {
 	/* states */
+	struct string_list *submodule_groups;
 	int count;
 	int print_unmatched;
 	/* configuration */
@@ -590,7 +591,7 @@ struct submodule_update_clone {
 	struct string_list projectlines;
 	struct pathspec pathspec;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
+#define SUBMODULE_UPDATE_CLONE_INIT {NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
 
 static void fill_clone_command(struct child_process *cp, int quiet,
 			       const char *prefix, const char *path,
@@ -633,6 +634,7 @@ static int update_clone_get_next_task(struct child_process *cp,
 		const char *update_module = NULL;
 		char *url = NULL;
 		int needs_cloning = 0;
+		int in_submodule_groups = 0;
 
 		if (ce_stage(ce)) {
 			if (pp->recursive_prefix)
@@ -676,6 +678,22 @@ static int update_clone_get_next_task(struct child_process *cp,
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.url", sub->name);
 		git_config_get_string(sb.buf, &url);
+		if (pp->submodule_groups && sub->groups){
+			struct string_list_item *item;
+			for_each_string_list_item(item, sub->groups) {
+				if (string_list_has_string(
+				    pp->submodule_groups, item->string)) {
+					in_submodule_groups = 1;
+					break;
+				}
+			}
+			if (in_submodule_groups) {
+				if (!url) {
+					init_submodule(sub->name, pp->prefix, pp->quiet);
+					url = xstrdup(sub->url);
+				}
+			}
+		}
 		if (!url) {
 			/*
 			 * Only mention uninitialized submodules when its
@@ -687,6 +705,7 @@ static int update_clone_get_next_task(struct child_process *cp,
 			continue;
 		}
 
+
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s/.git", ce->name);
 		needs_cloning = !file_exists(sb.buf);
@@ -742,6 +761,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	int max_jobs = -1;
+	const struct string_list *list;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -786,6 +806,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
 
+	list = git_config_get_value_multi("submodule.groups");
+	if (list) {
+		pp.submodule_groups = xmalloc(sizeof(*pp.submodule_groups));
+		string_list_init(pp.submodule_groups, 1);
+		for_each_string_list_item(item, list)
+			string_list_insert(pp.submodule_groups, item->string);
+	}
+
 	if (max_jobs < 0)
 		max_jobs = config_parallel_submodules();
 	if (max_jobs < 0)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b468278..e6a008c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1032,4 +1032,30 @@ test_expect_success 'submodule add records groups' '
 	test_cmp expected actual
 '
 
+cat <<EOF > expected
+submodule
+-submodule1
+EOF
+
+test_expect_success 'submodule update works with groups implied' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.7.0.rc0.41.g89994f2.dirty
