Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A7C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECA861029
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJCEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 22:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCEK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 22:04:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5BC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 19:03:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p6so588428wrn.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4wGUux8KYG7o0rKSd3ApIAUDbMevYzDylGxVWjE8Ips=;
        b=JLVhPrkoLE65GlIvEgbSlBnIP1EPJStLuSpOH8mkrJammVa1rYXXGnxJb7ngmWZ4cN
         mfLWt+hKTDT8GmtCUDLRH+sgAdJvmY3ks2XP5bFfqkPSf0qT73QdmN4YNgupiTEAFZnU
         obsUypUQgQEBxRxo6So8t5OR8ZUiLv8n64J4rl2d96fYlCh53i5Wx7Rpn7iGs7KcHAiM
         /cyz3V7pQMz8uQ1xs4AqTjt3CZe9d72M6bUPJdYcJmFAY6EqGw3DBOqICOWJjzmh2pD+
         AvlI+cxCmhtaClKRCjjoHUAaymJi9JFTE9d8mU+V2Yy5Mq90JLbWn47xv0khyhdMRlDn
         Z4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4wGUux8KYG7o0rKSd3ApIAUDbMevYzDylGxVWjE8Ips=;
        b=GQbKmQaTW9daZxhWFfDjkde1bYMyXKH2zPcyAkQneKSZCf0BRbCjXFEKRiaH7FIqSi
         ncCSsA60UQidVb0iwKQLaamIFRDyoBsTkx9M62OSG7eXoobaDTMYYpSM+rjnqsLCi+bq
         GB6TUvjU4maKJWxkYNZRUo7M8CJakKIBEEk19wuZQhupzVB4pRWGAHU6kKzo8vO1Qpnv
         DccKiu4H/zvpI9cIPhJIeIrvNuhRgWyqW/e83L/zQdoLkXUAgOzMrVLGw66j9cWhnXMP
         ONdUlzkFqLvJu8cxFr+ecYmp0Fw0Ly7TTyXoDbV8xU/jG3W6YI1XZsEhzorHt526v8Pm
         eP9g==
X-Gm-Message-State: AOAM533EZKeRjLvw13cuMV33jzgL4EjwJvNXmxY+otYUBWSfZsL8gomH
        bMQ9H3fT6LdmITLE7HCG/YCC4flHy/4=
X-Google-Smtp-Source: ABdhPJya+QanWW1plxnKnA71gNoZAJSpDIZWH2CZ8n/VtURitEK1dG8F+l5n60rqJSnW5+ti0uMtiQ==
X-Received: by 2002:adf:e108:: with SMTP id t8mr19714739wrz.371.1618020228224;
        Fri, 09 Apr 2021 19:03:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm6916792wrl.47.2021.04.09.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:03:47 -0700 (PDT)
Message-Id: <7f488eea6dbdd93ff1a97a2572de7ddb0d65b7e0.1618020225.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
        <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 02:03:44 +0000
Subject: [PATCH v3 2/3] fetch: add --prefetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --prefetch option will be used by the 'prefetch' maintenance task
instead of sending refspecs explicitly across the command-line. The
intention is to modify the refspec to place all results in
refs/prefetch/ instead of anywhere else.

Create helper method filter_prefetch_refspec() to modify a given refspec
to fit the rules expected of the prefetch task:

 * Negative refspecs are preserved.
 * Refspecs without a destination are removed.
 * Refspecs whose source starts with "refs/tags/" are removed.
 * Other refspecs are placed within "refs/prefetch/".

Finally, we add the 'force' option to ensure that prefetch refs are
replaced as necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/fetch-options.txt   |  5 +++
 builtin/fetch.c                   | 56 +++++++++++++++++++++++++++++++
 t/t5582-fetch-negative-refspec.sh | 30 +++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 07783deee309..9e7b4e189ce0 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -110,6 +110,11 @@ ifndef::git-pull[]
 	setting `fetch.writeCommitGraph`.
 endif::git-pull[]
 
