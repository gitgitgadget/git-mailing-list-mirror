From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Mon, 21 Mar 2016 19:06:10 -0700
Message-ID: <1458612372-10966-6-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiY-0000nu-AC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbcCVCGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35653 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbcCVCGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:31 -0400
Received: by mail-pf0-f176.google.com with SMTP id n5so287714573pfn.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jQDuh/XDFTAK86gtE+TXGL7B5/aLXV0NAYRMfD5o3A=;
        b=Rzy7YXs6HLSMjqJzubVNFpJPZ5jghW3e/mS8N7AXX87Q2SwHQrRAtczaWCCTVGD2kx
         AlHiqZe/Ry1JblRzeTwUmjes5g3sXb0GGzW1CSqZUQmo82V5+K8JymJvvpadAyr7SfNM
         VY5ZXxLD1Fbj2mUYsrjKA3SWD5ZPFfkb3Dhr2FY4kHJZIXuLY383LQAo5nhpl0tNHaaZ
         aVnNLKvMIXf9gwxiIzACVUcpYiAcHNDO7RSs4j6sUjh3LvZJRQcvKIKeXCTPKP8Ror9E
         QArov2nolLYHX8YXrkGPYxujipE3DvJUH3SqIvykFrm5Z0bYSbqmcgssc3WbRFtAmxML
         UNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0jQDuh/XDFTAK86gtE+TXGL7B5/aLXV0NAYRMfD5o3A=;
        b=R/w/lFyL9hfInLuh32cJwCuLkjKI8/QBnia9RMWyJ9JZXk1J+2M4lySWxsVzaJ3zPT
         phaVSgG30VH48DzzfN+QgUKBcqbCmoIznCVRGyjFpCCDK/jJFl0cyFjPZCPGM30LqXpo
         D+Zzko5Zxs1ZKbuFfFoYBmM0+3SBOGn7dd2Xxlb6Z7Vxk6Jko6bzk5N0v2c+ZqDtPb/7
         NGHTfoF9D52aZ2b9tplCfTvIa8V32kZ67n+hfG28NN46gXL4F1sWRCaj8i/Ex9coZGW2
         Q7e2PjaLeybAsoVtQrpDWp9A/V6+wa8GzcZmR7Fjj1DSgw2YjLfDKm0ZFdmT53Nw6ya0
         TtaQ==
X-Gm-Message-State: AD7BkJKLugKFyn6VSsp5u4HR88HC4B4YgNWzVk93zPl5O+g0xh251vNrXlKdwjlzhuC5MPy7
X-Received: by 10.98.42.150 with SMTP id q144mr50188690pfq.73.1458612390551;
        Mon, 21 Mar 2016 19:06:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id yl1sm43668346pac.35.2016.03.21.19.06.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:29 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289485>

This change introduces the 'submodule.actionOnLabel' variable
in a repository configuration. Generally speaking 'submodule.actionOnLabel'
restricts the action of a command when no submodules are selected via the
command line explicitely to those submodules, which are selected by
'submodule.actionOnLabel'. It can occur multiple times and can specify
the path, the name or one of the labels of a submodule to select that
submodule.

The introduction of 'submodule.actionOnLabel' starts with
'git submodule update' in this patch and other commands will follow
in later patches.

'submodule.actionOnLabel' implies '--init' in 'git submodule update'.

Signed-off-by: Stefan Beller <sbeller@google.com>

TODO: generic documentation for submodule.actionOnLabel
TODO: documentation for submodule update
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c |  22 ++++++++-
 t/t7400-submodule-basic.sh  | 115 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a69b1f4..93760ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -573,6 +573,8 @@ struct submodule_update_clone {
 	int current;
 	struct module_list list;
 	unsigned warn_if_uninitialized : 1;
+	/* patterns to initialize */
+	struct string_list *initialize;
 
 	/* update parameter passed via commandline */
 	struct submodule_update_strategy update;
@@ -590,7 +592,7 @@ struct submodule_update_clone {
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
+#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, NULL, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
@@ -644,6 +646,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	git_config_get_string(sb.buf, &url);
+	if (suc->initialize) {
+		if (!url) {
+			init_submodule(sub->path, suc->prefix, suc->quiet);
+			url = xstrdup(sub->url);
+		}
+		if (!submodule_applicable_by_labels(suc->initialize, sub)
+		    && !suc->warn_if_uninitialized)
+			goto cleanup;
+	}
 	if (!url) {
 		/*
 		 * Only mention uninitialized submodules when their
@@ -745,6 +756,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	const char *update = NULL;
 	int max_jobs = -1;
 	struct string_list_item *item;
+	const struct string_list *list;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -793,6 +805,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(submodule_config, NULL);
 
+	list = git_config_get_value_multi("submodule.actionOnLabel");
+	if (list) {
+		suc.initialize = xmalloc(sizeof(*suc.initialize));
+		string_list_init(suc.initialize, 1);
+		for_each_string_list_item(item, list)
+			string_list_insert(suc.initialize, item->string);
+	}
+
 	if (max_jobs < 0)
 		max_jobs = parallel_submodules();
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fc948fd..dc45551 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1032,4 +1032,119 @@ test_expect_success 'submodule add records multiple labels' '
 	test_cmp expected actual
 '
 
+cat <<EOF > expected
+submodule
+-submodule2
+EOF
+
+test_expect_success 'update initializes all modules when action-on-label configured' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule2 &&
+		git commit -a -m "add two modules, one is labled"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.actionOnLabel \*labelA &&
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+test_expect_success 'submodule update applies to action-on-label selection' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	oldSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule2 &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule3 &&
+		git commit -a -m "add two modules, both are labled"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.actionOnLabel \*labelA &&
+		git submodule update
+	) &&
+	(
+		cd example2 &&
+		touch anotherfile &&
+		git add anotherfile &&
+		git commit -m "advance example2" &&
+		git checkout -b branchName
+	) &&
+	newSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
+	(
+		cd super &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule4 &&
+		git commit -a -m "add another labeled module" &&
+		git config -f .gitmodules submodule.submodule2.label labelB &&
+		git config -f .gitmodules --unset submodule.submodule3.label &&
+		git commit -a -m "unlabel 2 and 3 upstream" &&
+		git submodule foreach git pull origin branchName &&
+		git commit -a -m "update all submodules" &&
+		git submodule status |cut -c1-52 >../actual
+	) &&
+	cat <<EOF >expected &&
+ $newSubmoduleHead submodule1
+ $newSubmoduleHead submodule2
+ $newSubmoduleHead submodule3
+ $newSubmoduleHead submodule4
+EOF
+	test_cmp actual expected &&
+	(
+		cd super_clone &&
+		git pull &&
+		git submodule update &&
+		git submodule status |cut -c1-52 >../actual
+	) &&
+	cat <<EOF >expected &&
+ $newSubmoduleHead submodule1
++$oldSubmoduleHead submodule2
++$oldSubmoduleHead submodule3
+ $newSubmoduleHead submodule4
+EOF
+	test_cmp actual expected
+'
+
+cat <<EOF > expected
+submodule1
+submodule2
+-submodule3
+EOF
+
+test_expect_success 'Change labels in .git/config' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
+		git submodule add file://"$pwd"/example2 submodule2 &&
+		git submodule add file://"$pwd"/example2 submodule3 &&
+		git commit -a -m "add two modules, one is labled"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.actionOnLabel \*labelA &&
+		git config submodule.submodule2.label labelA
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.7.0.rc0.45.g6b4c145
