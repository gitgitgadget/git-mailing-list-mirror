Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330719BCB
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns3Mabu8"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43913E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso7383955e9.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933137; x=1699537937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncAd+2ucxHGdsaMheafElVVM6cv8o6UtKktsMaTiu/U=;
        b=Ns3Mabu8bepcP0rlwL74s6kK3oMOGkJx6mJy1nwISIkvdSK/shSBlV1Tu+LtdsnMBX
         k7KjEaXdPw/e3y7fwpIPgdzkT+agJwz/eNbIUe1WxGPlYqIgqu/ne8TCUwQgGdTdCag1
         uTKMd7InWvnyPbwzU8CDZW00X7iMwdgTuNdCSyxhga2N+trX9enJhq1weQ1g69ljUhuG
         61RI7THVk6Fpa87fMdZaPW0TQhlE8rO24Y+2isHZAOamAW8jxHEPmIQGj7oe+WnnLGF5
         1XsWuFHJRLNj0c9l+9T97G/NSmShHcEfRlNPwlmU3qL8JEyrc/csYy58c/UPg8m+d/0R
         17qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933137; x=1699537937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncAd+2ucxHGdsaMheafElVVM6cv8o6UtKktsMaTiu/U=;
        b=XrKcjatNFWt9xDpFtnNgugebrgV9YJxgA8nQY5V1EaniXE9VdDHB0PfPUP0/uUAMB1
         Y4Ga93AXjTfurkb2+T/oDkwj1xNSPaAO+b0kvMMYmSgFRLwnruSOFHsg8NIgCXzCvn7X
         IJZi+14c2fABirmkJxnYcgce0ZnNyntCqBoG8JtxY2wdWpVnvfX7r6yBARqc8RylXnw+
         4yGFAJEnxJhgMdPvlpOgAwyz5/K08rX6HKld288hiNfTMai40jmg7+vX8q5ADUgGRMc0
         WiMgx0La4hb/vD4bZjkEiXi3Yh3G2t4IG2ezbHG/3zqQvs7VaV5Q6WlDbZTzY5PR6L6j
         K9og==
X-Gm-Message-State: AOJu0Yyx8yMCcnyplR3BUPRZXOIPBQJLub8l1jbb0XrJNbppzhJJc/bH
	z4Vu3Py2W3n+QMXFP8hqOTSVHLc924w=
X-Google-Smtp-Source: AGHT+IFXfP1CsYtEwTsspknG3po5qfarkaSmxO/6Kol83TT2VPsLS+TMRiIdhEx+Vn0mYfXGBHUgqA==
X-Received: by 2002:a05:600c:a0a:b0:409:5580:bc9f with SMTP id z10-20020a05600c0a0a00b004095580bc9fmr6347508wmp.34.1698933137429;
        Thu, 02 Nov 2023 06:52:17 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:16 -0700 (PDT)
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
Subject: [PATCH v6 05/14] replay: introduce pick_regular_commit()
Date: Thu,  2 Nov 2023 14:51:42 +0100
Message-ID: <20231102135151.843758-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's refactor the code to handle a regular commit (a commit that is
neither a root commit nor a merge commit) into a single function instead
of keeping it inside cmd_replay().

This is good for separation of concerns, and this will help further work
in the future to replay merge commits.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 54 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 32dbaaf028..5c4cbd11db 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -89,6 +89,35 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+static struct commit *pick_regular_commit(struct commit *pickme,
+					  struct commit *last_commit,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result)
+{
+	struct commit *base;
+	struct tree *pickme_tree, *base_tree;
+
+	base = pickme->parents->item;
+
+	pickme_tree = repo_get_commit_tree(the_repository, pickme);
+	base_tree = repo_get_commit_tree(the_repository, base);
+
+	merge_opt->branch2 = short_commit_name(pickme);
+	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+	merge_incore_nonrecursive(merge_opt,
+				  base_tree,
+				  result->tree,
+				  pickme_tree,
+				  result);
+
+	free((char*)merge_opt->ancestor);
+	merge_opt->ancestor = NULL;
+	if (!result->clean)
+		return NULL;
+	return create_commit(result->tree, pickme, last_commit);
+}
+
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
@@ -100,7 +129,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
-	struct tree *next_tree, *base_tree, *head_tree;
+	struct tree *head_tree;
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
@@ -175,7 +204,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
-		struct commit *base;
+		struct commit *pick;
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
@@ -185,26 +214,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		base = commit->parents->item;
-
-		next_tree = repo_get_commit_tree(the_repository, commit);
-		base_tree = repo_get_commit_tree(the_repository, base);
-
-		merge_opt.branch2 = short_commit_name(commit);
-		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
-
-		merge_incore_nonrecursive(&merge_opt,
-					  base_tree,
-					  result.tree,
-					  next_tree,
-					  &result);
-
-		free((char*)merge_opt.ancestor);
-		merge_opt.ancestor = NULL;
-		if (!result.clean)
+		pick = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		if (!pick)
 			break;
+		last_commit = pick;
 		last_picked_commit = commit;
-		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
 	merge_finalize(&merge_opt, &result);
-- 
2.42.0.496.g529a7fda40