+--prefetch::
+	Modify the configured refspec to place all refs into the
+	`refs/prefetch/` namespace. See the `prefetch` task in
+	linkgit:git-maintenance[1].
+
 -p::
 --prune::
 	Before fetching, remove any remote-tracking references that no
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0b90de87c7a2..30856b442b79 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,6 +48,7 @@ enum {
 static int fetch_prune_config = -1; /* unspecified */
 static int fetch_show_forced_updates = 1;
 static uint64_t forced_updates_ms = 0;
+static int prefetch = 0;
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
@@ -158,6 +159,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules fetched in parallel")),
+	OPT_BOOL(0, "prefetch", &prefetch,
+		 N_("modify the refspec to place all refs within refs/prefetch/")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
@@ -436,6 +439,55 @@ static void find_non_local_tags(const struct ref *refs,
 	oidset_clear(&fetch_oids);
 }
 
+static void filter_prefetch_refspec(struct refspec *rs)
+{
+	int i;
+
+	if (!prefetch)
+		return;
+
+	for (i = 0; i < rs->nr; i++) {
+		struct strbuf new_dst = STRBUF_INIT;
+		char *old_dst;
+		const char *sub = NULL;
+
+		if (rs->items[i].negative)
+			continue;
+		if (!rs->items[i].dst ||
+		    (rs->items[i].src &&
+		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
+			int j;
+
+			free(rs->items[i].src);
+			free(rs->items[i].dst);
+
+			for (j = i + 1; j < rs->nr; j++) {
+				rs->items[j - 1] = rs->items[j];
+				rs->raw[j - 1] = rs->raw[j];
+			}
+			rs->nr--;
+			continue;
+		}
+
+		old_dst = rs->items[i].dst;
+		strbuf_addstr(&new_dst, "refs/prefetch/");
+
+		/*
+		 * If old_dst starts with "refs/", then place
+		 * sub after that prefix. Otherwise, start at
+		 * the beginning of the string.
+		 */
+		if (!skip_prefix(old_dst, "refs/", &sub))
+			sub = old_dst;
+		strbuf_addstr(&new_dst, sub);
+
+		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
+		rs->items[i].force = 1;
+
+		free(old_dst);
+	}
+}
+
 static struct ref *get_ref_map(struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *rs,
@@ -452,6 +504,10 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	filter_prefetch_refspec(rs);
+	if (remote)
+		filter_prefetch_refspec(&remote->fetch);
+
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index f34509727702..030e6f978c4e 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -240,4 +240,34 @@ test_expect_success "push with matching +: and negative refspec" '
 	git -C two push -v one
 '
 
+test_expect_success '--prefetch correctly modifies refspecs' '
+	git -C one config --unset-all remote.origin.fetch &&
+	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
+	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
+	git -C one config --add remote.origin.fetch "refs/heads/bogus/*:bogus/*" &&
+
+	git tag -a -m never never-fetch-tag HEAD &&
+
+	git branch bogus/fetched HEAD~1 &&
+	git branch bogus/ignore HEAD &&
+
+	git -C one fetch --prefetch --no-tags &&
+	test_must_fail git -C one rev-parse never-fetch-tag &&
+	git -C one rev-parse refs/prefetch/bogus/fetched &&
+	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore &&
+
+	# correctly handle when refspec set becomes empty
+	# after removing the refs/tags/* refspec.
+	git -C one config --unset-all remote.origin.fetch &&
+	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
+
+	git -C one fetch --prefetch --no-tags &&
+	test_must_fail git -C one rev-parse never-fetch-tag &&
+
+	# The refspec for refs that are not fully qualified
+	# are filtered multiple times.
+	git -C one rev-parse refs/prefetch/bogus/fetched &&
+	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore
+'
+
 test_done
-- 
gitgitgadget

