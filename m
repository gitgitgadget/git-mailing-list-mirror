Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC9C1FADF
	for <e@80x24.org>; Tue,  1 May 2018 22:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEAWWe (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 18:22:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32819 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeEAWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 18:22:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id i194-v6so9162161pgd.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sY2hARdHa1LscQrCMX6l3gGJOhQIhHsOTnklySzxgtU=;
        b=PUp1bjnmPZf5Fb12SECfalLTr5ur0R2Zj3vmYkrPb+RygGRRUVhD31WD00dUHCteID
         lBu4miagurtsVK4jFbk1K1hmHEzNx3CGzrP8xYacoetHFUVB/t3vNrAivrXIuTHNXUS0
         kmnz8A6ONTJQHejnL3f9PgJFoCPnQ1tYjgysuBUXtMdMsEHKao5G2DwRcwjzwGlJnanN
         rxSveQcFhQwo9XpyicNddUm68loCWq7+WmEx4OcNeHx3UFsCW9OwDgkGu+SlSQvsBvLF
         xGR5AktNX7Zkem8uBYrA11Q/3T+YQnUU2WEXRdmlI0cwGAQx8VtXAdsNSGbtleMjfDna
         X1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sY2hARdHa1LscQrCMX6l3gGJOhQIhHsOTnklySzxgtU=;
        b=PC8BKxBOcJe2blp2mIwWBckJKtpRln91Ftzgb865g3iGncpg3Y8BcUF760/FgYT+ZH
         lX4raSWqZN+oPne0t5w1YZvvB5j+9ydx43qj/njygUbrVRQJnQqMRHhuv+7YZ2SllQ0I
         HSc1nN72lJfYng5GZGYS6uURZI9woEwf9QqIr+we6zDSXIDo9ObfiinDGoYzKmn6qmO9
         ETv6fj97M5Y8eTFKpDcWriyUT8biniaYNPZztn1Scy4tkSuI/DkaEwcH7vJ3BA4MTvll
         WrweP/H3wXLYBY5boHbvj6+vZCJewvq4CPj31nQLljQZRAIn2x8KMEhyH3nx1NoOhjvb
         DZKw==
X-Gm-Message-State: ALQs6tDsm5BoNKWlP2/x6UTKpcZT1HN8XNHP0ZLojbO/KL96i2Nc3FQS
        WTASIanH5bTxf5s29MeMjXBHtU+AgN0=
X-Google-Smtp-Source: AB8JxZo8URwXfdCvZxlCexGW9OscsqcxvSgfXeaSHXqx8kNtCwbiAFpVBpr/34727fULr1s8Q22T+Q==
X-Received: by 2002:a65:5247:: with SMTP id q7-v6mr14066019pgp.27.1525213351375;
        Tue, 01 May 2018 15:22:31 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u72-v6sm17192975pgb.16.2018.05.01.15.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 15:22:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] {fetch,upload}-pack: support filter in protocol v2
Date:   Tue,  1 May 2018 15:22:21 -0700
Message-Id: <0486dfdfe614f908b322552b02ebbb3f1f6cd6fc.1525213052.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch-pack/upload-pack protocol v2 was developed independently of
the filter parameter (used in partial fetches), thus it did not include
support for it. Add support for the filter parameter.

Like in the legacy protocol, the server advertises and supports "filter"
only if uploadpack.allowfilter is configured.

Like in the legacy protocol, the client continues with a warning if
"--filter" is specified, but the server does not advertise it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt |  9 +++
 fetch-pack.c                            | 23 +++++-
 t/t5702-protocol-v2.sh                  | 97 +++++++++++++++++++++++++
 upload-pack.c                           | 12 ++-
 4 files changed, 135 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 136179d7d..38d24fd2b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -290,6 +290,15 @@ included in the clients request as well as the potential addition of the
 	Cannot be used with "deepen", but can be used with
 	"deepen-since".
 
+If the 'filter' feature is advertised, the following argument can be
+included in the client's request:
+
+    filter <filter-spec>
+	Request that various objects from the packfile be omitted
+	using one of several filtering techniques. These are intended
+	for use with partial clone and partial fetch operations. See
+	`rev-list` for possible "filter-spec" values.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
diff --git a/fetch-pack.c b/fetch-pack.c
index f93723fec..3ed40aa46 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1191,14 +1191,29 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 	else if (is_repository_shallow() || args->deepen)
 		die(_("Server does not support shallow requests"));
 
