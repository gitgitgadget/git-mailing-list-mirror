Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21786C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F247E611AC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhDPMud (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhDPMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 08:50:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD91C061760
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s7so26485858wru.6
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5fQM2i0YarPXAiGL2ateoLUfZrvDMiRyg/WkQQFZUI=;
        b=iiNEzg0gBDkWxwUilR8hw3z/kWXq6syAkRQA3ZMVJJMy6QPetXhnpaC3T/k5+hCxmB
         5oiqpXbU125KyQhH/D3rV87hdd2AqTzwQOdhzAmd311ahxxsh9bf9N87F5owQ2i35lnj
         x6U0nzewMo2UGdvu675HpqGjMIvYI5i9fd94rYzUlVb35Tdfs0tZTiaWh0FQSOVpPKBK
         HT3T8YurMZbV60skKBrxbX2KplxoRQRM8KTazOA6JZ0AtpRwZBQdyvGk0zUYaxwwSZ9h
         RDK5SGsSXcx6pQ/b+VB3PfTrtFrPal9QOqnkg0h905+VC9y2KF4Vf6oswgVIX8zPlU3z
         Rj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5fQM2i0YarPXAiGL2ateoLUfZrvDMiRyg/WkQQFZUI=;
        b=DEYxn2LBdW31RS6KbZZC86qjPd+qaFHLILMiTF+93m0as2GmYVFgEG/o9169pXP3tY
         Jf6R2HJfmFtEDA9PKJNitRGvqwPhhWD2eHZOYIpq0v5HV5xIIj4U341jUBGw0wqNUi8J
         W1vjN+Lq/iyGO176dRyGx0q+so0qv/urWY/Cs7xHYgu0kdCoDB/ZPoINAm0upZ+dh02z
         xi0UW8SCSS/n6GpGuOxOUh+KJSQouH2+rLMK0p+x6diB3JV6v8uJh1WSEeZdheKLHSeO
         T8U4X3pbM1SU6RgHEOMHQdYkTFHkemEApiktJlYWXF6Z9VmZ6HNqK4iDRu5Upu3LEeeS
         kUNQ==
X-Gm-Message-State: AOAM5319rIkdpL6xSyDQYZprFM9uWUG/7apVdLLlulCuMMbS2fwcC08j
        aX72QamPrcCEZgxj1FLDclRzenjhNaU=
X-Google-Smtp-Source: ABdhPJzhN4UftZawRWGCBsayQ5F7O/fARLUB393PJH5kpjAW7tfCd2tU+q/iIsgZE41Xly5UZJEOdA==
X-Received: by 2002:adf:cc89:: with SMTP id p9mr8659624wrj.223.1618577402121;
        Fri, 16 Apr 2021 05:50:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm9812951wrt.94.2021.04.16.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:50:01 -0700 (PDT)
Message-Id: <73b4e8496746a3d1387e568a5a898c02ec81df76.1618577399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
        <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:49:57 +0000
Subject: [PATCH v4 2/4] fetch: add --prefetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
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

There are some interesting cases that are worth testing.

An earlier version of this change dropped the "i--" from the loop that
deletes a refspec item and shifts the remaining entries down. This
allowed some refspecs to not be modified. The subtle part about the
first --prefetch test is that the "refs/tags/*" refspec appears directly
before the "refs/heads/bogus/*" refspec. Without that "i--", this
ordering would remove the "refs/tags/*" refspec and leave the last one
unmodified, placing the result in "refs/heads/*".

It is possible to have an empty refspec. This is typically the case for
remotes other than the origin, where users want to fetch a specific tag
or branch. To correctly test this case, we need to further remove the
upstream remote for the local branch. Thus, we are testing a refspec
that will be deleted, leaving nothing to fetch.

Helped-by: Tom Saeger <tom.saeger@oracle.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/fetch-options.txt   |  5 +++
 builtin/fetch.c                   | 59 ++++++++++++++++++++++++++++++-
 t/t5582-fetch-negative-refspec.sh | 43 ++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)

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
index 0b90de87c7a2..97c4fe6e6d66 100644
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
@@ -436,6 +439,56 @@ static void find_non_local_tags(const struct ref *refs,
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
+			i--;
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
@@ -452,6 +505,10 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	filter_prefetch_refspec(rs);
+	if (remote)
+		filter_prefetch_refspec(&remote->fetch);
+
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
 
@@ -520,7 +577,7 @@ static struct ref *get_ref_map(struct remote *remote,
 			if (has_merge &&
 			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
-		} else {
+		} else if (!prefetch) {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
 				die(_("Couldn't find remote ref HEAD"));
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index f34509727702..e5d2e79ad382 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -240,4 +240,47 @@ test_expect_success "push with matching +: and negative refspec" '
 	git -C two push -v one
 '
 
+test_expect_success '--prefetch correctly modifies refspecs' '
+	git -C one config --unset-all remote.origin.fetch &&
+	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
+	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
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
+test_expect_success '--prefetch succeeds when refspec becomes empty' '
+	git checkout bogus/fetched &&
+	test_commit extra &&
+
+	git -C one config --unset-all remote.origin.fetch &&
+	git -C one config --unset branch.main.remote &&
+	git -C one config remote.origin.fetch "+refs/tags/extra" &&
+	git -C one config remote.origin.skipfetchall true &&
+	git -C one config remote.origin.tagopt "--no-tags" &&
+
+	git -C one fetch --prefetch
+'
+
 test_done
-- 
gitgitgadget

