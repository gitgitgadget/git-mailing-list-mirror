Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DCC7D63E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF7247F4
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcoMr4lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfLMSKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:10:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfLMSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:10:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so412053wrw.8
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0qk7b6g1pQds9xKSUfJ+AEExKJlN9hsr9amArUpjhf0=;
        b=ZcoMr4lQzRMtsXZFiFgUcr9ACN+oP4B3SRcbU17plMBXE2ScU4jma6nt3YVSTc+/Od
         X/F2cGazSyXavSO2S43NL2zQstWRfbBTDXbk3Iq1yqMvoSzflK2vtwhBfd9DEV1tWWKk
         bRyLHpjskonE6GkpFoeaiisRGsAdkZmDV9ymJSNIPomrzaOfpBORX/Oz9zcQlTo1LC6f
         hoKxJMoBV9di5cQLx5HBFrChFgkBcrJF/kHEf3Hz4vgFa7QLphVde7cN5ILt6CLO9I1h
         Z7xnB5TIzeH8sY7dxYOqGP5ybTimrUGtU5ROR36DU8paA6rt0zmdBDJrmTvocJXsO2gc
         shDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0qk7b6g1pQds9xKSUfJ+AEExKJlN9hsr9amArUpjhf0=;
        b=dtrTmXaBnIxuGFkGjEjX20rmfL8AF6awy7D7o7VYJwn7nZwN4yFLOkCzHnVOc5dRuO
         9vMyqNbHdWZbYv5FSzQlNNBpAmEsdnvpFM4MF6O0nuW93zWQDngqTr+qppgyavPKhGTP
         GqZLKljBwGnBq4oq6M6k+ztAV+bEGwHKdMMQH6lyfMb48H7och8kVgXHzssyYV7Cvbgu
         LY3sYgSibKvQenu03sKbOavHDeNWg7LuexV8ldoWpS2h3/jDDohuqvn4QOGLsIU6txUW
         CfM3EW9w0LynoCoZKW6Zojb3KFH1ooBmTBsFi7UWcpGBcYXq5EFQ87qs1fHIFGNszXmX
         4C6A==
X-Gm-Message-State: APjAAAVHRo3y2sOwLZuqMFrHVmFXRxCLoKFn7UHGeDpPVC6AtFlWbhJ1
        S1rqbKD4iMYUkARJnsg1D+yQiw33
X-Google-Smtp-Source: APXvYqykXgwquNM+xGpUgBBx3UM+rwEHx2x/ipQOy4CqVmPNB+mbZOnn2TT7vDTsDodoAIoubzChxw==
X-Received: by 2002:adf:93c6:: with SMTP id 64mr13478415wrp.212.1576260595722;
        Fri, 13 Dec 2019 10:09:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm11384799wrw.36.2019.12.13.10.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 10:09:55 -0800 (PST)
Message-Id: <dc97d5a0d2a39d3888b75e1154770817e16c3112.1576260593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.488.v2.git.1576260593.gitgitgadget@gmail.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <pull.488.v2.git.1576260593.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 18:09:53 +0000
Subject: [PATCH v2 1/1] sparse-checkout: respect core.ignoreCase in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a user uses the sparse-checkout feature in cone mode, they
add patterns using "git sparse-checkout set <dir1> <dir2> ..."
or by using "--stdin" to provide the directories line-by-line over
stdin. This behaviour naturally looks a lot like the way a user
would type "git add <dir1> <dir2> ..."

If core.ignoreCase is enabled, then "git add" will match the input
using a case-insensitive match. Do the same for the sparse-checkout
feature.

Perform case-insensitive checks while updating the skip-worktree
bits during unpack_trees(). This is done by changing the hash
algorithm and hashmap comparison methods to optionally use case-
insensitive methods.

When this is enabled, there is a small performance cost in the
hashing algorithm. To tease out the worst possible case, the
following was run on a repo with a deep directory structure:

	git ls-tree -d -r --name-only HEAD |
		git sparse-checkout set --stdin

The 'set' command was timed with core.ignoreCase disabled or
enabled. For the repo with a deep history, the numbers were

	core.ignoreCase=false: 62s
	core.ignoreCase=true:  74s (+19.3%)

For reproducibility, the equivalent test on the Linux kernel
repository had these numbers:

	core.ignoreCase=false: 3.1s
	core.ignoreCase=true:  3.6s (+16%)

