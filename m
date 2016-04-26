From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/15] submodule--helper list: respect submodule groups
Date: Tue, 26 Apr 2016 13:50:26 -0700
Message-ID: <1461703833-10350-9-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9xH-0006pt-7K
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcDZUvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36354 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbcDZUu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:58 -0400
Received: by mail-pa0-f54.google.com with SMTP id bt5so10783365pac.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JCN0TeQ+TQT9BIu9Rsg8/XyckHr1oDJg06xLqLd0J2s=;
        b=iX6bNg7imjRSGLEkdp5dgGg4fK4h7OmoqCbhwTVWDv2h7nug+vccoWIkDSPPimDTL8
         h1NAZrkkXYy4+xjvYzXNgYYm2VqSCNE4VlAhJTDvqXjF8qQbD4vY3U1AEXjMGIVKfHCN
         w1tl+R2wqp0dBiJicrXnE6bLbV7BPj41lMqMm45h2RnSvnCspU/s8xjCrdMfk7cGVWJ9
         6aMcwlMl7cfAa9wBpBZWB0vU7FlQE15f2a2czIhR8/vm2n7QSf+jsn9rzNrD+RlcE+Ij
         YklASGXUxx46JHAw8tQ22INwOz8RvRefPvgb+udN7EuJ3gFYozZ0H0LlugHSCb6D1vjZ
         n5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JCN0TeQ+TQT9BIu9Rsg8/XyckHr1oDJg06xLqLd0J2s=;
        b=dRhfkw6XNY8M3LTVn40wsUB5Lyuaw1eAXCRHD99WG0y++zwOqEG55oQRewNewOLg+v
         nyv/eh16vXwkcNCH/K+Z9IUGce+2be6oFV2ukp6MHDk9BaUfFS6BxrqmEO/MxiJ1uFJb
         EuYfnqZqNw0WjGI2x4vt7ZVt+QvlB+XrmuWwYP4q2OPdHbFbkepSmLGfyg6zvDsniRbL
         ufJtRHMpjvsrS4eEEb8+y4MBOJ3+EPgbDpPLmMWl4uqLNhfxzocImaqWO8YYSbxAEX43
         6ziLOWuv5218mwY+eQRfGP3nmN2zCRyIh/DexyBfPPipqLRcrzszplrqNrnZcBs4nO46
         GrfQ==
X-Gm-Message-State: AOPr4FUUP7QdQrbXu3OUE0FMwuC8xakm4ZO8jjWjBWTKgnbNVfPAijWwNihNzpMGgR8UMf/t
X-Received: by 10.66.90.226 with SMTP id bz2mr6645877pab.31.1461703855595;
        Tue, 26 Apr 2016 13:50:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id n10sm502069pfj.14.2016.04.26.13.50.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292681>

As submodule--helper list is the building block for some submodule
commands (foreach, deinit, status, sync), also add tests for those.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c  | 13 ++++++
 t/t7413-submodule--helper.sh | 97 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7b9a4d7..adb6188 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -271,6 +271,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
+	const struct string_list *group = NULL;
 
 	struct option module_list_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -292,9 +293,21 @@ static int module_list(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
+	if (!pathspec.nr)
+		group = git_config_get_value_multi("submodule.defaultGroup");
+	if (group)
+		gitmodules_config();
+
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
 
+		if (group) {
+			const struct submodule *sub =
+				submodule_from_path(null_sha1, ce->name);
+			if (!submodule_in_group(group, sub))
+				continue;
+		}
+
 		if (ce_stage(ce))
 			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
 		else
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index c6939ab..1b5d135 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -78,4 +78,101 @@ test_expect_success 'in-group' '
 	)
 '
 
+submodule_sha1=$(git -C sub rev-parse HEAD)
+
+cat >expect <<-EOF
+160000 $submodule_sha1 0	sub0
+160000 $submodule_sha1 0	sub1
+160000 $submodule_sha1 0	sub3
+EOF
+
+test_expect_success 'submodule--helper list respects groups' '
+	(
+		cd super &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule--helper list >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+Entering 'sub0'
+$submodule_sha1 sub0
+Entering 'sub1'
+$submodule_sha1 sub1
+Entering 'sub3'
+$submodule_sha1 sub3
+EOF
+
+test_expect_success 'submodule foreach respects groups' '
+	(
+		cd super &&
+		git submodule foreach "echo \$sha1 \$name" >../actual
+	) &&
+	test_cmp expect actual
+'
+
+sub_priorsha1=$(git -C sub rev-parse HEAD^)
+
+cat >expect <<-EOF
++$sub_priorsha1 sub0 (test)
++$sub_priorsha1 sub1 (test)
++$sub_priorsha1 sub3 (test)
+EOF
+
+test_expect_success 'submodule status respects groups' '
+	git clone --recurse-submodules super super_clone &&
+	(
+		cd super_clone &&
+		git -C sub0 checkout HEAD^ &&
+		git -C sub1 checkout HEAD^ &&
+		git -C sub2 checkout HEAD^ &&
+		git -C sub3 checkout HEAD^ &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule status >../actual &&
+		git config --unset-all submodule.defaultGroup &&
+		git submodule update
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule deinit respects groups' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super_clone &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule deinit &&
+		test_must_fail git config submodule.sub0.url &&
+		test_must_fail git config submodule.sub1.url &&
+		test "$(git config submodule.sub2.url)" = "$suburl" &&
+		test_must_fail git config submodule.sub3.url &&
+		git config --unset-all submodule.defaultGroup &&
+		git submodule init
+	)
+'
+
+test_expect_success 'submodule sync respects groups' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super_clone &&
+		git config submodule.sub0.url nonsense &&
+		git config submodule.sub1.url nonsense &&
+		git config submodule.sub2.url nonsense &&
+		git config submodule.sub3.url nonsense &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule sync &&
+		git config --unset-all submodule.defaultGroup &&
+		test "$(git config submodule.sub0.url)" = "$suburl" &&
+		test "$(git config submodule.sub1.url)" = "$suburl" &&
+		test "$(git config submodule.sub2.url)" = "nonsense" &&
+		test "$(git config submodule.sub3.url)" = "$suburl" &&
+		git submodule sync sub2 &&
+		test "$(git config submodule.sub2.url)" = "$suburl"
+	)
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3
