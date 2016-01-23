From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] submodule update: respect submodule.autoInitialize
Date: Fri, 22 Jan 2016 16:31:42 -0800
Message-ID: <1453509103-16470-5-git-send-email-sbeller@google.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7U-0006fU-Dh
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbcAWAbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:31:55 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34828 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbcAWAbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:53 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so50073561pff.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uY8Mn2MloDZFvs7frf6ho7lMdCU+3NwTyJcv9h8WlxU=;
        b=ZaPJ4G5s4nMX+HmU7dBly1oJ/LTRBD0/WH7xx2p2zWBHvUo+PSbBjaVXpEGk23q6md
         T/RXHClvny42nCcDuIZ/wUSR9YayYXCKoAVRYCZ8SaBOsuG6TVfWjz6tYulmRyKzXSpf
         0Y+tblGNe0gkpwuqTmq5lc2zJe28oeW6JAbNFt8JRDSvlKvG1KhgwW17kR7aLQYDoU7v
         yGKsYxJqv3j9lECK9Gy4rgZikL/3UAzWOGBxOHKaUbFTHD6qeGwi0HrgJytP8/0lHhSB
         zMeFmRxvnt9kUc5tV0sS0d/PzB4iITaOiJneHLyUGIpaxidc475leTzqvUEnshHFMxEj
         kJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uY8Mn2MloDZFvs7frf6ho7lMdCU+3NwTyJcv9h8WlxU=;
        b=Sp53rzW3idO6AqaSL4BUs7JhwJLomEa8A/QgsrqOymFWL/rfjKebfzklPo8y/uwo9k
         2nQCtRIdUofUllbBV0UQSDw71bJ73zlcVBwipX8Fx076PSnq9xemwJvI96fto018ywId
         qyqD8+mppRhDSd8kj2T7piMoXRKquncEJl8lgBJiF7d5tPt3sSQc0GW1Fb42CJ6/VIG9
         e8RIBbF7ctoZWvJova/86WC3mFbmEILX6c5OnVJJAdYMTLb75wVyQiTgtF4A7ViUa6+q
         KURFI+Xg+hKLcf+TZFTVRIHsR/Nnj+Dx/3DdoDfBRiGxWGtQvDl1jKacQkbeyQU5EUDz
         tDoA==
X-Gm-Message-State: AG10YOQMeTGh4oTmd1qBnxToF9ehBNo25MZrmTEJyDfe6I8iETdhPaZj4fdNArlf6YuvzaKx
X-Received: by 10.98.80.79 with SMTP id e76mr8518267pfb.126.1453509112734;
        Fri, 22 Jan 2016 16:31:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id dz8sm12265419pab.19.2016.01.22.16.31.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:52 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284614>

All submodules which are selected via submodule.autoInitialize
are initialized if they were not initialized before updating
the submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh  | 32 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05c18a3..61e2488 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -579,9 +579,10 @@ struct submodule_update_clone {
 	const char *prefix;
 	struct module_list list;
 	struct string_list projectlines;
+	struct string_list *initialize;
 	struct pathspec pathspec;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
+#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP, NULL}
 
 static void fill_clone_command(struct child_process *cp, int quiet,
 			       const char *prefix, const char *path,
@@ -624,6 +625,7 @@ static int update_clone_get_next_task(struct child_process *cp,
 		const char *update_module = NULL;
 		char *url = NULL;
 		int needs_cloning = 0;
+		int auto_init = 0;
 
 		if (ce_stage(ce)) {
 			if (pp->recursive_prefix)
@@ -667,6 +669,49 @@ static int update_clone_get_next_task(struct child_process *cp,
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.url", sub->name);
 		git_config_get_string(sb.buf, &url);
+		if (pp->initialize) {
+			if (sub->labels) {
+				struct string_list_item *item;
+				for_each_string_list_item(item, sub->labels) {
+					strbuf_reset(&sb);
+					strbuf_addf(&sb, "*%s", item->string);
+					if (string_list_has_string(
+					    pp->initialize, sb.buf)) {
+						auto_init = 1;
+						break;
+					}
+				}
+			}
+			if (sub->path) {
+				/*
+				 * NEEDSWORK: This currently works only for
+				 * exact paths, but we want to enable
+				 * inexact matches such wildcards.
+				 */
+				strbuf_reset(&sb);
+				strbuf_addf(&sb, "./%s", sub->path);
+				if (string_list_has_string(pp->initialize, sb.buf)) {
+					auto_init = 1;
+				}
+			}
+			if (sub->name) {
+				/*
+				 * NEEDSWORK: Same as with path. Do we want to
+				 * support wildcards or such?
+				 */
+				strbuf_reset(&sb);
+				strbuf_addf(&sb, ":%s", sub->name);
+				if (string_list_has_string(pp->initialize, sb.buf)) {
+					auto_init = 1;
+				}
+			}
+			if (auto_init) {
+				if (!url) {
+					init_submodule(sub->path, pp->prefix, pp->quiet);
+					url = xstrdup(sub->url);
+				}
+			}
+		}
 		if (!url) {
 			/*
 			 * Only mention uninitialized submodules when its
@@ -733,6 +778,7 @@ static int update_clone_task_finished(int result,
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	int max_jobs = -1;
+	const struct string_list *list;
 	struct string_list_item *item;
 	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -777,6 +823,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
 
+	list = git_config_get_value_multi("submodule.autoInitialize");
+	if (list) {
+		pp.initialize = xmalloc(sizeof(*pp.initialize));
+		string_list_init(pp.initialize, 1);
+		for_each_string_list_item(item, list)
+			string_list_insert(pp.initialize, item->string);
+	}
+
 	if (max_jobs < 0)
 		max_jobs = config_parallel_submodules();
 	if (max_jobs < 0)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 01d54e3..e1ade1e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1032,4 +1032,36 @@ test_expect_success 'submodule add records multiple lables' '
 	test_cmp expected actual
 '
 
+cat <<EOF > expected
+submodule
+submodule1
+submodule2
+-submodule3
+EOF
+
+test_expect_success 'submodule update auto-initializes submodules' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git submodule add --name specialSnowflake file://"$pwd"/example2 submodule1 &&
+		git submodule add file://"$pwd"/example2 submodule2 &&
+		git submodule add file://"$pwd"/example2 submodule3 &&
+		git commit -a -m "create repository with 4 submodules, one is labeled"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.autoInitialize \*labelA &&
+		git config --add submodule.autoInitialize :specialSnowflake &&
+		git config --add submodule.autoInitialize ./submodule2 &&
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.7.0.rc0.42.g77a36b9.dirty
