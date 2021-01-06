Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5480C433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A171C2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbhAFKCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFKCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:02:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002AC061359
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:02:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 3so2099431wmg.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SgToDSG62XEpKiQJxczUyqb8bpOQbaZOkpVNI+njTg=;
        b=MyhH4OdYKqT2bXYQefKcLT9NGMUMj99yCOOS7mt/cB1bHtgmUQk2bldJoMbjq6tuNP
         NG6L6w+X3kP1hmHD4cwXseEiFNwgmxLRvLX6wfkZ5GdWgcyyBywcQRkr+8dNe1ir4MqN
         z57iV44rOH0fvHRnqJA++sWmQGULx8OfYmFflenbU7r6kcbNwCNV7NPVMvjZIeycozii
         Z/+MP//lk2VmN2sbQg+fnchb3oS+0HQ5ywdmErbiiFg1SrGb+ZaKslHPUUXwSdZ28+Je
         /4AD2VpH4SoLFDgWbF9ssu6ixIBWwD5TZmHTruOUZLU8fZIaHe8YfuEkpfNOU1WII93B
         S2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/SgToDSG62XEpKiQJxczUyqb8bpOQbaZOkpVNI+njTg=;
        b=eb6AOV/9pFQE89ve3vTuo0x8Qn92fC7VLaGBWofDmmYrkSAa5tw9FffT1jkJqoajES
         NeHvLv6+wNeEThA7Piky63VkuPi+t9j04pOh9bR+Qcn7ZZ3whEeF7ws0EUYNb6SMD/yP
         CJdMv+DXQbow7NO67cxJXHRQpLWSO6Ov5ZgLwHTeztk+O2UQerMFSpQrTtDbylb3D9O7
         IG1yMlX0YQUQhcFD7y2O3EYF9PrTKhbhLcYuthHdk0b6DPjXLtw2CjDK/KamtwiuHgcY
         Tt85uQZ2e0+UWNB+jtEnF1MofV2Hgx0Pp55lmBZrQmSe/hvggxVKzxuKUWNxY83jeFjy
         A1SQ==
X-Gm-Message-State: AOAM5323IHeyuxaETier9nUElYAyv+NsdEJTZw8X/6dk9uCSCqR4r7jj
        fPianziBklfjUOrDbjTDn1w2xlkQSfoPfg==
X-Google-Smtp-Source: ABdhPJzlo0iQ5FJCjeZwimTcSCYJS8KDwb/cGhBylYkyDfc7XMjeMpd5S6tKpJM6WmapG0qFSWze5g==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr2937937wmj.170.1609927326115;
        Wed, 06 Jan 2021 02:02:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:02:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] branch: use the "detached_head_first" sorting option
Date:   Wed,  6 Jan 2021 11:01:38 +0100
Message-Id: <20210106100139.14651-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new ref_sorting_detached_head_first_all() sorting option in
ref-filter.c to revert and amend 28438e84e04 (ref-filter: sort
detached HEAD lines firstly, 2019-06-18).

In Chinese the fullwidth versions of punctuation like "()" are
typically written as (U+FF08 fullwidth left parenthesis), (U+FF09
fullwidth right parenthesis) instead. This form is used in both
po/zh_{CN,TW}.po in most cases where "()" is translated in a string.

In 28438e84e04 the ability to translate this as part of the "git
branch -l" output was removed because we'd like the detached line to
appear first at the start of "git branch -l", e.g.:

    $ git branch -l
    * (HEAD detached at <hash>)
      master

Let's instead use the new ref_sorting_detached_head_first_all() in
branch.c to say that we'd like these sorted before other entries.

As seen in the amended tests this made reverse sorting a bit more
consistent. Before this we'd sometimes sort this message in the
middle, now it's consistently at the beginning or end. Having it at
the end doesn't make much sense either, but at least it behaves
consistently now. A follow-up commit will make this behavior even
better.

I'm removing the "TRANSLATORS" comments that were in the old code
while I'm at it. Those were added in d4919bb288e (ref-filter: move
get_head_description() from branch.c, 2017-01-10). I think it's
obvious from context, string and translation memory in typical
translation tools that these are the same or similar string.

1. https://en.wikipedia.org/wiki/Chinese_punctuation#Marks_similar_to_European_punctuation

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c         |  1 +
 ref-filter.c             | 27 +++++++++------------------
 t/t3203-branch-output.sh |  4 ++--
 wt-status.c              |  4 ++--
 wt-status.h              |  2 --
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 045866a51ae..92221bdf8a6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -740,6 +740,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!sorting)
 			sorting = ref_default_sorting();
 		ref_sorting_icase_all(sorting, icase);
+		ref_sorting_detached_head_first_all(sorting, 1);
 		print_ref_list(&filter, sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
diff --git a/ref-filter.c b/ref-filter.c
index 94ab3f86a53..7e0289cb659 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1536,36 +1536,27 @@ char *get_head_description(void)
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(the_repository, &state, 1);
-
-	/*
-	 * The ( character must be hard-coded and not part of a localizable
-	 * string, since the description is used as a sort key and compared
-	 * with ref names.
-	 */
-	strbuf_addch(&desc, '(');
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
-			strbuf_addf(&desc, _("no branch, rebasing %s"),
+			strbuf_addf(&desc, _("(no branch, rebasing %s)"),
 				    state.branch);
 		else
-			strbuf_addf(&desc, _("no branch, rebasing detached HEAD %s"),
+			strbuf_addf(&desc, _("(no branch, rebasing detached HEAD %s)"),
 				    state.detached_from);
 	} else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("no branch, bisect started on %s"),
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
 		if (state.detached_at)
-			strbuf_addstr(&desc, HEAD_DETACHED_AT);
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
 		else
-			strbuf_addstr(&desc, HEAD_DETACHED_FROM);
-		strbuf_addstr(&desc, state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("no branch"));
-	strbuf_addch(&desc, ')');
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	} else
+		strbuf_addstr(&desc, _("(no branch)"));
 
-	wt_status_state_free_buffers(&state);
 	return strbuf_detach(&desc, NULL);
 }
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f92fb3aab9d..8f53b081365 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -223,8 +223,8 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	cat >expect <<-\EOF &&
 	  branch-one
 	  main
-	* (HEAD detached from fromtag)
 	  branch-two
+	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-objectsize >actual &&
 	test_i18ncmp expect actual
@@ -241,10 +241,10 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	* (HEAD detached from fromtag)
 	  branch-one
 	  branch-two
 	  main
+	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-type >actual &&
 	test_i18ncmp expect actual
diff --git a/wt-status.c b/wt-status.c
index 7074bbdd53c..40b59be478c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1742,9 +1742,9 @@ static void wt_longstatus_print(struct wt_status *s)
 			} else if (s->state.detached_from) {
 				branch_name = s->state.detached_from;
 				if (s->state.detached_at)
-					on_what = HEAD_DETACHED_AT;
+					on_what = _("HEAD detached at ");
 				else
-					on_what = HEAD_DETACHED_FROM;
+					on_what = _("HEAD detached from ");
 			} else {
 				branch_name = "";
 				on_what = _("Not currently on any branch.");
diff --git a/wt-status.h b/wt-status.h
index 35b44c388ed..0d32799b28e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,8 +77,6 @@ enum wt_status_format {
 	STATUS_FORMAT_UNSPECIFIED
 };
 
-#define HEAD_DETACHED_AT _("HEAD detached at ")
-#define HEAD_DETACHED_FROM _("HEAD detached from ")
 #define SPARSE_CHECKOUT_DISABLED -1
 
 struct wt_status_state {
-- 
2.29.2.222.g5d2a92d10f8

