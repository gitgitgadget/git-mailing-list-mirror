Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325FA200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeECXrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:47:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43120 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeECXrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:47:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id j20so1660850pff.10
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2rb6icoF2yb5EJoZzXZ4gw8NMkvw4uZUToYhPSeH8YY=;
        b=gPOjhxDKkPFasVhW9QIu8CahzbBkhMd0Dehumw70d2cQxgpLFDlVu9tMZDOJhGG/t3
         hJFVtqDH7pFO6lqgqmMVC1ixIowVRSeVGxUUMNiv1Rl5q82RBYYpy1Sn6CgodhdZXI7a
         1NQbgN/xkye5DGCjFx+/XE7BVbHbi8jZuosatWh8QZxyePQmWmcOa1npjoeBIOmPyO3H
         aMjvW+KnVyDqTX9HojnziizCGKnx+nFirb1d3g1pbWl6pOsRH0PrWd1miKo2/xofHFS/
         i6Hz4Fo8XTk4fz7/otm2nlPLRAp0lZ8v9VMVsHS7p5zyd0y2DiJWakeD5XXK34Wxawnc
         Ugag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2rb6icoF2yb5EJoZzXZ4gw8NMkvw4uZUToYhPSeH8YY=;
        b=f8YkpH/QjKm5Xugv+1x1sVqzFcKgzOCL03/dMpa4ZbZ/j0Bt+ZPaI7wmcOiQA4AMUK
         bkKoIXlDol9KFr0N9MmMPCun4a3MUjXZAn1wEgJ50L17WGX6yYWyDqHbtjBaxp+4C20W
         xmk6PEV5pEK5cCTJY85X17eic4TGaZnIiswfGsGdZo5nd1tNJ8g0Sg+xGxkhkW9r3z1n
         mLzQz2iBkBRecFET1WtmJlQ34scm7WLK1eW8ZlXHG8MNkT3qHZzaAJzTd+5YWFqixWsg
         CosuvOxAg/u+GH2VeiHv0i9MCeVKBSPuwysA7c5uSKhIRmZiFfZrxDh38+dJVGwQw8pq
         77Zw==
X-Gm-Message-State: ALQs6tDykaWYvLsnDEOs8et9QJIlu+u4LGZfrrY8GFeXpMGqWIEO+rZ6
        kPpQnnZfyBGtjH7caV5CBNCq6rV7GSE=
X-Google-Smtp-Source: AB8JxZpGOZPvntdsobg+8HsqbLxNTLzWOZyIITGQLnoN2qor6JPIfDkJX0nbXt3WW0f/DT0MmTw+2Q==
X-Received: by 2002:a17:902:7684:: with SMTP id m4-v6mr25785133pll.340.1525391237983;
        Thu, 03 May 2018 16:47:17 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a67-v6sm7924669pgc.23.2018.05.03.16.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 16:47:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH v3 3/3] {fetch,upload}-pack: support filter in protocol v2
Date:   Thu,  3 May 2018 16:46:56 -0700
Message-Id: <b1eca0f60a61c6a35ee4e7a6903aa056c0aaf710.1525391172.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525391172.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com> <cover.1525391172.git.jonathantanmy@google.com>
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
 t/t5702-protocol-v2.sh                  | 98 +++++++++++++++++++++++++
 upload-pack.c                           | 15 +++-
 4 files changed, 140 insertions(+), 5 deletions(-)

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
index abb15cd6d..25bf046b3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -215,6 +215,104 @@ test_expect_success 'upload-pack respects config using protocol v2' '
 	test_path_is_file server/.git/hookout
 '
 
+test_expect_success 'setup filter tests' '
+	rm -rf server client &&
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
index 113edd32d..82c16cae3 100644
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
@@ -1430,7 +1436,14 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value)
 {
-	if (value)
+	if (value) {
+		int allow_filter_value;
 		strbuf_addstr(value, "shallow");
+		if (!repo_config_get_bool(the_repository,
+					 "uploadpack.allowfilter",
+					 &allow_filter_value) &&
+		    allow_filter_value)
+			strbuf_addstr(value, " filter");
+	}
 	return 1;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

