Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BB620960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdDJUqd (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:46:33 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33150 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdDJUqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:46:30 -0400
Received: by mail-pg0-f49.google.com with SMTP id x125so111446832pgb.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y/GJntQert9pDd37OmZqiiVX21WtoEUXa+10NLP2iYk=;
        b=YbM7+/yLc+et6nR4C6PJjObKnVoa4UCExsBDZRp9RuMSVkZ5YAJXR0z4GLhdtYUSLc
         FsjJQ+BhX8G9ggG7qx2bSjlZIU6jOuiK3C+x/4I9SodoOIPBeOJeYQ6wiTAHNOrPk+Le
         nlXonKmKjuqT9aHycIwfbVcZLkX8k5/18Nbrp44MmTe13jRljX7zSzb3c2z8ADp9pOAN
         YpAru/GVM/lT1aTi+FgNKSDbbp6VoL9XjcG9o/TJEH+5iNgD+wXzjsdcgxom3XKglebH
         yDhdGwbLJLJJj46OQKywAe4uzEt1Edkm/d+u+Ophx1n2FdhtE6iK55jSOYGKSsZoX6HZ
         xshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y/GJntQert9pDd37OmZqiiVX21WtoEUXa+10NLP2iYk=;
        b=YZrqxig4U0CHSC/3VY7VFVoT+UBad66zDQF42sbl/YOw6QERQfVck2Xv3rlHz7Cf8f
         AX/YLZgLYEIHJtWf/G6rEzJzSSwzcJiWSGY3jH9m7TD4EWFfco+qUkT1Itr4l3ywd+uY
         dXHINSN3mr+7wePar0tp84d955femH5iGEuvweVbdB1wOFEt0IItjHhWGRsD3l76b0fM
         gS8Csp2JkTFfQCfYp7qKY+rlBc/GLlbTnzjXHA3oczNkTRsD7W5zMOoaFQ1M9bLtSA32
         HassTcNNOwo00UMB0hrR0Z9bDv+CNXMxWWmtEycHKMf5xIl3u1uBfC5OVd/s2vKNcMgU
         9vqQ==
X-Gm-Message-State: AFeK/H1NJIMStx5f766QdKahuEm0tfenqRmoeG+0IdwlVhXQ5U9mMvOxJ4MnRYAiMCkj7Vf1
X-Received: by 10.98.72.88 with SMTP id v85mr55171596pfa.99.1491857189480;
        Mon, 10 Apr 2017 13:46:29 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id r90sm6709414pfl.120.2017.04.10.13.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:46:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 4/4] server-endpoint: serve blobs by hash
Date:   Mon, 10 Apr 2017 13:46:10 -0700
Message-Id: <2cef84c6781af4b36c17968537ed4e492c4435b2.1491851452.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upgrade server-endpoint to also serve blobs in a packfile given their
hashes.  Reachability checks are performed before the packfile is sent -
both an absent blob and an unreachable blob are reported to the user in
the same way ("not our blob").

Due to a bug in "rev-list" in the absence of bitmaps (discussed here
[1]), the server repositories in tests all have bitmaps.

[1] <20170309003547.6930-1-jonathantanmy@google.com>

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 server-endpoint.c          | 121 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t5573-server-endpoint.sh |  60 ++++++++++++++++++++++
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 t/t5573-server-endpoint.sh

diff --git a/server-endpoint.c b/server-endpoint.c
index a9c0c7c94..870b853a6 100644
--- a/server-endpoint.c
+++ b/server-endpoint.c
@@ -192,6 +192,123 @@ static int fetch_ref(int stateless_rpc)
 	return -1;
 }
 