+	/* Add filter */
+	if (server_supports_feature("fetch", "filter", 0) &&
+	    args->filter_options.choice) {
+		print_verbose(args, _("Server supports filter"));
+		packet_buf_write(&req_buf, "filter %s",
+				 args->filter_options.filter_spec);
+	} else if (args->filter_options.choice) {
+		warning("filtering not recognized by server, ignoring");
+	}
+
 	/* add wants */
 	add_wants(wants, &req_buf);
 
-	/* Add all of the common commits we've found in previous rounds */
-	add_common(&req_buf, common);
+	if (args->no_dependents) {
+		packet_buf_write(&req_buf, "done");
+		ret = 1;
+	} else {
+		/* Add all of the common commits we've found in previous rounds */
+		add_common(&req_buf, common);
 
-	/* Add initial haves */
-	ret = add_haves(&req_buf, haves_to_send, in_vain);
+		/* Add initial haves */
+		ret = add_haves(&req_buf, haves_to_send, in_vain);
+	}
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 56f7c3c32..834ccc6f2 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -201,6 +201,103 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/three" log
 '
 
+test_expect_success 'setup filter tests' '
+	git init server &&
+
+	# 1 commit to create a file, and 1 commit to modify it
+	test_commit -C server message1 a.txt &&
+	test_commit -C server message2 a.txt &&
+	git -C server config protocol.version 2 &&
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git -C server config protocol.version 2
+'
+
+test_expect_success 'partial clone' '
+	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
+		clone --filter=blob:none "file://$(pwd)/server" client &&
+	grep "version 2" trace &&
+
+	# Ensure that the old version of the file is missing
+	git -C client rev-list master --quiet --objects --missing=print \
+		>observed.oids &&
+	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
+
+	# Ensure that client passes fsck
+	git -C client fsck
+'
+
+test_expect_success 'dynamically fetch missing object' '
+	rm "$(pwd)/trace" &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		cat-file -p $(git -C server rev-parse message1:a.txt) &&
+	grep "version 2" trace
+'
+
+test_expect_success 'partial fetch' '
+	rm -rf client "$(pwd)/trace" &&
+	git init client &&
+	SERVER="file://$(pwd)/server" &&
+	test_config -C client extensions.partialClone "$SERVER" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
+	grep "version 2" trace &&
+
+	# Ensure that the old version of the file is missing
+	git -C client rev-list other --quiet --objects --missing=print \
+		>observed.oids &&
+	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
+
+	# Ensure that client passes fsck
+	git -C client fsck
+'
+
+test_expect_success 'do not advertise filter if not configured to do so' '
+	SERVER="file://$(pwd)/server" &&
+
+	rm "$(pwd)/trace" &&
+	git -C server config uploadpack.allowfilter 1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
+		ls-remote "$SERVER" &&
+	grep "fetch=.*filter" trace &&
+
+	rm "$(pwd)/trace" &&
+	git -C server config uploadpack.allowfilter 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
+		ls-remote "$SERVER" &&
+	grep "fetch=" trace >fetch_capabilities &&
+	! grep filter fetch_capabilities
+'
+
+test_expect_success 'partial clone warns if filter is not advertised' '
+	rm -rf client &&
+	git -C server config uploadpack.allowfilter 0 &&
+	git -c protocol.version=2 \
+		clone --filter=blob:none "file://$(pwd)/server" client 2>err &&
+	test_i18ngrep "filtering not recognized by server, ignoring" err
+'
+
+test_expect_success 'even with handcrafted request, filter does not work if not advertised' '
+	git -C server config uploadpack.allowfilter 0 &&
+
+	# Custom request that tries to filter even though it is not advertised.
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	want $(git -C server rev-parse master)
+	filter blob:none
+	0000
+	EOF
+
+	test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
+	grep "unexpected line: .filter blob:none." err &&
+
+	# Exercise to ensure that if advertised, filter works
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C server serve --stateless-rpc <in >/dev/null
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index c4456bb88..3872fa518 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1205,6 +1205,7 @@ static void process_args(struct packet_reader *request,
 {
 	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
 		const char *arg = request->line;
+		const char *p;
 
 		/* process want */
 		if (parse_want(arg))
@@ -1251,6 +1252,11 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
+		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
+			parse_list_objects_filter(&filter_options, p);
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
@@ -1428,7 +1434,9 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value)
 {
-	if (value)
-		strbuf_addstr(value, "shallow");
+	git_config(upload_pack_config, NULL);
+	if (value) {
+		strbuf_addf(value, "%sshallow", allow_filter ? "filter " : "");
+	}
 	return 1;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

