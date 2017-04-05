Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0076E20966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbdDERrc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:47:32 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35390 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbdDERr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:29 -0400
Received: by mail-pf0-f180.google.com with SMTP id i5so10712002pfc.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eyUYS+taSePCzjppNadZbfsXiPNrhxPyZWBCL25GKdI=;
        b=qBejRV7+/BWgngxiaQommXxw+dmDEjhIaJqJEzHfVBN11qCaCibEAGAGd2UqEJhYb1
         kIfDMNMjWFTS6FUpZXnGijpaReb64QTWVQTEgHaF0BibmNP4q9b05jcg9sq+a5QIyKMt
         33Ebb62tacvlnBeDMooPis+TnxpEwr+HJ8SpmHZYARxH03wy0ttONd1hL50yR5clurec
         T+HKJHsHiQ90hxdU7oZ65snqW5oFe9CavL15jOO8VG80y1trBqJc0KkcTp3Q1nRnIz75
         f988XF+/7Myx0MZfkvkL5QCdNCBCWqT8kDmQDSmwAJkoJJ42pLo1gQig8yxp+0ibtaLW
         Lqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eyUYS+taSePCzjppNadZbfsXiPNrhxPyZWBCL25GKdI=;
        b=XowIyZKOXfNoomyh75FHDECKQt7+ZjSuRqtoqSQWK+QytqHMMNB7XVCz7A+hMLHMAc
         YFIZ2ztbQjsUU2/UTX8E0ee431entLj5oqrmqJ2tPAw33Mzrtmfkx+eYt1aQk5zUdPRu
         UOUsAdTT1FhHPv4CjYWha6fize7++G3faIoeFckQvLVdK/dqKUIdBI3A1jzJ77GhauLA
         jpDOYDchsrXcXrMgrwC9Rh9P5aQuJbmPb/fYZXpLKEquHfxrrPYchiPTrbd+1noADJB3
         eBREILMIPZfqvtG/BIAPv+0ddbam7hFLM/Hhll5txGrQcjnGNfph1OWD7PYc+tK8PXyA
         duJA==
X-Gm-Message-State: AFeK/H1Ozef0bBZgpgkg2yrfA/Sgn5LGFYqrQd37uPzkIb9dnyiaY1iffseHnQ1hIeYDFDNa
X-Received: by 10.84.128.75 with SMTP id 69mr37413018pla.111.1491414449016;
        Wed, 05 Apr 2017 10:47:29 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 2/5] push: propagate push-options with --recurse-submodules
Date:   Wed,  5 Apr 2017 10:47:16 -0700
Message-Id: <20170405174719.1297-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170405174719.1297-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach push --recurse-submodules to propagate push-options recursively to
the pushes performed in the submodules.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c             | 13 +++++++++++--
 submodule.h             |  1 +
 t/t5545-push-options.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 transport.c             |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c52d6634c..de444be61 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,7 +782,9 @@ int find_unpushed_submodules(struct sha1_array *commits,
 	return needs_pushing->nr;
 }
 
-static int push_submodule(const char *path, int dry_run)
+static int push_submodule(const char *path,
+			  const struct string_list *push_options,
+			  int dry_run)
 {
 	if (add_submodule_odb(path))
 		return 1;
@@ -793,6 +795,12 @@ static int push_submodule(const char *path, int dry_run)
 		if (dry_run)
 			argv_array_push(&cp.args, "--dry-run");
 
+		if (push_options && push_options->nr) {
+			const struct string_list_item *item;
+			for_each_string_list_item(item, push_options)
+				argv_array_pushf(&cp.args, "--push-option=%s",
+						 item->string);
+		}
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
@@ -807,6 +815,7 @@ static int push_submodule(const char *path, int dry_run)
 
 int push_unpushed_submodules(struct sha1_array *commits,
 			     const char *remotes_name,
+			     const struct string_list *push_options,
 			     int dry_run)
 {
 	int i, ret = 1;
@@ -818,7 +827,7 @@ int push_unpushed_submodules(struct sha1_array *commits,
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path, dry_run)) {
+		if (!push_submodule(path, push_options, dry_run)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index 8a8bc49dc..0e26430fd 100644
--- a/submodule.h
+++ b/submodule.h
@@ -92,6 +92,7 @@ extern int find_unpushed_submodules(struct sha1_array *commits,
 				    struct string_list *needs_pushing);
 extern int push_unpushed_submodules(struct sha1_array *commits,
 				    const char *remotes_name,
+				    const struct string_list *push_options,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 97065e62b..f9232f5d0 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -142,6 +142,46 @@ test_expect_success 'push options work properly across http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push options and submodules' '
+	test_when_finished "rm -rf parent" &&
+	test_when_finished "rm -rf parent_upstream" &&
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	cp -r upstream parent_upstream &&
+	test_commit -C upstream one &&
+
+	test_create_repo parent &&
+	git -C parent remote add up ../parent_upstream &&
+	test_commit -C parent one &&
+	git -C parent push --mirror up &&
+
+	git -C parent submodule add ../upstream workbench &&
+	git -C parent/workbench remote add up ../../upstream &&
+	git -C parent commit -m "add submoule" &&
+
+	test_commit -C parent/workbench two &&
+	git -C parent add workbench &&
+	git -C parent commit -m "update workbench" &&
+
+	git -C parent push \
+		--push-option=asdf --push-option="more structured text" \
+		--recurse-submodules=on-demand up master &&
+
+	git -C upstream rev-parse --verify master >expect &&
+	git -C parent/workbench rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	git -C parent_upstream rev-parse --verify master >expect &&
+	git -C parent rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options &&
+	test_cmp expect parent_upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
+'
+
 stop_httpd
 
 test_done
diff --git a/transport.c b/transport.c
index 417ed7f19..64e60b635 100644
--- a/transport.c
+++ b/transport.c
@@ -1031,6 +1031,7 @@ int transport_push(struct transport *transport,
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote->name,
+						      transport->push_options,
 						      pretend)) {
 				sha1_array_clear(&commits);
 				die("Failed to push all needed submodules!");
-- 
2.12.2.715.g7642488e1d-goog

