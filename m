Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50DAC48BC2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48B9613EF
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhF1DTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DTP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 23:19:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15098C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:16:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so17237860otg.1
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJZXaGICX9GwkPC64uv/owCKKkrZek6qm8SP3+tnlqY=;
        b=m2i8x/x/8gxo2KM/5gMhGIXeVRS3yEQSB8/wcbFErHn/MjXGemsb4w0qZGQ3K3Ir6S
         2rjMEElyB8BHpLEJLs5bxK9zhcNjCryjvHXuT9Bwy90giWjI5maVVojAN5wkVO3eH9MD
         g7TsZ7Zhr2z9GFDaDX3M51QGnHpTUr5GjNb4XkXU8H1jgXAXpaEAc+RSkPbWkcJwrgJi
         snY5NJi42WmhcjtMTmHOOKP+Ul0FXcP0cvBYuek4Aj3i59i/a5e94l3lXWtPu0W+jKRc
         kHiftkQl3srATViTCdP5MHilgDi0P4jdAgV5VRx9a69+3LfUFK1Wp56d0AWivgsMvSHf
         2FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJZXaGICX9GwkPC64uv/owCKKkrZek6qm8SP3+tnlqY=;
        b=O7UTv/bSkyRrGI038mgx/ewcnMOBj/V7wHpNXd3siAU3lYGo15uiAfCNqUO/1h28qo
         2kz5kyh+kTvAJeRBeN0FckHLq1qfxbqotNJ52GeoEll7RIXtY6h5vgQ0olcN0+GP7Pet
         WOoTumT14tvaVGchC3U7hIWnQgMgOlVV/9PHQUjm//ndX66BfQfcO14RQIhwSOjcVOJe
         t1qpxV2TE7e+Ohi1dM8SANq2Gwe+OZjhkpdq6fwd0LlL4DVRNkC6q8bxBW0f3izWTLKz
         tkhakujx4nohrMZumug+aswR8Vd7yauALTZ724s/amHYv59qOEv4FUZim4rMSoce0Skm
         SOqA==
X-Gm-Message-State: AOAM530ceN0E14ue5O63KFRtqOFztE5JktoD1CQf415aTYrwF9zRi4og
        U0ctUnasd+Q0OoZjo2SeWg+JUe1NaUSiTQ==
X-Google-Smtp-Source: ABdhPJzmgWa5pYjFXlyYUg+9lPXq9Bn4UqoJRnKsATTQ/oD+aFMuM9bsx1UVkNXcNE+XK+oKUXQI8g==
X-Received: by 2002:a9d:6087:: with SMTP id m7mr19094240otj.318.1624850209010;
        Sun, 27 Jun 2021 20:16:49 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l201sm1697729oih.22.2021.06.27.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 20:16:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] pull: introduce --merge option
Date:   Sun, 27 Jun 2021 22:16:42 -0500
Message-Id: <20210628031642.699156-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatibility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I've sent many versions of this patch over the years (since 2013) in
many different series and nobody has objected to it (to the best of my
recollection).

The idea came after a comment from Linus Torvalds regarding what should
be the default mode of "git pull" and why [1].

It conflicts with some of my previous patch series, but they aren't even
in "seen" yet, and the ones that are resolve easily.

[1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/

 Documentation/git-pull.txt   | 7 +++++--
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..d23128fa72 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -131,8 +131,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..186adbff71 100644
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
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..6d03e0b9fe 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -60,9 +60,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
@@ -119,9 +119,9 @@ test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
+test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.32.0

