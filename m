Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739711FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbdCaX4c (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:56:32 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36561 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbdCaX4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:56:31 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so83249525pge.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncKbO3ofMmv/o9r4QZFVAPhGrdcRXf+sEIPCOD9N6fk=;
        b=u9yR5arlw/yU6oz3iEenqq+ZakeutKYKFJMAcsJfYHwvrJzIVeiWLorZBuZmG965ld
         wX0JCrmEWTilVY3aDyLlWFaN+339KD5meuWbeoWD89Uy8rhqzVONzU98ZJDc67nUhgFw
         gLbsaem1rrfi0ZlOEMjlac4JxSmdGrQUDQRWyvDLrBP//Ez+Nm9C/lQajSLoWiZULiEc
         cSYfeFyWjazIEEazntOETuuyliMmCabDiVsnJduFx71MMv6lFFA387JbiYwPyfIHEbsb
         kn0xn0zWf4hE9RlSKBDGRjN6NQwD+0NbzJz2vVJnQcJtdbGWgj4NfNkGi2FTGiJu2Qe6
         3qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncKbO3ofMmv/o9r4QZFVAPhGrdcRXf+sEIPCOD9N6fk=;
        b=iexRcpRQuZL304clWyKQH71F1FpofSOVWywXx054P8iwPsF0Dli22JT1aIMO25GCl+
         fLu/T9j7I/SFaxtiV8wOR5yUESUDmyks7N9ywit2d17cumGIOErvR91iUfDLryc5DPHj
         R1xlpWOYRCziNPl4otVdIUKiXuD+R0uDTmwiIQhEtywZILb7P1PA/+oz9xg9VsLQY2T3
         MScfrmZDHO2Zz2I1Pk3whuAYCbaQa3UZpf+WMIfvQKtj9Un+Pvq6Yr6y9Qjvu674wXzk
         iJ3goKgDuQpA1L9ak0mtAcFFqEeDPRhhM2i1KASxwYXyhPLE/8jN6K9Dm/x3byCZRelv
         j9qw==
X-Gm-Message-State: AFeK/H23kIWAqrUIfRJ7QJZ9gVY4K84PGnz3zQazfaMCMIgM5hCknn5esEPTtLh0gDuKybM1
X-Received: by 10.98.16.11 with SMTP id y11mr4888831pfi.84.1491004590491;
        Fri, 31 Mar 2017 16:56:30 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x22sm12504643pfi.35.2017.03.31.16.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:56:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 2/2] push: propagate push-options with --recurse-submodules
Date:   Fri, 31 Mar 2017 16:56:23 -0700
Message-Id: <20170331235623.166408-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.564.g063fe858b8-goog
In-Reply-To: <20170331235623.166408-1-bmwill@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
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
 t/t5545-push-options.sh | 39 +++++++++++++++++++++++++++++++++++++++
 transport.c             |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

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
index 97065e62b..32c513c78 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -142,6 +142,45 @@ test_expect_success 'push options work properly across http' '
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
2.12.2.564.g063fe858b8-goog

