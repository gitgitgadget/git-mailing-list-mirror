Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3E520323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935281AbdCVTva (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:51:30 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34015 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935169AbdCVTvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:51:15 -0400
Received: by mail-pf0-f175.google.com with SMTP id p189so72914130pfp.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iQ5SiwkggPhuwISHJhyzzbyZnaGWLp2XAyiJryCQ5M=;
        b=dTYNnYT3sK5o4A2gHDc4rp4fpJ1dCNb/g1QY/XkNQdWCyNstTPK/Mk18x8TZ9XWB0f
         mZOLBwfgyxsAR7RSCaVFE9aNLZG4yk+0aB2HeQgy5ztE54VplnuKq2chvl0DawdH/BQN
         f6tGH6cU8rCurgALUS3mkc8HesttW/qRoVLFjDqJAZyU7Kla6zRBfqVAJKn1p9npEi9J
         6KhipuDU/Fx/Fq6vIgPoLzjtnqy+pzmDpyp/DyuDorvcEeR6vNWTRM1prnxez239nPpw
         jv2bmHVNvmp2W/4JEWDhSpwoq8M/Au/OUgG3mRwh1szbwPqki/EGnks0S7GLFtlmx+CL
         wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4iQ5SiwkggPhuwISHJhyzzbyZnaGWLp2XAyiJryCQ5M=;
        b=KnBcj6BN0nNDAdIZgrX8P1zijVK/i7DP3OgM+dq/U0oWRXHp91hUk9y1TsCHSXmQ8A
         h8pHDocPgtIjO2USJczbQCylIq7QcPrZe7exKonPgXe/wdAzfVCOv848CH54HkXOIYhF
         M1/NKkJEwFV386896iE6CCwDPgM1rrDPaQozP6gTOdemcMhgioE5php3mc56veH9pRl3
         eqLlFm/aN9bNxcixSkZGVRuHsIFSqAmu/NWLUOzthhwVu9cd0+uH7fyIIrlj621kY96n
         SSqYBcaKUUQTLuFf94MCghYLu8tyz/dzAXL+4x4uiM0fWO4Cxj31hFr8iay5jiebKgv8
         cgMA==
X-Gm-Message-State: AFeK/H1WTG82pQGRBSEWGdrXYd+jkH3+IfrTxexGSs+p+FVeuFxFp3OIAmq+Mli+126WfsbB
X-Received: by 10.99.114.89 with SMTP id c25mr1538977pgn.163.1490212273856;
        Wed, 22 Mar 2017 12:51:13 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id h14sm5577315pgn.41.2017.03.22.12.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 12:51:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/2] remote-curl: allow push options
Date:   Wed, 22 Mar 2017 12:51:02 -0700
Message-Id: <20170322195102.165314-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
In-Reply-To: <20170322195102.165314-1-bmwill@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach remote-curl to understand push options and to be able to convey
them across HTTP.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/send-pack.c     |  5 +++++
 remote-curl.c           |  8 ++++++++
 t/t5545-push-options.sh | 30 +++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1ff5a6753..6796f3368 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -152,6 +152,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
+	struct string_list push_options = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbose),
@@ -171,6 +172,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
+		OPT_STRING_LIST('o', "push-option", &push_options,
+				N_("server-specific"),
+				N_("option to transmit")),
 		{ OPTION_CALLBACK,
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
@@ -199,6 +203,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	args.use_thin_pack = use_thin_pack;
 	args.atomic = atomic;
 	args.stateless_rpc = stateless_rpc;
+	args.push_options = push_options.nr ? &push_options : NULL;
 
 	if (from_stdin) {
 		struct argv_array all_refspecs = ARGV_ARRAY_INIT;
diff --git a/remote-curl.c b/remote-curl.c
index 34a97e732..e953d06f6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -22,6 +22,7 @@ struct options {
 	unsigned long depth;
 	char *deepen_since;
 	struct string_list deepen_not;
+	struct string_list push_options;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -139,6 +140,9 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+	} else if (!strcmp(name, "push-option")) {
+		string_list_append(&options.push_options, value);
+		return 0;
 
 #if LIBCURL_VERSION_NUM >= 0x070a08
 	} else if (!strcmp(name, "family")) {
@@ -943,6 +947,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
 		argv_array_push(&args, "--verbose");
+	for (i = 0; i < options.push_options.nr; i++)
+		argv_array_pushf(&args, "--push-option=%s",
+				 options.push_options.items[i].string);
 	argv_array_push(&args, options.progress ? "--progress" : "--no-progress");
 	for_each_string_list_item(cas_option, &cas_options)
 		argv_array_push(&args, cas_option->string);
@@ -1028,6 +1035,7 @@ int cmd_main(int argc, const char **argv)
 	options.progress = !!isatty(2);
 	options.thin = 1;
 	string_list_init(&options.deepen_not, 1);
+	string_list_init(&options.push_options, 1);
 
 	remote = remote_get(argv[1]);
 
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 9a57a7d8f..ac62083e9 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -102,7 +102,9 @@ test_expect_success 'two push options work' '
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
 '
 
-test_expect_success 'push option denied properly by http remote helper' '\
+test_expect_success 'push option denied properly by http server' '
+	test_when_finished "rm -rf test_http_clone" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
 	mk_repo_pair &&
 	git -C upstream config receive.advertisePushOptions false &&
 	git -C upstream config http.receivepack true &&
@@ -113,6 +115,32 @@ test_expect_success 'push option denied properly by http remote helper' '\
 	git -C test_http_clone push origin master
 '
 
+test_expect_success 'push options work properly across http' '
+	test_when_finished "rm -rf test_http_clone" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	git -C upstream config http.receivepack true &&
+	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
+	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+
+	test_commit -C test_http_clone one &&
+	git -C test_http_clone push origin master &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
+	git -C test_http_clone rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	test_commit -C test_http_clone two &&
+	git -C test_http_clone push --push-option=asdf --push-option="more structured text" origin master &&
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/post-receive.push_options &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git rev-parse --verify master >expect &&
+	git -C test_http_clone rev-parse --verify master >actual &&
+	test_cmp expect actual
+'
+
 stop_httpd
 
 test_done
-- 
2.12.1.500.gab5fba24ee-goog