Now, this is not an entirely fair comparison, as most users
will define their sparse cone using more shallow directories,
and the performance improvement from eb42feca97 ("unpack-trees:
hash less in cone mode" 2019-11-21) can remove most of the
hash cost. For a more realistic test, drop the "-r" from the
ls-tree command to store only the first-level directories.
In that case, the Linux kernel repository takes 0.2-0.25s in
each case, and the deep repository takes one second, plus or
minus 0.05s, in each case.

Thus, we _can_ demonstrate a cost to this change, but it is
unlikely to matter to any reasonable sparse-checkout cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  5 +++++
 builtin/sparse-checkout.c             | 10 ++++++++--
 dir.c                                 | 15 ++++++++++++---
 t/t1091-sparse-checkout-builtin.sh    | 17 +++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b975285673..9c3c66cc37 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -150,6 +150,11 @@ expecting patterns of these types. Git will warn if the patterns do not match.
 If the patterns do match the expected format, then Git will use faster hash-
 based algorithms to compute inclusion in the sparse-checkout.
 
+If `core.ignoreCase=true`, then the pattern-matching algorithm will use a
+case-insensitive check. This corrects for case mismatched filenames in the
+'git sparse-checkout set' command to reflect the expected cone in the working
+directory.
+
 SEE ALSO
 --------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a542d617a5..5d62f7a66d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -313,7 +313,10 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 	struct pattern_entry *e = xmalloc(sizeof(*e));
 	e->patternlen = path->len;
 	e->pattern = strbuf_detach(path, NULL);
-	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
+	hashmap_entry_init(&e->ent,
+			   ignore_case ?
+			   strihash(e->pattern) :
+			   strhash(e->pattern));
 
 	hashmap_add(&pl->recursive_hashmap, &e->ent);
 
@@ -329,7 +332,10 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		e = xmalloc(sizeof(struct pattern_entry));
 		e->patternlen = newlen;
 		e->pattern = xstrndup(oldpattern, newlen);
-		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
+		hashmap_entry_init(&e->ent,
+				   ignore_case ?
+				   strihash(e->pattern) :
+				   strhash(e->pattern));
 
 		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
 			hashmap_add(&pl->parent_hashmap, &e->ent);
diff --git a/dir.c b/dir.c
index 2ef92a50a0..22d08e61c2 100644
--- a/dir.c
+++ b/dir.c
@@ -625,6 +625,8 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 			 ? ee1->patternlen
 			 : ee2->patternlen;
 
+	if (ignore_case)
+		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
 	return strncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
@@ -665,7 +667,9 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		translated->pattern = truncated;
 		translated->patternlen = given->patternlen - 2;
 		hashmap_entry_init(&translated->ent,
-				   memhash(translated->pattern, translated->patternlen));
+				   ignore_case ?
+				   strihash(translated->pattern) :
+				   strhash(translated->pattern));
 
 		if (!hashmap_get_entry(&pl->recursive_hashmap,
 				       translated, ent, NULL)) {
@@ -694,7 +698,9 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	translated->pattern = xstrdup(given->pattern);
 	translated->patternlen = given->patternlen;
 	hashmap_entry_init(&translated->ent,
-			   memhash(translated->pattern, translated->patternlen));
+			   ignore_case ?
+			   strihash(translated->pattern) :
+			   strhash(translated->pattern));
 
 	hashmap_add(&pl->recursive_hashmap, &translated->ent);
 
@@ -724,7 +730,10 @@ static int hashmap_contains_path(struct hashmap *map,
 	/* Check straight mapping */
 	p.pattern = pattern->buf;
 	p.patternlen = pattern->len;
-	hashmap_entry_init(&p.ent, memhash(p.pattern, p.patternlen));
+	hashmap_entry_init(&p.ent,
+			   ignore_case ?
+			   strihash(p.pattern) :
+			   strhash(p.pattern));
 	return !!hashmap_get_entry(map, &p, ent, NULL);
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index d5e2892526..cee98a1c8a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -304,4 +304,21 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 	git -C dirty sparse-checkout disable
 '
 
+test_expect_success 'cone mode: set with core.ignoreCase=true' '
+	git -C repo sparse-checkout init --cone &&
+	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/folder1/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget
