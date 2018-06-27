Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D266E1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965440AbeF0NZe (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:34 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44175 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965430AbeF0NZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:32 -0400
Received: by mail-qk0-f193.google.com with SMTP id i188-v6so985939qkc.11
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv9rMa1GFxvJf0pEWP5QSgWbPTCzbmmH2K76LcDsF0w=;
        b=m5n3RsHgWLkWnpW3YwbWtNfeEpyrbNQN5W8/BIdOUeeyr7xfpIoEj+VGbIfTm76Ne3
         1ZAj8VARlf43ZI/3SQeD7y4BLlWSVcM3iguUTRXy5DLP4Efz3oNX28kuJIeLHgnsLace
         37Uf61yfcpfAaBKQsxdlKvt5THa7xin+niFpjq3FiE+xxbxTCga2K0RYLEnJoWuO+TM8
         3MHHmcT3mecNzeESi2sxHyYDd9CRtoUpknFRtPaOlzeq6KiDkgz5PpPcJoaT3RHGgLGg
         8ecV8ipPXbmtVZIMTH4Dsj1u/3DCXLJ6yiw2RrqGLyqThjSzlun4EZjfU/JVNB7eD/Cw
         W4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv9rMa1GFxvJf0pEWP5QSgWbPTCzbmmH2K76LcDsF0w=;
        b=PUPiVLFXBxb2IBwFYutHH0XB7PxDQpVU35OnQhtw9bZTlU5eYSieH4GB3swjfaDfEW
         QWIJT7Q5FbrZeLcrQqA5xdykvSlAbdV0861PKFczXwtYuB0xDa/kohwiIHGoc7MWlIWk
         3ue3HberKGnwxSqVkIcLcKoC9V1vmbr72eWVixtrAQuMHEJ9u5EOQxjkduAbqKGdR5kn
         U8bANID54USmWMW3avtfk1J39ttR/yzftb3DobsRAvyLbFJ0OeDLj3j4ZH+IPBa1H0Xt
         RwyI6VSkZM5p4c5AU1/1KyEzCbW8IOFza8vtrxywzRZrLnOYGqKGRJS2Kbc/pq+cXTCk
         kzYQ==
X-Gm-Message-State: APt69E0lrD0pzdX8Qk79aqXX2IZ+Eg4TrX20I0vxRHeLpJrTQkdjlT8F
        DH6rtJIQOTaSALzD2D7U6uARmqXKefI=
X-Google-Smtp-Source: AAOMgpeFTfNK6kaJh3eNIAaMlh5DdcE4oNoLPL/ZLxwavFf6+4+7apvpmENY2n/8C/rla1yoB4BeXQ==
X-Received: by 2002:a37:de02:: with SMTP id h2-v6mr5039275qkj.420.1530105931185;
        Wed, 27 Jun 2018 06:25:31 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:30 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 18/22] fsck: verify commit-graph
Date:   Wed, 27 Jun 2018 09:24:43 -0400
Message-Id: <20180627132447.142473-19-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If core.commitGraph is true, verify the contents of the commit-graph
during 'git fsck' using the 'git commit-graph verify' subcommand. Run
this check on all alternates, as well.

We use a new process for two reasons:

1. The subcommand decouples the details of loading and verifying a
   commit-graph file from the other fsck details.

2. The commit-graph verification requires the commits to be loaded
   in a specific order to guarantee we parse from the commit-graph
   file for some objects and from the object database for others.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-fsck.txt |  3 +++
 builtin/fsck.c             | 21 +++++++++++++++++++++
 t/t5318-commit-graph.sh    |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b9f060e3b2..ab9a93fb9b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -110,6 +110,9 @@ Any corrupt objects you will have to find in backups or other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
 
+If core.commitGraph is true, the commit-graph file will also be inspected
+using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
+
 Extracted Diagnostics
 ---------------------
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3ad4f160f9..9fb2edc69f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -18,6 +18,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "run-command.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -47,6 +48,7 @@ static int name_objects;
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
 #define ERROR_REFS 010
+#define ERROR_COMMIT_GRAPH 020
 
 static const char *describe_object(struct object *obj)
 {
@@ -822,5 +824,24 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	check_connectivity();
+
+	if (core_commit_graph) {
+		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
+		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
+		commit_graph_verify.argv = verify_argv;
+		commit_graph_verify.git_cmd = 1;
+
+		if (run_command(&commit_graph_verify))
+			errors_found |= ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb(the_repository);
+		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+			verify_argv[2] = "--object-dir";
+			verify_argv[3] = alt->path;
+			if (run_command(&commit_graph_verify))
+				errors_found |= ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fed05e2f12..a9e8c774d5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -399,4 +399,12 @@ test_expect_success 'detect invalid checksum hash' '
 		"incorrect checksum"
 '
 
+test_expect_success 'git fsck (checks commit-graph)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	test_must_fail git fsck
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

