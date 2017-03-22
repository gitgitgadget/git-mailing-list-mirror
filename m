Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC72520323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbdCVWWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:22:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36053 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbdCVWWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:22:09 -0400
Received: by mail-pf0-f181.google.com with SMTP id o126so97133786pfb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtCFagFMs679xuSHqQEUbklBG4Z96jyA3eOwzZiBgVo=;
        b=lywOhSSploHPu87vebrtsf2RTXrMzT0Ns9N2JKR6WPkzt5M+oUbmut2bdfl0YK+YKt
         rvqXfeztr097gEMZNrGv+yfllRes6Y6/tizRNyA2lFYI2R7PaPidaXfuwMHK1fxoF6PB
         41XcEU0t9pPaFCqLuGaTe780I8qAAO2ZeDjNrlNZAqJlvenxnhGleOz24rMGkn3WTQsc
         BSTVBxuH2NgOasRESru3QhUfKVnBKK1Kn+HDZ0hzq1xa12bmxDRuCucPx6iWoUXt9vXp
         b+sm6ZgYM1Dyr9VGL3/oImwYh1KWxQ5QxIGLlAwqTMpSSsfdlNRSWDd/u+kqiPbfycFp
         ASJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CtCFagFMs679xuSHqQEUbklBG4Z96jyA3eOwzZiBgVo=;
        b=krbEEWoKeT/CUOGDtjYeqB6ZGTiaLTahUwRLoc3429juZKtdm89Q8X7OIgrrF+jEXD
         cg6E/x2rxVX5F5vhwobsnL60Lr5JbJsK/aKr8FHvywQur3LhVPbCSRW7mBNYyLx3fQE/
         2cq/7pNWrfHg6YtOEAsN3w7K4z+qIK8qaY4fn/RRHT1MBzdj0g4tNA5S0+AsN0v2nKYC
         vw9roS42SSNaX2V8eD3F0XeOGbkLcMLGPA5GdEypfOL2QAJW4Uup6Slaa0y49pZXLI6E
         IN0wMStOPNt2A0FX7+xR93ljigvbCjUHKG/xb1aDZF+8j2OYYhU/vXB58xBewuvrx1OW
         7MOw==
X-Gm-Message-State: AFeK/H1xFItzie0KUOx0CH9QzwjOlOHO2egF9cPLP/0GM0HyEhXhl+zO3CaC87WE8iqVrlwP
X-Received: by 10.99.7.3 with SMTP id 3mr35614296pgh.95.1490221328258;
        Wed, 22 Mar 2017 15:22:08 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t67sm5813582pfd.76.2017.03.22.15.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:22:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [PATCH v2 2/2] remote-curl: allow push options
Date:   Wed, 22 Mar 2017 15:22:00 -0700
Message-Id: <20170322222200.103204-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
In-Reply-To: <20170322222200.103204-1-bmwill@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322222200.103204-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach remote-curl to understand push options and to be able to convey
them across HTTP.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-send-pack.txt |  6 ++++++
 builtin/send-pack.c             |  5 +++++
 remote-curl.c                   |  8 ++++++++
 t/t5545-push-options.sh         | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index a831dd028..966abb0df 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -81,6 +81,12 @@ be in a separate packet, and the list must end with a flush packet.
 	will also fail if the actual call to `gpg --sign` fails.  See
 	linkgit:git-receive-pack[1] for the details on the receiving end.
 
+--push-option=<string>::
+	Pass the specified string as a push option for consumption by
+	hooks on the server side.  If the server doesn't support push
+	options, error out.  See linkgit:git-push[1] and
+	linkgit:githooks[5] for details.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1ff5a6753..832fd7ed0 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -144,6 +144,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	unsigned force_update = 0;
 	unsigned quiet = 0;
 	int push_cert = 0;
+	struct string_list push_options = STRING_LIST_INIT_NODUP;
 	unsigned use_thin_pack = 0;
 	unsigned atomic = 0;
 	unsigned stateless_rpc = 0;
@@ -165,6 +166,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK,
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
+		OPT_STRING_LIST(0, "push-option", &push_options,
+				N_("server-specific"),
+				N_("option to transmit")),
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
 		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
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
index 9a57a7d8f..97065e62b 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -102,17 +102,46 @@ test_expect_success 'two push options work' '
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
 '
 
-test_expect_success 'push option denied properly by http remote helper' '\
+test_expect_success 'push option denied properly by http server' '
+	test_when_finished "rm -rf test_http_clone" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH\"/upstream.git" &&
 	mk_repo_pair &&
 	git -C upstream config receive.advertisePushOptions false &&
 	git -C upstream config http.receivepack true &&
 	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
 	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
 	test_commit -C test_http_clone one &&
-	test_must_fail git -C test_http_clone push --push-option=asdf origin master &&
+	test_must_fail git -C test_http_clone push --push-option=asdf origin master 2>actual &&
+	test_i18ngrep "the receiving end does not support push options" actual &&
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

