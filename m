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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E1C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FFF610F7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhGUBDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGUBCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:02:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674DC0613DB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x14-20020a7bc20e0000b0290249f2904453so44353wmi.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1UCY7UForPBm5YSkc9esdo7zarpxMjwVtqmvE7a43wg=;
        b=n0OjsgxEucTmk7OMCaJpeIqEj5pJMV0Vj74/X7fgldcHnuJGcWUDVNsW7iig/xfFIJ
         H2vsgfQXAujY3FN/pgV/44Q6ipjLWSYbaNZOaQxzNep5UB1EFagCzDF3FvzT/c4DxT+/
         0sxNZnRM71Lv4rbgT+uwRrBgUiMtecdet8H7+9GZrUID8dEdaFQXKpa2CyyZD1zLBUgG
         pox9PxH3qc+P0iseLPo3r75+KvE6SoCWfY2RMdAvSTPaTxR7cHgWfNqyQLWUmyN0/h71
         nlg4Kl473/krSyLyCw3UkcLPE5t7rGHZpwMlnCLzUjy/C8/f2hPnGOEco7L8wLK9Ic/B
         QiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1UCY7UForPBm5YSkc9esdo7zarpxMjwVtqmvE7a43wg=;
        b=tHVKpPxTC5lVUAujUp6DywOf1+LtqaTS26faSA2K2t9bOELXcZUK1O7xCimFj0KqMu
         l7t6x4jpHqLlcULTsWYKMfIqjHNPK3J2L5kspE/SOaCqfZc3EljNlQJyq3uhkSUvsOml
         rtkjpm9Dv5/A7586rFiT4aYlqxZ6KoJ7exUT8oZZ6/Rnvfl8+HpFPrHsj8TLrfriXXZx
         fwA4lnCAjjurMlegiQNyauftx0HJ26NSMWJurr5gkGr3fGx0WZGvv2PAGpQxIvsZnafy
         ojofSBscfKXpd9jGSomeB3OyI2ZwkZNSpix/Mupmfphyn8T8QG4TMjgh7siIhQz9HN5T
         twTA==
X-Gm-Message-State: AOAM530mfi1hwHaNDZk/AJOs/CPCdycSRRBUN9SEhGzy74WOsf7vl4bB
        4+nAgIp+1a/7yctDHUyQYgkPaKQmxfs=
X-Google-Smtp-Source: ABdhPJz2UieBcW78II3FwL1mmE79mC4PucW6+p52Y7Y81qPUtHbuuvN9oKaRsycwoXsliLPnlAeXpw==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr1332253wml.140.1626831748621;
        Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7sm3769578wmq.22.2021.07.20.18.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Message-Id: <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:20 +0000
Subject: [PATCH v2 4/8] pull: since --ff-only overrides, handle it first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are both merge and rebase branches in the logic, and previously
both had to handle fast-forwarding.  Merge handled that implicitly
(because git merge handles it directly), while in rebase it was
explicit.  Given that the --ff-only flag is meant to override any
--rebase or --no-rebase, make the code reflect that by handling
--ff-only before the merge-vs-rebase logic.

It turns out that this also fixes a bug for submodules.  Previously,
when --ff-only was given, the code would run `merge --ff-only` on the
main module, and then run `submodule update --recursive --rebase` on the
submodules.  With this change, we still run `merge --ff-only` on the
main module, but now run `submodule update --recursive --checkout` on
the submodules.  I believe this better reflects the intent of --ff-only
to have it apply to both the main module and the submodules.

(Sidenote: It is somewhat interesting that all merges pass `--checkout`
to submodule update, even when `--no-ff` is specified, meaning that it
will only do fast-forward merges for submodules.  This was discussed in
commit a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
changes only)", 2017-06-23).  The same limitations apply now as then, so
we are not trying to fix this at this time.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c  | 24 +++++++++---------------
 t/t5520-pull.sh |  6 +++---
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d9796604825..92150f976cd 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1046,15 +1046,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!can_ff) {
-		if (opt_ff) {
-			if (!strcmp(opt_ff, "--ff-only"))
-				die_ff_impossible();
-		} else {
-			if (rebase_unspecified && opt_verbosity >= 0)
-				show_advice_pull_non_ff();
-		}
+	/* ff-only takes precedence over rebase */
+	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
+		if (!can_ff)
+			die_ff_impossible();
+		opt_rebase = REBASE_FALSE;
 	}
+	/* If no action specified and we can't fast forward, then warn. */
+	if (!opt_ff && rebase_unspecified && !can_ff)
+		show_advice_pull_non_ff();
 
 	if (opt_rebase) {
 		int ret = 0;
@@ -1069,13 +1069,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
-		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
-			ret = run_merge();
-		} else {
-			ret = run_rebase(&newbase, &upstream);
-		}
+		ret = run_rebase(&newbase, &upstream);
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c510222..4b50488141f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -295,7 +295,7 @@ test_expect_success '--rebase (merge) fast forward' '
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
-	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff (finish): returning to refs/heads/to-rebase" >reflog.expected &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
@@ -307,8 +307,8 @@ test_expect_success '--rebase (am) fast forward' '
 
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
-	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
-	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	sed -e "s/^[0-9a-f][0-9a-f]*/OBJID/" -e "s/[0-9a-f][0-9a-f]*$/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: rebase finished: refs/heads/to-rebase onto OBJID" >reflog.expected &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-- 
gitgitgadget

