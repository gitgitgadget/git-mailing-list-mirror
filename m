Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80017983
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QexKe8eV"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046818D
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso53567015e9.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058828; x=1700663628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gucjjutSMVzlO70K3OzRYYC9EXAij3BX9+NVIUVS8yc=;
        b=QexKe8eVIg4wHAfG2W6zH8kT3NtlOjf8zEh4guHUMhk+wIuSfOx3c5yHXzUqqLQA8M
         wcsaw2MDuweHFNegK+FyqleLRizEJD3raCEfW72iLQWB0PL5o43GnRdJVR7Qa9+MEy0M
         XeFKn6kfDuDhtS0KYvMFACQnEy/pFDMdsvaTbC/UOilphceWTgzG7zTc1gnjhsNqLxev
         4bEgrw6IjhEUw6joWpJYBoEsH26uh9FqGrBOieFkCCaRCu798f73y6o8GZNZf4mVnThm
         up1PI/RYD7asnLZfLqEyRQ/LC8pKNNI8KpIignvNRRsrNL8Rz5wTlt7e9dZQJSumjjqY
         smCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058828; x=1700663628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gucjjutSMVzlO70K3OzRYYC9EXAij3BX9+NVIUVS8yc=;
        b=WD0SsFo/84v1+wpsWVkAF7GkRM3hRrhD69VVw+EsBgYZvhPdQvXj8o+HpHrDacREsT
         xpC/P0R/uLev0H5O1YGrI2UvVlyu1+gQ1oJP/pUMuY2YrRHgAJF3EHrj9dlOtuv+khxf
         QSL0rpfyz+iotsoZmfvEn1c1oIGzck2GhKju/+/bspV5gZXOU0dQCgL1CVp++9nGEbH/
         DefJ+l+gsTiEZIuedBBDIjbQVFa0OnuS95PVmzEa0YyXdWRt5Mq+AFgs6624+nIcmXSw
         0PdgJOoWMIAb5jsmPJ0fuAdgjn4xYmfQwt6bdUrtVpg00tuin39cauoQxfAndBmuWlze
         puZQ==
X-Gm-Message-State: AOJu0YyoyBFPfp6TmmhjcD1GT3DOhkGPKRVzsX6svgem4fEk9ide/GZI
	rdP9ZJq8iIf7KQsNO6Sd8wXJnbGaHyo=
X-Google-Smtp-Source: AGHT+IFgBkglXuD1rE18SrX51JHc0IC//2o1AZxufRN5ip05Pq75qCngMbMWP3/fRy9ImNqZDaWBDA==
X-Received: by 2002:a05:600c:35d2:b0:408:55f8:7de with SMTP id r18-20020a05600c35d200b0040855f807demr9115662wmq.28.1700058828053;
        Wed, 15 Nov 2023 06:33:48 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:47 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 03/14] replay: start using parse_options API
Date: Wed, 15 Nov 2023 15:33:16 +0100
Message-ID: <20231115143327.2441397-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Instead of manually parsing arguments, let's start using the parse_options
API. This way this new builtin will look more standard, and in some
upcoming commits will more easily be able to handle more command line
options.

Note that we plan to later use standard revision ranges instead of
hardcoded "<oldbase> <branch>" arguments. When we will use standard
revision ranges, it will be easier to check if there are no spurious
arguments if we keep ARGV[0], so let's call parse_options() with
PARSE_OPT_KEEP_ARGV0 even if we don't need ARGV[0] right now to avoid
some useless code churn.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index f2d8444417..afabb844d3 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -15,7 +15,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "read-cache-ll.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
@@ -92,6 +92,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -105,16 +106,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h")) {
-		printf("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL\n");
-		exit(129);
+	const char * const replay_usage[] = {
+		N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
+		NULL
+	};
+	struct option replay_options[] = {
+		OPT_STRING(0, "onto", &onto_name,
+			   N_("revision"),
+			   N_("replay onto given commit")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	if (!onto_name) {
+		error(_("option --onto is mandatory"));
+		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (argc != 5 || strcmp(argv[1], "--onto"))
-		die("usage: read the code, figure out how to use it, then do so");
+	if (argc != 3) {
+		error(_("bad number of arguments"));
+		usage_with_options(replay_usage, replay_options);
+	}
 
-	onto = peel_committish(argv[2]);
-	strbuf_addf(&branch_name, "refs/heads/%s", argv[4]);
+	onto = peel_committish(onto_name);
+	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
 	/* Sanity check */
 	if (repo_get_oid(the_repository, "HEAD", &head))
@@ -126,6 +143,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -134,7 +152,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -197,8 +216,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &last_picked_commit->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
@@ -210,8 +229,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &head,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 	}
 	ret = (result.clean == 0);
-- 
2.43.0.rc1.15.g29556bcc86

