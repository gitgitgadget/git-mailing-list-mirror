Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF712035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034384AbcJ1S4m (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:42 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34531 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034353AbcJ1S4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id n85so41598793pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WB8KpQL7cw89rCGH8HPqkvU5zy+AnzuLHO0PjYaX7tM=;
        b=P9NSiH/os6RbneF0ZwVaW/dZTCt4H3xp2K9qe8ZSSEiBkFa05gxtHx+w8V/vGb+U5q
         eMv6C9x702Gnae/ZWzz4pnPdXIV24S6256ZFsDtrHfwFDaIQdHhu6HAxdQL4AGEnOvnN
         IA4joW7ZanEqDqEWL2p8+bSI2Qypi7PMYUXo7lBTybj0amsMc3h9EerkgCzdo1PK82TP
         0MD6VK+dqrpj/2Hk4jgK2gRAFhQr0wMr4cdznWBCDKnkJD3y8WwqxRJxmXg08Qg/WwIF
         PIrX5ywlTQXmEWkeb6tD9vPeD/51Zef1ZjEXaP6ym/iwNctLsVYtm9ki+2QNH9io+mnW
         m6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WB8KpQL7cw89rCGH8HPqkvU5zy+AnzuLHO0PjYaX7tM=;
        b=iboHCKnM1OU7+mrG9a+I/bE0gii0QqSC9q6m8Dnn5o92uM49PVP+Ci/PQ35XIwZLZ4
         FLjunTUZpKk2CPCa4qLIbvLR7y25TyjPH2fLVgIqHs5AteeXaa9j547Jf1lmgN/G496O
         r7mQ8FaazNSlm5msoFj2fRPMsxIJ/1yNyuB37LjP/gRgA/YGOmkET7KwQu1yA6Dn71MZ
         QO0/uqgaw5vq9/8w8x5ng+wRCXSyf2qfEXoH8adspo8AVTNLu58jq7x/NhMM6tmRPZ8o
         K9nLKmCmuO8x39n0uE4AuQGB0iHucGofpSH8TzhaT3TRT3YLYjUFjhaaFGb/79KkfXt7
         sZJg==
X-Gm-Message-State: ABUngvcNtoWBQlF83J2mpuqv1h9Mq7SdqzFzWgq2asXtzjgK2tKT3SjN60XuASM33tNTML8C
X-Received: by 10.98.200.15 with SMTP id z15mr27708078pff.128.1477680989468;
        Fri, 28 Oct 2016 11:56:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id oo10sm20630638pac.12.2016.10.28.11.56.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 35/36] clone: add --init-submodule=<pathspec> switch
Date:   Fri, 28 Oct 2016 11:55:01 -0700
Message-Id: <20161028185502.8789-36-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch passes the pathspec to `git submodule update --init`
which is called after the actual clone is done.

Additionally this configures the submodule.defaultUpdatePath to
be the given pathspec, such that any future invocation of
`git submodule update --init-default-paths` will keep up
with the pathspec.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt | 23 +++++++++----
 builtin/clone.c             | 36 ++++++++++++++++++--
 t/t7400-submodule-basic.sh  | 81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 35cc34b2fb..1089f3812c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--init-submodule <pathspec>] [--jobs <n>] [--]
+	  <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -217,12 +218,20 @@ objects from the source repository into a pack in the cloned repository.
 
 --recursive::
 --recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	After the clone is created, initialize and clone all submodules
+	within, using their default settings. This is equivalent to
+	running `git submodule update --recursive --init `
+	immediately after the clone is finished. This option is ignored
+	if the cloned repository does not have a worktree/checkout (i.e.
+	if any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--init-submodule::
+	After the clone is created, initialize and clone specified
+	submodules within, using their default settings. It is possible
+	to give multiple specifications by giving this argument multiple
+	times. This is equivalent to configure `submodule.defaultUpdateGroup`
+	and then running `git submodule update --init-default-path`
+	immediately after the clone is finished.
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
diff --git a/builtin/clone.c b/builtin/clone.c
index 6c76a6ed66..748e7c0c19 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,6 +56,16 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list init_submodules;
+
+static int init_submodules_cb(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		return -1;
+
+	string_list_append((struct string_list *)opt->value, arg);
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -112,6 +122,9 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("<pathspec>"),
+			N_("clone specific submodules. Pass multiple times for complex pathspecs"),
+			init_submodules_cb),
 	OPT_END()
 };
 
@@ -733,13 +746,21 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recursive || init_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (init_submodules.nr > 0)
+			argv_array_pushf(&args, "--init-default-path");
+		else
+			argv_array_pushf(&args, "--init");
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
@@ -887,6 +908,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.defaultUpdatePath=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4699b1c532..90f9030541 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1170,4 +1170,85 @@ test_expect_success 'submodule update --init-default-path' '
 	test_cmp expect actual
 '
 
+cat <<EOF > expected
+ sub0 (test2)
+-sub1
+-sub2
+-sub3
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="sub0" multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+test_expect_success 'clone with multiple --init-submodule options' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules \
+		  --init-submodule="." \
+		  --init-submodule ":(exclude)sub0" \
+		  --init-submodule ":(exclude)sub2" \
+			multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+
+cat <<EOF > expect2
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+-sub4
+ sub5 (test2)
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="." \
+				       --init-submodule ":(exclude)sub0" \
+				       --init-submodule ":(exclude)sub2" \
+				       --init-submodule ":(exclude)sub4" \
+				       multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual &&
+	(
+		cd multisuper &&
+		git submodule add ../sub1 sub4 &&
+		git submodule add ../sub1 sub5 &&
+		git commit -m "add more submodules"
+	) &&
+	(
+		cd multisuper_clone &&
+		# obtain the new superproject
+		git pull &&
+		git submodule update --init-default-path &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.10.1.714.ge3da0db