+/*
+ * Returns 1 if all blobs are reachable. If not, returns 0 and stores the hash
+ * of one of the unreachable blobs in unreachable.
+ */
+static int are_all_reachable(const struct object_array *blobs, struct object_id *unreachable)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	static const char *argv[] = {
+		"rev-list", "--objects", "--use-bitmap-index", "--stdin", "--not", "--all", "--not", NULL,
+	};
+	int i;
+	char buf[41] = {0};
+
+	cmd.argv = argv;
+	cmd.git_cmd = 1;
+	cmd.in = -1;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		goto error;
+	
+	for (i = 0; i < blobs->nr; i++) {
+		write_in_full(cmd.in, sha1_to_hex(blobs->objects[i].item->oid.hash), 40);
+		write_in_full(cmd.in, "\n", 1);
+	}
+	close(cmd.in);
+	cmd.in = -1;
+
+	i = read_in_full(cmd.out, buf, 40);
+	close(cmd.out);
+	cmd.out = -1;
+
+	if (finish_command(&cmd))
+		goto error;
+
+	if (i) {
+		if (get_oid_hex(buf, unreachable))
+			goto error;
+		return 0;
+	}
+
+	return 1;
+
+error:
+	if (cmd.out >= 0)
+		close(cmd.out);
+	die("problem with running rev-list");
+}
+
+static void send_blobs(const struct object_array *blobs)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	static const char *argv[] = {
+		"pack-objects", "--stdout", NULL
+	};
+	int i;
+
+	cmd.argv = argv;
+	cmd.git_cmd = 1;
+	cmd.in = -1;
+	cmd.out = 0;
+
+	if (start_command(&cmd))
+		goto error;
+	
+	for (i = 0; i < blobs->nr; i++) {
+		write_in_full(cmd.in, sha1_to_hex(blobs->objects[i].item->oid.hash), 40);
+		write_in_full(cmd.in, "\n", 1);
+	}
+	close(cmd.in);
+	cmd.in = -1;
+
+	if (finish_command(&cmd))
+		goto error;
+
+	return;
+
+error:
+	die("problem with running pack-objects");
+}
+
+static int fetch_blob(void)
+{
+	char *line;
+
+	struct object_array wanted_blobs = OBJECT_ARRAY_INIT;
+	struct object_id unreachable;
+
+	while ((line = packet_read_line(0, NULL))) {
+		const char *arg;
+		if (skip_prefix(line, "want ", &arg)) {
+			struct object_id oid;
+			struct object *obj;
+			if (get_oid_hex(arg, &oid)) {
+				packet_write_fmt(1, "ERR invalid object ID <%s>", arg);
+				return 0;
+			}
+			obj = parse_object(oid.hash);
+			if (!obj || obj->type != OBJ_BLOB) {
+				packet_write_fmt(1, "ERR not our blob <%s>", arg);
+				return 0;
+			}
+			add_object_array(obj, NULL, &wanted_blobs);
+		}
+	}
+
+	if (!are_all_reachable(&wanted_blobs, &unreachable)) {
+		packet_write_fmt(1, "ERR not our blob <%s>", oid_to_hex(&unreachable));
+		return 0;
+	}
+
+	packet_write_fmt(1, "ACK\n");
+	send_blobs(&wanted_blobs);
+
+	return 0;
+}
+
 static int server_endpoint_config(const char *var, const char *value, void *unused)
 {
 	return parse_hide_refs_config(var, value, "uploadpack");
@@ -224,5 +341,7 @@ int cmd_main(int argc, const char **argv)
 	line = packet_read_line(0, NULL);
 	if (!strcmp(line, "fetch-refs"))
 		return fetch_ref(stateless_rpc);
-	die("only fetch-refs is supported");
+	if (!strcmp(line, "fetch-blobs"))
+		return fetch_blob();
+	die("only fetch-refs and fetch-blobs are supported");
 }
diff --git a/t/t5573-server-endpoint.sh b/t/t5573-server-endpoint.sh
new file mode 100644
index 000000000..48f052851
--- /dev/null
+++ b/t/t5573-server-endpoint.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='server-endpoint'
+
+. ./test-lib.sh
+
+test_expect_success 'fetch-blobs basic' '
+	rm -rf server client &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+		test_commit 1 &&
+		git repack -a -d --write-bitmap-index
+	) &&
+	BLOB0=$(git hash-object server/0.t) &&
+	BLOB1=$(git hash-object server/1.t) &&
+	printf "000ffetch-blobs0031want %s0031want %s0000" "$BLOB0" "$BLOB1" | git server-endpoint server >out &&
+
+	test "$(head -1 out)" = "0008ACK" &&
+
+	git init client &&
+	sed 1d out | git -C client unpack-objects &&
+	git -C client cat-file -e "$BLOB0" &&
+	git -C client cat-file -e "$BLOB1"
+'
+
+test_expect_success 'fetch-blobs no such object' '
+	rm -rf server client &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+		git repack -a -d --write-bitmap-index
+	) &&
+	BLOB0=$(git hash-object server/0.t) &&
+	echo myblob >myblob &&
+	MYBLOB=$(git hash-object myblob) &&
+	printf "000ffetch-blobs0031want %s0031want %s0000" "$BLOB0" "$MYBLOB" | git server-endpoint server >out &&
+
+	test_i18ngrep "$(printf "ERR not our blob.*%s" "$MYBLOB")" out
+'
+
+test_expect_success 'fetch-blobs unreachable' '
+	rm -rf server client &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 0 &&
+		git repack -a -d --write-bitmap-index
+	) &&
+	BLOB0=$(git hash-object server/0.t) &&
+	echo myblob >myblob &&
+	MYBLOB=$(git -C server hash-object -w ../myblob) &&
+	printf "000ffetch-blobs0031want %s0031want %s0000" "$BLOB0" "$MYBLOB" | git server-endpoint server >out &&
+
+	test_i18ngrep "$(printf "ERR not our blob.*%s" "$MYBLOB")" out
+'
+
+test_done
-- 
2.12.2.715.g7642488e1d-goog

