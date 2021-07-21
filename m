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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B36C636CA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061CE60FF1
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhGUNHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhGUNHD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 09:07:03 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6FC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 06:47:38 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id u13-20020a4ad0cd0000b02902638ef0f883so562627oor.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcV/4XBT3q+6qr/z5Xdrf5+A3WXs2iibz+FciazvFtQ=;
        b=VX0tOREKd2xVeOQDOIPctDc6GBK11ZDYpe31FvNBkchyJ6C73Gy0VeMJfsXUUpsK9Y
         gOo7BjP17is4iQ9NpOrBiR9U+kGeeeHNnxRmT535gnBhM+okK5+caP2uVvWeO+CXC4gv
         Uo7+oHTpCteR8v/tRRJ7WVdDxPRVhbrO37qFBxxsw+FzYxRc0mta4xXzWVPQXbVmxMxD
         pDZdoisFzbIYBpuy4JqLTxVtwdzxQ4gRY2ZOqyZjQteQSvJsiUSJum1w0za9i5gV8kjU
         Gr537iVtzr7EEBTQqy21NN0y28YLGHXrsJ/dU5bbAwft2OUJo2eNBZAtSCtDccafXsZQ
         vRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcV/4XBT3q+6qr/z5Xdrf5+A3WXs2iibz+FciazvFtQ=;
        b=ABBm0KW9byhTfIJyny7QEhekcag//jj7RsR9jjZKxn0iNkMbSh3dT8btP7cuewVhNB
         y5228tNP1zdQoajhTqzAi4BMctS6pCdn86ZQhGS3oQvlCtdHqNnmZhAwrPbwzFOhxqAw
         4LNmVWr3MXHZS0OWNSYMi6MSLanMcJmUCROtsFlUanhiEtekWWahiArPZdf3iqVBYXNl
         F8aLsJ0HIQPj/QMpoPoyT2A2wij4ahRSgWB0xL9cj+WCTGUFnVs3XGgMhHlZG/PwN/Mu
         nxnL/KRa5cLec5grx3oobSLFoGjX3zDXiuRRLH7oCI36zX/SbQrUcYwS8vfyo5J9HKZG
         ZZBQ==
X-Gm-Message-State: AOAM530+M/pQ+PuSU00xtn9jozmPhyDYHstFd5FhSlZNV1mNYEi0Vkc5
        b/CaLQprarh+4O5xCiccixTm5FFAVBIeFQ==
X-Google-Smtp-Source: ABdhPJxJH8zSX7mcpUsdRD5+vf++C0hx7wxnp/JNwExEJD1+Yxb6phSd+aPYtWKPOJbBow+yBqRSoA==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr24656512ooo.79.1626875258110;
        Wed, 21 Jul 2021 06:47:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m129sm4926837oif.15.2021.07.21.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:47:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] pull: introduce --merge option
Date:   Wed, 21 Jul 2021 08:46:50 -0500
Message-Id: <20210721134650.1866387-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users need to specify if they want to either --merge or --rebase, but
unfortunately the former is missing.

In many discussions regarding `git pull` --merge is often mentioned, but
for one reason or another the patches have not been merged.

Let's just go ahead and do it.

Now we can update the default warning to say --merge instead of the
non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v1 I've removed any hint of deprecation (even though we obviously
want to do that), and added an actual test (I don't seem to find a
simialr one for --no-rebase).

Range-diff against v1:
1:  80d7866599 < -:  ---------- pull: introduce --merge option
-:  ---------- > 1:  5969fc4455 pull: introduce --merge option

 Documentation/git-pull.txt | 6 ++++++
 builtin/pull.c             | 4 +++-
 t/t5520-pull.sh            | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..c7a1f676cc 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -134,6 +134,12 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+-m::
+--merge::
+	Do a merge.
++
+Alias for --no-rebase.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 3e13f81084..0d76b54186 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -129,6 +129,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -936,7 +938,7 @@ static void show_advice_pull_non_ff(void)
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+		 "preference for all repositories. You can also pass --rebase, --merge,\n"
 		 "or --ff-only on the command line to override the configured default per\n"
 		 "invocation.\n"));
 }
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c51022..f299a82405 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -452,6 +452,13 @@ test_expect_success 'pull.rebase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull.rebase with --merge' '
+	git reset --hard before-rebase &&
+	test_config pull.rebase true &&
+	git pull --merge . copy &&
+	test_cmp_rev HEAD^2 copy
+'
+
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
 	test_pull_autostash 1 --autostash
-- 
2.32.0.40.gb9b36f9b52

