Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AA2EAE1
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqqEyDpS"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408C18E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso51181375e9.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058832; x=1700663632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkCo+BViWWdWCywWrH14NiTrFEqnHkxrdCRhzBg115M=;
        b=cqqEyDpShequ8Im/RvTPQOp9hwe5bAANODzFpV11ZDfOKrCsFVZVImVGuDBROpGwyH
         uHNyf53/an7JoPI1K0RZRFXt0noiA9a1eYABX3plj6/8/OEUyd5BISZwAeuaqhCZQjoH
         UaN5GHz3VewQ1ajenC/tPsO7XJIUV/WpCmiLRFPnE8LjQyJ6s8QqHsegTXqW3g+eAkdI
         TUtRIWMrfq6kGWiGqi6fDnNl63DOLpRorYgK0cLS+WbSddhtg9TjsHAD0/oYUY2CDG/3
         qvVfeZ/slkpsdoRFLPxFyRI3Q6Pfhsuno5qqi5nYAkW6TwrUX+xD5P6Rw3mnUbHdVZE1
         DmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058832; x=1700663632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkCo+BViWWdWCywWrH14NiTrFEqnHkxrdCRhzBg115M=;
        b=XCc/8J31p1SzNtJ6uuzbKFfE3AXuoPkhEsvfHpIQZ1pQd955MUg1RbJ7Dc2WpcZr4S
         AyOJ5QmsMSylkVXd5mebj77p3Mh6z44dVM0WILz4LlRX+NySyf+GmbXIffZZihSLv1Jv
         98+DH0+kUb8DPx/3I/VEW+Mg4vyf1xOeEB5aEDZ3s+fmslLIkBk+rd4MInkNnWqR/VFm
         9uByVHwzFtlHbyD6zjltVw9tnjPjnSGjQ+v0PfjYkLvw3XBfW1/dpcFSReh+qZlfAjle
         cPFssaVJLhcevd0DtlpNYdoNlh6iJkdBo4sVYOYB6P0rbFBqcyFR2dWoUBr73nBUsbSV
         iSIg==
X-Gm-Message-State: AOJu0YwcUKjXnOTZdryudpm6sRTdrIn+nUbzJk97XAnzquyLiflUeV8O
	C/9RHwkkWTc0NtC701/UdiaHB7AJJJo=
X-Google-Smtp-Source: AGHT+IG5yEv61pJBdhAAwD7nq74RnwSpnaFXqCkhYRMa+EUX91uEdrjfrW4jgJbabTnyjVWrLNLfxg==
X-Received: by 2002:a05:600c:1914:b0:405:3885:490a with SMTP id j20-20020a05600c191400b004053885490amr11056122wmq.0.1700058832177;
        Wed, 15 Nov 2023 06:33:52 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:50 -0800 (PST)
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
Subject: [PATCH v7 05/14] replay: introduce pick_regular_commit()
Date: Wed, 15 Nov 2023 15:33:18 +0100
Message-ID: <20231115143327.2441397-6-christian.couder@gmail.com>
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
2.43.0.rc1.15.g29556bcc86

