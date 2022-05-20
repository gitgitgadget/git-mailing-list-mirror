Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A086C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353100AbiETSme (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353035AbiETSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61515220D9
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i82-20020a1c3b55000000b00397391910d5so1334654wma.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1tBebPfZzrWCT1icKKMlNNXv9VOZNIGbQaxj1hfmSsc=;
        b=htBGbhMPWe3me8bARFicGYVeOd+seLN0cMNnrbNCy0CaM1hx87Es7zWCXsmkzvvAIt
         /HYdVszqeiUIxn1qzp68xJ7ukR7FRYCOLUSBbRCjwSMrATf3XbrJo4ZcqYZsXjwQa/7R
         562RBtVxpiDgWazQuLaCBZm0IPWfuhkcm3JaR5hwUxbuDPYnYFav6mpJyGo0ZPXHoPkX
         9kTNR97MhVOB0MB0o16yQNJkQj8T6fEIhXryAedRyU6xuLoBdsGagoDJQYoGV+JM6yOg
         K87YMmnIXbeVrBbUPuW13wPRAmMJZt0qg+hmd2tC4zDaKPr6czNOYfsEhzO+o/UNyl6t
         khbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1tBebPfZzrWCT1icKKMlNNXv9VOZNIGbQaxj1hfmSsc=;
        b=57CMEvTV65seC4HQEttPuD7Utm2z5Vb4fsA/gNR6PTu468UzIltStvoIryiZ1Bxvq8
         8Cm9HoC09y7ov/QD3BK8iNNMx9KEk5sVCTPxcAtWLoU20V858ewV9ocNXJdQ6bIG/I5p
         MdMguqn2iveVt/d4TMHnYgHSz550OK4JIHh+uPTVbAfo6SI7Gol3hmWbkN6SKMZByfzB
         L08oHzUZXMOdu6QMvoSlrExXWKmLLaUoqhkmNNNcro8j7110SC6C9MoQ5FDG1Q2iCYe6
         YBTU5MTT9h1bWPaq6ldgb/IBhwGG/b94UHJ8aXfGFKxPlP5KeSkgmlO4dx0YtC0UFjsL
         KYAg==
X-Gm-Message-State: AOAM531iOvidOQv2EEi7xXaceynQNVUEgFrcnH8DnGOehGYORlWzoFgr
        cuGvbecHiK0hsYAw3UpZC/PyjLa2uAE=
X-Google-Smtp-Source: ABdhPJx3Q07VsrtX626oFb63j4rYHdB5DGvDVDHUto/mjTu74BemmYV2ZpxNJp3QwVpF8AVlorQepg==
X-Received: by 2002:a05:600c:1c25:b0:394:62c4:2722 with SMTP id j37-20020a05600c1c2500b0039462c42722mr9404070wms.69.1653072068132;
        Fri, 20 May 2022 11:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b00395f15d993fsm2738329wmr.5.2022.05.20.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:07 -0700 (PDT)
Message-Id: <be9b139db9113f5653ceaed9b5c35c236cf70a78.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:39 +0000
Subject: [PATCH 21/24] bundle-uri: allow relative URLs in bundle lists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Bundle providers may want to distribute that data across multiple CDNs.
This might require a change in the base URI, all the way to the domain
name. If all bundles require an absolute URI in their 'uri' value, then
every push to a CDN would require altering the table of contents to
match the expected domain and exact location within it.

Allow a bundle list to specify a relative URI for the bundles.
This allows easier distribution of bundle data.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                |  6 ++++-
 bundle-uri.h                |  9 +++++++
 t/helper/test-bundle-uri.c  |  2 ++
 t/t5750-bundle-uri-parse.sh | 54 +++++++++++++++++++++++++++++++++++++
 transport.c                 |  3 +++
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 70be53aa38d..9e7dc0fb4ca 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
+#include "remote.h"
 
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
@@ -49,6 +50,7 @@ void clear_bundle_list(struct bundle_list *list)
 
 	for_all_bundles_in_list(list, clear_remote_bundle_info, NULL);
 	hashmap_clear_and_free(&list->bundles, struct remote_bundle_info, ent);
+	free(list->baseURI);
 }
 
 int for_all_bundles_in_list(struct bundle_list *list,
@@ -169,7 +171,7 @@ static int bundle_list_update(const char *key, const char *value,
 
 	if (!strcmp(dot, "uri")) {
 		free(bundle->uri);
-		bundle->uri = xstrdup(value);
+		bundle->uri = relative_url(list->baseURI, value, NULL);
 		return 0;
 	}
 
@@ -197,6 +199,8 @@ int parse_bundle_list_in_config_format(const char *uri,
 	};
 
 	list->mode = BUNDLE_MODE_NONE;
+	if (!list->baseURI)
+		list->baseURI = xstrdup(uri);
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
 						   &opts);
diff --git a/bundle-uri.h b/bundle-uri.h
index 9f6fc2d75f9..fdcaea048a8 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -65,6 +65,15 @@ struct bundle_list {
 	enum bundle_list_mode mode;
 	unsigned forFetch : 1;
 	struct hashmap bundles;
+
+	/**
+	 * The baseURI of a bundle_list is used as the base for any
+	 * relative URIs advertised by the bundle list at that location.
+	 *
+	 * When the list is generated from a Git server, then use that
+	 * server's location.
+	 */
+	char *baseURI;
 };
 
 void init_bundle_list(struct bundle_list *list);
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 23ce0eebca3..b535dc47134 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -35,6 +35,8 @@ static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mo
 
 	init_bundle_list(&list);
 
+	list.baseURI = xstrdup("<uri>");
+
 	switch (mode) {
 	case KEY_VALUE_PAIRS:
 		if (argc)
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index c2b7a8ce968..ea279c2b762 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -30,6 +30,30 @@ test_expect_success 'bundle_uri_parse_line() just URIs' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'bundle_uri_parse_line(): relative URIs' '
+	cat >in <<-\EOF &&
+	bundle.one.uri=bundle.bdl
+	bundle.two.uri=../bundle.bdl
+	bundle.three.uri=sub/dir/bundle.bdl
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = <uri>/bundle.bdl
+	[bundle "two"]
+		uri = bundle.bdl
+	[bundle "three"]
+		uri = <uri>/sub/dir/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-key-values <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
 	cat >in <<-\EOF &&
 	=bogus-value
@@ -106,6 +130,36 @@ test_expect_success 'parse config format: just URIs' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: relative URIs' '
+	cat >in <<-\EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = bundle.bdl
+	[bundle "two"]
+		uri = ../bundle.bdl
+	[bundle "three"]
+		uri = sub/dir/bundle.bdl
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = <uri>/bundle.bdl
+	[bundle "two"]
+		uri = bundle.bdl
+	[bundle "three"]
+		uri = <uri>/sub/dir/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-config in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
 test_expect_success 'parse config format edge cases: empty key or value' '
 	cat >in1 <<-\EOF &&
 	= bogus-value
diff --git a/transport.c b/transport.c
index f0114778ff4..52b99cd3298 100644
--- a/transport.c
+++ b/transport.c
@@ -1544,6 +1544,9 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
 		return 0;
 
+	if (!transport->bundles->baseURI)
+		transport->bundles->baseURI = xstrdup(transport->url);
+
 	if (!vtable->get_bundle_uri) {
 		if (quiet)
 			return -1;
-- 
gitgitgadget

