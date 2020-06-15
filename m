Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6CC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5EA206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frNwZWtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgFOMuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgFOMu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4604FC08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b82so5991663wmb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S0CMFVB1e1YXOFVZJe4be2qV6eCJOxF5msCtstwq5gE=;
        b=frNwZWtvQpxYprNefa0xToU2r8WetCCthuU/OlWQxYhSx+Zw3YRV9mIC3x1xQ5UKzX
         e+71iDRPW5D/sd5PxSZmdWp6PMARKum3CzLQF3tS+AuzvozLLbaqj5DT/q+bsJiQ0m+I
         kPQIRL7V5RwvdMaIOr7yhH1jDaUNy8ijfyo0wGu4s92RgN48YL9jl0pcGYJ8FQr1MW7q
         GVTMdj7TdoBuUUVuwOwx4HKMCxg34Jd1LNOB78wojb6Dppee2gC7G5WlWOPkpK+1tOgn
         FwxCDCNLAA5mP6+D3OH6JoNEtGeEXE3+Ljnk0vLRezrqijhKyXeAdUxsiSOzIauif5kZ
         KIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S0CMFVB1e1YXOFVZJe4be2qV6eCJOxF5msCtstwq5gE=;
        b=MLD9khKmF00Izj63QtokLjR2Xt64I837YZ1jUTTkJG/VZPePFvujsqwNK1sxx2vyuC
         2gSpR4QHVvP0Y6X7VfHo336Kk7GzvS19kawPj0Hu/S5eAGQkXsDFNDXVwojxjbnJuAGI
         2jNyfGbFM48Ul2EwgRWpKyoS3ysgeWWHjl8I1Zm2VWK88vG2YfkWjrlBpz+mklIZOyvQ
         5+nz8M3CsvJMcfH3scLb7maVpnNRG/YCoebdjUCNtYqHo9eahSylrizkfbyE/klwBw3T
         10Qgx72Xao749TV4ublvujMkEM+8f4VB0gyZtsoe0fqzOBF4TRCe9Xl2OzYzG19bd835
         hYcA==
X-Gm-Message-State: AOAM5312+A/2QYy6UbpW6VbRjsCmIieZjmnO181kkCcfFADXsxLo9tPE
        IZ0SlF0ON/aXhCcJlRmPRg4rxcpi
X-Google-Smtp-Source: ABdhPJzxmRaCKSCptsg4QfgPtvogmOYytfhwqjM+uqkgGFGRwt1OilGworLU0LoJnmc9QHnPuxOkog==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr12526770wmj.153.1592225427796;
        Mon, 15 Jun 2020 05:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm25401813wrg.50.2020.06.15.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:27 -0700 (PDT)
Message-Id: <59b8f4cfbb278b1bcb9c189e5c57e37d98db3fbe.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:14 +0000
Subject: [PATCH v2 10/12] remote: learn about the possibly-overridden default
 main branch name
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When guessing the default branch name of a remote, and there are no refs
to guess from, we want to go with the preference specified by the user
for the fall-back, i.e. the default name to be used for the main branch
of new repositories (because as far as the user is concerned, a remote
that has no branches yet is a new repository).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c                 | 15 ++++++++++-----
 t/t5606-clone-options.sh | 11 ++++++++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 534c6426f1e..2dcf4ac6d15 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 
 static void read_branches_file(struct remote *remote)
 {
-	char *frag;
+	char *frag, *main_branch = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
 
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
+		frag = main_branch = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
 	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
@@ -299,6 +299,7 @@ static void read_branches_file(struct remote *remote)
 	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
 	refspec_append(&remote->push, buf.buf);
 	remote->fetch_tags = 1; /* always auto-follow */
+	free(main_branch);
 	strbuf_release(&buf);
 }
 
@@ -2097,9 +2098,13 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (head->symref)
 		return copy_ref(find_ref_by_name(refs, head->symref));
 
-	/* If refs/heads/master could be right, it is. */
+	/* If a remote branch exists with the main branch name, let's use it. */
 	if (!all) {
-		r = find_ref_by_name(refs, "refs/heads/master");
+		char *name = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
+						  MAIN_BRANCH_FOR_INIT);
+
+		r = find_ref_by_name(refs, name);
+		free(name);
 		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
 	}
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 98b2d8527f6..61ce9c09920 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -49,7 +49,16 @@ test_expect_success 'guesses main branch name correctly' '
 	git -C main-branch branch abc guess &&
 	git clone main-branch is-it &&
 	test guess = $(git -C is-it config core.mainBranch) &&
-	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
+	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD) &&
+
+	git -c init.defaultBranch=none init --bare no-head &&
+	git -C main-branch push ../no-head guess abc &&
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

