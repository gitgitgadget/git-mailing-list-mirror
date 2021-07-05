Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80BC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C49613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhGEMfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGEMfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:31 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233FFC06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:55 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id h9so20607744oih.4
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56B58ZKb0REYSNPSVm4zhHzHtjpWoxQSwtDzOcmhUxw=;
        b=OhJqsYnavErF5b0QQf7rXrde4QPe2jm8m0dez2zEq6n8Obm4kvgchBpRhT0TrVaamv
         Pe727D6lr6wwXqDRLy5qqXOGiu1pwXS13ojrk2HQLIOi7k/BbOOtCnv9hjpNOyPGZCLv
         38N5jlt63E3GTdMOdkCC+lLrKOT4Xzi1B/HlPTHXNxYPCcamwz/3OsWW3J6/P/h3BZg7
         TThwIHkqTD59h5LxNFmYnZoJtxt19w+W1jb6CkdHNE5xpJY5I/ilO07QiHFIWO167x6v
         cZcNUydW7RPFpIfA2OXydSOYleWaSUW4/1xe5bufIyafdSlUD/dtc5+DWjK1RRVz9GCu
         OG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56B58ZKb0REYSNPSVm4zhHzHtjpWoxQSwtDzOcmhUxw=;
        b=FiDN1x8WFI33+9/exE8JxmfcEGKbKxpYbBpsKBpg9ZmV70rU6FzxXL136JERhzCOdp
         QJSPogvQO3WhicThzgzJOr4QjCW7WThSV0cQoQ1OVWefUuSShm/R6bsXnaDoPx8MhkDh
         UTo3uE/SdNHbzHCwN2iOpLHfzKOmrGhimgLo9N761IFiSe22iuXyBrdzy/fH1ettHXHv
         xIvJw43cXSe8z/Vyq4k1cCpj+XlV3Nalfj5Oezg5v1JzPZVRQPd+tpZ3w6Zry0ZI2Obz
         AMbuiY6ls+Kn3hryM+JwnIiUOVnOsalRWPkTQp5Wmf8XLTSL15MTfGQUF13dljD1la+S
         l5pg==
X-Gm-Message-State: AOAM533p2eYwYhKrb9A4d/3QwxaV+fRpjtaeRuNkArEFWBkYPEJoAQZ9
        Sr+VTc/RvMQ3SPp1OuMhztJXA/fPk9RAMA==
X-Google-Smtp-Source: ABdhPJxAvfwszFtD1VstTqfVCSzwkoHPCMsl+vcZbN4QkLmw36pycTReA4zd1RJTiT1JmVIsbY0T7g==
X-Received: by 2002:aca:1809:: with SMTP id h9mr10204049oih.4.1625488374260;
        Mon, 05 Jul 2021 05:32:54 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id s131sm2624797oib.52.2021.07.05.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 25/35] pull: show warning with --ff options
Date:   Mon,  5 Jul 2021 07:31:59 -0500
Message-Id: <20210705123209.1808663-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want the user to specify either --merge or --rebase, if she doesn't
we throw a warning.

Using --ff, --no-ff, or --ff-only does not make the merge explicit.

For example, if the user has the following configuration:

  git config pull.rebase true
  git pull --no-ff

A merge is not implied.

We should be consistent and either imply a merge--in which case a
previous "pull.rebase=true" configuration is overridden--or don't--in
which case the warning should be thrown.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 61af8ea2cb..2c2f0822d5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1042,7 +1042,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !opt_ff && !can_ff) {
+	if (!opt_rebase && !can_ff) {
 		if (opt_verbosity >= 0)
 			show_advice_pull_non_ff();
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6d03e0b9fe..7c4607191a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -96,21 +96,21 @@ test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
@@ -128,19 +128,19 @@ test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'merge c1 with c2' '
-- 
2.32.0.36.g70aac2b1aa

