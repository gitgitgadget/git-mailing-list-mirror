Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03ED20193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965323AbcHDTwS (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:18 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33562 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965313AbcHDTwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:16 -0400
Received: by mail-pa0-f52.google.com with SMTP id ti13so7155768pac.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2FgwqUuhwr1t/yITPafLQf87moJ8Gf6uh3awVdOKj4=;
        b=PW5li9U1GjYZM13odRUftfpH1irP3PrRv79w3dC6rpg7eycjZ8qctc33teRHkJZGGT
         VxX0bBfeqZVGC/YA97lELJ/XpqZHvy+kJrpvtICe+hs5G/ixG1tM1/sZY0VlEY3dUVkt
         LkaNI/uEzpmG/xQMhzN7JFIyGOnjrRHmHXa4WABBDVAVXzmqCTOkOcMh82LtGdc4/zge
         jesJ7qziQTzL2ZEGXothp9uoYpS6luPVOoRvYlUv8Hw/6TNS4mDXdCZl4fHOKI7cJ8YL
         CFJCJzWrZhA19L9USNZWV2F2kYJ94Ecbqqah1zd4vOidrNRPis+/fOG7XVqfWHbZ09AQ
         4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2FgwqUuhwr1t/yITPafLQf87moJ8Gf6uh3awVdOKj4=;
        b=h5XgE4kzQqbZYrOtofV01u8Y0nU3Po3CFpHpLfd1NOGqsY28io4pmKbiNTLYQmN2l3
         zxQUzV+bYQMy0F7eTSYRNEKzvs+rqnJ7BFF8n9ixjesEoARQdQ0erES7k/5Np9VqT4qb
         +pYF14vGUxtqsUrpIyC4hU5n+eNXkfOWkL/W1hG0mEkuUI6RLmp5USthJDcZjWk7ucFZ
         zwkgFdMjAM/e7Vb5o/w+QlnIt8Jbkqu37MbayXhUdgRO7rMWUFciupKOT9Az5ACTk2rW
         408QaTWbPR7TKkMA8YmAkOx/8xlZjZrs8iSADw4/ck/Lw1LH1bl8oLFRQ7b5UUUIRqPV
         S3Ng==
X-Gm-Message-State: AEkoouv7gRc8FoTVDGv5YVyxhL0cgRCFPytJaRukX7Gx9jvJB+arewk7liqx9m/FgqNTJmz9
X-Received: by 10.66.249.201 with SMTP id yw9mr113050477pac.130.1470340335441;
        Thu, 04 Aug 2016 12:52:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id wp4sm22357923pab.15.2016.08.04.12.52.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:14 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] submodule update: add super-reference flag
Date:	Thu,  4 Aug 2016 12:51:58 -0700
Message-Id: <20160804195159.7788-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 14 +++++++++++++-
 git-submodule.sh            | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6f297b..707f201 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -584,6 +584,7 @@ struct submodule_update_clone {
 	int quiet;
 	int recommend_shallow;
 	struct string_list references;
+	struct string_list superreferences;
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
@@ -600,7 +601,7 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
-	NULL, NULL, NULL, \
+	STRING_LIST_INIT_DUP, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
@@ -715,6 +716,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		for_each_string_list_item(item, &suc->references)
 			argv_array_pushl(&child->args, "--reference", item->string, NULL);
 	}
+	if (suc->superreferences.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &suc->superreferences) {
+			strbuf_reset(&sb);
+			argv_array_pushf(&child->args, "--reference=%s/%s",
+					 relative_path(item->string, suc->prefix, &sb),
+					 sub->path);
+		}
+	}
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
@@ -835,6 +845,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
+		OPT_STRING_LIST(0, "super-reference", &suc.superreferences, N_("repo"),
+			   N_("superproject of a reference repository")),
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
diff --git a/git-submodule.sh b/git-submodule.sh
index 526ea5d..99d45c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,6 +34,7 @@ command=
 branch=
 force=
 reference=
+superreference=
 cached=
 recursive=
 init=
@@ -520,6 +521,14 @@ cmd_update()
 		--reference=*)
 			reference="$1"
 			;;
+		--super-reference)
+			case "$2" in '') usage ;; esac
+			superreference="--super-reference=$2"
+			shift
+			;;
+		--super-reference=*)
+			superreference="$1"
+			;;
 		-m|--merge)
 			update="merge"
 			;;
@@ -576,6 +585,7 @@ cmd_update()
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
+		${superreference:+"$superreference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-- 
2.9.2.572.g9d9644e.dirty

