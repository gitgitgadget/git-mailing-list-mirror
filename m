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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA0C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB206101B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbhIALVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbhIALVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:21:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C6C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:20:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1664038wml.3
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXwoaJRA4HnYcVNkbNI9sIJXRvxcVyZ2RwCtvIepZ4k=;
        b=RmIBPtiLk4wBcmly2Y8eeud5qXsWmFopTittg317fRnlqK27Du9XFsMmaBEY6mZi5l
         LlGL33qAvn9LwOUp/nUsj3U6gLXuJMUP1q34Rv5h2e7HzvXDYFy8aWT/dqbv+AOXeZx/
         FP4mbqe/2kmIpMlWVYsIZZtiAHY9Xy3T9NzxNa3AkNa2GTDPgLnRNqlA7sxuqb/Ajacu
         KI9x5seSsdnog41Ow1uuP0ghgiIVnmSJMrFbaPzK1Q39MDJpNQcO1N8uMFgXRHjY7yEt
         MjpqdVx0me1qdmGh5iKicBsvo5PiG3lZa+xKr6gvIzPPSFelgDRmGpqUe4nPf4V3meFR
         59oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXwoaJRA4HnYcVNkbNI9sIJXRvxcVyZ2RwCtvIepZ4k=;
        b=pm9GEfbwz0iRFquY3U02BIMmUpMASb+MOOadIYzpvui7bvEyBfEVgo/7CVoTl+SqpQ
         gnnn36GgVpVFBHgAjf4NPHheBzZWpHxNuN+4Rthm1G19Byy8pkCmQ8o6WpKzduew4gmw
         7BlAQkU5XpB03S8Vq+tGkEwMMDtgGv/4Kn8xhMPElOQR6YONKUDCvJSR91o8MpHuU0BE
         0jprmzBskjpHmHo5CRXvVG1McfvIgHpv5gQv6ynNLGXSeatgE/7IYQSRQekg9ujBjoLm
         +TrGQtvmRiP9DMvIJ11mZjSBnpWo6Y/09fVfHVWLKefarwpZtPMAG8LXnzzqKicASPGq
         +qRw==
X-Gm-Message-State: AOAM5316sOBvXW9wt2iQ7Xxe+GfOm45J77cvSk3iJn6vXq4xy8PSTqIP
        slXnYkq8eSJGGoLE54IhT7ZCsw0mOi+mIA==
X-Google-Smtp-Source: ABdhPJyM0fEsbbgK+uLSTihMMtmvPNgR/DKdJ45MG6VgekqkVIy2UN2/rBQHqKI/NZ7Ma7uO/Zpxxg==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr8946639wmi.157.1630495212809;
        Wed, 01 Sep 2021 04:20:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t14sm4827332wmi.12.2021.09.01.04.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:20:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] stash: print the correct usage on "git stash [push] --invalid-option"
Date:   Wed,  1 Sep 2021 13:19:54 +0200
Message-Id: <patch-1.1-47c582f1218-20210901T111930Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.807.gf14ecf9c2e9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage message emitted by "git stash --invalid-option" to
emit usage information for "git stash" in general, and not just for
the "push" command.

That we emitted the usage for just "push" in the case of the
subcommand not being explicitly specified was an unintentional
side-effect of how it was implemented. When it was converted to C in
d553f538b8a (stash: convert push to builtin, 2019-02-25) the pattern
of having per-subcommand usage information was rightly continued. The
Git-stash.sh shellscript did not have that, and always printed the
equivalent of "git_stash_usage".

But in doing so the case of push being implicit and explicit was
conflated. A variable was added to track this in 8c3713cede7 (stash:
eliminate crude option parsing, 2020-02-17), but it did not update the
usage output accordingly. Let's do that.

This still leaves e.g. "git stash push -h" emitting the
"git_stash_usage" output, instead of "git_stash_push_usage". That
should be fixed, but is a much deeper misbehavior in parse_options()
not being aware of subcommands at all. I.e. in how
PARSE_OPT_KEEP_UNKNOWN and PARSE_OPT_NO_INTERNAL_HELP combine in
commands such as "git stash".

Perhaps PARSE_OPT_KEEP_UNKNOWN should imply
PARSE_OPT_NO_INTERNAL_HELP, or better yet parse_options() should be
extended to fully handle these subcommand cases that we handle
manually in "git stash", "git commit-graph", "git multi-pack-index"
etc. All of those musings would be a much bigger change than this
isolated fix though, so let's leave that for some other time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c  |  1 +
 t/t3903-stash.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..cf62c3b3cd8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1608,6 +1608,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	if (argc) {
 		force_assume = !strcmp(argv[0], "-p");
 		argc = parse_options(argc, argv, prefix, options,
+				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage,
 				     PARSE_OPT_KEEP_DASHDASH);
 	}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..ba9582bdee5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -10,6 +10,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'usage' '
+	test_expect_code 129 git stash -h >out &&
+	grep "or: git stash" out &&
+
+	test_expect_code 129 git stash --invalid-option >out 2>err &&
+	grep "or: git stash" err &&
+
+	test_expect_code 129 git stash push --invalid-option >out 2>err &&
+	! grep "or: git stash" err
+'
+
 diff_cmp () {
 	for i in "$1" "$2"
 	do
-- 
2.33.0.807.gf14ecf9c2e9

