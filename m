Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7150AC433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399592078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NysOoFCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgFWWrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbgFWWra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BA1C061249
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so392294wmo.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JsFwrwBeovrN2oreGP6xI879NLRY2J7OhkBwtD9k7sA=;
        b=NysOoFCLu1fkzuBIkjMELUMul7lySWFvLfjeyOCFyEI/3+80bu+8oinWIsw+6tblj3
         jw3qHipqxATaF9gZTn2WFgYyt9gsODmMl6M4rdMKySMwM64z0hI8I0WSEzsUHZHiWN6W
         c6aHI/h5LHtNihe1mW0dwRnjfd1yJOCW549CkImnG/SrtqZlgonO1JN3/bV3hUoroUa4
         3wv17IdqRVjugDiSyPdtrsrFDyNkxBhrgncL0py4X1V6wl1GNDBJvnY4/OMYdUog388b
         0EdFB/kEcWk5lMhK7DfxzEvb6lvZ5vtregt7BDXT0tCjLPfnJ82BTvFCqoKdUL07lt12
         Ab0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JsFwrwBeovrN2oreGP6xI879NLRY2J7OhkBwtD9k7sA=;
        b=EKx2kMfonOUDOwuU9lU2ECSNbIaYh7Of+aryIUi5X75fIhbwOT3bpzudG2C4w7dP8c
         rh8+PXSTuPnWMOG0MR7FJNxDAt8avHnGv1kFbz+RF9jI+aBFF7U1L5aax+lT3sObUKRT
         f2Cn8qGT5nR9ikcNKybh55oa3kIgxsti4I9mfeultjJy6N/2whs6jTMURq1Qtc/mwX3T
         OmuDzCD6TnV88cQbIAMhJK4gGAuUnMhp8spfTRvb1H5Al4SnUNK/E0kBGpLLqo8rLW8+
         sF48QuwUL5qSSHBZqmUU/JtZNr6p88J2IorVQZtxRTQzsurI7ztzqxTI/b/t4XWgg/cw
         sElQ==
X-Gm-Message-State: AOAM532rJ7AGQU3wvYyRHpVX/qudNDH13+eESU8WDa69Qkj47jB/0YSU
        I6KcJ7uE3Cckb7XJINmVceF29YRD
X-Google-Smtp-Source: ABdhPJz+oouXkBs3Ykm8pc4K3rRXYHQvVIVav4SbeyNESphILhOoUSnUEGsk/x9W/XzZa+GvYqkEKg==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr27018634wma.33.1592951620261;
        Tue, 23 Jun 2020 15:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j24sm22619909wrd.43.2020.06.23.15.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:39 -0700 (PDT)
Message-Id: <00a1b281e5ae4cf14435a6745cc55fc248f378a5.1592951611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:29 +0000
Subject: [PATCH v3 7/8] remote: use the configured default branch name when
 appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When guessing the default branch name of a remote, and there are no refs
to guess from, we want to go with the preference specified by the user
for the fall-back, i.e. the default name to be used for the initial
branch of new repositories (because as far as the user is concerned, a
remote that has no branches yet is a new repository).

At the same time, when talking to an older Git server that does not
report a symref for `HEAD` (but instead reports a commit hash), let's
try to guess the configured default branch name first. If it does not
match the reported commit hash, let's fall back to `master` as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c                 | 14 +++++++++++---
 t/t5606-clone-options.sh | 11 ++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 534c6426f1..965129adc3 100644
--- a/remote.c
+++ b/remote.c
@@ -276,7 +276,7 @@ static void read_branches_file(struct remote *remote)
 
 	/*
 	 * The branches file would have URL and optionally
-	 * #branch specified.  The "master" (or specified) branch is
+	 * #branch specified.  The main (or specified) branch is
 	 * fetched and stored in the local branch matching the
 	 * remote name.
 	 */
@@ -284,7 +284,7 @@ static void read_branches_file(struct remote *remote)
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = "master";
+		frag = (char *)git_default_branch_name();
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
 	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
@@ -2097,8 +2097,16 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (head->symref)
 		return copy_ref(find_ref_by_name(refs, head->symref));
 
-	/* If refs/heads/master could be right, it is. */
+	/* If a remote branch exists with the default branch name, let's use it. */
 	if (!all) {
+		char *ref = xstrfmt("refs/heads/%s", git_default_branch_name());
+
+		r = find_ref_by_name(refs, ref);
+		free(ref);
+		if (r && oideq(&r->old_oid, &head->old_oid))
+			return copy_ref(r);
+
+		/* Fall back to the hard-coded historical default */
 		r = find_ref_by_name(refs, "refs/heads/master");
 		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 286bfd93ac..e69427f881 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -47,7 +47,16 @@ test_expect_success 'guesses initial branch name correctly' '
 	test_commit -C initial-branch no-spoilers &&
 	git -C initial-branch branch abc guess &&
 	git clone initial-branch is-it &&
-	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
+	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD) &&
+
+	git -c init.defaultBranch=none init --bare no-head &&
+	git -C initial-branch push ../no-head guess abc &&
+	git clone no-head is-it2 &&
+	test_must_fail git -C is-it2 symbolic-ref refs/remotes/origin/HEAD &&
+	git -C no-head update-ref --no-deref HEAD refs/heads/guess &&
+	git -c init.defaultBranch=guess clone no-head is-it3 &&
+	test refs/remotes/origin/guess = \
+		$(git -C is-it3 symbolic-ref refs/remotes/origin/HEAD)
 '
 
 test_done
-- 
gitgitgadget

