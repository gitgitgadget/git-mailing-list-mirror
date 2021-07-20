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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A99C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE5961029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhGTLBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhGTK7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55136C0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1305763wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waP9c37Y2qR6tqt2P4b7cAqOtDg1FvYNwdRKPb1sN2I=;
        b=AOSzgBPvC0AkcztyJoAIcBeNKn4f0RqjN4A1MN+f3on1LZs6GFFrhz6SWyCTLOlqj0
         c46JL245hLnCzXwwN7OYzWXUG8bSfxLETO5u9vKH9jz0tHJMTC841oZWFmO60cgUiWT2
         xM9EztY/kel/7UeKJkV0dQMmtotOnuVbXsTswyohiEMaM5uxiTeWOuOU2Q5s9EyuxSy/
         j7awZYXhA6DDiq6/LrdmoaTBEy2h0AwK/zZo0A0ZOxpLqDu3D45Khwjjfz4v1YfOxBAB
         JkcslluU5gTnDKbu1VsU6ELugUXZoOAtmmnxUiVQyr+ej8aGIhr5x+9msJ3wt8zierv7
         F7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waP9c37Y2qR6tqt2P4b7cAqOtDg1FvYNwdRKPb1sN2I=;
        b=FXm+R29TMymcgJXwf6zfPicRqhobhRQeJTWCjWaWLTF9B9le9A6+P8CDNCMdI2qxXB
         HN7weOAyQ44BFLxEQCsihP5UzLpCkX449Aowd1wWGfE4NI2Ul90EhkPiQKGxlwXjqAbC
         Y4u2LkxpKemhyBY5C/HgCVkNa/P7zHt747yY64gtHLk/CVuEC3D1vbyS91+dLSenhtvY
         ln8HCK/na13o8whGluDxRjjy72ttGBvVbweysmsG7DG7ofFhZqytXB9kbuM8EMw7krrg
         Ywf2x4Wn+H9ZWFc3NypvEU7jP5hR/Am0tbl4mG8eeExcBszqB+EpjWeqiyemuUN872Pz
         ImwA==
X-Gm-Message-State: AOAM533Deif+1mP7qQYcMkalPbkjnIrtzczOLAAVdRUX9GnMPrU/mE5X
        GFEfeFLR3pQMJS68ndV27NjgTNItUlF28w==
X-Google-Smtp-Source: ABdhPJwqmKej4wjTk+KpINY/8ViFmu6m2BKIqzGqNY1MKSy4hZrzItBe4cPbhV8q1YlE6k+rv98+Jg==
X-Received: by 2002:a05:600c:1d04:: with SMTP id l4mr23844311wms.130.1626781207697;
        Tue, 20 Jul 2021 04:40:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] commit-graph: show usage on "commit-graph [write|verify] garbage"
Date:   Tue, 20 Jul 2021 13:39:45 +0200
Message-Id: <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_options() invocation in the commit-graph code to make
sense. We're calling it twice, once for common options parsing, and
then for the sub-commands.

But we never checked if we had something leftover in argc in "write"
or "verify", as a result we'd silently accept garbage in these
subcommands. Let's not do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 10 ++++++++--
 t/t5318-commit-graph.sh |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bf34aa43f22..88cbcb5a64f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **argv)
 	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
 			     options,
-			     builtin_commit_graph_verify_usage, 0);
+			     builtin_commit_graph_verify_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_commit_graph_verify_usage, options);
 
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
@@ -261,7 +264,10 @@ static int graph_write(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, NULL,
 			     options,
-			     builtin_commit_graph_write_usage, 0);
+			     builtin_commit_graph_write_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_commit_graph_write_usage, options);
 
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index af88f805aa2..09a2ccd2920 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -5,6 +5,11 @@ test_description='commit graph'
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+test_expect_success 'usage' '
+	test_expect_code 129 git commit-graph write blah &&
+	test_expect_code 129 git commit-graph write verify
+'
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.32.0.874.ge7a9d58bfcf

